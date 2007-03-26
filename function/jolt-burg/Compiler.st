" Compiler.st -- translate Expressions to abstract Instructions

  Copyright (c) 2006, 2007 Ian Piumarta
  All rights reserved.

  Permission is hereby granted, free of charge, to any person obtaining a
  copy of this software and associated documentation files (the 'Software'),
  to deal in the Software without restriction, including without limitation
  the rights to use, copy, modify, merge, publish, distribute, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, provided that the above copyright notice(s) and this
  permission notice appear in all copies of the Software and that both the
  above copyright notice(s) and this permission notice appear in supporting
  documentation.

  THE SOFTWARE IS PROVIDED 'AS IS'.  USE ENTIRELY AT YOUR OWN RISK.

  Last edited: 2007-03-26 12:39:15 by piumarta on emilia
"

{ import: Objects }
{ import: Expression }
{ import: CodeGenerator }
{ import: Instruction }
{ import: CompilerOptions }

"----------------------------------------------------------------"

Variable : Object ( name )

Variable withName: nameSymbol
[
    self := self new.
    name := nameSymbol
]

Variable translateRvalue: compiler	[ ^INDIRI4 new lhs: (self translateLvalue: compiler) ]


GlobalVariable : Variable ( _storage )

GlobalVariable withName: nameSymbol
[
    self := super withName: nameSymbol.
    _storage := _object _palloc: 1.
]

GlobalVariable withName: nameSymbol value_: _value
[
    self := self withName: nameSymbol.
    { *((oop *)self->v__storage)= v__value; }.
]

GlobalVariable value_: _value			{ *((oop *)self->v__storage)= v__value; }
GlobalVariable _value				{ return *(oop *)self->v__storage; }

GlobalVariable _address				[ ^_storage ]
GlobalVariable translateLvalue: compiler	[ ^ADDRGP4 new arg: self ]

GlobalVariable printOn: aStream			[ aStream nextPutAll: name; nextPut: $=; print_x: _storage ]


LocalVariable : Variable ( location )

LocalVariable location				[ ^location ]
LocalVariable location: aTemporary		[  location := aTemporary ]
LocalVariable base				[ ^location base ]
LocalVariable offset				[ ^location offset ]
LocalVariable translateLvalue: compiler		[ ^ADDRLP4 new arg: self ]

LocalVariable allocate: codeGenerator		[ location := codeGenerator allocateTemp: self ]

LocalVariable printOn: aStream			[ aStream nextPutAll: name; nextPut: $=; print: location ]


ParameterVariable : LocalVariable ()

ParameterVariable allocate: codeGenerator	[ location := codeGenerator allocateParam: self ]


CompilerVariable : Variable ( _value )

CompilerVariable value_: _v	[ ^_value := _v ]
CompilerVariable _value		[ ^_value ]

"----------------------------------------------------------------"

Environment : IdentityDictionary ( syntax )

Environment lookupVariable: name	[ ^self at: name ifAbsent: [] ]

Environment lookupSyntax: name		[ ^syntax ifTrue: [syntax at: name ifAbsent: []] ]

Environment defineSyntax: name
[
    syntax ifFalse: [syntax := IdentityDictionary new].
    ^syntax at: name put: (CompilerVariable withName:  name)
]


GlobalEnvironment : Environment ()

GlobalEnvironment defineVariable: name			[ ^self at: name put: (GlobalVariable withName: name) ]
GlobalEnvironment defineVariable: name value_: _value	[ ^self at: name put: (GlobalVariable withName: name value_: _value) ]


LocalEnvironment : Environment ( parent )

LocalEnvironment withParent: parentEnvironment
[
    self := self new.
    parent := parentEnvironment.
]

LocalEnvironment parent	[ ^parent ]

LocalEnvironment lookupVariable: name	[ ^(super lookupVariable: name) ifNil: [parent lookupVariable: name] ]
LocalEnvironment lookupSyntax: name	[ ^(super lookupSyntax: name) ifNil: [parent lookupSyntax: name] ]

LocalEnvironment defineVariable: name	[ ^self at: name put: (LocalVariable withName: name) ]
LocalEnvironment defineParameter: name	[ ^self at: name put: (ParameterVariable withName: name) ]


TheGlobalEnvironment := [ GlobalEnvironment new ]

