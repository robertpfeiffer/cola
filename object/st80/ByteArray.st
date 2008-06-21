" ByteArray.st -- arrayed collections of bytes

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

  Last edited: 2008-06-20 14:35:08 by piumarta on emilia.local
"

{ import: ArrayedCollection }

ByteArray : ArrayedCollection ( _bytes )

ByteArray species	[ ^ByteArray ]

Object    isByteArray	[ ^false ]
ByteArray isByteArray	[ ^true ]

ByteArray size: byteSize value_: _value
[
    self := self _clone.
    size := byteSize.
    _bytes := _value.
]

ByteArray size_: _size value_: _value	"ByteArray and String constructor"
[
    self := self _clone.
    size := SmallInteger value_: _size.
    _bytes := _value.
]

ByteArray initialize: anInteger
[
    super initialize: anInteger.
    _bytes := self _newBytes: anInteger
]

ByteArray _bytes	[ ^_bytes ]
ByteArray _elements	[ ^_bytes ]

ByteArray byteAt: anInteger
[
    { if (((long)v_anInteger & 1) && ((long)v_anInteger > 1) && ((long)v_anInteger <= (long)self->v_size))
        return (oop)((((long)(((unsigned char *)self->v__bytes)[((long)v_anInteger >> 1) - 1])) << 1) | 1); }.
    ^self primitiveFailed
]

ByteArray byteAt: anInteger put: aByte
[
    {
      if (((long)v_anInteger & 1) && ((long)v_anInteger > 1) && ((long)v_anInteger <= (long)self->v_size) && ((long)v_aByte & 1))
        {
          ((char *)self->v__bytes)[((long)v_anInteger >> 1) - 1]= (long)v_aByte >> 1;
          return v_aByte;
        }
    }.
    ^self primitiveFailed
]

ByteArray at: anInteger			[ ^self byteAt: anInteger ]
ByteArray at: anInteger put: aByte	[ ^self byteAt: anInteger put: aByte ]

ByteArray elementSize			[ ^1 ]

ByteArray replaceFrom: first to: last with: bytes startingAt: offset
[
    | count |
    count := last - first + 1.
    (bytes isByteArray
		and: [1 <= first
		and: [first <= last
		and: [last <= self size
		and: [1 <= offset
		and: [offset + count - 1 <= bytes size]]]]])
	ifFalse: [^super replaceFrom: first to: last with: bytes startingAt: offset].
    self replaceFrom_: first  _integerValue
	 for_:	       count  _integerValue
	 with_:	       bytes  _bytes
	 startingAt_:  offset _integerValue
]

ByteArray replaceFrom_: _first for_: _count with_: _source startingAt_: _offset
{
    memcpy((char *)self->v__bytes + (long)v__first - 1, (char *)v__source + (long)v__offset - 1, (long)v__count);
}


ImmutableByteArray : ByteArray ()

ImmutableByteArray at: anInteger put: aByte
[
    ^self errorImmutable
]

ImmutableByteArray replaceFrom: first to: last with: bytes startingAt: offset
[
    ^self errorImmutable
]
