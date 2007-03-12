" Instruction.st -- abstract instructions

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

  Last edited: 2007-03-12 14:28:14 by piumarta on emilia.local
"

{ import: Objects }
{ import: Expression }
{ import: Resource }
{ import: CompilerOptions }


InstructionCount := [ 0 ]

Instruction : Object (
    id		"SmallInteger - my unique identifier"
    parent	"Instruction that consumes the value of (or sequences) me"
    type	"Symbol - name of my output's resource class"
    source	"Instruction or nil - the instruction that allocates my output value"
    output	"Register or Location of my output value"
    clobbered	"RegisterSet of Registers that are clobbered while my output is live"
    nextLive	"Instruction most recently executed whose output is still live"
    generator	"Block evaluated to generate my machine code"
)

Instruction id	[ ^id ]

Instruction new
[
    self := super new.
    id     := InstructionCount := InstructionCount + 1.
    type   := #nil.
    source := nil.
]

Instruction parent: anInsn	[  parent := anInsn ]
Instruction parent		[ ^parent ]
Instruction type		[ ^type ]
Instruction source		[ ^source ]
Instruction output: aRegister	[  output := aRegister ]
Instruction output		[ ^output ]
Instruction nextLive: anInsn	[ ^nextLive := anInsn ]
Instruction nextLive		[ ^nextLive ]

Instruction isVoid			[ ^self subtypeResponsibility: 'isVoid' ]

Instruction clobberAllRegistersIn: insn
[
    clobbered ifTrue: [clobbered do: [:reg | insn clobberRegister: reg]]
]

Instruction clobberRegister: aRegister
[
    clobbered isNil ifTrue: [clobbered := RegisterSet new].
    clobbered add: aRegister.
    CompilerOptions verboseRegs ifTrue: [StdOut tab; nextPutAll: '**** CLOBBER '; print: clobbered; nextPutAll: ' IN '; print: self; cr].
]

Instruction findSources: filter		[ ^self subtypeResponsibility: 'findSources:' ]
Instruction clobberRegisters:	gen	[ ^self subtypeResponsibility: 'clobberRegisters:' ]
Instruction allocateRegisters:	alloc	[ ^self subtypeResponsibility: 'allocateRegisters:' ]

Instruction releaseRegister
[
    output
	ifTrue:
	   [(CompilerOptions verboseRegs and: [output]) ifTrue: [StdOut nextPutAll: 'release register '; print: self; cr].
	    output releaseRegister]
]

Instruction assertType: aSymbol
[
    type == aSymbol ifFalse: [self error: self debugName, ' type ', type printString, ' is not expected type ', aSymbol]
]

"neither generates nor consumes"

Statement : Instruction ()

Statement isVoid				[ ^true ]