Symbol _dlsym		[ ^self _dlsym_: self _stringValue ]
Symbol _dlsym_: _string	{ return (oop)dlsym(RTLD_DEFAULT, (char *)v__string); }

[
    | _value |
    { v__value= (oop)RTLD_DEFAULT; }.  TheGlobalEnvironment defineVariable: #_RTLD_DEFAULT value_: _value.
    { v__value= (oop)RTLD_LAZY;    }.  TheGlobalEnvironment defineVariable: #_RTLD_LAZY    value_: _value.
    { v__value= (oop)RTLD_NOW;     }.  TheGlobalEnvironment defineVariable: #_RTLD_NOW     value_: _value.
    { v__value= (oop)RTLD_GLOBAL;  }.  TheGlobalEnvironment defineVariable: #_RTLD_GLOBAL  value_: _value.
    TheGlobalEnvironment defineVariable: #_dlsym value_: #dlsym _dlsym.
]

"----------------------------------------------------------------"

Compiler : Object ( environment labels generatorType breaks continues )

Compiler withGeneratorType: genType
[
    self := super new.
    environment := TheGlobalEnvironment.
    labels := OrderedCollection new.
    generatorType := genType.
    breaks := OrderedCollection new.
    continues := OrderedCollection new.
]

Compiler lookupSyntax: name ifAbsent: defaultBlock
[
    | var |
    var := environment lookupSyntax: name.
    ^var ifNil: defaultBlock
]

Compiler lookupVariable: name ifAbsent: defaultBlock
[
    | var |
    var := environment lookupVariable: name.
    ^var ifNil: defaultBlock
]

Compiler lookupVariable: name
[
    ^self lookupVariable: name ifAbsent: [self errorUndefined: name]
]

Compiler defineVariable: name	[ ^environment defineVariable: name ]
Compiler defineParameter: name	[ ^environment defineParameter: name ]

Compiler defineSyntax: name	[ ^environment defineSyntax: name ]

Compiler beginScope	[ ^environment := LocalEnvironment withParent: environment ]
Compiler endScope	[  environment := environment parent ]

Compiler labels		[ ^labels ]

Compiler newLabel	[ ^labels add: Label new ]

SyntaxTable := [
    IdentityDictionary new
	at: #+		 	put: #xAdd:;
	at: #-		 	put: #xSub:;
	at: #*		 	put: #xMul:;
	at: #/		 	put: #xDiv:;
	at: #%		 	put: #xMod:;
	at: #&		 	put: #xAnd:;
	at: #|		 	put: #xOr:;
	at: #^		 	put: #xXor:;
	at: #!		 	put: #xNot:;
	at: #<<		 	put: #xShl:;
	at: #>>		 	put: #xShr:;
	at: #<		 	put: #xLess:;
	at: #<=		 	put: #xLessEqual:;
	at: #==		 	put: #xEqual:;
	at: #!=		 	put: #xNotEqual:;
	at: #>=		 	put: #xGreaterEqual:;
	at: #>		 	put: #xGreater:;
	at: #'char@'	 	put: #xChar:;
	at: #'short@'	 	put: #xShort:;
	at: #'int@'	 	put: #xInt:;
	at: #'long@'	 	put: #xLong:;
	at: #'set-char@'  	put: #xSetChar:;
	at: #'set-short@' 	put: #xSetShort:;
	at: #'set-int@'   	put: #xSetInt:;
	at: #'set-long@' 	put: #xSetLong:;
	at: #quote	 	put: #xQuote:;
	at: #syntax	 	put: #xSyntax:;
	at: #define	 	put: #xDefine:;
	at: #set		put: #xSet:;
	at: #and		put: #xLogAnd:;
	at: #or		 	put: #xLogOr:;
	at: #not		put: #xNot:;
	at: #if		 	put: #xIf:;
	at: #while	 	put: #xWhile:;
	at: #break		put: #xBreak:;
	at: #continue		put: #xContinue:;
	at: #let		put: #xLet:;
	at: #lambda		put: #xLambda:;
	at: #return		put: #xReturn:;
	at: #extern		put: #xExtern:;
	yourself
]

"----------------------------------------------------------------"

Expression   translate: aCompiler	[ ^aCompiler translateExpression: self ]
SmallInteger translate: aCompiler	[ ^aCompiler translateInteger:    self ]
LargeInteger translate: aCompiler	[ ^aCompiler translateInteger:    self ]
String	     translate: aCompiler	[ ^aCompiler translateString:     self ]
Symbol	     translate: aCompiler	[ ^aCompiler translateSymbol:     self ]

