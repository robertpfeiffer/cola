" WordArray.st -- arrayed collections of words

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

  Last edited: 2006-04-25 16:38:38 by piumarta on emilia.local
"

{ import: ArrayedCollection }

WordArray : ArrayedCollection ( _words )

WordArray species	[ ^WordArray ]

Object     isWordArray	[ ^false ]
WordArray  isWordArray	[ ^true ]

WordArray initialize: anInteger
[
    super initialize: anInteger.
    _words := self _newWords: anInteger
]

WordArray _words	[ ^_words ]
WordArray _elements	[ ^_words ]

WordArray at: anInteger
[
    | _w |
    { unsigned int w;
      if (((int)v_anInteger & 1) && ((int)v_anInteger > 1) && ((int)v_anInteger <= (int)self->v_size))
        w= (((unsigned int *)self->v__words)[((int)v_anInteger >> 1) - 1]);
      else return _send(s_primitiveFailed, v_self);
      if (!(w & 0xc0000000)) return (oop)(w << 1 | 1);
      v__w= (oop)w;
    }.
    ^LargePositiveInteger value_: _w
]

WordArray at: anInteger put: aWord
[
    | _w |
    {
      if (((int)v_anInteger & 1) && ((int)v_anInteger > 1) && ((int)v_anInteger <= (int)self->v_size) && ((int)v_aWord & 1))
        {
          ((unsigned int *)self->v__words)[((int)v_anInteger >> 1) - 1]= (unsigned int)v_aWord >> 1;
          return v_aWord;
        }
    }.
    (anInteger isSmallInteger and: [anInteger > 0 and: [anInteger <= size]]) ifFalse: [^self primitiveFailed].
    (aWord isLargePositiveInteger and: [aWord digitLength == 4]) ifFalse: [^self primitiveFailed].
    _w := aWord _integerValue.
    { ((unsigned int *)self->v__words)[((int)v_anInteger >> 1) - 1]= (unsigned int)v__w; }.
    ^aWord
]

WordArray integerAt: anInteger
[
    { if (((int)v_anInteger & 1) && ((int)v_anInteger > 1) && ((int)v_anInteger <= (int)self->v_size)) {
        int w= (((unsigned int *)self->v__words)[((int)v_anInteger >> 1) - 1]);
        if ((w ^ (w << 1)) >= 0) return (oop)(w << 1 | 1); } }.
    ^self primitiveFailed
]

WordArray _at: anInteger
[
    { if (((int)v_anInteger & 1) && ((int)v_anInteger > 1) && ((int)v_anInteger <= (int)self->v_size))
        return (oop)(((unsigned int *)self->v__words)[((int)v_anInteger >> 1) - 1]); }.
    ^self primitiveFailed
]

WordArray _at: anInteger put_: _word
[
    {
      if (((int)v_anInteger & 1) && ((int)v_anInteger > 1) && ((int)v_anInteger <= (int)self->v_size))
        {
          ((unsigned int *)self->v__words)[((int)v_anInteger >> 1) - 1]= (unsigned int)v__word;
          return v__word;
        }
    }.
    ^self primitiveFailed
]

WordArray elementSize
{
    return (oop)(sizeof(int) << 1 | 1);
}


WordArray replaceFrom: first to: last with: words startingAt: offset
[
    | count |
    count := last - first + 1.
    (words isWordArray
		and: [1 <= first
		and: [first <= last
		and: [last <= self size
		and: [1 <= offset
		and: [offset + count - 1 <= words size]]]]])
	ifFalse: [^super replaceFrom: first to: last with: words startingAt: offset].
    self replaceFrom_: first  _integerValue
	 for_:	       count  _integerValue
	 with_:	       words  _words
	 startingAt_:  offset _integerValue
]

WordArray replaceFrom_: _first for_: _count with_: _source startingAt_: _offset
{
    memcpy((char *)self->v__words + sizeof(unsigned int) * ((int)v__first - 1),
	   (char *)v__source + sizeof(unsigned int) * ((int)v__offset - 1),
	   sizeof(unsigned int) * (int)v__count);
}


ImmutableWordArray : WordArray ()			{ pragma: type wordArray ImmutableWordArray }

ImmutableWordArray size_: _size value_: _value		"constructor"
[
    self := self _clone.
    size := SmallInteger value_: _size.
    _words := _value.
]

ImmutableWordArray at: anInteger put: aWord
[
    ^self errorImmutable
]

ImmutableWordArray replaceFrom: first to: last with: aCollection startingAt: offset
[
    ^self errorImmutable
]
