{ import: Objects }
{ import: Expression }
{ import: Resource }
{ import: Instruction }
{ import: CompilerOptions }

CodeGenerator : Object ( ccrs csrs temps params lastLive labels needsFrame parametersSize frameSize )

CodeGenerator withLabels: labelCollection
[
    self := self new.
    labels := labelCollection.
]

CodeGenerator new
[
    self := super new.
    ccrs  := RegisterSet new.
    csrs  := RegisterSet new.
    temps := OrderedCollection new.
    params := OrderedCollection new.
    lastLive := nil.
    labels := OrderedCollection new.
    needsFrame := false.
    parametersSize := 0.
    frameSize := 0.
]

CodeGenerator noteLive: insn
[
    insn nextLive: lastLive.
    lastLive := insn.
]

CodeGenerator noteDead: insn
[
    lastLive output == insn output ifFalse: [self error: 'CodeGenerator.noteDead internal error: ', insn printString].
    lastLive := lastLive nextLive.
]

CodeGenerator noteFree: insn
[
    lastLive == insn ifFalse: [self error: 'CodeGenerator.noteFree internal error: ', insn printString].
    lastLive := lastLive nextLive.
]

CodeGenerator lastLive		[ ^lastLive ]

CodeGenerator requireFrame	[ needsFrame := true ]

CodeGenerator dumpResources
[
    ccrs  do: [:reg | StdOut tab; print: reg refCount; tab; print: reg; cr].
    csrs  do: [:reg | StdOut tab; print: reg refCount; tab; print: reg; cr].
    temps do: [:tmp | StdOut tab; print: tmp refCount; tab; print: tmp; cr].
]

CodeGenerator clobberRegister: aRegister
[
    | insn |
    insn := lastLive.
    [insn]
	whileTrue:
	   [insn clobberRegister: aRegister.
	    insn := insn nextLive]
]

CodeGenerator allocateRegister: insn
[
    | reg |
    (reg := insn output) ifTrue: [^reg allocate].
    (reg := ccrs allocate: insn) notNil
	ifTrue:
	   [CompilerOptions verboseRegs ifTrue: [StdOut nextPutAll: 'ALLOCATE '; print: reg; nextPutAll: ' TO '; print: insn; cr].
	    ^reg allocate].
    (reg := csrs allocate: insn) notNil
	ifTrue:
	   [CompilerOptions verboseRegs ifTrue: [StdOut nextPutAll: 'ALLOCATE '; print: reg; nextPutAll: ' TO '; print: insn; cr].
	    ^reg allocate].
    CompilerOptions verboseRegs ifTrue: [StdOut nextPutAll: 'looking for a register to spill for '; print: insn; cr].
    (insn parent notNil and: [reg := insn parent spillRegisterFor: insn in: self])
	ifFalse: [self error: 'could not find a register for ', insn printString].
    CompilerOptions verboseRegs ifTrue: [StdOut nextPutAll: 'ALLOCATE '; print: reg; nextPutAll: ' TO '; print: insn; cr].
    ^reg
]

CodeGenerator relocateLabels_: _addr
[
    labels do: [:label | label relocate_: _addr]
]

CodeGenerator enter :e		[ self emitPrologue ]
CodeGenerator parami4 :s	[]
CodeGenerator drop :s		[]
CodeGenerator argi4 :s		[]
CodeGenerator retv :s		[ self emitEpilogue ]
