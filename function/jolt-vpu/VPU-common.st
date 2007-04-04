" VPU-common -- simplest possible VPU-like code generator

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

  Last edited: 2007-04-03 18:34:40 by piumarta on alan-kays-computer.local
"

{ import: Object }

VPULabel : Object ( _address defined definition )

VPULabel new
[
    self := super new.
    defined := false.
    definition := nil.
]

VPULabel lookup: name
[
    self := self new.
    self _address_: name asSymbol _dlsym.
]

VPULabel  definition: insn	[ ^definition := insn ]
VPULabel  definition		[ ^definition ]
VPULabel  defined		[ ^defined ]
VPULabel  noteDefined		[  defined := true ]
VPULabel _address		[ ^_address ]
VPULabel _address_: _addr	[ ^_address := _addr ]

VPULabel relocate_: _offset	{ self->v__address= (oop)((long)self->v__address + ((long)v__offset)); }

VPULabel value			{ /*printf("exec %p\n", self->v__address);*/  return ((oop (*)(void))self->v__address)(); }
"
VPULabel value:	a		{ return (oop)label_call1((CLabel *)self->v__label, (long)v_a >> 1); }
"

" xxx COMPAT xxx "

VPULabel _labelAddress		[ ^_address ]

"----------------------------------------------------------------"

Insn : Link ( location )

Insn location	[ ^location ]

Insn printOn: aStream
[
    super printOn: aStream.
    self printArgumentsOn: aStream.
]

Insn printArgumentsOn: aStream	[]


DefineLabel : Insn ( label )

DefineLabel with: aLabel
[
    self := self new.
    label := aLabel
]

DefineLabel printArgumentsOn: aStream	[ aStream nextPut: $(; print: label; nextPut: $) ]


Begin : Insn ( size )

Begin with: anInteger
[
    self := self new.
    size := anInteger.
]

Begin printArgumentsOn: aStream	[ aStream nextPut: $(; print: size; nextPut: $) ]


Define : Insn ( index label )

Define with: anInteger
[
    self := self new.
    index := anInteger.
]

Define printArgumentsOn: aStream	[ aStream nextPut: $(; print: index; nextPut: $) ]


End : Insn ( size )

End with: anInteger
[
    self := self new.
    size := anInteger.
]

End printArgumentsOn: aStream	[ aStream nextPut: $(; print: size; nextPut: $) ]


IEnter : Insn ()


IArg : Insn ( index argLocation )


ITmp : Insn ( index tmpLocation )

ITmp printArgumentsOn: aStream	[ aStream nextPut: $(; print: index; nextPutAll: ' => '; print: tmpLocation; nextPut: $) ]


DropTmp : Insn ()


LdFP : Insn ()


LdInt : Insn ( value )

LdInt with: anInteger
[
    self := self new.
    value := anInteger
]

File printd_: _value		[ self nextPutAll: (String format_: _value as: '%ld') ]
File printx_: _value		[ self nextPutAll: (String format_: _value as: '%lx') ]

WriteStream printd_: _value	[ self nextPutAll: (String format_: _value as: '%ld') ]
WriteStream printx_: _value	[ self nextPutAll: (String format_: _value as: '%lx') ]

String format_: _value as: fmt	[ ^self value_: (self _format_: _value as_: fmt _stringValue) ]

String _format_: _value as_: _fmt
{
    static char buf[32];
    sprintf(buf, (char *)v__fmt, (long)v__value);
    return (oop)buf;
}

LdInt printArgumentsOn: aStream	[ aStream nextPut: $(; printd_: value; nextPut: $) ]


LdPtr : LdInt ()

LdPtr printArgumentsOn: aStream	[ aStream nextPut: $(; printx_: value; nextPut: $) ]


LdArg : Insn ( index argLocation )

LdArg with: anInteger
[
    self := self new.
    index := anInteger
]

LdArg printArgumentsOn: aStream	[ aStream nextPut: $(; print: index; nextPutAll: ' => '; print: argLocation; nextPut: $) ]


StArg : Insn ( index argLocation )

