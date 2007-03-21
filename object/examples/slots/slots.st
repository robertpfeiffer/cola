{ import: st80 }	"Gets the built-in types (SmallInteger, Symbol, etc.)"

"----------------------------------------------------------------"

_object _new		[ ^self _vtable alloc: self _sizeof ]

"----------------------------------------------------------------"

_selector asString	[ ^String value_: self _string ]

_selector print		[ self asString print ]

"----------------------------------------------------------------"

_assoc key		[ ^key ]
_assoc value		[ ^value ]

_assoc withKey: aKey value: aValue
[
    self := self _new.
    key := aKey.
    value := aValue.
]

"----------------------------------------------------------------"

_closure setMethod: aMethod	[ ^_method := aMethod ]
_closure setData:   anObject	[ ^data := anObject ]

"----------------------------------------------------------------"

_vector  size			[ ^SmallInteger value_: _size ]

_vector at: anInteger
[
    {
        long index= (long)v_anInteger >> 1;
        if (((long)v_anInteger & 1) && (index >= 0) && (index < (long)self->v__size))
    	return ((oop *)v_self)[1 + index];
    }.
    ^self primitiveFailed
]

_vector at: anInteger put: anObject
[
    {
        long index= (long)v_anInteger >> 1;
        if (((long)v_anInteger & 1) && (index >= 0) && (index < (long)self->v__size))
    	return ((oop *)v_self)[1 + index]= v_anObject;
    }.
    ^self primitiveFailed
]

_vector grow
[
    | newVector newSize |
    newSize := self size * 2.
    newVector := self new_: newSize _integerValue.
    0 to: self size - 1 do: [:index | newVector at: index put: (self at: index)].
    ^newVector.
]

"----------------------------------------------------------------"

_vtable  tally			[ ^SmallInteger value_: _tally ]
_vtable  tally: anInteger	[  _tally := anInteger _integerValue ]

_vtable alloc: size
{
    oop *object= _palloc(sizeof(oop) + (v_size ? (size_t)v_size : 1));
    *object= v_self;
    return (oop)(object + 1);
}

_vtable findKeyOrNil: aSelector
[
    | assoc |
    0 to: self tally - 1 do: [:index | (assoc := bindings at: index) key == aSelector ifTrue: [^assoc]].
    ^nil
]

_vtable add: anAssociation
[
    | tally |
    (tally := self tally) == bindings size ifTrue: [bindings := bindings grow].
    bindings at: tally put: anAssociation.
    self tally: tally + 1.
    ^anAssociation
]

"<================ uncomment the first statement of the next method to show method dictionaries being built ================>"

_vtable methodAt: aSelector put: aMethod with: closureData
[
    | assoc |
    "('INSTALL: ', aSelector asString) putln."
    (assoc := self findKeyOrNil: aSelector) ifFalse: [assoc := self add: (_assoc withKey: aSelector value: _closure _new)].
    assoc value setMethod: aMethod.
    assoc value setData:   closureData.
    self flush.
    ^assoc value
]

"<================ uncomment the first statement of the next method to show methods being looked up ================>"

_vtable lookup: aSelector
[
    | assoc |
    "('LOOKUP: ', aSelector asString) putln."
    ^(assoc := self findKeyOrNil: aSelector)
	ifTrue:  [assoc]
	ifFalse: [delegate ifTrue: [delegate lookup: aSelector]].
]

"----------------------------------------------------------------"

{ import: st80 }	"Loads the Smalltalk-80-like library"

"----------------------------------------------------------------"

_vtable closureAt: aSelector
[
    | assoc |
    ^(assoc := self lookup: aSelector) ifTrue: [assoc value].
]

_vtable methodAt: aSelector
[
    | closure |
    ^(closure := self closureAt: aSelector) ifTrue: [closure _method].
]

_closure _method [ ^_method ]
_closure data [ ^data ]

_vtable universalGetter			[ ^_closure data ]
_vtable universalSetter: anObject	[ ^_closure data setData: anObject ]

Foo : Object ()

[
    Foo _vtable methodAt: #bar  asSelector
		put:      (_vtable _vtable methodAt: #universalGetter asSelector)
		with:     42.

    Foo _vtable methodAt: #bar: asSelector
		put:      (_vtable _vtable methodAt: #universalSetter: asSelector)
		with:     (Foo _vtable closureAt: #bar asSelector).

    Foo bar println.
    Foo bar: 666.
    Foo bar println.
]
