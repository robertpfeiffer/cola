" Array.st -- support for arrays of pointers

  Copyright (c) 2005 Ian Piumarta
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

  Last edited: 2008-06-20 14:41:29 by piumarta on emilia.local
"

{ import: ArrayedCollection }

Array : ArrayedCollection ( _pointers )

Array species	[ ^Array ]

Object isArray	[ ^false ]
Array  isArray	[ ^true ]

Array initialize: anInteger
[
    super initialize: anInteger.
    _pointers := self _newPointers: anInteger
]

Array _pointers	[ ^_pointers ]
Array _elements	[ ^_pointers ]

Array at: anInteger
[
    { if (((long)v_anInteger & 1) && ((long)v_anInteger > 1) && ((long)v_anInteger <= (long)self->v_size))
        return ((oop *)self->v__pointers)[((long)v_anInteger >> 1) - 1]; }.
    ^self primitiveFailed
]

Array at: anInteger put: anObject
[
    { if (((long)v_anInteger & 1) && ((long)v_anInteger > 1) && ((long)v_anInteger <= (long)self->v_size))
        return ((oop *)self->v__pointers)[((long)v_anInteger >> 1) - 1]= v_anObject; }.
    ^self primitiveFailed
]

Array elementSize
{
    return (oop)(long)(sizeof(oop) << 1 | 1);
}

Array printOn: aStream
[
    aStream nextPutAll: '#'.
    self printElementsOn: aStream
]

Array replaceFrom: first to: last with: ptrs startingAt: offset
[
    | count |
    count := last - first + 1.
    (ptrs isArray
		and: [1 <= first
		and: [first <= last
		and: [last <= self size
		and: [1 <= offset
		and: [offset + count - 1 <= ptrs size]]]]])
	ifFalse: [^super replaceFrom: first to: last with: ptrs startingAt: offset].
    self replaceFrom_: first  _integerValue
	 for_:	       count  _integerValue
	 with_:	       ptrs   _pointers
	 startingAt_:  offset _integerValue
]

Array replaceFrom_: _first for_: _count with_: _source startingAt_: _offset
{
    memcpy((char *)self->v__pointers + sizeof(oop) * ((long)v__first - 1),
	   (char *)v__source + sizeof(oop) * ((long)v__offset - 1),
	   sizeof(oop) * (long)v__count);
}


ImmutableArray : Array ()					{ pragma: type objectArray ImmutableArray }

ImmutableArray size_: _size value_: _value	"Array constructor"
[
    self := self _clone.
    size := SmallInteger value_: _size.
    _pointers := _value.
    {
      int i;
      for (i= 0;  i < (long)v__size;  ++i)
        ((oop *)self->v__pointers)[i]= *((oop **)v__value)[i];
    }.
]

ImmutableArray at: anInteger put: anObject
[
    ^self errorImmutable
]

ImmutableArray replaceFrom: first to: last with: aCollection startingAt: offset
[
    ^self errorImmutable
]



Collection asArray
[
    ^self as: Array
]