StArg with: anInteger
[
    self := self new.
    index := anInteger
]

StArg printArgumentsOn: aStream	[ aStream nextPut: $(; print: index; nextPutAll: ' => '; print: argLocation; nextPut: $) ]


AddrArg : Insn ( index argLocation )

AddrArg with: anInteger
[
    self := self new.
    index := anInteger
]

AddrArg printArgumentsOn: aStream	[ aStream nextPut: $(; print: index; nextPutAll: ' => '; print: argLocation; nextPut: $) ]


LdTmp : Insn ( index tmpLocation )

LdTmp with: anInteger
[
    self := self new.
    index := anInteger
]

LdTmp printArgumentsOn: aStream	[ aStream nextPut: $(; print: index; nextPutAll: ' => '; print: tmpLocation; nextPut: $) ]


StTmp : Insn ( index tmpLocation )

StTmp with: anInteger
[
    self := self new.
    index := anInteger
]

StTmp printArgumentsOn: aStream	[ aStream nextPut: $(; print: index; nextPutAll: ' => '; print: tmpLocation; nextPut: $) ]


AddrTmp : Insn ( index tmpLocation )

AddrTmp with: anInteger
[
    self := self new.
    index := anInteger
]

AddrTmp printArgumentsOn: aStream	[ aStream nextPut: $(; print: index; nextPutAll: ' => '; print: tmpLocation; nextPut: $) ]


Dup : Insn ( index )

Dup with: anInteger
[
    self := self new.
    index := anInteger
]

Dup printArgumentsOn: aStream	[ aStream nextPut: $(; print: index; nextPut: $) ]


Drop : Insn ()

Rdb : Insn ()
Rdh : Insn ()
Rdw : Insn ()

Wrb : Insn ()
Wrh : Insn ()
Wrw : Insn ()

PixAdd : Insn ()
PixSub : Insn ()
PixMul : Insn ()
PixIn : Insn ()
PixOver : Insn ()
Add : Insn ()
Sub : Insn ()
Mul : Insn ()
FixMul : Insn ()
Div : Insn ()
FixDiv : Insn ()
Mod : Insn ()

And : Insn ()
Or  : Insn ()
Xor : Insn ()

Lsl : Insn ()
Lsr : Insn ()
Asr : Insn ()

Lt : Insn ()
Le : Insn ()
Eq : Insn ()
Ne : Insn ()
Ge : Insn ()
Gt : Insn ()

Not : Insn ()

Br : Insn ( index label )

Br with: anIntegerOrLabel
[
    self := self new.
    anIntegerOrLabel isSmallInteger ifTrue: [index := anIntegerOrLabel] ifFalse: [label := anIntegerOrLabel].
]

Br printArgumentsOn: aStream	[ aStream nextPut: $(; print: index; nextPutAll: ' => '; print: label; nextPut: $) ]


Bt : Insn ( index label )

Bt with: anIntegerOrLabel
[
    self := self new.
    anIntegerOrLabel isSmallInteger ifTrue: [index := anIntegerOrLabel] ifFalse: [label := anIntegerOrLabel].
]

Bt printArgumentsOn: aStream	[ aStream nextPut: $(; print: index; nextPutAll: ' => '; print: label; nextPut: $) ]


Bf : Insn ( index label )

Bf with: anIntegerOrLabel
[
    self := self new.
    anIntegerOrLabel isSmallInteger ifTrue: [index := anIntegerOrLabel] ifFalse: [label := anIntegerOrLabel].
]

Bf printArgumentsOn: aStream	[ aStream nextPut: $(; print: index; nextPutAll: ' => '; print: label; nextPut: $) ]


ICall : Insn ( arity label )

ICall withSize: anInteger label: aLabel
[
    self := self new.
    arity := anInteger.
    label := aLabel.
]

ICall printArgumentsOn: aStream	[ aStream nextPut: $(; print: arity; nextPutAll: ', '; print: label; nextPut: $) ]


ICalli : Insn ( arity )

ICalli withSize: anInteger
[
    self := self new.
    arity := anInteger.
]

