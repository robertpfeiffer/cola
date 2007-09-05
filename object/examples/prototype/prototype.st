{ import: st80 }

{ include "send2.h" }

Prototype : Object ( next )

Prototype next: anObject
[
    next := anObject
]

Pring : Prototype ( string )

Pring withString: aString
[
    self := self new.
    string := aString.
]

Pring string [ ^string ]

Pring announce
[
    'INST ' put.       string putln.
    'SEND ' put.  self string putln.
    '----' putln.
]



Object perform: aSymbol withSelf: anObject	[ ^self _perform: (SelectorTable at: aSymbol) s: anObject ]

Object _perform: s s: r				{ struct __closure *c= _libid->bind(v_s, v_self);  return (c->method)((oop)c, v_self, v_r); }


Pring test
[
    ^[string]
]

[
    | p q |
    (p := Pring withString: 'pring thing') announce.
    (q := Pring withString: 'quing thing') announce.
    q perform: #announce withSelf: p.
    p test value putln.
]


Prototype _delegate [ ^next ]

Prototype withDelegate: anObject
[
    self := self new.
    next := anObject.
]


A : Prototype ()

A a	[ 'A.a' putln ]

B : Prototype ()

B a	[ 'B.a' putln ]
B b	[ 'B.b ' put.  self a ]

C : Prototype ()

C c	[ 'C.c ' put.  self a; b ]

[
    | a b c |
    a := A withDelegate: (b := B withDelegate: (c := C new)).
    '======== a a:\n' put.  a a.
    '======== a b:\n' put.  a b.
    '======== a c:\n' put.  a c.
]
