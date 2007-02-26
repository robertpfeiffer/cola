{ import: st80 }

_selector isNil            [ ^false ]
_selector = aSelector      [ ^self == aSelector ]
_selector intern: aString  [ ^_selector _intern: aString _stringValue ]

_object _vtable: aVtable
{
    ((oop *)self)[-1]= v_aVtable;
}

_object isNil		[ ^false ]
_selector asSelector	[ ^self ]
_assoc value		[ ^value ]
_closure _method	[ ^_method ]
_closure data		[ ^data ]

_object ifNil: aBlock	[ ^self ]

_vtable methodAt: aSelector
[
    | assoc |
    ^(assoc := self findKeyOrNil: aSelector) isNil ifFalse: [assoc value _method]
]

TraitUtil : Object ()

TraitUtil forward
[
    self in: _closure data key perform: _closure data value
]

TraitUtil forward: anObject
[
    self in: _closure data key perform: _closure data value with: anObject
]

"--------------------------------------------------------------------------------------------------------------"

VTable : _vtable ()

VTable _clone		[ ^self _vtable _alloc: self _sizeof ]
VTable _clone: size	[ ^self _vtable _alloc: size _integerValue ]
VTable new		[ ^self _clone initialize ]

VTable initialize
[
    super init; flush.
    delegate := _vtable _vtable.
]

"--------------------------------------------------------------------------------------------------------------"

VTableForMultipleDelegation : VTable ( delegates )

VTableForMultipleDelegation initialize
[
    super initialize.
    delegates := OrderedCollection new.
]

VTableForMultipleDelegation lookup: aSelector
[
    delegates do: [:obj | | assoc | (assoc := obj _vtable lookup: aSelector) == nil ifFalse: [^assoc]].
    ^(super lookup: aSelector) ifNil: [delegate lookup: aSelector].
]

VTableForMultipleDelegation addDelegate: anObject
[
    delegates add: anObject
]

"--------------------------------------------------------------------------------------------------------------"

VTableForMethodExclusion : VTable ( delegateObject selectors )

VTableForMethodExclusion initialize
[
    super initialize.
    selectors := IdentitySet new.
]

VTableForMethodExclusion lookup: aSelector
[
    (selectors includes: aSelector) ifTrue: [^nil].
    ^delegateObject _vtable lookup: aSelector.
]

VTableForMethodExclusion delegateObject: anObject
[
    delegateObject := anObject
]

VTableForMethodExclusion addSelector: aSymbol
[
    selectors add: (_selector intern: aSymbol)
]

"--------------------------------------------------------------------------------------------------------------"

VTableForMethodAliasing : VTable ( delegateObject aliases )

VTableForMethodAliasing initialize
[
    super initialize.
    aliases := OrderedCollection new.
]

VTableForMethodAliasing lookup: aSelector
[
    aliases do: [:alias | alias key == aSelector ifTrue: [ ^delegateObject _vtable lookup: alias value]].
    ^delegateObject _vtable lookup: aSelector.
]

VTableForMethodAliasing delegateObject: anObject
[
    delegateObject := anObject
]

VTableForMethodAliasing addAlias: anAssociation
[
    anAssociation key: (_selector intern: anAssociation key).
    anAssociation value: (_selector intern: anAssociation value).
    aliases add: anAssociation. 
]

"--------------------------------------------------------------------------------------------------------------"

Object traitPlus: anObject
[
    | vt r |
    vt := VTableForMultipleDelegation new.
    vt addDelegate: self.
    vt addDelegate: anObject.
    r := Object _delegated.
    r _vtable: vt.
    ^r.
]

Object traitMinus: aSymbol
[
    | vt r |
    vt := VTableForMethodExclusion new.
    vt delegateObject: self.
    vt addSelector: aSymbol.
    r := Object _delegated.
    r _vtable: vt.
    ^r.
]

Object traitAlias: anAssociation
[
    | vt r |
    vt := VTableForMethodAliasing new.
    vt delegateObject: self.
    vt addAlias: anAssociation.
    r := Object _delegated.
    r _vtable: vt.
    ^r.
]

"--------------------------------------------------------------------------------------------------------------"

Foo : Object ()
Foo m [ 'this is Foo''s m' putln ]

Bar : Object ()
Bar m [ 'this is Bar''s m' putln ]

Baz : Object ( a b c )
[
  Baz := ((Foo traitAlias: #n->#m) traitMinus: #m) traitPlus: Bar.
]

[
  Baz new m; n.
]