Statement findSources: filter		[ ^nil ]
Statement clobberRegisters: gen		[ gen clobberRegisters: self ]
Statement allocateRegisters: alloc	[ self assertType: #VOID.  ^nil ]

"generates a value"

Leaf : Instruction ( arg )

Leaf arg: a	[  arg := a ]
Leaf arg	[ ^arg ]

Leaf isVoid	[ ^false ]

Leaf findSources: filter
[
    ^(filter perform: type) ifTrue: [source := self]
]

Leaf clobberRegisters: codeGenerator
[
    source ifTrue: [codeGenerator noteLive: self].
    codeGenerator clobberRegisters: self.
]

Leaf allocateRegisters: allocator
[
    ^source == self ifTrue: [output := allocator perform: type with: self]
]

"generates a value, consumes a value"

Unary : Instruction ( lhs )

Unary lhs: l	[  lhs := l parent: self ]
Unary lhs	[ ^lhs ]

Unary isVoid	[ ^false ]

Unary findSources: filter
[
    ^source := (lhs findSources: filter) ifNil: [(filter perform: type) ifTrue: [self]]
]

Unary clobberRegisters: codeGenerator
[
    lhs clobberRegisters: codeGenerator.
    source == self ifTrue: [codeGenerator noteLive: self].
    codeGenerator clobberRegisters: self.
]

Unary allocateRegisters: allocator
[
    lhs allocateRegisters: allocator.
    ^output := source == self ifTrue: [allocator perform: type with: self] ifFalse: [lhs output]
]

"generates a value, consumes two values"

Binary : Unary ( rhs )

Binary rhs: r	[  rhs := r parent: self ]
Binary rhs	[ ^rhs ]

Binary findSources: filter
[
    source := (lhs findSources: filter) ifNil: [(filter perform: type) ifTrue: [self]].
    rhs findSources: filter.
    ^source
]

Binary clobberRegisters: codeGenerator
[
    lhs clobberRegisters: codeGenerator.
    rhs clobberRegisters: codeGenerator.
    codeGenerator clobberRegisters: self.
    rhs source ifTrue: [codeGenerator noteDead: rhs].
    source == self ifTrue: [codeGenerator noteLive: self].
]

Binary allocateRegisters: allocator
[
    "self assertType: #REG."
    lhs allocateRegisters: allocator.
    rhs allocateRegisters: allocator.
    rhs releaseRegister.
    lhs releaseSpill.
    ^output := source == self ifTrue: [allocator perform: type with: self] ifFalse: [lhs output]
]

Binary spillRegisterFor: insn in: gen
[
    | reg |
    parent notNil ifTrue: [reg := parent spillRegisterFor: insn in: gen].
    reg notNil ifTrue: [^reg].
    CompilerOptions verboseRegs ifTrue:  [StdOut nextPutAll: '  trying '; print: self; nextPutAll: ' -> '; print: lhs; space; print: rhs; cr].
    (reg := lhs spilledRegisterFor: insn) ifFalse: [^nil].
    CompilerOptions verboseRegs ifTrue: [StdOut nextPutAll: '  spilling '; print: lhs; cr].
    lhs := lhs spilledIn: gen.
    ^reg
]

"consumes a value"

Sink : Unary ()

Sink isVoid	[ ^true ]

Sink allocateRegisters: allocator
[
    self assertType: #VOID.
    lhs allocateRegisters: allocator; releaseRegister.
    ^nil
]

Sink findSources: filter
[
    lhs findSources: filter.
    ^nil
]

Sink clobberRegisters: codeGenerator
[
    lhs clobberRegisters: codeGenerator.
    codeGenerator clobberRegisters: self.
    lhs source ifTrue: [codeGenerator noteDead: lhs].
]

"consumes zero or more values, generates zero or one value"

Block : Instruction (
    scope		"LocalEnvironment"
    instructions	"statements/expressions within the block"
    inputs		"top-level non-void expressions, candidates for the overall value of the block"
)

Instruction isBlock	[ ^false ]
Block       isBlock	[ ^true ]

Block name	[ ^#block ]

Block new
[
    self := super new.
    instructions := OrderedCollection new.
    inputs := nil.    
]

Block scope: anEnvironment	[ scope := anEnvironment ]

Block add: insn
[
    insn isVoid ifFalse: [inputs := OrderedCollection new].
    ^instructions add: (insn parent: self)
]

Block addInput: insn
[
    inputs ifFalse: [inputs := OrderedCollection new].
    ^inputs add: insn
]

Block isVoid	[ ^inputs isNil ]

Block setType: aSymbol
[
    type == #nil ifTrue: [^type := aSymbol].
    type == aSymbol ifFalse: [self error: 'cannot add input of type ', aSymbol, ' to block of type ', type].
]

Block findSources: filter
[
    instructions do: [:insn | (insn findSources: filter) ifTrue: [source := self]].
    ^source
]

Block clobberRegisters: codeGenerator
[
    instructions do: [:insn |
	insn clobberRegisters: codeGenerator.
	insn isVoid
	    ifFalse:
	       [(self addInput: codeGenerator lastLive) clobberAllRegistersIn: self.
		codeGenerator noteDead: insn.
		self setType: insn type]].
    (inputs isNil and: [source]) ifTrue: [self error: 'Block inputs and !source'].
    (source isNil and: [inputs]) ifTrue: [self error: 'Block source and !inputs'].
    inputs
	ifTrue:  [codeGenerator noteLive: self]
	ifFalse: [self setType: #VOID]
]

Block allocateRegisters: allocator
[
    | reg |
    self assertType: (source ifTrue: [#REG] ifFalse: [#VOID]).
    scope notNil ifTrue: [scope valuesDo: [:var | var allocate: allocator codeGenerator]].
    inputs
	ifTrue:
	   [reg := allocator perform: type with: self.
	    inputs do: [:insn | insn output: reg].
	    reg release].
    output := nil.	"avoid spill of pre-allocated output until block is complete"
    instructions do: [:insn | insn allocateRegisters: allocator; releaseSpill; releaseRegister].
    reg ifTrue: [output := reg allocate].
    scope notNil ifTrue: [scope valuesReverseDo: [:var | var location release]].
    ^output
]

"consumes one or more values, generates one value"

Call : Instruction (
    arguments	"function, argument expressions, leftmost first"
)

Call new
[
    self := super new.
    arguments := OrderedCollection new.
]

Call isVoid		[ ^false ]

Call function: expr	[  arguments add: (expr parent: self) ]
Call function		[ ^arguments first ]

Call addArgument: expr	[  arguments add: (expr parent: self) ]
Call argumentAt: index	[ ^arguments at: index + 1 ]

Call arity		[ ^arguments size - 1 ]

Call findSources: filter
[
    arguments do: [:arg | arg findSources: filter].
    ^(filter perform: type) ifTrue: [source := self]
]

Call clobberRegisters: codeGenerator
[
    type := #REG.
    arguments do: [:arg | arg clobberRegisters: codeGenerator].
    arguments from: 1 reverseDo: [:arg | codeGenerator noteDead: arg].
    codeGenerator clobberRegisters: self.
    arguments first source ifTrue: [codeGenerator noteDead: arguments first].
    source ifTrue: [codeGenerator noteLive: self].
]

Call allocateRegisters: allocator
[
    | reg |
    self assertType: (source ifTrue: [#REG] ifFalse: [#VOID]).
    reg := output.
    output := nil.	"avoid spill of pre-allocated output until call is complete"
    arguments do: [:arg | arg allocateRegisters: allocator].
    arguments do: [:arg | arg releaseSpill; releaseRegister].
    output := reg.
    ^source ifTrue: [output := allocator perform: type with: self].
]

Call spillRegisterFor: insn in: gen
[
    | reg |
    parent notNil ifTrue: [reg := parent spillRegisterFor: insn in: gen].
    reg notNil ifTrue: [^reg].
    CompilerOptions verboseRegs ifTrue: [StdOut nextPutAll: '  trying '; print: self; cr].
    arguments doWithIndex: [:arg :index |
	CompilerOptions verboseRegs ifTrue: [StdOut nextPutAll: '  ... trying '; print: arg; cr].
	(reg := arg spilledRegisterFor: insn)
	    ifTrue:
	       [CompilerOptions verboseRegs ifTrue: [StdOut nextPutAll: '  spilling '; print: arg; cr].
		arguments at: index put: (arg spilledIn: gen).
		^reg]].
    ^nil
]

"----------------------------------------------------------------"

Spill : Unary  ( location )

Instruction isSpill	[ ^false ]
Spill	    isSpill	[ ^true ]

Spill location: aTemp	[  location := aTemp ]
Spill location		[ ^location ]

Instruction releaseSpill []

Spill releaseSpill
[
    CompilerOptions verboseRegs ifTrue: [StdOut nextPutAll: 'release spill '; print: self; cr].
    location release.
    output allocate.
]

Instruction spillRegisterFor: insn in: gen
[
    ^parent notNil ifTrue: [parent spillRegisterFor: insn in: gen]
]

Instruction clobbers: aRegister	[ ^clobbered and: [clobbered includes: aRegister] ]

Instruction spilledRegisterFor: insn
[
    (output)			ifFalse: [CompilerOptions verboseRegs ifTrue: [StdOut nextPutAll: '  reg is nil\n'].	^nil].
    (output live)		ifFalse: [CompilerOptions verboseRegs ifTrue: [StdOut nextPutAll: '  reg dead\n'].	^nil].
    (self == insn)		ifTrue:  [CompilerOptions verboseRegs ifTrue: [StdOut nextPutAll: '  is target\n'].	^nil].
    (insn clobbers: output)	ifTrue:  [CompilerOptions verboseRegs ifTrue: [StdOut nextPutAll: '  clobbered\n'].	^nil].
    ^output
]

Spill spilledRegisterFor: insn
[
    CompilerOptions verboseRegs ifTrue: [StdOut nextPutAll: '  is spill\n'].
    ^false
]

Instruction spilledIn: gen
[
    | spill |
    spill := SPILLI4 new.
    spill
	output:   output;
	lhs:      self;
	location: (gen allocateSpill: spill).
    ^spill
]

Spill spilledIn: gen	[ self error: 'Spill.spilledIn: this cannot happen']

Spill	    emit:   gen	[ self subtypeResponsibility: 'emit:' ]

Instruction reload: gen	[]
Spill	    reload: gen	[ self subtypeResponsibility: 'reload:' ]

"----------------------------------------------------------------"

Branch : Statement ( destination )

Branch destination: aLabel	[  destination := aLabel ]
Branch destination		[ ^destination ]

Branch emit: gen		[ gen perform: self name with: destination ]

ConditionalBranch : Sink ( destination )

ConditionalBranch destination: aLabel	[  destination := aLabel ]
ConditionalBranch destination		[ ^destination ]

ConditionalBranch emit: gen		[ lhs emit: gen.  gen perform: self name with: lhs output with: destination ]

"----------------------------------------------------------------"

LabelCount := [ 0 ]

Label : Statement ( ordinal _address )	Label name [ ^#label ]

Label new
[
    self := super new.
    ordinal := LabelCount := LabelCount + 1.
]

Label ordinal		[ ^ordinal ]

Label address_: _addr	[  _address := _addr ]
Label _address		[ ^_address ]

Label relocate_: _addr	{ self->v__address= (oop)((long)self->v__address + (long)v__addr); }

Label phaseCheck_: _addr	[ _addr == _address ifFalse: [self error: 'phase error'] ]

"----------------------------------------------------------------"

ADDI4   : Binary ()		ADDI4   name [ ^#addi4	 ]
ADDRFP4 : Leaf ()		ADDRFP4 name [ ^#addrfp4 ]
ADDRGP4 : Leaf ()		ADDRGP4 name [ ^#addrgp4 ]
ADDRJP4 : Leaf ()		ADDRJP4 name [ ^#addrjp4 ]
ADDRLP4 : Leaf ()		ADDRLP4 name [ ^#addrlp4 ]
ANDI4   : Binary ()		ANDI4   name [ ^#andi4	 ]
ASGNI1  : Binary ()		ASGNI1  name [ ^#asgni1	 ]
ASGNI2  : Binary ()		ASGNI2  name [ ^#asgni2	 ]
ASGNI4  : Binary ()		ASGNI4  name [ ^#asgni4	 ]
BRA	: Branch ()		BRA	name [ ^#bra	 ]
BRNZ	: ConditionalBranch ()	BRNZ	name [ ^#brnz	 ]
BRZ	: ConditionalBranch ()	BRZ	name [ ^#brz 	 ]
CALLI4	: Call ()		CALLI4	name [ ^#calli4	 ]
CNSTI4  : Leaf ()		CNSTI4  name [ ^#cnsti4	 ]
CNSTP4  : Leaf ()		CNSTP4  name [ ^#cnstp4	 ]
DIVI4   : Binary ()		DIVI4   name [ ^#divi4	 ]
DROP    : Sink ()		DROP    name [ ^#drop	 ]
ENTER   : Statement ()		ENTER   name [ ^#enter	 ]
EQI4    : Binary ()		EQI4    name [ ^#eqi4	 ]
GEI4    : Binary ()		GEI4    name [ ^#gei4	 ]
GTI4    : Binary ()		GTI4    name [ ^#gti4	 ]
INDIRI1	: Unary ()		INDIRI1	name [ ^#indiri1 ]
INDIRI2	: Unary ()		INDIRI2	name [ ^#indiri2 ]
INDIRI4	: Unary ()		INDIRI4	name [ ^#indiri4 ]
LEI4    : Binary ()		LEI4    name [ ^#lei4	 ]
LTI4    : Binary ()		LTI4    name [ ^#lti4	 ]
MODI4   : Binary ()		MODI4   name [ ^#modi4	 ]
MULI4   : Binary ()		MULI4   name [ ^#muli4	 ]
NEGI4   : Unary ()		NEGI4   name [ ^#negi4	 ]
NEI4    : Binary ()		NEI4    name [ ^#nei4	 ]
NOP	: Statement ()		NOP	name [ ^#nop	 ]
NOTI4   : Unary ()		NOTI4   name [ ^#noti4	 ]
ORI4    : Binary ()		ORI4    name [ ^#ori4	 ]
PARAMI4	: Leaf ()		PARAMI4	name [ ^#parami4 ]
RETV    : Statement ()		RETV    name [ ^#retv	 ]
RETI4   : Sink ()		RETI4   name [ ^#reti4	 ]
SHLI4   : Binary ()		SHLI4   name [ ^#shli4	 ]
SHRI4   : Binary ()		SHRI4   name [ ^#shri4	 ]
SPILLI4	: Spill ()		SPILLI4	name [^ #spilli4 ]
SUBI4   : Binary ()		SUBI4   name [ ^#subi4	 ]
XORI4   : Binary ()		XORI4   name [ ^#xori4	 ]

"----------------------------------------------------------------"

SPILLI4 emit: gen
[
    lhs emit: gen.
    gen spilli4: lhs output to: location
]

SPILLI4 reload: gen	[ gen reloadi4: output from: location ]

"----------------------------------------------------------------"

Instruction reduceTo: aSymbol in: aGrammar for: gen
[
    "StdOut print: self; nextPutAll: ' reduceTo: '; nextPutAll: aSymbol; cr."
    (aGrammar startSetAt: aSymbol at: self name) do: [:rule |
	(self matchPattern: rule pattern in: aGrammar for: gen)
	    ifTrue:
	       ["StdOut print: self; nextPutAll: ' --> '; print: rule pattern; nextPutAll: ' -> '; print: rule symbol; cr."
		generator := rule action.
		^type := aSymbol]].
    ^self error: 'cannotReduce ', self name, ' to ', aSymbol
]

Block reduceTo: aSymbol in: aGrammar for: gen
[
    type := #nil.
    "StdOut print: self; nextPutAll: ' reduceTo: '; nextPutAll: aSymbol; cr."
    instructions do: [:insn | insn reduceTo: (insn isVoid ifTrue: [#VOID] ifFalse: [aSymbol]) in: aGrammar for: gen].
    type := aSymbol.
]

Call reduceTo: aSymbol in: aGrammar for: gen
[
    type := #nil.
    "StdOut print: self; nextPutAll: ' reduceTo: '; nextPutAll: aSymbol; cr."
    arguments from: 1 do: [:arg | arg reduceTo: #REG in: aGrammar for: gen].
    super reduceTo: aSymbol in: aGrammar for: gen.
    gen noteCall: self.
    type := aSymbol.
]

Instruction matchPattern: aPattern in: aGrammar for: gen
[
    "StdOut print: self; nextPutAll: ' matchPattern: '; print: aPattern; cr."
    ^aPattern isSymbol
	ifTrue:  [type == aPattern or: [self reduceTo: aPattern in: aGrammar for: gen]]
	ifFalse: [aPattern first == self name and: [self matchArguments: aPattern in: aGrammar for: gen]]
]

Instruction matchArguments: aPattern in: aGrammar for: gen	[ self subtypeResponsibility: 'matchArgments:in:for:' ]

Statement	  matchArguments: p in: g for: gen	[ ^true ]
Leaf   		  matchArguments: p in: g for: gen	[ ^true ]
Unary  		  matchArguments: p in: g for: gen	[ ^(lhs matchPattern: p second in: g for: gen) ]
Binary 		  matchArguments: p in: g for: gen	[ ^(lhs matchPattern: p second in: g for: gen) and: [rhs matchPattern: p third in: g for: gen] ]
Block  		  matchArguments: p in: g for: gen	[ ^true ]
Call   		  matchArguments: p in: g for: gen	[ ^self function matchPattern: p second in: g for: gen ]

Instruction generate: gen	[                                         		    generator ifTrue: [generator value: self value: gen] ]
Unary	    generate: gen	[ lhs generate: gen.                      		    generator ifTrue: [generator value: self value: gen] ]
Binary	    generate: gen	[ lhs generate: gen.  rhs generate: gen.  lhs reload: gen.  generator ifTrue: [generator value: self value: gen] ]
Block	    generate: gen	[ instructions do: [:i| i generate: gen].  		    generator ifTrue: [generator value: self value: gen] ]
Call	    generate: gen	[ arguments    do: [:i| i generate: gen].  		    generator ifTrue: [generator value: self value: gen] ]

Spill	    generate: gen	[ lhs generate: gen.  gen spilli4: self output to: self location ]

"----------------------------------------------------------------"

Instruction printOn: aStream
[
    aStream print: id; nextPut: $(.
    source == self ifTrue: [aStream nextPutAll: '+++ '] ifFalse: [source ifTrue: [aStream print: source id; nextPutAll: ' => ']].
    type
	ifTrue:  [aStream print: type; nextPut: $ ]
	ifFalse: [aStream nextPutAll: '--- '].
    super printOn: aStream.
    output
	ifTrue:  [aStream nextPut: $ ; print: output; nextPut: $,; print: output refCount]
	ifFalse: [aStream nextPutAll: ' ---'].
    aStream nextPut: $).
    parent ifTrue: [aStream nextPut: $.; print: parent id].
]

Instruction printOn: aStream indent: i
[
    aStream cr.
    i timesRepeat: [aStream nextPutAll: '| '].
    aStream print: id; nextPut: $(.
    source == self ifTrue: [aStream nextPutAll: '+++ '] ifFalse: [source ifTrue: [aStream print: source id; nextPutAll: ' => ']].
    type == #nil ifTrue: [aStream nextPutAll: '--- '] ifFalse: [aStream print: type; nextPut: $ ].
    super printOn: aStream.
    output
	ifTrue:  [aStream nextPut: $ ; print: output; nextPut: $,; print: output refCount]
	ifFalse: [aStream nextPutAll: ' ---'].
    self printInsnOn: aStream indent: i.
    aStream nextPut: $).
]

Block	printInsnOn: aStream indent: i	[ instructions do: [:insn | insn printOn: aStream indent: i + 1] ]

Call	printInsnOn: aStream indent: i
[
    arguments do: [:arg | arg printOn: aStream indent: i + 1].
]

Leaf    printInsnOn: aStream indent: i	[ aStream space; print: arg ]
Unary   printInsnOn: aStream indent: i	[ lhs printOn: aStream indent: i + 1 ]
Binary  printInsnOn: aStream indent: i	[ lhs printOn: aStream indent: i + 1.  rhs printOn: aStream indent: i + 1 ]

Statement  printInsnOn: aStream indent: i	[]

Branch		  printInsnOn: aStream indent: i	[ aStream space; print: destination ]
ConditionalBranch printInsnOn: aStream indent: i	[ aStream space; print: destination.  super printInsnOn: aStream indent: i.   ]

Label	printInsnOn: aStream indent: i	[ aStream space; print: self ordinal ]

CNSTI4	printInsnOn: aStream indent: i	[ aStream space; print: (SmallInteger value_: arg) ]
CNSTP4	printInsnOn: aStream indent: i	[ aStream space; print: (SmallInteger value_: arg) ]

ADDRGP4	printInsnOn: aStream indent: i	[ aStream space; print: arg ]
