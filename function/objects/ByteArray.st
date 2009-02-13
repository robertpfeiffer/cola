" ByteArray.st -- vectors of bytes

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

  Last edited: 2009-02-13 14:53:09 by piumarta on emilia.local
"

{ import: Objects }

ByteArray : ArrayedCollection ( _bytes )

ByteArray isByteArray	[ ^true ]
Object	  isByteArray	[ ^false ]

ByteArray new: capacity
[
    self := super new: capacity.
    _bytes := self _balloc: capacity.
]

ByteArray _bytes	[ ^_bytes ]
ByteArray _elements	[ ^_bytes ]

ByteArray asSymbol	[ ^Symbol intern_: self _bytes size_: size _integerValue ]

ByteArray at: offset
[
    ^(0 <= offset and: [offset < size])
	ifTrue:  [SmallInteger value_: (self _at_: offset _integerValue)]
	ifFalse: [self errorOutOfBounds: offset]
]

ByteArray _at_: _offset
{
    _return (oop)((long)(((unsigned char *)self->v__bytes)[(long)v__offset]));
}

ByteArray at: offset put: anInteger
[
    {
	int offset= (long)v_offset >> 1;
	int anInteger= (long)v_anInteger >> 1;
	if (((long)v_offset & (long)v_anInteger & 1) && 0 <= offset && v_offset < self->v_size && 0 <= anInteger && anInteger < 256)
	{
	    ((char *)self->v__bytes)[offset]= anInteger;
	    return v_anInteger;
	}
    }.
    (0 <= offset and: [offset < size and: [0 <= anInteger and: [anInteger < 256]]])
	ifTrue:  [self at_: offset _integerValue put_: anInteger _integerValue]
	ifFalse: [self errorOutOfBounds: offset].
    ^anInteger.
]

ByteArray at_: _offset put_: _integer
{
    ((char *)self->v__bytes)[(long)v__offset]= (long)v__integer;
}

ByteArray s16at: offset put: anInteger
[
    {
	int size= (long)self->v_size >> 1;
	int offset= (long)v_offset >> 1;
	int anInteger= (long)v_anInteger >> 1;
	if (((long)v_offset & (long)v_anInteger & 1) && 0 <= offset && offset * 2 + 1 < size && -32768 <= anInteger && anInteger < 32768)
	{
	    ((short *)self->v__bytes)[offset]= anInteger;
	    return v_anInteger;
	}
    }.
    (0 <= offset and: [offset * 2 + 1 < size and: [-32768 <= anInteger and: [anInteger < 32768]]])
	ifTrue:  [self s16at_: offset _integerValue put_: anInteger _integerValue]
	ifFalse: [self errorOutOfBounds: offset].
    ^anInteger.
]

ByteArray s16at_: _offset put_: _integer
{
    ((short *)self->v__bytes)[(long)v__offset]= (long)v__integer;
}

ByteArray replaceFrom: firstIndex to: lastIndex with: aCollection startingAt: startIndex
[
    | count _src |
    count := lastIndex - firstIndex + 1.
    (aCollection isByteArray
	   and: [startIndex + count <= aCollection size
	   and: [(firstIndex between: 0 and: lastIndex)
	   and: [lastIndex + count <= size]]])
	ifFalse: [^super replaceFrom: firstIndex to: lastIndex with: aCollection startingAt: startIndex].
    _src := aCollection _bytes.
    {
	char *dst= (char *)self->v__bytes + ((long)v_firstIndex >> 1);
	char *src= (char *)      v__src   + ((long)v_startIndex >> 1);
	memcpy(dst, src, (long)v_count >> 1);
    }.
]

ByteArray setBit: n
[
    | offset |
    offset := n // 8.
    self at: offset put: ((self at: offset) | (1 << (n \\ 8))).
]

ByteArray bitAt: n
[
    | offset |
    offset := n // 8.
    ^((self at: offset) >> (n \\ 8)) & 1
]

ByteArray invertBits
[
    self doWithIndex: [:b :i | self at: i put: 255 - b].
]

ByteArray asPrototype
{
    int size= (long)self->v_size >> 1;
    char buf[1024];
    if (size >= sizeof(buf)) size= sizeof(buf) - 1;
    strncpy(buf, (char *)self->v__bytes, size);
    buf[size]= '\0';
    _return(_libid->import(buf));
}

ByteArray isPrototype
{
    int size= (long)self->v_size >> 1;
    char buf[1024];
    if (size >= sizeof(buf)) size= sizeof(buf) - 1;
    strncpy(buf, (char *)self->v__bytes, size);
    buf[size]= '\0';
    _return(_libid->isExported(buf) ? v_self : (oop)0);
}

ByteArray bePrototype: anObject
{
    int size= (long)self->v_size >> 1;
    char buf[1024];
    if (size >= sizeof(buf)) size= sizeof(buf) - 1;
    strncpy(buf, (char *)self->v__bytes, size);
    buf[size]= '\0';
    _return(_libid->export(buf, v_anObject));
}

ByteArray printOn: aStream
[
    aStream nextPutAll: '#['.
    self do: [:b | b printOn: aStream] separatedBy: [aStream space].
    aStream nextPut: $].
]