Compiler translateInteger: anInteger
[
    ^CNSTI4 new arg: anInteger _integerValue
]

Compiler translateString: aString
[
    ^CNSTP4 new arg: aString _strdup
]

Compiler translateSymbol: aSymbol
[
    | var |
    var := self lookupVariable: aSymbol ifAbsent: [self errorUndefined: aSymbol].
    ^var translateRvalue: self
]

Compiler translateExpression: expr
[
    | head op |
    expr isEmpty ifTrue: [self errorSyntax: expr].
    head := expr first.
    head isSymbol
	ifTrue:
	   [(op := environment lookupSyntax: head)	ifTrue: [^self recompile: (self applySyntax:   op with: expr)].
	    (op := SyntaxTable at: head ifAbsent: [])	ifTrue: [^self recompile: (self performSyntax: op with: expr)]].
    ^self apply: expr
]

Compiler recompile: anObject
[
    ^anObject
	ifTrue:  [anObject translate: self]
	ifFalse: [NOP new]
]

Instruction translate: compiler	[]
Object translate: compiler	[ compiler errorSyntax: self ]

Compiler applySyntax: var with: form
[
    | rewrite |
    CompilerOptions verboseSyntax ifTrue: [StdOut nextPutAll: '  SYNTAX  -> '; print: form; cr].
    rewrite := self applySyntax_: var _value with: form.
    CompilerOptions verboseSyntax ifTrue: [StdOut nextPutAll: '  REWRITE => '; print: rewrite; cr].
    ^rewrite.
]

Compiler applySyntax_: _syntax with: form
{
    return ((_imp_t)v__syntax)(v_form, v_self);
}

Compiler performSyntax: aSelector with: form
[
    | rewrite |
    rewrite := self perform: aSelector with: form.
    CompilerOptions verboseSyntax ifTrue: [StdOut nextPutAll: '  BUILTIN -> '; print: form; cr; nextPutAll: '  REWRITE => '; print: rewrite; cr].
    ^rewrite.
]

Compiler apply: expr
[
    | call |
    (call := CALLI4 new) function: (expr first translate: self).
    expr from: 1 do: [:arg | call addArgument: (arg translate: self)].
    ^call
]

"----------------------------------------------------------------"

Compiler xAdd: expr
[
    expr size >= 3 ifFalse: [self errorArgumentCount: expr].
    expr := expr leftAssociated.
    ^ADDI4 new
	lhs: (expr second translate: self);
	rhs: (expr third  translate: self)
]

Compiler xSub: expr
[
    expr size == 2 ifTrue: [^NEGI4 new lhs: (expr second translate: self)].
    expr size >= 3 ifFalse: [self errorArgumentCount: expr].
    expr := expr leftAssociated.
    ^SUBI4 new
	lhs: (expr second translate: self);
	rhs: (expr third  translate: self)
]

Compiler xMul: expr
[
    expr size >= 3 ifFalse: [self errorArgumentCount: expr].
    expr := expr leftAssociated.
    ^MULI4 new
	lhs: (expr second translate: self);
	rhs: (expr third  translate: self)
]

Compiler xDiv: expr
[
    expr size >= 3 ifFalse: [self errorArgumentCount: expr].
    expr := expr leftAssociated.
    ^DIVI4 new
	lhs: (expr second translate: self);
	rhs: (expr third  translate: self)
]

Compiler xMod: expr
[
    expr size >= 3 ifFalse: [self errorArgumentCount: expr].
    expr := expr leftAssociated.
    ^MODI4 new
	lhs: (expr second translate: self);
	rhs: (expr third  translate: self)
]

Compiler xAnd: expr
[
    expr size >= 3 ifFalse: [self errorArgumentCount: expr].
    expr := expr leftAssociated.
    ^ANDI4 new
	lhs: (expr second translate: self);
	rhs: (expr third  translate: self)
]

Compiler xOr: expr
[
    expr size >= 3 ifFalse: [self errorArgumentCount: expr].
    expr := expr leftAssociated.
    ^ORI4 new
	lhs: (expr second translate: self);
	rhs: (expr third  translate: self)
]

Compiler xXor: expr
[
    expr size >= 3 ifFalse: [self errorArgumentCount: expr].
    expr := expr leftAssociated.
    ^XORI4 new
	lhs: (expr second translate: self);
	rhs: (expr third  translate: self)
]

