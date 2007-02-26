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