ICalli printArgumentsOn: aStream	[ aStream nextPut: $(; print: arity; nextPut: $) ]


Ret : Insn ()


Note : Insn ( note )

Note with: aNote
[
    self := self new.
    note := aNote
]

Note printOn: aStream	[ aStream tab; nextPutAll: '# '; nextPutAll: note ]


"----------------------------------------------------------------"

VPU : Object (
    compileFlags	"compilation options"
    debugFlags		"debugging options"
    program		"LinkedList of Insns"
    argCount		"number of incoming arguments"
    stackDepth		"current depth of value stack"
    stackCount		"max depth of value stack"
    leaf		"true if no call insns appear"
    paramCount		"max number of outgoing parameters"
    tempDepth		"current number of live local variables"
    tempCount		"max number of live local variables"
    stackBase		"offset from SP of first temp value"
    tempBase		"offset from SP of first local variable"
    argBase		"offset from SP of first incoming argument"
    frameSize		"total size of frame (including linkage) in bytes"
    labels		"current contents of label stack, most recent first"
    _start		"address of first instruction generated"
    _end		"address of byte following last instruction generated"
)

" debug flags "

VPUDebugProg		:= [ 0x001 ]	VPU debugProg	  [ ^VPUDebugProg     ]
VPUDebugLabels		:= [ 0x002 ]	VPU debugLabels	  [ ^VPUDebugLabels   ]
VPUDebugStack		:= [ 0x004 ]	VPU debugStack	  [ ^VPUDebugStack    ]
VPUDebugDead		:= [ 0x008 ]	VPU debugDead	  [ ^VPUDebugDead     ]
VPUDebugAllocate	:= [ 0x010 ]	VPU debugAllocate [ ^VPUDebugAllocate ]
VPUDebugEmit		:= [ 0x020 ]	VPU debugEmit	  [ ^VPUDebugEmit     ]
VPUDebugNotes		:= [ 0x040 ]	VPU debugNotes	  [ ^VPUDebugNotes    ]
VPUDebugCode		:= [ 0x080 ]	VPU debugCode	  [ ^VPUDebugCode     ]

VPU warn: message	[ StdErr nextPutAll: 'WARNING: '; nextPutAll: message; cr ]

VPU _defaultMalloc	{ return (oop)malloc; }
VPU _defaultFree	{ return (oop)free; }

_malloc := [ VPU _defaultMalloc ]
_free   := [ VPU _defaultFree ]

VPU malloc: fn		[ _malloc := fn ]
VPU free: fn		[ _free := fn ]

VPU malloc_: _size	{ return ((oop (*)(oop))v__malloc)(v__size); }

VPU new
[
    self := super new.
    program := LinkedList new.
    labels := OrderedCollection new.
]


VPU dump: what
[
    StdOut nextPutAll: '----------------------------------------------------------------'; nextPutAll: what; cr.
    program do: [:insn | insn dump]
]

Insn dump		[ StdOut print: location; tab; print: self; cr]


VPU paramCount		[ ^paramCount ]
VPU tempCount		[ ^tempCount ]
VPU stackCount		[ ^stackCount ]

VPU tempDepth		[ ^tempDepth ]

VPU argBase		[ ^argBase ]
VPU tempBase		[ ^tempBase ]
VPU stackBase		[ ^stackBase ]

VPU frameSize		[ ^frameSize ]

VPU note: aString	[ program addLast: (Note with: aString) ]

VPU newLocalLabel	[ ^VPULabel new ]
VPU defineLocalLabel: l	[ program addLast: (DefineLabel with: l) ]
VPU defineLabel: l	[ program addLast: (DefineLabel with: l) ]

VPU begin: n		[ program addLast: (Begin  with: n) ]
VPU define: n		[ program addLast: (Define with: n) ]
VPU end: n		[ program addLast: (End	   with: n) ]

VPU iEnter		[ program addLast: IEnter new ]
VPU iArg		[ program addLast: IArg new ]
VPU iArg: n		[ n timesRepeat: [self iArg] ]

