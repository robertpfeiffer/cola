" Arrayed.st -- vectors of objects

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

  Last edited: 2007-09-03 13:00:01 by piumarta on ubuntu
"

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
    _return ((oop *)self->v__oops)[(int)v__offset];
}

Array at: offset put: anObject
[
    ^(0 <= offset and: [offset < size])
	ifTrue:  [self at_: offset _integerValue put: anObject]
	ifFalse: [self errorOutOfBounds: offset]
]

Array at_: _offset put: anObject
{
    _return ((oop *)self->v__oops)[(int)v__offset]= v_anObject;
}

Array  argumentVectorSize	[ ^SmallInteger value_: self _argumentVectorSize ]
Array _argumentVectorSize	{ _return (oop)_libid->param(0); }
Array  argumentVectorAt: offset	[ ^String value_: (self _argumentVectorAt_: offset _integerValue) ]
Array _argumentVectorAt_: _off	{ _return (oop)(((char **)_libid->param(1))[(int)v__off]); }

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
