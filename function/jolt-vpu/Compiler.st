{ import: Objects }
{ import: Expression }
{ import: VPU }

SyntaxFlag   := [ false ]
CompileFlags := [ 0 ]
DebugFlags   := [ 0"VPUDebugEmit" ]

VPU compileFlags: c	[ CompileFlags := c ]
VPU debugFlags: d	[ DebugFlags := d ]

Symbol asSymbol		[ ^self ]

Symbol _dlsym		[ ^self _dlsym_: self _stringValue ]
Symbol _dlsym_: _string	{ return (oop)dlsym(RTLD_DEFAULT, (char *)v__string); }
Symbol _RTLD_DEFAULT	{ return (oop)RTLD_DEFAULT; }
Symbol _RTLD_LAZY	{ return (oop)RTLD_LAZY; }
Symbol _RTLD_NOW	{ return (oop)RTLD_NOW; }

Globals := [
    FastIdentityDictionary new
	at: #_RTLD_DEFAULT	put: #dlsym _RTLD_DEFAULT;
	at: #_RTLD_LAZY		put: #dlsym _RTLD_LAZY;
	at: #_RTLD_NOW		put: #dlsym _RTLD_NOW;
	at: #_dlsym		put: #dlsym _dlsym;
	yourself
]

Association _valuePointer
{
    return (oop)&self->v_value;
}

"----------------------------------------------------------------"

Variable : Object ( value )

Variable copy
[
    ^self withValue: value
]

Variable withValue: anObject
[
    self := self new.
    value := anObject.
]

Variable value	[ ^value ]

Variable addOffset: anInteger	[]

GlobalVariable : Variable ()

GlobalVariable compileRead:  aCompiler	[ aCompiler globalRead:  value ]
GlobalVariable compileWrite: aCompiler	[ aCompiler globalWrite: value ]

ArgumentVariable : Variable ()

ArgumentVariable compileRead:  aCompiler	[ aCompiler argumentRead:  value ]
ArgumentVariable compileWrite: aCompiler	[ aCompiler argumentWrite: value ]

TemporaryVariable : Variable ()

TemporaryVariable addOffset: anInteger		[ value := value + anInteger ]

TemporaryVariable compileRead:  aCompiler	[ aCompiler temporaryRead:  value ]
TemporaryVariable compileWrite: aCompiler	[ aCompiler temporaryWrite: value ]

"----------------------------------------------------------------"

Environment : Object ( bindings syntax )

Environment new
[
    ^self withBindings: FastIdentityDictionary new.
]

Environment withBindings: aDictionary
[
    self := super new.
    bindings := aDictionary.
    syntax := FastIdentityDictionary new.
]

Environment bindings	[ ^bindings ]
Environment size	[ ^bindings size ]

Environment define: aSymbol syntax: lambda
[
    syntax at: aSymbol put: lambda
]


GlobalEnvironment : Environment ()

GlobalEnvironment isGlobalEnvironment	[ ^true ]
Environment isGlobalEnvironment		[ ^false ]

GlobalEnvironment declare: aSymbol	[ Globals at: aSymbol put: nil ]

GlobalEnvironment lookup: aSymbol
[
    | assoc |
    ^(assoc := bindings associationAt: aSymbol ifAbsent: []) notNil
	ifTrue:  [GlobalVariable withValue: assoc]
]

GlobalEnvironment lookupSyntax: aSymbol	[ ^syntax at: aSymbol ifAbsent: [] ]


LocalEnvironment : Environment ( outer )

LocalEnvironment withOuter: outerEnvironment
[
    self := super new.
    outer := outerEnvironment.
]

LocalEnvironment outer				[ ^outer ]

LocalEnvironment declareArgument: aSymbol	[ ^bindings at: aSymbol put: (ArgumentVariable withValue: bindings size) ]
LocalEnvironment declareTemporary: aSymbol	[ ^bindings at: aSymbol put: (TemporaryVariable withValue: bindings size) ]

LocalEnvironment declare: aSymbol		[ ^self declareTemporary: aSymbol ]

LocalEnvironment lookup: aSymbol
[
    | variable |
    variable := bindings at: aSymbol ifAbsent: [].
    variable notNil ifTrue: [^variable copy].
    variable := outer lookup: aSymbol.
    variable notNil ifTrue: [variable addOffset: bindings size].
    ^variable
]

LocalEnvironment lookupSyntax: aSymbol		[ ^syntax at: aSymbol ifAbsent: [outer lookupSyntax: aSymbol] ]

