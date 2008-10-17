{ import: Object }

" A few primitives for inspecting and manipulating the size of and fields within an object. "

Object sizeof		[ ^SmallInteger value_: self _sizeof ]
Object sizeofOop	{ _return (oop)(sizeof(oop) << 1 | 1); }
Object instVarCount	[ ^self sizeof / self sizeofOop ]

Object instVarAt: offset		[ ^self instVarAt_: offset _integerValue ]
Object instVarAt: offset put: anObject	[ ^self instVarAt_: offset _integerValue put: anObject ]

Object instVarAt_: _offset			{ _return ((oop *)self)[(long)v__offset]; }
Object instVarAt_: _offset put: anObject	{ _return ((oop *)self)[(long)v__offset]= v_anObject; }

"----------------------------------------------------------------"

" The state of execution of a method is stored in a Context, one
  Context per method activation.  Context is derived from Array so
  that it can directly provide storage for the method's execution
  stack. "

Context : Array (
    sp		"SmallInteger -- the offset within me of the topmost item on the stack"
    pc		"SmallInteger -- the offset within me of the next instruction to execute"
    code	"Array of instructions and their inline arguments"
    receiver	"Object that received the message that caused this Context to be activated"
    arguments	"Array of the arguments passed to this method, or nil if came from a unary send"
)

Context withCode: codeArray receiver: anObject arguments: argumentArray
[
    self := super new: 32.
    pc := sp := -1.
    code := codeArray.
    receiver := anObject.
    arguments := argumentArray.
]

"----------------------------------------------------------------"

" All interpreted methods cause the following primitive method to be
  run.  It creates the Context for the interpreted activation, copies
  arguments (if any) and then asks the Context to run its code to
  completion. "

Object interpretedMethod ...
[
    | _send nArgs args _args |
    _send := _closure.
    { v__closure= (oop)(((struct __send *)v__send)->closure);  v_nArgs= ((struct __send *)v__send)->nArgs << 1 | 1; }.
    nArgs > 0 ifTrue: [
	args := Array new: nArgs.
	_args := args _elements.
	{
	    int i, n= ((struct __send *)v__send)->nArgs;
	    for (i= 0;  i < n;  ++i) ((oop *)v__args)[i]= va_arg(ap, oop);
        }.
    ].
    ^(Context withCode: _closure data receiver: self arguments: args) run.
]

" An interpreted method is stored in a vtable as a closure whose
  method is Object.interpretedMethod and whose data is the code array
  to be interpreted. "

