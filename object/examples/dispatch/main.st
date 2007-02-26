{ import: st80-imports }

Interpreter : Object ( program stack )

Interpreter withProgram: aProgram
[
    self := self new.
    program := aProgram.
    stack := OrderedCollection new.
]

Interpreter runWith: argument
[
    stack addLast: argument.
    self run
]

"----------------------------------------------------------------"

DumbInterpreter : Interpreter ()

DumbInterpreter run
[
    | pc insn |
    insn := program at: (pc := 1).
    [
	    insn == #push
		ifTrue:
		    [stack addLast: (program at: (pc := pc + 1)).
		     insn := program at: (pc := pc + 1)].
	    insn == #dup
		ifTrue:
		    [stack addLast: stack last.
		     insn := program at: (pc := pc + 1)].
	    insn == #add
		ifTrue:
		    [stack addLast: (stack removeLast + stack removeLast).
		     insn := program at: (pc := pc + 1)].
	    insn == #sub
		ifTrue:
		    [stack addLast: (stack removeLast negated + stack removeLast).
		     insn := program at: (pc := pc + 1)].
	    insn == #ceq
		ifTrue:
		    [stack addLast: (stack removeLast == stack removeLast).
		     insn := program at: (pc := pc + 1)].
	    insn == #bf
		ifTrue:
		    [stack removeLast
			 ifTrue:  [pc := pc + 1]
			 ifFalse: [pc := pc + 1 + (program at: (pc := pc + 1))].
		     insn := program at: (pc := pc + 1)].
	    insn == #jump
		ifTrue:
		    [insn := program at: (pc := (program at: (pc := pc + 1)))].
	    insn == #print
		ifTrue:
		    [stack removeLast println.
		     insn := program at: (pc := pc + 1)].
	    insn == #halt
		ifTrue:
		    ['HALT' putln.
		     ^nil]
    ] repeat
]

"----------------------------------------------------------------"

CleverInterpreter : Interpreter ( pc instructions )

CleverInterpreter new
[
    self := super new.
    instructions := IdentityDictionary new
	at: #push	put: (#xPush  asSelector);
	at: #dup	put: (#xDup   asSelector);
	at: #add	put: (#xAdd   asSelector);
	at: #sub	put: (#xSub   asSelector);
	at: #ceq	put: (#xCeq   asSelector);
	at: #bf		put: (#xBf    asSelector);
	at: #jump	put: (#xJump  asSelector);
	at: #print	put: (#xPrint asSelector);
	at: #halt	put: (#xHalt  asSelector);
	yourself
]

CleverInterpreter run
[
    pc := 0.
    [true] whileTrue: [self _perform: (instructions at: (program at: (pc := pc + 1)))].
]

CleverInterpreter xPush		[ stack addLast: (program at: (pc := pc + 1)) ]
CleverInterpreter xDup		[ stack addLast: stack last ]
CleverInterpreter xAdd		[ stack addLast: (stack removeLast + stack removeLast) ]
CleverInterpreter xSub		[ stack addLast: (stack removeLast negated + stack removeLast) ]
CleverInterpreter xCeq		[ stack addLast: (stack removeLast == stack removeLast) ]
CleverInterpreter xBf		[ pc := pc + (stack removeLast ifTrue:  [1] ifFalse: [1 + (program at: (pc := pc + 1))]) ]
CleverInterpreter xJump		[ pc := (program at: (pc := pc + 1)) - 1 ]
CleverInterpreter xPrint	[ stack removeLast println ]
CleverInterpreter xHalt		[ 'HALT' putln.  Smalltalk quit ]

"----------------------------------------------------------------"

FastInterpreter : Interpreter ( pc instructions instructionMap )

FastInterpreter new
[
    self := super new.
    instructions := #(push dup add sub ceq bf jump print halt).
    instructionMap := IdentityDictionary new.
    instructions doWithIndex: [:insn :index | instructionMap at: insn put: index].
    instructions := instructions collect: [:insn | insn asSelector].
]

Symbol isSymbol [ ^true ]
Object isSymbol [ ^false ]

FastInterpreter run
[
    | _words tmp |
    program := program collect: [:insn | insn isSymbol ifTrue: [self implementationAt: insn] ifFalse: [insn]].
    pc := 0.
    _words := program _elements.
    [true]
	whileTrue:
	   [tmp := pc.
	    pc := pc + 1.
	    { _imp_t imp= ((_imp_t *)v__words)[(long)v_tmp >> 1];
	      imp(0, v_self); }]
]

FastInterpreter implementationAt: aSymbol
[
    ^self _vtable methodAt: aSymbol asSelector
]

_vtable methodAt: aSelector
[
    | assoc |
    ^(assoc := self findKeyOrNil: aSelector) isNil ifFalse: [assoc value _method]
]

_object   isNil		[ ^false ]
_assoc    value		[ ^value ]
_closure _method	[ ^_method ]

FastInterpreter push		[ stack addLast: (program at: (pc := pc + 1)) ]
FastInterpreter dup		[ stack addLast: stack last ]
FastInterpreter add		[ stack addLast: (stack removeLast + stack removeLast) ]
FastInterpreter sub		[ stack addLast: (stack removeLast negated + stack removeLast) ]
FastInterpreter ceq		[ stack addLast: (stack removeLast == stack removeLast) ]
FastInterpreter bf		[ pc := pc + (stack removeLast ifTrue:  [1] ifFalse: [1 + (program at: (pc := pc + 1))]) ]
FastInterpreter jump		[ pc := (program at: (pc := pc + 1)) - 1 ]
FastInterpreter print		[ stack removeLast println ]
FastInterpreter halt		[ 'HALT' putln.  Smalltalk quit ]

"----------------------------------------------------------------"

[
"
    (DumbInterpreter withProgram: #(
	push 3
	push 4
	add
	print
	halt)) run.
    (CleverInterpreter withProgram: #(
	push 3
	push 4
	add
	print
	halt)) run.
    (FastInterpreter withProgram: #(
	push 3
	push 4
	add
	print
	halt)) run.
"
    false ifTrue: [
    'run dumb...' putln.
    (DumbInterpreter withProgram: #(
	"dup print"
	dup
	push 0
	ceq
	bf   1
	halt
	push 1
	sub
	jump 1)) runWith: 1000000.
    ] ifFalse: [
    'run fast...' putln.
    (FastInterpreter withProgram: #(
	"dup print"
	dup
	push 0
	ceq
	bf   1
	halt
	push 1
	sub
	jump 1)) runWith: 1000000.
    ]
]