Compiler xNot: expr
[
    expr size == 2 ifFalse: [self errorArgumentCount: expr].
    ^NOTI4 new lhs: (expr second translate: self)
]

Compiler xShl: expr
[
    expr size == 3 ifFalse: [self errorArgumentCount: expr].
    ^SHLI4 new
	lhs: (expr second translate: self);
	rhs: (expr third  translate: self)
]

Compiler xShr: expr
[
    expr size == 3 ifFalse: [self errorArgumentCount: expr].
    ^SHRI4 new
	lhs: (expr second translate: self);
	rhs: (expr third  translate: self)
]

Compiler xLess: expr
[
    | insn |
    expr size == 3 ifFalse: [self errorArgumentCount: expr].
    ^LTI4 new
	lhs: (expr second translate: self);
	rhs: (expr third  translate: self)
]

Compiler xLessEqual: expr
[
    expr size == 3 ifFalse: [self errorArgumentCount: expr].
    ^LEI4 new
	lhs: (expr second translate: self);
	rhs: (expr third  translate: self)
]

Compiler xEqual: expr
[
    expr size == 3 ifFalse: [self errorArgumentCount: expr].
    ^EQI4 new
	lhs: (expr second translate: self);
	rhs: (expr third  translate: self)
]

Compiler xNotEqual: expr
[
    expr size == 3 ifFalse: [self errorArgumentCount: expr].
    ^NEI4 new
	lhs: (expr second translate: self);
	rhs: (expr third  translate: self)
]

Compiler xGreaterEqual: expr
[
    expr size == 3 ifFalse: [self errorArgumentCount: expr].
    ^GEI4 new
	lhs: (expr second translate: self);
	rhs: (expr third  translate: self)
]

Compiler xGreater: expr
[
    expr size == 3 ifFalse: [self errorArgumentCount: expr].
    ^GTI4 new
	lhs: (expr second translate: self);
	rhs: (expr third  translate: self)
]

Compiler xChar: expr
[
    expr size == 2 ifTrue: [^INDIRI1 new lhs: (expr second translate: self)].
    expr size == 3 ifTrue: [^INDIRI1 new
				lhs: (ADDI4 new
					  lhs: (expr second translate: self);
					  rhs: (expr third  translate: self))].
    self errorArgumentCount: expr.
]

Compiler xShort: expr
[
    expr size == 2 ifTrue: [^INDIRI2 new lhs: (expr second translate: self)].
    expr size == 3 ifTrue: [^INDIRI2 new
				lhs: (ADDI4 new
					  lhs: (expr second translate: self);
					  rhs: (MULI4 new
						    lhs: (CNSTI4 new arg: 2 _integerValue);
						    rhs: (expr third translate: self)))].
    self errorArgumentCount: expr.
]

Compiler xInt: expr
[
    expr size == 2 ifFalse: [self errorArgumentCount: expr].
    ^INDIRI4 new lhs: (expr second translate: self)
]

Compiler xLong: expr
[
    expr size == 2 ifTrue: [^INDIRI4 new
				lhs: (expr second translate: self)].
    expr size == 3 ifTrue: [^INDIRI4 new
				lhs: (ADDI4 new
					  lhs: (expr second translate: self);
					  rhs: (MULI4 new
						    lhs: (CNSTI4 new arg: 4 _integerValue);
						    rhs: (expr third translate: self)))].
    self errorArgumentCount: expr.
]

Compiler xSetChar: expr
[
    expr size == 3 ifFalse: [self errorArgumentCount: expr].
    ^ASGNI1 new
	lhs: (expr third  translate: self);
	rhs: (expr second translate: self)
]

Compiler xSetShort: expr
[
    expr size == 3 ifTrue: [^ASGNI2 new
				lhs: (expr third  translate: self);
				rhs: (expr second translate: self)].
    expr size == 4 ifTrue: [^ASGNI2 new
				lhs: (expr fourth translate: self);
				rhs: (ADDI4 new
					  lhs: (expr second translate: self);
					  rhs: (MULI4 new
						    lhs: (CNSTI4 new arg: 2 _integerValue);
						    rhs: (expr third translate: self)))].
    self errorArgumentCount: expr.
]