Environment inner	[ ^LocalEnvironment withOuter: self ]


[ GlobalEnvironment := GlobalEnvironment withBindings: Globals ]

"----------------------------------------------------------------"

SyntaxTable := [
    FastIdentityDictionary new
	at: #pixadd	  put: #xPixAdd:;
	at: #pixin	  put: #xPixIn:;
	at: #pixover	  put: #xPixOver:;
	at: #+		  put: #xAdd:;
	at: #-		  put: #xSubtract:;
	at: #*		  put: #xMultiply:;
	at: #fixmul	  put: #xFixMultiply:;
	at: #/		  put: #xDivide:;
	at: #fixdiv	  put: #xFixDivide:;
	at: #%		  put: #xRemainder:;
	at: #&		  put: #xAnd:;
	at: #|		  put: #xOr:;
	at: #^		  put: #xXor:;
	at: #!		  put: #xNot:;
	at: #<<		  put: #xLshift:;
	at: #>>		  put: #xRshift:;
	at: #<		  put: #xLess:;
	at: #<=		  put: #xLessEqual:;
	at: #==		  put: #xEqual:;
	at: #!=		  put: #xNotEqual:;
	at: #>=		  put: #xGreaterEqual:;
	at: #>		  put: #xGreater:;
	at: #'char@'	  put: #xChar:;
	at: #'short@'	  put: #xShort:;
	at: #'int@'	  put: #xInt:;
	at: #'long@'	  put: #xLong:;
	at: #'set-char@'  put: #xSetChar:;
	at: #'set-short@' put: #xSetShort:;
	at: #'set-int@'	  put: #xSetInt:;
	at: #'set-long@'  put: #xSetLong:;
	at: #quote	  put: #xQuote:;
	at: #syntax	  put: #xSyntax:;
	at: #define	  put: #xDefine:;
	at: #set	  put: #xSet:;
	at: #and	  put: #xLogAnd:;
	at: #or		  put: #xLogOr:;
	at: #not	  put: #xNot:;
	at: #if		  put: #xIf:;
	at: #while	  put: #xWhile:;
	at: #break	  put: #xBreak:;
	at: #continue	  put: #xContinue:;
	at: #let	  put: #xLet:;
	at: #lambda	  put: #xLambda:;
	at: #return	  put: #xReturn:;
	at: #send	  put: #xSend:;
	yourself
]

CompilerEvalCodeSize := [ 0 ]
CompilerLambdaCodeSize := [ 0 ]

LambdaLiterals := [ OrderedCollection new ]

Compiler : Object ( vpu entry environment loops )

Compiler parseOption: aString
[
    aString = '-vx' ifTrue: [^CompileFlags := 1].
    aString = '-vs' ifTrue: [^SyntaxFlag   := true].
    ^false
]

Compiler new
[
    ^self withEnvironment: GlobalEnvironment
]

Compiler withEnvironment: anEnvironment
[
    self := super new.
    vpu := VPU new.
    entry := VPULabel new.
    environment := anEnvironment.
    loops := OrderedCollection new.
]

Compiler vpu		[ ^vpu ]
Compiler evalCodeSize	[ ^CompilerEvalCodeSize ]
Compiler lambdaCodeSize	[ ^CompilerLambdaCodeSize ]

LambdaRegisterFunction := [ nil ]
LambdaDefinitionName := [ nil ]

Compiler registerLambdasWith: _fn	[ LambdaRegisterFunction := _fn ]

Compiler syntaxError: anExpression	[ self error: 'syntax error: ', anExpression printString ]
Compiler undefinedError: anIdentifier	[ self error: 'undefined: ', anIdentifier asString ]

Compiler syntaxError: anExpression in: outerExpression
[
    self error: 'in expression: ', outerExpression printString,
	'\nsyntax error: ', anExpression printString
]

Compiler compileLambda: expr
[
    self := self withEnvironment: GlobalEnvironment inner.
    vpu
	defineLabel: entry;
	iEnter.
    expr size >= 2 ifFalse: [self syntaxError: expr].
    expr second isArray ifFalse: [self syntaxError: expr].
    expr second do: [:formal |
	formal isSymbol ifFalse: [self syntaxError: expr].
	environment declareArgument: formal.
	vpu iArg].
    expr size == 2
	ifTrue:  [vpu ldInt: 0]
	ifFalse:
	   [environment := environment inner.	"scope for inner defines"
	    expr third compile: self.
	    expr from: 3 do: [:elt |
		vpu drop.
		elt compile: self].
	    vpu dropTmp: environment size.	"inner defines"
	    environment := environment outer].
    vpu
	ret;
	compile: CompileFlags debug: DebugFlags.
    CompilerLambdaCodeSize := CompilerLambdaCodeSize + vpu codeSize.
    LambdaDefinitionName notNil ifTrue: [self registerLambda_: entry _labelAddress size_: vpu codeSize _integerValue].
    ^entry
]