VPU iTmp		[ program addLast: ITmp new ]
VPU iTmp: n		[ n timesRepeat: [self iTmp] ]
VPU dropTmp		[ program addLast: DropTmp new ]
VPU dropTmp: n		[ n timesRepeat: [self dropTmp] ]

VPU ldFP		[ program addLast: LdFP new ]

VPU ldInt: n		[ program addLast: (LdInt with: n) ]
VPU ldPtr: p		[ program addLast: (LdPtr with: p) ]

VPU ldArg: n		[ program addLast: (LdArg with: n) ]
VPU stArg: n		[ program addLast: (StArg with: n) ]
VPU addrArg: n		[ program addLast: (AddrArg with: n) ]
VPU ldTmp: n		[ program addLast: (LdTmp with: n) ]
VPU stTmp: n		[ program addLast: (StTmp with: n) ]
VPU addrTmp: n		[ program addLast: (AddrTmp with: n) ]

VPU dup			[ self dup: 0 ]
VPU dup: n		[ program addLast: (Dup with: n) ]
VPU drop		[ program addLast: (Drop new) ]
VPU drop: n		[ n timesRepeat: [self drop] ]

VPU rdb			[ program addLast: Rdb new ]
VPU rdh			[ program addLast: Rdh new ]
VPU rdw			[ program addLast: Rdw new ]
VPU wrb			[ program addLast: Wrb new ]
VPU wrh			[ program addLast: Wrh new ]
VPU wrw			[ program addLast: Wrw new ]

VPU pixadd		[ program addLast: PixAdd new ]
VPU pixsub		[ program addLast: PixSub new ]
VPU pixmul		[ program addLast: PixMul new ]
VPU pixin		[ program addLast: PixIn new ]
VPU pixover		[ program addLast: PixOver new ]
VPU add			[ program addLast: Add new ]
VPU sub			[ program addLast: Sub new ]
VPU mul			[ program addLast: Mul new ]
VPU fixmul		[ program addLast: FixMul new ]
VPU div			[ program addLast: Div new ]
VPU fixdiv		[ program addLast: FixDiv new ]
VPU mod			[ program addLast: Mod new ]

VPU and			[ program addLast: And new ]
VPU or			[ program addLast: Or  new ]
VPU xor			[ program addLast: Xor new ]

VPU lsl			[ program addLast: Lsl new ]
VPU lsr			[ program addLast: Lsr new ]
VPU asr			[ program addLast: Asr new ]

VPU lt			[ program addLast: Lt new ]
VPU le			[ program addLast: Le new ]
VPU eq			[ program addLast: Eq new ]
VPU ne			[ program addLast: Ne new ]
VPU ge			[ program addLast: Ge new ]
VPU gt			[ program addLast: Gt new ]

VPU not			[ program addLast: Not new ]

VPU br: l		[ program addLast: (Br with: l) ]
VPU bt: l		[ program addLast: (Bt with: l) ]
VPU bf: l		[ program addLast: (Bf with: l) ]

VPU brLocal: l		[ self br: l ]

VPU iCall: n label: l	[ program addLast: (ICall withSize: n label: l) ]
VPU iCalli: n		[ program addLast: (ICalli withSize: n) ]

VPU ret			[ program addLast: Ret new ]

VPU compile		[ self  compile: 0 debug: 0 ]
VPU compile: c		[ self  compile: c debug: 0 ]

VPU codeSize
{
    return (oop)(((long)self->v__end - (long)self->v__start) << 1 | 1);
}

VPU versionString	[ ^'VPU 5.0 ', self targetString ]

"----------------------------------------------------------------"

VPU compile: c debug: d
[
    compileFlags := c.
    debugFlags := d.
    ""				(self debugFlag: VPUDebugProg    ) ifTrue: [self dump: 'program'].
    self makeLabels.		(self debugFlag: VPUDebugLabels  ) ifTrue: [self dump: 'labels'].
    self makeStack.		(self debugFlag: VPUDebugStack   ) ifTrue: [self dump: 'stack'].
    program last location == -1 ifFalse: [self error: 'stack not empty at end of program: ', program last location printString].
    self deleteDeadCode.	(self debugFlag: VPUDebugDead    ) ifTrue: [self dump: 'dead code'].
    self allocate.		(self debugFlag: VPUDebugAllocate) ifTrue: [self dump: 'allocate'].
    self emit.
]

