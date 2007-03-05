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

  Last edited: 2007-03-05 11:33:31 by piumarta on emilia.local
"

{ import: Objects }
{ import: Expression }
{ import: Resource }
{ import: CompilerOptions }


InstructionCount := [ 0 ]

Instruction : Object  ( id parent type output clobbered nextLive )

Instruction id	[ ^id ]

Instruction new
[
    self := super new.
    id := InstructionCount := InstructionCount + 1.
]

Instruction parent: anInsn	[  parent := anInsn ]
Instruction parent		[ ^parent ]
Instruction type		[ ^type ]
Instruction output: aRegister	[  output := aRegister ]
Instruction output		[ ^output ]
Instruction nextLive: anInsn	[ ^nextLive := anInsn ]
Instruction nextLive		[ ^nextLive ]

Instruction isVoid		[ ^self class == #V ]


Block : Instruction (
    scope		"LocalEnvironment"
    instructions	"statements/expressions within the block"
    inputs		"top-level non-void expressions, candidates for the overall value of the block"
    class		"machine class of output value"
)

Instruction isBlock	[ ^false ]
Block       isBlock	[ ^true ]

Block new
[
    self := super new.
    instructions := OrderedCollection new.
    inputs := nil.    
    class := #V.
]

Block scope: anEnvironment	[ scope := anEnvironment ]

Block class			[ ^class ]

Block add: insn
[
    insn isVoid ifFalse: [class := insn class].
    ^instructions add: (insn parent: self)
]

Block addInput: insn
[
    inputs ifFalse: [inputs := OrderedCollection new].
    ^inputs add: insn
]



Leaf		: Instruction ( arg )	Leaf    arg [ ^arg ]	Leaf    arg: a	[ arg := a		]
Unary		: Instruction ( lhs )	Unary   lhs [ ^lhs ]	Unary   lhs: l	[ lhs := l parent: self ]
Binary		: Unary	      ( rhs )	Binary  rhs [ ^rhs ]	Binary  rhs: r	[ rhs := r parent: self ]

Parameter : Leaf ()

Call : Instruction (
    arguments	"function, argument expressions, leftmost first"
)

Call new
[
    self := super new.
    arguments := OrderedCollection new.
]

Call function: expr	[  arguments add: (expr parent: self) ]
Call function		[ ^arguments first ]

Call addArgument: expr	[  arguments add: (expr parent: self) ]
Call argumentAt: index	[ ^arguments at: index + 1 ]

Call arity		[ ^arguments size - 1 ]


Spill : Unary  ( location )

Instruction isSpill	[ ^false ]
Spill	    isSpill	[ ^true ]

Spill location: aTemp	[ location := aTemp ]

LabelCount := [ 0 ]

LABEL : Instruction ( ordinal _address )	LABEL name [ ^#label ]	LABEL class [ ^#V ]

LABEL new
[
    self := super new.
    ordinal := LabelCount := LabelCount + 1.
]

LABEL ordinal		[ ^ordinal ]

LABEL address_: _addr	[  _address := _addr ]
LABEL _address		[ ^_address ]

LABEL relocate_: _addr	{ self->v__address= (oop)((long)self->v__address + (long)v__addr); }

LABEL phaseCheck_: _addr	[ _addr == _address ifFalse: [self error: 'phase error'] ]

Branch : Instruction ( destination )

Branch destination: aLabel	[ destination := aLabel ]

BRA : Branch ()			BRA name [ ^#bra ]	BRA class	[ ^#V ]

ConditionalBranch : Unary ( destination )

ConditionalBranch destination: aLabel	[ destination := aLabel ]

BRZ  : ConditionalBranch ()	BRZ  name [ ^#brz  ]	BRZ  class	[ ^#V ]
BRNZ : ConditionalBranch ()	BRNZ name [ ^#brnz ]	BRNZ class	[ ^#V ]

NOP : Leaf ()

Instruction isNOP	[ ^false ]
NOP isNOP		[ ^true ]

NOP class		[ ^#V ]

NOP selectInstructions: gen	[]
NOP clobberRegisters: gen	[]
NOP allocateRegisters: gen	[]
NOP emit: gen	[]

"----------------------------------------------------------------"

" Choose concrete instructions and record each abstract insn's semantic type. "

Leaf   selectInstructions: gen	[ type := #REG ]
Unary  selectInstructions: gen	[ type := #REG.  lhs selectInstructions: gen ]
Binary selectInstructions: gen	[ type := #REG.  lhs selectInstructions: gen.  rhs selectInstructions: gen ]

Branch		  selectInstructions: gen	[ type := #VOID ]
ConditionalBranch selectInstructions: gen	[ type := #VOID.  lhs selectInstructions: gen ]
LABEL		  selectInstructions: gen	[ type := #VOID ]

LeafV	 : Leaf   ()	LeafV	 class [ ^#V ]
LeafI4	 : Leaf   ()	LeafI4   class [ ^#I4 ]
LeafP4	 : Leaf   ()	LeafP4   class [ ^#P4 ]
UnaryV   : Unary  ()	UnaryV   class [ ^#V  ]
UnaryI4  : Unary  ()	UnaryI4  class [ ^#I4 ]
BinaryI4 : Binary ()	BinaryI4 class [ ^#I4 ]

ADDI4   : BinaryI4 ()	ADDI4   name [ ^#addi4 ]
ANDI4   : BinaryI4 ()	ANDI4   name [ ^#andi4 ]
ASGNI1  : BinaryI4 ()	ASGNI1  name [ ^#asgni1 ]
ASGNI2  : BinaryI4 ()	ASGNI2  name [ ^#asgni2 ]
ASGNI4  : BinaryI4 ()	ASGNI4  name [ ^#asgni4 ]
CNSTI4  : LeafI4   ()	CNSTI4  name [ ^#cnsti4 ]
CNSTP4  : LeafP4   ()	CNSTP4  name [ ^#cnstp4 ]
DIVI4   : BinaryI4 ()	DIVI4   name [ ^#divi4 ]
DROP    : UnaryV   ()	DROP    name [ ^#drop ]
ENTER   : LeafV   ()	ENTER   name [ ^#enter ]
EQI4    : BinaryI4 ()	EQI4    name [ ^#eqi4 ]
LEI4    : BinaryI4 ()	LEI4    name [ ^#lei4 ]
LTI4    : BinaryI4 ()	LTI4    name [ ^#lti4 ]
GEI4    : BinaryI4 ()	GEI4    name [ ^#gei4 ]
GTI4    : BinaryI4 ()	GTI4    name [ ^#gti4 ]
INDIRI1	: UnaryI4  ()	INDIRI1	name [ ^#indiri1 ]
INDIRI2	: UnaryI4  ()	INDIRI2	name [ ^#indiri2 ]
INDIRI4	: UnaryI4  ()	INDIRI4	name [ ^#indiri4 ]
MODI4   : BinaryI4 ()	MODI4   name [ ^#modi4 ]
MULI4   : BinaryI4 ()	MULI4   name [ ^#muli4 ]
NEGI4   : UnaryI4  ()	NEGI4   name [ ^#negi4 ]
NEI4    : BinaryI4 ()	NEI4    name [ ^#nei4 ]
NOTI4   : UnaryI4  ()	NOTI4   name [ ^#noti4 ]
ORI4    : BinaryI4 ()	ORI4    name [ ^#ori4 ]
RETV    : LeafV   ()	RETV    name [ ^#retv ]
RETI4   : UnaryV   ()	RETI4   name [ ^#reti4 ]
SUBI4   : BinaryI4 ()	SUBI4   name [ ^#subi4 ]
SHLI4   : BinaryI4 ()	SHLI4   name [ ^#shli4 ]
SHRI4   : BinaryI4 ()	SHRI4   name [ ^#shri4 ]
XORI4   : BinaryI4 ()	XORI4   name [ ^#xori4 ]

CALLI4	: Call ()	CALLI4	name [ ^#calli4 ]	CALLI4  class	[ ^#I4 ]

PARAMI4	: Parameter ()	PARAMI4	name [ ^#parami4 ]	PARAMI4 class	[ ^#I4 ]

SPILLI4	: Spill ()	SPILLI4	name [^ #spilli4 ]	SPILLI4 class	[ ^#I4 ]

Address : LeafP4 ( variable )

ADDRFP4 : LeafP4  ()	ADDRFP4 name [ ^#addrfp4 ]
ADDRGP4 : Address ()	ADDRGP4 name [ ^#addrgp4 ]
ADDRJP4 : Address ()	ADDRJP4 name [ ^#addrjp4 ]
ADDRLP4 : Address ()	ADDRLP4 name [ ^#addrlp4 ]

"----------------------------------------------------------------"

Block selectInstructions: gen
[
    instructions do: [:insn | insn selectInstructions: gen].
]

Call selectInstructions: gen
[
    arguments do: [:arg | arg selectInstructions: gen].
    gen noteCall: self.
]

" Ask the codeGenerator to clobber registers in the receiver and all
  its children.  Keep the codeGenerator informed of the birth and
  death of values so that clobbered registers can be propagated to all
  affected outputs. "

Block clobberRegisters: codeGenerator
[
    instructions do: [:insn |
	insn clobberRegisters: codeGenerator.
	insn isVoid
	    ifFalse:
	       [(self addInput: codeGenerator lastLive) clobberAllRegistersIn: self.
		codeGenerator noteDead: insn]].
    inputs ifTrue: [codeGenerator noteLive: self]
]

Instruction clobberAllRegistersIn: insn
[
    clobbered ifTrue: [clobbered do: [:reg | insn clobberRegister: reg]]
]

Call clobberRegisters: codeGenerator
[
    arguments do: [:arg | arg clobberRegisters: codeGenerator].
    arguments from: 1 reverseDo: [:arg | codeGenerator noteDead: arg].
    codeGenerator clobberRegisters: self.
    codeGenerator noteDead: arguments first; noteLive: self.
]

Leaf clobberRegisters: codeGenerator
[
    codeGenerator noteLive: self; clobberRegisters: self
]

LeafV clobberRegisters: codeGenerator
[
    codeGenerator clobberRegisters: self.
]

Unary clobberRegisters: codeGenerator
[
    lhs clobberRegisters: codeGenerator.
    codeGenerator clobberRegisters: self
]

UnaryV clobberRegisters: codeGenerator
[
    lhs clobberRegisters: codeGenerator.
    codeGenerator clobberRegisters: self; noteDead: lhs.
]

Binary clobberRegisters: codeGenerator
[
    lhs clobberRegisters: codeGenerator.
    rhs clobberRegisters: codeGenerator.
    codeGenerator clobberRegisters: self; noteDead: rhs
]

Branch clobberRegisters: codeGenerator
[
    codeGenerator clobberRegisters: self
]

ConditionalBranch clobberRegisters: codeGenerator
[
    lhs clobberRegisters: codeGenerator.
    codeGenerator clobberRegisters: self; noteDead: lhs
]

LABEL clobberRegisters: codeGenerator	[]

" Sent from CodeGenerator>>clobberRegisters: for each register
  clobbered by the execution of the receiver. "

Instruction clobberRegister: aRegister
[
    clobbered isNil ifTrue: [clobbered := RegisterSet new].
    clobbered add: aRegister.
    CompilerOptions verboseRegs ifTrue: [StdOut tab; nextPutAll: '**** CLOBBER '; print: clobbered; nextPutAll: ' IN '; print: self; cr].
]

Instruction clobbers: aRegister	[ ^clobbered and: [clobbered includes: aRegister] ]

" Allocate an output register if needed.  Release any inputs that are
  dead after execution of the insn. "

Block allocateRegisters: codeGenerator
[
    | reg |
    scope notNil ifTrue: [scope valuesDo: [:var | var allocate: codeGenerator]].
    inputs
	ifTrue:
	   [reg := codeGenerator allocateRegister: self.
	    inputs do: [:insn | insn output: reg].
	    reg release].
    output := nil.	"no spill before block complete"
    instructions do: [:insn | insn allocateRegisters: codeGenerator; releaseSpill; releaseRegister].
    reg ifTrue: [output := reg allocate].
    scope notNil ifTrue: [scope valuesDo: [:var | var location release]].
    ^output
]

Call allocateRegisters: codeGenerator
[
    | reg |
    reg := output.
    output := nil.	"no spill before call complete"
    arguments do: [:arg | arg allocateRegisters: codeGenerator].
    arguments do: [:arg | arg releaseSpill; releaseRegister].
    output := reg.
    ^output := codeGenerator allocateRegister: self.
]

Leaf allocateRegisters: codeGenerator
[
    output := codeGenerator allocateRegister: self.
    ^output
]

Unary allocateRegisters: codeGenerator
[
    output := lhs allocateRegisters: codeGenerator.
    ^output
]

Binary allocateRegisters: codeGenerator
[
    lhs allocateRegisters: codeGenerator.
    rhs allocateRegisters: codeGenerator.
    rhs releaseRegister.
    lhs releaseSpill.
    ^output := lhs output
]

Branch allocateRegisters: codeGenerator [ ^nil ]

ConditionalBranch allocateRegisters: codeGenerator
[
    lhs allocateRegisters: codeGenerator; releaseRegister.
    ^nil
]

LABEL allocateRegisters: codeGenerator []

Instruction releaseRegister
[
    output
	ifTrue:
	   [(CompilerOptions verboseRegs and: [output]) ifTrue: [StdOut nextPutAll: 'release register '; print: self; cr].
	    output releaseRegister]
]

Instruction releaseSpill []

Spill	    releaseSpill
[
    CompilerOptions verboseRegs ifTrue: [StdOut nextPutAll: 'release spill '; print: self; cr].
    location release.
    output allocate.
]

" Sent from CodeGenerator>>allocateRegister: when all registers are in
  use.  Choose to spill the highest insn having a suitable register. "

Instruction spillRegisterFor: insn in: gen
[
    ^parent notNil ifTrue: [parent spillRegisterFor: insn in: gen]
]

Instruction canSpillFor: insn
[
    (output)			ifFalse: [CompilerOptions verboseRegs ifTrue: [StdOut nextPutAll: '  reg is nil\n'].	^nil].
    (output live)		ifFalse: [CompilerOptions verboseRegs ifTrue: [StdOut nextPutAll: '  reg dead\n'].	^nil].
    (self == insn)		ifTrue:  [CompilerOptions verboseRegs ifTrue: [StdOut nextPutAll: '  is target\n'].	^nil].
    (insn clobbers: output)	ifTrue:  [CompilerOptions verboseRegs ifTrue: [StdOut nextPutAll: '  clobbered\n'].	^nil].
    ^output
]

Spill canSpillFor: insn
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
	location: (gen allocateTemp: spill).
    ^spill
]

Binary spillRegisterFor: insn in: gen
[
    | reg |
    parent notNil ifTrue: [reg := parent spillRegisterFor: insn in: gen].
    reg notNil ifTrue: [^reg].
    CompilerOptions verboseRegs ifTrue:  [StdOut nextPutAll: '  trying '; print: self; nextPutAll: ' -> '; print: lhs; space; print: rhs; cr].
    (reg := lhs canSpillFor: insn) ifFalse: [^nil].
    CompilerOptions verboseRegs ifTrue: [StdOut nextPutAll: '  spilling '; print: lhs; cr].
    lhs := lhs spilledIn: gen.
    ^reg
]

Call spillRegisterFor: insn in: gen
[
    | reg |
    parent notNil ifTrue: [reg := parent spillRegisterFor: insn in: gen].
    reg notNil ifTrue: [^reg].
    CompilerOptions verboseRegs ifTrue: [StdOut nextPutAll: '  trying '; print: self; cr].
    arguments doWithIndex: [:arg :index |
	CompilerOptions verboseRegs ifTrue: [StdOut nextPutAll: '  ... trying '; print: arg; cr].
	(reg := arg canSpillFor: insn)
	    ifTrue:
	       [CompilerOptions verboseRegs ifTrue: [StdOut nextPutAll: '  spilling '; print: arg; cr].
		arguments at: index put: (arg spilledIn: gen).
		^reg]].
    ^nil
]

" Recursively emit concrete insns for an entire abstract insn tree. "

Block emit: gen
[
    instructions do: [:insn | insn emit: gen].
]

Call emit: gen
[
    arguments do: [:arg | arg emit: gen].
    gen perform: self name with: self
]

Leaf emit: gen
[
    gen perform: self name with: output with: arg
]

Unary emit: gen
[
    lhs emit: gen.
    gen perform: self name with: lhs output
]

Binary emit: gen
[
    lhs emit: gen.
    rhs emit: gen.
    lhs reload: gen.	"in case lhs was spilled"
    gen perform: self name with: lhs output with: rhs output
]

SPILLI4 emit: gen
[
    lhs emit: gen.
    gen spilli4 :lhs output :location
]

Branch		  emit: gen	[ gen perform: self name with: destination ]
ConditionalBranch emit: gen	[ lhs emit: gen.  gen perform: self name with: lhs output with: destination ]
LABEL		  emit: gen	[ gen perform: self name with: self ]

Instruction reload: gen	[]
SPILLI4	    reload: gen	[ gen reloadi4 :output :location ]

"----------------------------------------------------------------"

Instruction printOn: aStream
[
    aStream print: id; nextPut: $(.
    type notNil ifTrue: [aStream print: type; nextPut: $ ].
    super printOn: aStream.
    output notNil ifTrue: [aStream nextPut: $ ; print: output; nextPut: $,; print: output refCount].
    aStream nextPut: $).
    parent ifTrue: [aStream nextPut: $.; print: parent id].
]

Instruction printOn: aStream indent: i
[
    aStream cr.
    i timesRepeat: [aStream nextPutAll: '| '].
    aStream print: id; nextPut: $(.
    type notNil ifTrue: [aStream print: type; nextPut: $ ].
    super printOn: aStream.
    output notNil ifTrue: [aStream nextPut: $ ; print: output; nextPut: $,; print: output refCount].
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

Branch		  printInsnOn: aStream indent: i	[ aStream space; print: destination ]
ConditionalBranch printInsnOn: aStream indent: i	[ aStream space; print: destination.  super printInsnOn: aStream indent: i.   ]

LABEL	printInsnOn: aStream indent: i	[ aStream space; print: self ordinal ]

CNSTI4	printInsnOn: aStream indent: i	[ aStream space; print: (SmallInteger value_: arg) ]
CNSTP4	printInsnOn: aStream indent: i	[ aStream space; print: (SmallInteger value_: arg) ]

ADDRGP4	printInsnOn: aStream indent: i	[ aStream space; print: arg ]
