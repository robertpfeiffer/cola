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

Foo : Object ()
Bar : Object ()

Foo one		[ 'Foo one' putln ]
Foo two		[ 'Foo two' putln.  self one ]

Bar one		[ 'Bar one' putln ]
Bar two		[ 'Bar two' putln ]

Foo one: a	[ ('Foo one: ', a printString) putln ]
Foo two: a	[ ('Foo two: ', a printString) putln.  self one: a ]

Bar one: a	[ ('Bar one: ', a printString) putln ]
Bar two: a	[ ('Bar two: ', a printString) putln ]

Object forward
[
    self in: _closure data key perform: _closure data value
]

Object forward: anObject
[
    self in: _closure data key perform: _closure data value with: anObject
]

[
    | fwd0 fwd1 |
    fwd0 := Object _vtable methodAt: #forward  asSelector.
    fwd1 := Object _vtable methodAt: #forward: asSelector.

    Bar _vtable methodAt: #doit  asSelector put: fwd0 with: Foo -> #two.
    Bar _vtable methodAt: #doit: asSelector put: fwd1 with: Foo -> #one:.

    Bar doit.
    Bar doit: 42.
]
