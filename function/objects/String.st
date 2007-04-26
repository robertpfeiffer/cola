" String.st -- character strings

  Copyright (c) 2006, 2007 Ian Piumarta
  All rights reserved.

  Permission is hereby granted, free of charge, to any person obtaining a
  copy of this software and associated documentation files (the 'Software'),
  to deal in the Software without restriction, including without limitation
  the rights to use, copy, modify, merge, publish, distribute, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, provided that the above copyright notice(s) and this
  permission notice appear in all copies of the Software and that both the
  above copyright notice(s) and this permission notice appear in supporting
  documentation.

  THE SOFTWARE IS PROVIDED 'AS IS'.  USE ENTIRELY AT YOUR OWN RISK.

  Last edited: 2007-04-25 11:59:17 by piumarta on emilia
"

{ import: Objects }

Object isString	[ ^false ]
String isString	[ ^true ]

String asString []

String new: capacity
[
    self := super new: capacity + 1.
    self at: size - 1 put: 0.
    size := size - 1.
]

String value_: _value
[
    self := self new.
    _bytes := _value.
    size := SmallInteger value_: self _size.
]

String _size
{
    return (oop)strlen((char *)self->v__bytes);
}

String _stringValue
{
    return (oop)self->v__bytes;
}

String _strdup
{
    size_t size= ((long)self->v_size) >> 1;
    char *string= malloc(size + 1);
    memcpy(string, self->v__bytes, size);
    string[size]= '\0';
    return (oop)string;
}

String beginsWith: aString
[
    self size < aString size ifTrue: [^false].
    aString doWithIndex: [:e :i | (self at: i) == e ifFalse: [^false]].
    ^true
]

String endsWith: aString
[
    | start |
    self size < aString size ifTrue: [^false].
    start := self size - aString size.
    aString doWithIndex: [:e :i | (self at: start + i) == e ifFalse: [^false]].
    ^true
]

String asSymbol		[ ^Symbol intern_: self _bytes size_: size _integerValue ]

String printOn: aStream	[ ^aStream nextPut: $'; nextPutAll: self; nextPut: $' ]

String putln
{
    puts((char *)self->v__bytes);
}

String dirname
[
    (self includes: $/) ifFalse: [^'.'].
    self := self copy.
    [size > 0 and: [self last ~~ $/]]
	whileTrue:
	   [self at: size - 1 put: 0.
	    size := size - 1].
    (size > 0 and: [self last == $/])
	ifTrue:
	   [self at: size - 1 put: 0.
	    size := size - 1].
]