VPU debugFlag: flag	[ ^(debugFlags bitAnd: flag) ~~ 0 ]

"----------------------------------------------------------------"

VPU makeLabels
[
    argCount := 0.
    paramCount := 0.
    tempDepth := tempCount := 0.
    program do: [:insn | insn makeLabels: self]
]

Insn		makeLabels: vpu	[]

Begin		makeLabels: vpu	[ vpu pushLabels: size ]
End		makeLabels: vpu	[ vpu popLabels: size ]

Br		makeLabels: vpu	[ label isNil ifTrue: [label := vpu labelAt: index] ]
Bt		makeLabels: vpu	[ label isNil ifTrue: [label := vpu labelAt: index] ]
Bf		makeLabels: vpu	[ label isNil ifTrue: [label := vpu labelAt: index] ]

DefineLabel	makeLabels: vpu	[ label definition
				      ifTrue:  [self error: 'multiply-defined label']
				      ifFalse: [label definition: self] ]

Define		makeLabels: vpu	[ label isNil ifTrue: [label := vpu labelAt: index].
				  label definition
				      ifTrue:  [self error: 'multiply-defined label']
				      ifFalse: [label definition: self] ]

VPU pushLabels: size	[ size timesRepeat: [labels addFirst: VPULabel new] ]
VPU popLabels: size	[ size timesRepeat: [labels removeFirst] ]
VPU labelAt: index	[ ^labels at: index ]

IArg		makeLabels: vpu	[ index := vpu pushArg ]
ITmp		makeLabels: vpu	[ index := vpu pushTmp ]
LdTmp		makeLabels: vpu	[ index := vpu tempDepth - 1 - index ]
StTmp		makeLabels: vpu	[ index := vpu tempDepth - 1 - index ]
AddrTmp		makeLabels: vpu	[ index := vpu tempDepth - 1 - index ]

DropTmp		makeLabels: vpu	[ vpu popTmp ]
ICall		makeLabels: vpu	[ vpu noteParams: arity ]
ICalli		makeLabels: vpu	[ vpu noteParams: arity ]

VPU pushArg	[ ^(argCount := argCount + 1) - 1 ]

VPU pushTmp
[
    (tempDepth := tempDepth + 1) > tempCount ifTrue: [tempCount := tempDepth].
    ^tempDepth - 1
]

VPU popTmp
[
    ^tempDepth := tempDepth - 1
]

VPU noteParams: arity
[
    leaf := false.
    arity > paramCount ifTrue: [paramCount := arity].
]

"----------------------------------------------------------------"

VPU makeStack
[
    stackDepth := stackCount := 0.
    leaf := true.
    self makeStackFrom: program first
]

VPU makeStackFrom: insn
[
    (insn location notNil and: [insn location ~~ self stackTop])
	ifTrue: [self warn: 'possible stack mismatch (', self stackTop printString, ' ', insn location printString ,') at: ', insn printString].
    [insn notNil and: [insn location isNil and: [insn makeStack: self]]]
	whileTrue:
	   [insn := insn nextLink].
]

Br		makeStack: vpu	[ location := vpu stackTop.
				  label definition isNil ifTrue: [self error: 'unconditional branch to undefined label'].
				  vpu makeStackFrom: label definition.
				  ^false ]

Bt		makeStack: vpu	[ location := vpu popStack.
				  label definition isNil ifTrue: [self error: 'conditional branch to undefined label'].
				  vpu makeStackFrom: label definition.
				  vpu setStack: location.
				  ^true ]

Bf		makeStack: vpu	[ location := vpu popStack.
				  label definition isNil ifTrue: [self error: 'conditional branch to undefined label'].
				  vpu makeStackFrom: label definition.
				  vpu setStack: location.
				  ^true ]

