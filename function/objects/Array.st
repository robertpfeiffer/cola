{ import: Objects }

_object isArray	[ ^false ]
Array isArray	[ ^true ]

Array size_: _size value_: _value
[
    self := self new: (SmallInteger value_: _size).
    _oops := _value.
    {
      int i;
      for (i= 0;  i < (int)v__size;  ++i)
        ((oop *)self->v__oops)[i]= *((oop **)v__value)[i];
    }.
]

Array new: capacity
[
    self := super new.
    size := capacity.
    _oops := self _palloc: size
]

Array _elements	[ ^_oops ]

Array at: offset
[
    ^(0 <= offset and: [offset < size])
	ifTrue:  [self at_: offset _integerValue]
	ifFalse: [self errorOutOfBounds: offset]
]

Array at_: _offset
{
    return ((oop *)self->v__oops)[(int)v__offset];
}

Array at: offset put: anObject
[
    ^(0 <= offset and: [offset < size])
	ifTrue:  [self at_: offset _integerValue put: anObject]
	ifFalse: [self errorOutOfBounds: offset]
]

Array at_: _offset put: anObject
{
    return ((oop *)self->v__oops)[(int)v__offset]= v_anObject;
}

Array  argumentVectorSize	[ ^SmallInteger value_: self _argumentVectorSize ]
Array _argumentVectorSize	{ return (oop)_param(0); }
Array  argumentVectorAt: offset	[ ^String value_: (self _argumentVectorAt_: offset _integerValue) ]
Array _argumentVectorAt_: _off	{ return (oop)(((char **)_param(1))[(int)v__off]); }

Array argumentVector
[
    self := self new: self argumentVectorSize.
    0 to: size - 1 do: [:offset | self at: offset put: (self argumentVectorAt: offset)].
]

Array printOn: aStream
[
    aStream nextPut: $#.
    self printContentsOn: aStream.
]
