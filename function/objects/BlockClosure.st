{ import: Objects }

StaticBlockClosure function_: _implementationAddress arity_: _argumentCount
[
    { v_self= v_stateful_self= _alloc(v_self, sizeof(*self)); }.
    _arity    := _argumentCount.
    _function := _implementationAddress.
]

StaticBlockClosure arity	[ ^SmallInteger value_: _arity ]

"evaluating"

StaticBlockClosure value
[
    { if ((int)self->v__arity == 0) return ((_imp_t)(self->v__function))(v__closure, v_self); }.
    ^self errorArgumentCount: 0
]

StaticBlockClosure value: a
[
    { if ((int)self->v__arity == 1) return ((_imp_t)(self->v__function))(v__closure, v_self, v_a); }.
    ^self errorArgumentCount: 1
]

StaticBlockClosure value: a value: b
[
    { if ((int)self->v__arity == 2) return ((_imp_t)(self->v__function))(v__closure, v_self, v_a, v_b); }.
    ^self errorArgumentCount: 1
]

StaticBlockClosure value: a value: b value: c
[
    { if ((int)self->v__arity == 3) return ((_imp_t)(self->v__function))(v__closure, v_self, v_a, v_b, v_c); }.
    ^self errorArgumentCount: 1
]

StaticBlockClosure value: a value: b value: c value: d
[
    { if ((int)self->v__arity == 4) return ((_imp_t)(self->v__function))(v__closure, v_self, v_a, v_b, v_c, v_d); }.
    ^self errorArgumentCount: 1
]

StaticBlockClosure value: a value: b value: c value: d value: e
[
    { if ((int)self->v__arity == 5) return ((_imp_t)(self->v__function))(v__closure, v_self, v_a, v_b, v_c, v_d, v_e); }.
    ^self errorArgumentCount: 1
]

"controling"

StaticBlockClosure whileTrue
[
    [self value] whileTrue: []
]

StaticBlockClosure whileTrue: aBlock
[
    self value
	ifTrue:
	   [aBlock value.
	    self whileTrue: aBlock].
]

StaticBlockClosure whileFalse
[
    [self value] whileFalse: []
]

StaticBlockClosure whileFalse: aBlock
[
    self value
	ifFalse:
	   [aBlock value.
	    self whileFalse: aBlock].
]

StaticBlockClosure repeat
[
    [true] whileTrue: [self value]
]


BlockClosure function_: _implementationAddress arity_: _argumentCount
	     outer: outerBlock state: variableArray nlr_: _dynamicEnvironment
[
    { v_self= v_stateful_self= _alloc(v_self, sizeof(*self)); }.
    _function := _implementationAddress.
    _arity    := _argumentCount.
    outer     := outerBlock.
    state     := variableArray.
    _nlr      := _dynamicEnvironment.
]