Note		makeStack: vpu	[ location := -1 ]
DefineLabel	makeStack: vpu	[ location := vpu stackTop ]
Define		makeStack: vpu	[ location := vpu stackTop ]
Begin		makeStack: vpu	[ location := vpu stackTop ]
End		makeStack: vpu	[ location := vpu stackTop ]
IEnter		makeStack: vpu	[ location := vpu stackTop ]
IArg		makeStack: vpu	[ location := vpu stackTop ]
ITmp		makeStack: vpu	[ location := vpu stackTop ]
DropTmp		makeStack: vpu	[ location := vpu stackTop ]
LdFP		makeStack: vpu	[ location := vpu pushStack ]
LdInt		makeStack: vpu	[ location := vpu pushStack ]
LdPtr		makeStack: vpu	[ location := vpu pushStack ]
LdArg		makeStack: vpu	[ location := vpu pushStack ]
StArg		makeStack: vpu	[ location := vpu stackTop ]
AddrArg		makeStack: vpu	[ location := vpu pushStack ]
LdTmp		makeStack: vpu	[ location := vpu pushStack ]
StTmp		makeStack: vpu	[ location := vpu stackTop ]
AddrTmp		makeStack: vpu	[ location := vpu pushStack ]
Dup		makeStack: vpu	[ location := vpu pushStack ]
Drop		makeStack: vpu	[ location := vpu popStack ]
Rdb		makeStack: vpu	[ location := vpu stackTop ]
Rdh		makeStack: vpu	[ location := vpu stackTop ]
Rdw		makeStack: vpu	[ location := vpu stackTop ]
Wrb		makeStack: vpu	[ location := vpu popStack ]
Wrh		makeStack: vpu	[ location := vpu popStack ]
Wrw		makeStack: vpu	[ location := vpu popStack ]
PixAdd		makeStack: vpu	[ location := vpu popStack ]
PixSub		makeStack: vpu	[ location := vpu popStack ]
PixMul		makeStack: vpu	[ location := vpu popStack ]
PixIn		makeStack: vpu	[ location := vpu popStack ]
PixOver		makeStack: vpu	[ location := vpu popStack ]
Add		makeStack: vpu	[ location := vpu popStack ]
Sub		makeStack: vpu	[ location := vpu popStack ]
Mul		makeStack: vpu	[ location := vpu popStack ]
FixMul		makeStack: vpu	[ location := vpu popStack ]
Div		makeStack: vpu	[ location := vpu popStack ]
FixDiv		makeStack: vpu	[ location := vpu popStack ]
Mod		makeStack: vpu	[ location := vpu popStack ]
And		makeStack: vpu	[ location := vpu popStack ]
Or		makeStack: vpu	[ location := vpu popStack ]
Xor		makeStack: vpu	[ location := vpu popStack ]
Lsl		makeStack: vpu	[ location := vpu popStack ]
Lsr		makeStack: vpu	[ location := vpu popStack ]
Asr		makeStack: vpu	[ location := vpu popStack ]
Lt		makeStack: vpu	[ location := vpu popStack ]
Le		makeStack: vpu	[ location := vpu popStack ]
Eq		makeStack: vpu	[ location := vpu popStack ]
Ne		makeStack: vpu	[ location := vpu popStack ]
Ge		makeStack: vpu	[ location := vpu popStack ]
Gt		makeStack: vpu	[ location := vpu popStack ]
Not		makeStack: vpu	[ location := vpu popStack; pushStack ]
ICall		makeStack: vpu	[ location := vpu popStack: arity - 1 ]
ICalli		makeStack: vpu	[ location := vpu popStack: arity ]
Ret		makeStack: vpu	[ location := vpu popStack ]

VPU pushStack
[
    (stackDepth := stackDepth + 1) > stackCount ifTrue: [stackCount := stackDepth].
    ^stackDepth - 1
]

VPU stackTop
[
    ^stackDepth - 1
]

VPU popStack
[
    ^(stackDepth := stackDepth - 1) - 1
]

VPU popStack: n
[
    ^(stackDepth := stackDepth - n) - 1
]

VPU setStack: n
[
    stackDepth := n + 1
]