Compiler registerLambda_: _start size_: _size
[
    nil == LambdaRegisterFunction ifTrue: [^nil].
    self registerLambda_: _start size_: _size named_: LambdaDefinitionName _stringValue with_: LambdaRegisterFunction
]

Compiler registerLambda_: _start size_: _size named_: _name with_: _registrar
{
    ((void (*)(long, long, oop))v__registrar)((long)v__start, (long)v__start + (long)v__size, v__name);
}

Compiler compile: expr
[
    self := self new.
    vpu
	defineLabel: entry;
	iEnter.
    expr compile: self.
    vpu
	ret;
	compile: CompileFlags debug: DebugFlags.
    CompilerEvalCodeSize := CompilerEvalCodeSize + vpu codeSize.
    ^entry
]

Compiler integer: anInteger
[
    vpu ldInt: anInteger.
    ^nil
]

Compiler largeInteger: aLargeInteger
[
    aLargeInteger bitSize > 31
	ifTrue: [StdErr
		     nextPutAll: 'WARNING: ';
		     print: aLargeInteger bitSize + 1;
		     nextPutAll: '-bit signed constant ';
		     print: aLargeInteger;
		     nextPutAll: ' truncated to 32 bits\n'].
    vpu ldInt: aLargeInteger.
    ^nil
]

Compiler string: aString
[
    | bytes |
    bytes := aString _stringValue.
    LambdaLiterals addLast: (String value_: bytes).
    vpu note: aString.
    vpu ldPtr: bytes.
    ^nil
]

Compiler identifier: aSymbol
[
    | variable |
    variable := environment lookup: aSymbol.
    variable isNil ifTrue: [self undefinedError: aSymbol].
    vpu note: aSymbol.
    variable compileRead: self.
    ^nil
]

Compiler globalRead:  anAssociation	[ vpu ldPtr: anAssociation _valuePointer; rdw ]
Compiler globalWrite: anAssociation	[ vpu ldPtr: anAssociation _valuePointer; wrw ]

Compiler argumentRead:  anInteger	[ vpu ldArg: anInteger ]
Compiler argumentWrite: anInteger	[ vpu stArg: anInteger ]

Compiler temporaryRead:  anInteger	[ vpu ldTmp: anInteger ]
Compiler temporaryWrite: anInteger	[ vpu stTmp: anInteger ]

Compiler form: aForm
[
    | head syntax |
    aForm isEmpty ifTrue: [self syntaxError: aForm].
    head := aForm first.
    (syntax := environment lookupSyntax: head) ~~ nil	 ifTrue: [^self recompile: (self applySyntax: syntax with: aForm)].
    (syntax := SyntaxTable at: head ifAbsent: []) ~~ nil ifTrue: [^self recompile: (self performSyntax: syntax with: aForm)].
    "apply"
    aForm reverseDo: [:arg | arg compile: self].
    vpu iCalli: aForm size - 1.
    ^nil
]

Compiler performSyntax: syntax with: aForm
[
    | rewrite |
    rewrite := self perform: syntax with: aForm.
    SyntaxFlag
	ifTrue:
	   [StdErr nextPutAll: '  BUILTIN -> '; print: aForm; cr.
	    StdErr nextPutAll: '  REWRITE => '; print: rewrite; cr].
    ^rewrite.
]

Compiler applySyntax: syntax with: aForm
[
    | rewrite |
    SyntaxFlag ifTrue: [StdErr nextPutAll: '  SYNTAX  -> '; print: aForm; cr].
    rewrite := self applySyntax_: syntax with: aForm.
    SyntaxFlag ifTrue: [StdErr nextPutAll: '  REWRITE => '; print: rewrite; cr].
    ^rewrite.
]

Compiler applySyntax_: syntax with: aForm
{
    return ((_imp_t)v_syntax)(v_aForm, v_self);
}

Compiler recompile: anObject
[
    ^anObject isNil ifFalse: [anObject compile: self]
]