Compiler xSetInt: expr
[
    expr size == 3 ifTrue: [^ASGNI4 new
				lhs: (expr third  translate: self);
				rhs: (expr second translate: self)].
    expr size == 4 ifTrue: [^ASGNI4 new
				lhs: (expr fourth translate: self);
				rhs: (ADDI4 new
					  lhs: (expr second translate: self);
					  rhs: (MULI4 new
						    lhs: (CNSTI4 new arg: 4 _integerValue);
						    rhs: (expr third translate: self)))].
    self errorArgumentCount: expr.
]

Compiler xSetLong: expr
[
    expr size == 3 ifTrue: [^ASGNI4 new
				lhs: (expr third  translate: self);
				rhs: (expr second translate: self)].
    expr size == 4 ifTrue: [^ASGNI4 new
				lhs: (expr fourth translate: self);
				rhs: (ADDI4 new
					  lhs: (expr second translate: self);
					  rhs: (MULI4 new
						    lhs: (CNSTI4 new arg: 4 _integerValue);
						    rhs: (expr third translate: self)))].
    self errorArgumentCount: expr.
]

CompilerLiterals := [ OrderedCollection new ]

Compiler xQuote: expr
[
    | literal |
    expr size == 2 ifFalse: [self errorAgumentCount: expr].
    literal := expr second.
    (literal isSmallInteger or: [literal isNil]) ifFalse: [CompilerLiterals addLast: literal].
    ^CNSTP4 new  arg: literal
]

Compiler xSyntax: form
[
    | name var _value |
    form size == 3			ifFalse: [self errorSyntax: form].
    (name := form second) isSymbol	ifFalse: [self errorSyntax: form].
    _value := form third _eval.
    var := "self lookupSyntax: name ifAbsent: ["self defineSyntax: name"]".
    var value_: _value.
    ^CNSTP4 new arg: _value
]

Compiler xDefine: form
[
    | lvalue |
    form size >= 2 ifFalse: [self errorSyntax: form].
    ^(lvalue := form second) isSymbol
	ifTrue:  [self defineVariable: lvalue from: form]
	ifFalse: [self defineAccessor: lvalue from: form]
]

Compiler defineVariable: name from: form
[
    | var value |
    (form size <= 3)			ifFalse:  [self errorSyntax: form].
    var := self lookupVariable: name	ifAbsent: [self defineVariable: name].
    value := form size == 3
	ifTrue:  [form third translate: self]
	ifFalse: [CNSTI4 new arg: nil].
    ^ASGNI4 new lhs: value; rhs: (var translateLvalue: self).
]

Compiler defineAccessor: accessor from: expr	"(define (foo bar...) baz) -> (set-foo bar... baz)"
[
    | setter syntax |
    (accessor isArray and: [accessor size > 0 and: [accessor first isSymbol]]) ifFalse: [self errorSyntax: accessor].
    setter := WriteStream on: (Expression new: 8).
    setter nextPut: ('define-' , accessor first asString) asSymbol.
    accessor from: 1 do: [:elt | setter nextPut: elt].
    expr from: 2 do: [:val | setter nextPut: val].
    ^setter contents
]

Compiler xSet: form
[
    | lvalue |
    form size == 3 ifFalse: [self errorSyntax: form].
    ^(lvalue := form second) isSymbol
	ifTrue:  [self setVariable: lvalue from: form third]
	ifFalse: [self setAccessor: lvalue from: form third]
]

Compiler setVariable: name from: expr
[
    | var value |
    var := self lookupVariable: name ifAbsent: [self errorUndefined: name].
    ^ASGNI4 new lhs: (expr translate: self); rhs: (var translateLvalue: self).
]

Compiler setAccessor: accessor from: expr	"(set (foo bar...) baz) -> (set-foo bar... baz)"
[
    | head op setter syntax |
    (accessor isArray and: [accessor size > 0 and: [accessor first isSymbol]])	ifFalse: [self errorSyntax: accessor].
    head := accessor first.
    (op := environment lookupSyntax: head) ifTrue:  [accessor := self applySyntax: op with: accessor].
    (accessor isArray and: [accessor size > 0 and: [accessor first isSymbol]])	ifFalse: [self errorSyntax: expr].
    setter := WriteStream on: (Expression new: 8).
    setter nextPut: ('set-' , accessor first asString) asSymbol.
    accessor from: 1 do: [:elt | setter nextPut: elt].
    setter nextPut: expr.
    ^setter contents
]

