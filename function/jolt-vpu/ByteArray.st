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

ByteArray at: offset
[
    ^(0 <= offset and: [offset < size])
	ifTrue:  [SmallInteger value_: (self _at_: offset _integerValue)]
	ifFalse: [self errorOutOfBounds: offset]
]

ByteArray _at_: _offset
{
    return (oop)((long)(((unsigned char *)self->v__bytes)[(int)v__offset]));
}

ByteArray at: offset put: anInteger
[
    (0 <= offset and: [offset < size and: [0 <= anInteger and: [anInteger < 256]]])
	ifTrue:  [self at_: offset _integerValue put_: anInteger _integerValue]
	ifFalse: [self errorOutOfBounds: offset].
    ^anInteger.
]

ByteArray at_: _offset put_: _integer
{
    ((char *)self->v__bytes)[(int)v__offset]= (int)v__integer;
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