Compiler binary: aForm op: operator
[
    aForm size >= 3 ifFalse: [self syntaxError: aForm].
    aForm second compile: self.
    aForm from: 2 do: [:elt |
	elt compile: self.
	vpu perform: operator].
    ^nil
]

Compiler xPixAdd:  aForm	[ ^self binary: aForm op: #pixadd ]
Compiler xPixIn:   aForm	[ ^self binary: aForm op: #pixin  ]
Compiler xPixOver: aForm	[ ^self binary: aForm op: #pixover  ]

Compiler xAdd: aForm
[
    ^aForm size == 2
	ifTrue:  [aForm second compile: self]
	ifFalse: [self binary: aForm op: #add]
]

Compiler xSubtract: aForm
[
    aForm size >= 2 ifFalse: [self syntaxError: aForm].
    aForm size == 2
	ifTrue:
	   [vpu ldInt: 0.
	    aForm second compile: self.
	    vpu sub]
	ifFalse:
	   [aForm second compile: self.
	    aForm from: 2 do: [:elt |
		elt compile: self.
		vpu sub]].
    ^nil
]

Compiler xMultiply: aForm	[ ^self binary: aForm op: #mul ]
Compiler xFixMultiply: aForm	[ ^self binary: aForm op: #fixmul ]
Compiler xDivide: aForm		[ ^self binary: aForm op: #div ]
Compiler xFixDivide: aForm	[ ^self binary: aForm op: #fixdiv ]
Compiler xRemainder: aForm	[ ^self binary: aForm op: #mod ]

Compiler xAnd: aForm		[ ^self binary: aForm op: #and ]
Compiler xOr:  aForm		[ ^self binary: aForm op: #or  ]
Compiler xXor: aForm		[ ^self binary: aForm op: #xor ]

Compiler xLshift: aForm		[ ^self binary: aForm op: #lsl ]
Compiler xRshift: aForm		[ ^self binary: aForm op: #asr ]

Compiler relation: aForm op: op
[
    aForm size == 3 ifFalse: [self syntaxError: aForm].
    aForm second compile: self.
    aForm third  compile: self.
    vpu perform: op.
    ^nil.
]

Compiler xLess:         aForm	[ ^self relation: aForm op: #lt ]
Compiler xLessEqual:    aForm	[ ^self relation: aForm op: #le ]
Compiler xEqual:        aForm	[ ^self relation: aForm op: #eq ]
Compiler xNotEqual:     aForm	[ ^self relation: aForm op: #ne ]
Compiler xGreaterEqual: aForm	[ ^self relation: aForm op: #ge ]
Compiler xGreater:      aForm	[ ^self relation: aForm op: #gt ]

Compiler xNot: aForm
[
    aForm size == 2 ifFalse: [self syntaxError: aForm].
    aForm second compile: self.
    vpu not.
    ^nil.
]

Compiler xChar:  aForm		[ ^self read: aForm with: #rdb scaled: 1 ]
Compiler xShort: aForm		[ ^self read: aForm with: #rdh scaled: 2 ]
Compiler xInt:   aForm		[ ^self read: aForm with: #rdw scaled: 4 ]
Compiler xLong:  aForm		[ ^self read: aForm with: #rdw scaled: 4 ]

Compiler read: expr with: opcode scaled: scale		"(long addr) (long addr offset)"
[
    | size |
    size := expr size.
    (size == 2 or: [size == 3]) ifFalse: [self syntaxError: expr].
    expr second compile: self.
    size == 3
	ifTrue:
	   [expr third compile: self.
	    scale > 1 ifTrue: [vpu ldInt: scale; mul].
	    vpu add].
    vpu perform: opcode.
    ^nil
]

Compiler xSetChar:  aForm		[ ^self write: aForm with: #wrb scaled: 1 ]
Compiler xSetShort: aForm		[ ^self write: aForm with: #wrh scaled: 2 ]
Compiler xSetInt:   aForm		[ ^self write: aForm with: #wrw scaled: 4 ]
Compiler xSetLong:  aForm		[ ^self write: aForm with: #wrw scaled: 4 ]

Compiler write: expr with: opcode scaled: scale		"(set-long addr value) (set-long addr offset value)"
[
    | size |
    size := expr size.
    (size == 3 or: [size == 4]) ifFalse: [self syntaxError: expr].
    expr last compile: self.
    expr second compile: self.
    size == 4
	ifTrue:
	   [expr third compile: self.
	    scale > 1 ifTrue: [vpu ldInt: scale; mul].
	    vpu add].
    vpu perform: opcode.
    ^nil
]

Compiler xQuote: aForm
[
    | literal |
    aForm size == 2 ifFalse: [self syntaxError: aForm].
    vpu ldPtr: (literal := aForm second).
    (literal isSmallInteger or: [literal isNil]) ifFalse: [LambdaLiterals addLast: literal].
    ^nil
]

Compiler xSyntax: aForm
[
    | symbol syntax |
    aForm size == 3 ifFalse: [self syntaxError: aForm].
    syntax := aForm third _eval.
    environment define: aForm second syntax: syntax.
    vpu ldPtr: syntax.
    ^nil
]

Compiler xDefine: aForm
[
    | lvalue |
    aForm size == 3 ifFalse: [self syntaxError: aForm].
    ^(lvalue := aForm second) isSymbol
	ifTrue:  [self defineVariable: lvalue from: aForm third]
	ifFalse: [self defineAccessor: lvalue from: aForm third]
]

Compiler defineVariable: aSymbol from: expr
[
    environment isGlobalEnvironment
	ifTrue:
	   [LambdaDefinitionName := aSymbol.
	    (environment lookup: aSymbol) isNil ifTrue: [environment declare: aSymbol].
	    expr compile: self.
	    vpu note: aSymbol.
	    (environment lookup: aSymbol) compileWrite: self.
	    LambdaDefinitionName := nil]
	ifFalse:
	   [expr compile: self.
	    (environment bindings at: aSymbol ifAbsent: []) isNil
		ifTrue:
		   [environment bindings do: [:var | var value addOffset: 1].
		    environment bindings at: aSymbol put: (TemporaryVariable withValue: 0).
		    vpu iTmp].
	    vpu note: aSymbol.
	    (environment lookup: aSymbol) compileWrite: self].
    ^nil
]

Compiler defineAccessor: accessor from: expr	"(define (foo bar...) baz) -> (define-foo bar... baz)"
[
    | setter |
    (accessor isArray and: [accessor size > 0 and: [accessor first isSymbol]]) ifFalse: [self syntaxError: accessor].
    setter := WriteStream on: (Expression new: 8).
    setter nextPut: ('define-' , accessor first asString) asSymbol.
    accessor from: 1 do: [:elt | setter nextPut: elt].
    setter nextPut: expr.
    ^setter contents
]

Compiler xSet: aForm
[
    | lvalue |
    aForm size == 3 ifFalse: [self syntaxError: aForm].
    ^(lvalue := aForm second) isSymbol
	ifTrue:  [self setVariable: lvalue from: aForm third]
	ifFalse: [self setAccessor: lvalue from: aForm third]
]

Compiler setVariable: symbol from: expr
[
    | variable |
    expr compile: self.
    (variable := environment lookup: symbol) isNil ifTrue: [self undefinedError: symbol].
    vpu note: symbol.
    variable compileWrite: self.
    ^nil
]

Compiler setAccessor: accessor from: expr	"(set (foo bar...) baz) -> (set-foo bar... baz)"
[
    | setter syntax |
    (accessor isArray and: [accessor size > 0 and: [accessor first isSymbol]]) ifFalse: [self syntaxError: accessor].
    setter := WriteStream on: (Expression new: 8).
    setter nextPut: ('set-' , accessor first asString) asSymbol.
    accessor from: 1 do: [:elt | setter nextPut: elt].
    setter nextPut: expr.
    ^setter contents
]

Compiler xLogAnd: aForm
[
    vpu note: 'logAnd'.
    vpu begin:	1.
    vpu ldInt:	0.
    aForm from: 1 do: [:cond |
	cond compile: self.
	vpu bf: 0].
    vpu drop;
	ldInt:	1;
	define:	0;
	end:	1.
    ^nil
]

Compiler xLogOr: aForm
[
    vpu note: 'logOr'.
    vpu begin:	1.
    vpu ldInt:	1.
    aForm from: 1 do: [:cond |
	cond compile: self.
	vpu bt: 0].
    vpu drop;
	ldInt:	0;
	define:	0;
	end:	1.
    ^nil
]

Compiler xIf: aForm
[
    vpu note: 'if'.
    (aForm size == 3 or: [aForm size == 4]) ifFalse: [self syntaxError: aForm].
    vpu begin: 2.
    aForm second compile: self.			"condition"
    vpu bf: 0.
    aForm third compile: self.			"consequent"
    vpu br: 1.
    vpu define: 0.
    aForm size == 4
	ifTrue:  [aForm fourth compile: self]	"alternate"
	ifFalse: [vpu ldInt: 0].
    vpu define: 1.
    vpu end: 2.
    ^nil
]

Compiler xWhile: aForm
[
    | break continue |
    aForm size >= 2 ifFalse: [self syntaxError: aForm].
    vpu note: 'while'.
    aForm size == 2
	ifTrue:
	   [vpu begin: 1; define: 0.
	    aForm second compile: self.
	    vpu bt: 0; end: 1; ldInt: 0]
	ifFalse:
	   [continue := vpu newLocalLabel.
	    break    := vpu newLocalLabel.
	    loops addFirst: continue; addFirst: break.
	    vpu begin: 2; br: 1; define: 0.
	    aForm from: 2 do: [:expr |
		expr compile: self.
		vpu drop].
	    vpu define: 1.
	    loops removeFirst; removeFirst.
	    vpu defineLocalLabel: continue.
	    aForm second compile: self.
	    vpu bt: 0; end: 2; defineLocalLabel: break; ldInt: 0].
    ^nil
]

Compiler loopExit: aForm to: aLabel
[
    aForm size == 1 ifFalse: [self syntaxError: aForm].
    loops isEmpty ifTrue: [self error: 'break/continue outside while'].
    vpu brLocal: aLabel; ldInt: 0.
    ^nil
]

Compiler xBreak:    aForm	[ ^self loopExit: aForm to: loops first  ]
Compiler xContinue: aForm	[ ^self loopExit: aForm to: loops second ]

Compiler xLet: aForm
[
    | inner bindings |
    aForm size >= 2 ifFalse: [self syntaxError: aForm].
    (bindings := aForm second) isArray ifFalse: [self syntaxError: bindings in: aForm].
    environment := environment inner.
    bindings do: [:binding |
	(binding isArray and: [binding size == 2 and: [binding first isSymbol]])
	    ifFalse: [self syntaxError: binding in: aForm].
	environment declareTemporary: binding first].
    vpu note: 'let'.
    vpu iTmp: bindings size.
    bindings do: [:binding |
	binding second compile: self.
	vpu note: binding first.
	(environment lookup: binding first) compileWrite: self.
	vpu drop].
    aForm size == 2
	ifTrue:  [vpu ldInt: 0]
	ifFalse:
	   [aForm third compile: self.
	    aForm from: 3 do: [:expr |
		vpu drop.
		expr compile: self]].
    vpu dropTmp: environment size.	"inner defines"
    environment := environment outer.
    ^nil
]

Compiler xLambda: aForm
[
    vpu note: 'lambda'.
    vpu ldPtr: (self compileLambda: aForm) _labelAddress.
    ^nil
]

Compiler xReturn: aForm
[
    aForm size > 2 ifTrue: [self syntaxError: aForm].
    aForm size == 1
	ifTrue:  [vpu ldInt: 0]
	ifFalse: [aForm second compile: self].
    vpu	ret;
	ldInt:	0.	"expr must have a value"
    ^nil
]

LibidBindLabel := [ VPULabel lookup: #_libid_bind ]

Compiler xSend: aForm
[
    "(send selector receiver args...)"
    vpu note: 'send ', aForm second printString.
    aForm size >= 3 ifFalse: [self syntaxError: aForm].
    aForm from: 2 reverseDo: [:expr | expr compile: self].	"rcv arg..."
    vpu dup; dup.						"rcv rcv rcv arg..."
    aForm second compile: self.					"selector rcv rcv rcv arg..."
    vpu note: 'bind'.
    vpu	iCall:	2 label: LibidBindLabel;			"closure rcv rcv arg..."
	dup;							"closure closure rcv rcv arg..."
	rdw;							"method closure rcv rcv arg..."
	iCalli: aForm size.					"result"
    ^nil
]

"----------------------------------------------------------------"

Object eval	[ ^Integer value_: self _eval ]
Object _eval	[ ^self compile value ]
Object compile	[ ^Compiler compile: self ]

SmallInteger compile: compiler	[ ^compiler integer:      self ]
LargeInteger compile: compiler	[ ^compiler largeInteger: self ]
String       compile: compiler	[ ^compiler string:       self ]
Symbol       compile: compiler	[ ^compiler identifier:   self ]
Expression   compile: compiler	[ ^compiler form:         self ]