Compiler xLogAnd: form
[
    | block l1 l2 |
    l1 := self newLabel.
    l2 := self newLabel.
    block := Block new.
    form from: 1 do: [:expr | block add: (BRZ new destination: l1; lhs: (expr translate: self))].
    block
	add: (CNSTI4 new arg: 0);
	add: (BRA new destination: l2);
	add: l1;
	add: (CNSTI4 new arg: nil);
	add: l2.
    ^block
]

Compiler xLogOr: form
[
    | block l1 l2 |
    l1 := self newLabel.
    l2 := self newLabel.
    block := Block new.
    form from: 1 do: [:expr | block add: (BRNZ new destination: l1; lhs: (expr translate: self))].
    block
	add: (CNSTI4 new arg: nil);
	add: (BRA new destination: l2);
	add: l1;
	add: (CNSTI4 new arg: 0);
	add: l2.
    ^block
]

Compiler xIf: form
[
    | l1 l2 |
    (form size between: 3 and: 4) ifFalse: [self errorArgumentCount: form].
    l1 := self newLabel.
    l2 := self newLabel.
    ^Block new
	add: (BRZ new destination: l1; lhs: (form second translate: self));
	add: (form third translate: self);
	add: (BRA new destination: l2);
	add: l1;
	add: (form size == 4 ifTrue: [form fourth translate: self] ifFalse: [CNSTI4 new arg: nil]);
	add: l2;
	yourself
]

Compiler xWhile: form
[
    | block body continue break |
    form size > 1 ifFalse: [self errorArgumentCount: form].
    body     := self newLabel.
    continue := self newLabel.
    break    := self newLabel.
    breaks    addFirst: break.
    continues addFirst: continue.
    (block := Block new)
	add: (BRA new destination: continue);
	add: body.
    form from: 2 do: [:expr | block
	add: (DROP new lhs: (expr translate: self))].
    block
	add: continue;
	add: (BRNZ new destination: body; lhs: (form second translate: self));
	add: break;
	add: (CNSTI4 new arg: nil).
    breaks    removeFirst.
    continues removeFirst.
    ^block
]

Compiler xBreak: form		[ ^self escape: form in: breaks ]
Compiler xContinue: form	[ ^self escape: form in: continues ]

Compiler escape: form in: labelList
[
    | depth |
    (form size between: 1 and: 2) ifFalse: [self errorSyntax: form].
    form size == 1
	ifTrue:  [depth := 0]
	ifFalse: [(depth := form second) isSmallInteger ifFalse: [self errorSyntax: form]].
    (depth between: 0 and: labelList size - 1) ifFalse: [self errorLoop: form].
    ^BRA new destination: (labelList at: depth)
]

Compiler xLet: form
[
    | block specs |
    form size > 2 ifFalse: [self errorArgumentCount: form].
    (specs := form second) isExpression ifFalse: [self errorSyntax: form].
    block := Block new.
    block scope: self beginScope.
    specs do: [:binding |
	| name var |
	    (binding isExpression and: [binding size == 2 and: [(name := binding first) isSymbol]]) ifFalse: [self errorSyntax: form].
	var := self defineVariable: name.
	block add: (DROP new lhs: (ASGNI4 new
				       lhs: (binding second translate: self);
				       rhs: (var translateLvalue: self)))].
    form from: 2 to: form size - 2 do: [:expr | block add: (DROP new lhs: (expr translate: self))].
    block add: (form last translate: self).
    self endScope.
    ^block
]

Compiler xLambda: form
[
    ^ADDRJP4 new arg: (self compileLambda: form)
]

