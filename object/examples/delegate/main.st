{ import: st80 }

{ include "send2.h" }

ClassVars : Object ( foo bar )

ClassVars foo: f	[  foo := f ]
ClassVars bar: b	[  bar := b ]
ClassVars foo		[ ^foo ]
ClassVars bar		[ ^bar ]

ClassVarsHolder := [ ClassVars new foo: 42; bar: 666 ]

InstVars : Object ( baz )

InstVars baz	[ ^baz ]

InstVars _delegate [ ^ClassVarsHolder ]

InstVars new: b
[
    self := super new.
    baz := b
]

InstVars printOn: aStream
[
    aStream
	print: self foo;
	nextPut: $,;
	print: self bar;
	nextPut: $,;
	print: self baz
]

[
    | a b |
    a := InstVars new: 'this is a'.
    b := InstVars new: 'this is bee'.
    a printString putln.
    b printString putln.
    ClassVarsHolder bar: 'look ma, class vars'.
    a printString putln.
    b printString putln.
]