InterpretedMethod := [ Object _methodAt: #interpretedMethod ]

_vtable interpretedMethodAt: selectorSymbol put: codeArray	[ self methodAt: selectorSymbol put: InterpretedMethod with: codeArray ]
Object _interpretedMethodAt: selectorSymbol put: codeArray	[ self _vtable interpretedMethodAt: selectorSymbol put: codeArray ]

" Some primitives for creating new types and accessing their slots. "

Object genericGetter
[
    { v__closure= (oop)(((struct __send *)v__closure)->closure); }.
    ^self instVarAt: _closure data.
]

GenericGetter := [ Object _methodAt: #genericGetter ]

_vtable genericGetterAt: selectorSymbol put: offsetInteger	[ self methodAt: selectorSymbol put: GenericGetter with: offsetInteger ]
Object _genericGetterAt: selectorSymbol put: offsetInteger	[ self _vtable genericGetterAt: selectorSymbol put: offsetInteger ]


Object genericSetter: anObject
[
    { v__closure= (oop)(((struct __send *)v__closure)->closure); }.
    ^self instVarAt: _closure data put: anObject.
]

GenericSetter := [ Object _methodAt: #genericSetter: ]

_vtable genericSetterAt: selectorSymbol put: offsetInteger	[ self methodAt: selectorSymbol put: GenericSetter with: offsetInteger ]
Object _genericSetterAt: selectorSymbol put: offsetInteger	[ self _vtable genericSetterAt: selectorSymbol put: offsetInteger ]


Object genericConstant
[
    { v__closure= (oop)(((struct __send *)v__closure)->closure); }.
    ^_closure data
]

GenericConstant := [ Object _methodAt: #genericConstant ]

_vtable genericConstantAt: selectorSymbol put: anObject	[ self methodAt: selectorSymbol put: GenericConstant with: anObject ]
Object _genericConstantAt: selectorSymbol put: anObject	[ self _vtable genericConstantAt: selectorSymbol put: anObject ]


Object newSubtypeNamed: nameSymbol withSlotNames: slotNameArray
[
    "Answer a new subtype of the receiver with the given name and slots."
    | type |
    "create an empty type delegating to the receiver's type"
    type := self _delegated.
    "install the methods required by the runtime system"
    type _genericConstantAt: #_debugName put: nameSymbol _stringValue.
    type _genericConstantAt: #_sizeof    put: (self sizeof + (self sizeofOop * slotNameArray size)) _integerValue.
    "install accessors for each of the slots in the new type"
    slotNameArray doWithIndex: [:slotName :index |
	type _genericGetterAt: slotName       put: self instVarCount + index.
	type _genericSetterAt: slotName , ':' put: self instVarCount + index].
    ^type.	"may it serve you well"
]

"----------------------------------------------------------------"

" Run the code within a Context.  Each instruction is dispatched as a
  message to the Context in a loop that terminates at the first
  instruction that answers nil, then answers the topmost item on the
  Context's stack. "

Context run
[
    [self perform: (code at: (pc := pc + 1))] whileTrue.	"run until an insn wants to return"
    sp := sp - 1.
    ^self at: sp + 1.
]

" Instructions.  Should be self-explanatory.  Note that performance
  could be doubled easily by implementing inline versions of the
  arithmetic and/or special selectors that are inlined by the Id
  compiler.  Each such insn would save one computed message send. "

Context self	[ self at: (sp := sp + 1) put: receiver ]
Context arg	[ self at: (sp := sp + 1) put: (arguments at: (code at: (pc := pc + 1)) - 1) ]
Context arg1	[ self at: (sp := sp + 1) put: (arguments at: 0) ]
Context push	[ self at: (sp := sp + 1) put: (code at: (pc := pc + 1)) ]
Context pop	[ sp := sp - 1 ]

Context dup
[
    | tos |
    tos := self at: sp.
    self at: (sp := sp + 1) put: tos.
]

Context send
[
    | s n r |
    n := code at: (pc := pc + 1).
    s := code at: (pc := pc + 1).
    sp := sp - n.
    r := self at: sp + 1.
    r := r perform: s withArguments: (self copyFrom: sp + 2 to: sp + n).
    self at: (sp := sp + 1) put: r.
]

Context send1
[
    | s r |
    s := code at: (pc := pc + 1).
    sp := sp - 1.
    r := self at: sp + 1.
    r := r perform: s.
    self at: (sp := sp + 1) put: r.
]

Context send2
[
    | s r a |
    s := code at: (pc := pc + 1).
    sp := sp - 2.
    r := self at: sp + 1.
    a := self at: sp + 2.
    r := r perform: s with: a.
    self at: (sp := sp + 1) put: r.
]

Context return
[
    ^nil
]

Context brt	"branch relative if true"
[
    sp := sp - 1.
    pc := pc + 1.
    (self at: sp + 1) ifTrue: [pc := pc + (code at: pc)].
]

Context brf	"idem false"
[
    sp := sp - 1.
    pc := pc + 1.
    (self at: sp + 1) ifFalse: [pc := pc + (code at: pc)].
]

"----------------------------------------------------------------"

" Demonstrations... "

[
    | Point aPoint |

    Object _interpretedMethodAt: #testInterp0 put: #(push 'Hello, interpreted world!' send1 putln return).

    Object testInterp0.

    Object _interpretedMethodAt: #testInterp1 put: #(push 6 push 7 send2  * return).	"small nArgs"
    Object _interpretedMethodAt: #testInterp2 put: #(push 6 push 7 send 2 * return).	"arbitrary nArgs"

    Object testInterp1 println.
    Object testInterp2 println.

    Point := Object newSubtypeNamed: #Point withSlotNames: #( x y ).

    Point _interpretedMethodAt: #r put: #(
	self send1 x dup send2 *	" x^2 "
	self send1 y dup send2 *	" y^2 "
	send2 +				" x^2 + y^2 "
	send1 sqrt			" sqrt(x^2 + y^2) "
	return).

    Point _interpretedMethodAt: #scaleBy: put: #(
	self self send1 x arg1 send2 * send2 x: pop	" self x: self x * arg1 "
	self self send1 y arg1 send2 * send2 y: pop	" self y: self y * arg1 "
	self return).

    (aPoint := Point new) x: 3; y: 4.
    aPoint r println.
    aPoint scaleBy: 2.
    aPoint r println.

    Integer _interpretedMethodAt: #nfibs put: #(
	self push 2 send2 < brf 3
	push 1 return
	self push 1 send2 - send1 nfibs
	self push 2 send2 - send1 nfibs
	push 1 send2 + send2 + return).

    (Time millisecondsToRun: [23 nfibs println]) println.
    "about 100,000 sends/second on my Q9450, compiled -O -g"
    "about 300,000 sends/second compiled -Op"
]
