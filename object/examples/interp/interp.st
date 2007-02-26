{ import: st80 }

_object isNil		[ ^false ]
_selector asSelector	[ ^self ]
_assoc value		[ ^value ]
_closure _method	[ ^_method ]
_closure data		[ ^data ]

_vtable methodAt: aSelector
[
    | assoc |
    ^(assoc := self findKeyOrNil: aSelector) isNil ifFalse: [assoc value _method]
]

Object testNative1	[ ^3 + 4 ]
Object testNative2	[ ^6 * 7 ]

Object interpret
[
    | prog pc stack |
    prog := _closure data.
    ('Object>>interpret: ', prog printString) putln.
    pc := 0.
    stack := OrderedCollection new.
    [true]
	whileTrue:
	   [| insn arg |
	    insn := (prog at: (pc := pc + 1)).
	    insn == #push   ifTrue: [stack addLast: (prog at: (pc := pc + 1))].
	    insn == #add    ifTrue: [| a b | a := stack removeLast.  b := stack removeLast.  stack addLast: a + b].
	    insn == #mul    ifTrue: [| a b | a := stack removeLast.  b := stack removeLast.  stack addLast: a * b].
	    insn == #return ifTrue: [^stack last]].
]

[
    | interp |

    Object testNative1 println.
    Object testNative2 println.

    interp := Object _vtable methodAt: #interpret asSelector.

    Object _vtable methodAt: #testInterp1 asSelector put: interp with: #(push 3 push 4 add return).
    Object _vtable methodAt: #testInterp2 asSelector put: interp with: #(push 6 push 7 mul return).
    Object testInterp1 println.
    Object testInterp2 println.

    Object _vtable methodAt: #testInterp1 asSelector put: interp with: #(push 3 push 4 mul return).
    Object _vtable methodAt: #testInterp2 asSelector put: interp with: #(push 6 push 7 add return).
    Object testInterp1 println.
    Object testInterp2 println.
]