"----------------------------------------------------------------"

VPU deleteDeadCode
[
    program do: [:insn |
	insn isDead
	    ifTrue:
	       [(self debugFlag: VPUDebugDead) ifTrue: [self warn: 'dead code: ', insn printString].
		program remove: insn]]
]

Insn isDead	[ ^location not ]

"----------------------------------------------------------------"

VPU allocate
[
    self allocateFrame.
    (self debugFlag: VPUDebugProg)
	ifTrue:
	   [StdOut
		nextPutAll:  'paramCount ';  print: paramCount;
		nextPutAll: ' tempCount ';   print: tempCount;
		nextPutAll: ' stackCount ';  print: stackCount;
		nextPutAll: ' tempBase ';    print: tempBase;
		nextPutAll: ' stackBase ';   print: stackBase;
		nextPutAll: ' frameSize ';   print: frameSize; cr ].
    program do: [:insn | insn allocate: self].
]

Insn  allocate: vpu	[ location := 4 * location + vpu stackBase.							]
IArg  allocate: vpu	[						argLocation := 4 * index + vpu   argBase.	]
LdArg allocate: vpu	[ location := 4 * location + vpu stackBase.	argLocation := 4 * index + vpu   argBase.	]
StArg allocate: vpu	[ location := 4 * location + vpu stackBase.	argLocation := 4 * index + vpu   argBase.	]
AddrArg allocate: vpu	[ location := 4 * location + vpu stackBase.	argLocation := 4 * index + vpu   argBase.	]
ITmp  allocate: vpu	[						tmpLocation := 4 * index + vpu  tempBase.	]
LdTmp allocate: vpu	[ location := 4 * location + vpu stackBase.	tmpLocation := 4 * index + vpu  tempBase.	]
StTmp allocate: vpu	[ location := 4 * location + vpu stackBase.	tmpLocation := 4 * index + vpu  tempBase.	]
AddrTmp allocate: vpu	[ location := 4 * location + vpu stackBase.	tmpLocation := 4 * index + vpu  tempBase.	]

"----------------------------------------------------------------"

VPU  asmPass		[ ^SmallInteger value_: self _asmPass ]
VPU  asmPass:   n	[ self _asmPass_: n _integerValue ]
VPU  asmPC		[ ^SmallInteger value_: self _asmPC ]
VPU  asmPC:   n		[ self _asmPC_: n _integerValue ]

VPU emit
[
    | _ip |
    self asmPass: 0.
    self asmPC: 0.
    program do: [:insn | insn emit: self].
    self asmPass: 1.
    _start := self _asmPC_: (self malloc_: self _asmPC).
    labels do: [:label | label relocate_: self _asmPC].
    (self debugFlag: VPUDebugEmit)
	ifTrue:
	   [program do: [:insn |
	       StdOut tab; tab; tab; tab.  insn dump.
	       _ip := self _asmPC.
	       insn emit: self.
	       self flush_: _ip to_: self _asmPC.
	       self disassemble_: _ip to_: self _asmPC]]
	ifFalse:
	   [program do: [:insn | insn emit: self]].
    _end := self _asmPC.
    self flush_: _start to_: _end.
]

Note		emit: vpu	[ ]

DefineLabel	emit: vpu	[ vpu emitDefineLabel: label ]
Define		emit: vpu	[ vpu emitDefineLabel: label ]

VPU emitDefineLabel: aLabel
[
    self asmPass == 0
	ifTrue:
	   [aLabel defined ifTrue: [self error: 'multiply-defined label'].
	    aLabel _address_: self _asmPC.
	    labels addLast: aLabel.
	    aLabel noteDefined]
	ifFalse:
	   [aLabel _address == self _asmPC ifFalse: [self error: 'phase error']]
]

Begin	emit: vpu []
End	emit: vpu []
IArg	emit: vpu []	"may be overridden to save registers"
DropTmp	emit: vpu []
Drop	emit: vpu []

"----------------------------------------------------------------"

CodeGenerator : Object ()

CodeGenerator versionString	[ ^VPU targetString ]