Compiler compileLambda: form
[
    | block entry last gen |
    self := self withGeneratorType: generatorType.
    (block := Block new)
	scope:	self beginScope;
	add:	(entry := self newLabel);
	add:	ENTER new.
    form second do: [:param |
	param isSymbol ifFalse: [self errorSyntax: form second].
	block add: (DROP new lhs: (PARAMI4 new arg: (self defineParameter: param)))].
    form from: 2 to: form size - 2 do: [:expr | block add: (DROP new lhs: (expr translate: self))].
    last := form last translate: self.
    last isVoid
	ifTrue:  [block add: last; add: RETV new]
	ifFalse: [block add: (RETI4 new lhs: last)].
    self endScope.
    CompilerOptions verboseTree ifTrue: [block printOn: StdOut indent: 2.  StdOut cr].
    gen := generatorType withLabels: labels.
    gen selectInstructions: block.    "block selectInstructions: gen."
    block findSources: gen registerFilter.
    CompilerOptions verboseTree ifTrue: [block printOn: StdOut indent: 2.  StdOut cr].
    gen lastLive ifTrue: [self error: 'compileLambda: codeGen begins with live register: ', gen lastLive printString].
    block clobberRegisters: gen.
    gen lastLive ifTrue: [self error: 'compileLambda: clobber ends with live register: ', gen lastLive printString].
    block allocateRegisters: gen registerAllocator.
    CompilerOptions verboseTree ifTrue: [block printOn: StdOut indent: 2.  StdOut cr].
    gen generate: block.    "gen emit: block."
    CompilerOptions verboseRegs ifTrue: [gen dumpResources].
    ^entry
]

Compiler xReturn: form
[
    ^RETI4 new lhs: (form second translate: self)
]

Compiler xExtern: form
[
    | name var |
    (form size == 2 and: [(name := form second) isSymbol]) ifFalse: [self errorSyntax: form].
    var := self lookupVariable: name ifAbsent: [self defineVariable: name].
    var value_: name _dlsym.
    generatorType defineVariable: name.
    ^CNSTP4 new arg: var _value
]

Compiler xCompile: form
[
    | result |
    (form size == 2 and: [form second isSymbol]) ifFalse: [self errorSyntax: form].
    generatorType isStatic ifTrue: [form from: 2 do: [:expr | result := expr _eval]].
    ^CNSTP4 new arg: result
]
 
Compiler xEvaluate: form
[
    | result |
    (form size == 2 and: [form second isSymbol]) ifFalse: [self errorSyntax: form].
    generatorType isDynamic ifTrue: [form from: 2 do: [:expr | result := expr _eval]].
    ^CNSTP4 new arg: result
]

"----------------------------------------------------------------"

Compiler errorUndefined: aSymbol	[ self error: 'undefined: ', aSymbol ]
Compiler errorSyntax: form		[ self error: 'syntax error: ', form printString ]
Compiler errorArgumentCount: form	[ self error: 'wrong number of aguments: ', form printString ]
Compiler errorLoop: form		[ self error: 'no loop: ', form printString ]

"----------------------------------------------------------------"

Compiler compile: anObject for: codeGeneratorType
[
    | block entry tree gen |
    self := self withGeneratorType: codeGeneratorType.
    (block := Block new)
	add: (entry := self newLabel);
	add: ENTER new.
    tree := anObject translate: self.
    tree isVoid
	ifTrue:  [block add: tree; add: RETV new]
	ifFalse: [block add: (RETI4 new lhs: tree)].
    CompilerOptions verboseTree ifTrue: [block printOn: StdOut indent: 2.  StdOut cr].
    gen := generatorType withLabels: labels.
    gen selectInstructions: block.    "block selectInstructions: gen."
    block findSources: gen registerFilter.
    CompilerOptions verboseTree ifTrue: [block printOn: StdOut indent: 2.  StdOut cr].
    gen lastLive ifTrue: [self error: 'compile: codeGen begins with live register: ', gen lastLive printString].
    block clobberRegisters: gen.
    gen lastLive ifTrue: [self error: 'compile: clobber ends with live register: ', gen lastLive printString].
    block allocateRegisters: gen registerAllocator.
    CompilerOptions verboseTree ifTrue: [block printOn: StdOut indent: 2.  StdOut cr].
    gen generate: block.    "gen emit: block."
    CompilerOptions verboseRegs ifTrue: [gen dumpResources].
    ^entry
]

Compiler registerLambdasWith: _function	[]

Object compile
[
    Compiler compile: self for: CodeGenerator default static
]

Object eval
[
    ^Integer value_: self _eval
]

Object _eval
[
    CompilerOptions verboseList ifTrue: [self compile].
    ^(Compiler compile: self for: CodeGenerator default dynamic) call
]

"----------------------------------------------------------------"

Label call
[
    | _result |
    CompilerOptions verboseExec ifTrue: [{ printf("call %p\n", self->v__address); }].
    { v__result= ((oop (*)(void))self->v__address)(); }.
    CompilerOptions verboseExec ifTrue: [{ printf("=> %d\n", (int)v__result); }].
    ^_result
]
