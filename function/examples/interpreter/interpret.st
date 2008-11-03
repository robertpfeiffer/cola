{ import: Objects }

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
    _nlr	"opaque state for returning from the active block's home context's run loop"
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
    { v__closure= (oop)(((struct __send *)v__send)->closure);  v_nArgs= (oop)(((struct __send *)v__send)->nArgs << 1 | 1); }.
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

InterpretedBlockClosure : BlockClosure ( receiver code )

InterpretedBlockClosure receiver	[ ^receiver ]
InterpretedBlockClosure code		[ ^code ]

BlockClosure _nlr			[ ^_nlr ]

" Similarly for interpreted blocks. "

InterpretedBlockClosure interpretedBlock ...
[
    | block nArgs args _args |
    block := stateful_self.
    nArgs := block arity.
    nArgs > 0 ifTrue: [
	args := Array new: nArgs.
	args at: 0 put: self.
	_args := args _elements.
	{
	    int i, n= (long)v_nArgs >> 1;
	    for (i= 1;  i < n;  ++i) ((oop *)v__args)[i]= va_arg(ap, oop);
        }.
    ].
    ^(Context withCode: block code receiver: block receiver arguments: args) run: block _nlr.
]

InterpretedBlock := [ InterpretedBlockClosure _methodAt: #interpretedBlock ]

InterpretedBlockClosure arity: nArgs outer: outerBlock state: stateArray _nlr: _nlrState self: me code: codeArray
[
    self := self new.
    _function := InterpretedBlock.
    _arity    := nArgs _integerValue.
    outer     := outerBlock.
    state     := stateArray.
    _nlr      := _nlrState.
    receiver  := me.
    code      := codeArray.
]

Context block	"create closure from inline arguments"
[
    | nArgs body |
    nArgs := code at: (pc := pc + 1).
    body  := code at: (pc := pc + 1).
    self at: (sp := sp + 1) put: (InterpretedBlockClosure arity: nArgs outer: self state: nil _nlr: _nlr self: receiver code: body).
]

Context sblock	"create closure from stack arguments"
[
    | nArgs body |
    sp := sp - 1.
    nArgs := self at: sp + 1.
    body  := self at: sp.
    self at: sp put: (InterpretedBlockClosure arity: nArgs outer: self state: nil _nlr: _nlr self: receiver code: body).
]

Context nlReturn
[
    | answer |
    answer := self at: sp.
    sp := sp - 1.
  { _libid->nlreturn(self->v__nlr, v_answer); }.
]

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
    type _genericConstantAt: #_debugName   put: nameSymbol _stringValue.
    type _genericConstantAt: #_sizeof      put: (self sizeof + (self sizeofOop * slotNameArray size)) _integerValue.
    type _genericConstantAt: #allSlotNames put: self allSlotNames , slotNameArray.
    "install accessors for each of the slots in the new type"
    slotNameArray doWithIndex: [:slotName :index |
	type _genericGetterAt: slotName       put: self instVarCount + index.
	type _genericSetterAt: slotName , ':' put: self instVarCount + index].
    ^type new
]
    
Object withNewSlotNamed: slotName
[
    | clone |
    clone := (self newSubtypeNamed: self debugName asSymbol , #+ , slotName
		   withSlotNames:   (Array with: slotName)) new.
    self sizeof println.
    clone sizeof println.
    self shallowCopyInto: clone.
    ^clone
]

Object shallowCopyInto: anObject
[
    | _size |
    _size := self _sizeof.
    { memcpy(v_anObject, self, (long)v__size); }.
]

"----------------------------------------------------------------"

" Run the code within a Context.  Each instruction is dispatched as a
  message to the Context in a loop that terminates at the first
  instruction that answers nil, then answers the topmost item on the
  Context's stack. "

Context run
[
    ^self run: [:answer | ^answer] _nlr.
]

Context run: _nlrState
[
    _nlr := _nlrState.
    ["pc print. $\t put. (code at: pc + 1) println."
     self perform: (code at: (pc := pc + 1))] whileTrue.	"run until an insn wants to return"
    sp := sp - 1.
    ^self at: sp + 1.
]

" Instructions.  Should be self-explanatory.  Note that performance
  could be doubled easily by implementing inline versions of the
  arithmetic and/or special selectors that are inlined by the Id
  compiler.  Each such insn would save one computed message send. "

Context self		[ self at: (sp := sp + 1) put: receiver ]
Context arg		[ self at: (sp := sp + 1) put: (arguments at: (code at: (pc := pc + 1)) - 1) ]
Context arg1		[ self at: (sp := sp + 1) put: (arguments at: 0) ]
Context arg2		[ self at: (sp := sp + 1) put: (arguments at: 1) ]
Context push		[ self at: (sp := sp + 1) put: (code at: (pc := pc + 1)) ]
Context pushGlobal	[ self at: (sp := sp + 1) put: (code at: (pc := pc + 1)) asString asPrototype ]
Context pop		[ sp := sp - 1 ]

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

Context send3
[
    | s r a |
    s := code at: (pc := pc + 1).
    sp := sp - 3.
    r := self at: sp + 1.
    a := self at: sp + 2.
    a := self at: sp + 3.
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
