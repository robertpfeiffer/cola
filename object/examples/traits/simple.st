{ import: st80 }

_object _vtable: aVtable
{
    ((oop *)self)[-1]= v_aVtable;
}

VTable : _vtable ()

VTable _clone		[ ^self _vtable _alloc: self _sizeof ]
VTable _clone: size	[ ^self _vtable _alloc: size _integerValue ]
VTable new		[ ^self _clone initialize ]

VTable initialize
[
    super init; flush.
    delegate := _vtable _vtable.
]

VTableForMultipleDelegation : VTable ( delegates )

VTableForMultipleDelegation initialize
[
    super initialize.
    delegates := OrderedCollection new.
]

VTableForMultipleDelegation lookup: aSelector
[
    delegates do: [:obj | | assoc | (assoc := obj _vtable lookup: aSelector) == nil ifFalse: [^assoc]].
    ^delegate lookup: aSelector.
]

VTableForMultipleDelegation addDelegate: anObject
[
    delegates add: anObject
]

"----------------------------------------------------------------"

Foo : Object ()
[
    Foo _vtable: (VTableForMultipleDelegation new).
]

Bar : Object ()		Bar doit [ 'Bar.doit' putln ]		Bar foit [ 'Bar.foit' putln ]
Baz : Object ()		Baz doit [ 'Baz.doit' putln ]		Baz goit [ 'Baz.goit' putln ]

[
    Foo _vtable addDelegate: Bar.
    Foo _vtable addDelegate: Baz.
]

[
    Foo doit.
    Foo foit.
    Foo goit.
]

{ import: perform }

Qux : Baz ()

Object boo	[ 'Object.boo!' putln ]
Baz boo		[ 'Baz.boo!' putln ]
Qux boo		[ 'Qux.boo!' putln ]

Baz booit	[ self boo ]
Baz fooit	[ self perform: #boo ]
Baz gooit	[ self
		      in: Object perform: #boo;
		      in: Baz    perform: #boo;
		      in: Qux    perform: #boo ]

[ Qux booit ]
[ Qux fooit ]
[ Qux gooit ]
