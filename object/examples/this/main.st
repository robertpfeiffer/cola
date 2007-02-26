{ import: st80 }

" The variables 'self', 'super' and 'this' all refer to the receiver.
  Lookup behaves differently depending on which of the three is
  writtten as the receiver in a message send expression:

    self foo

  sends 'foo' to self commencing the search for the method in the
  actual type of the receiver (i.e., the search starts in the most
  specific type relative to the current receiver);

    super foo

  sends 'foo' to self commencing the search for the method in the
  supertype of the type in which the currently executing method is
  installed;

    this foo

  sends 'foo' to self commencing the search for the method in the type
  in which the currently executing method is installed (i.e., it works
  like super without immediately delegating 'upwards' to the
  supertype).

  If none of that made any sense, you will probably never need to know
  that 'this' even exists. "

A : Object ()	A foo [ 'A.foo ' putln.  self  bar ]	A bar [ 'A.bar ' putln.          ]
B : A ()	B foo [ 'B.foo ' put.    this  bar ]	B bar [ 'B.bar ' put.  super bar ]
C : B ()	C foo [ 'C.foo ' put.    super foo ]	C bar [ 'C.bar ' put.  super bar ]

[
    A foo.
    B foo.
    C foo.
]
