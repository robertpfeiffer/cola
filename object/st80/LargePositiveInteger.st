" LargePositiveInteger.st -- support for arbitrary-precision integers

  Copyright (c) 2006 Ian Piumarta
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

  Last edited: 2006-04-25 17:28:39 by piumarta on emilia.local
"

{ import: Integer }

LargePositiveInteger : Integer ( bytes )

Object isLargePositiveInteger			[ ^false ]
LargePositiveInteger isLargePositiveInteger	[ ^true ]

LargePositiveInteger bytes [ ^bytes ]

LargePositiveInteger new: length
[
    self := super new.
    bytes := ByteArray new: length.
    bytes atAllPut: 0.
]

LargePositiveInteger withBytes: aByteArray
[
    self := super new.
    bytes := aByteArray.
]

LargePositiveInteger value_: _word
[
    | _bytes |
    self := self new: 4.
    _bytes := bytes _bytes.
    {
	((unsigned char *)v__bytes)[0]= ((unsigned int)v__word >>  0) & 0xff;
	((unsigned char *)v__bytes)[1]= ((unsigned int)v__word >>  8) & 0xff;
	((unsigned char *)v__bytes)[2]= ((unsigned int)v__word >> 16) & 0xff;
	((unsigned char *)v__bytes)[3]= ((unsigned int)v__word >> 24) & 0xff;
    }.
]

LargePositiveInteger _integerValue
[
    | _bytes |
    bytes size ~~ 4 ifTrue: [^super _integerValue].
    _bytes := bytes _bytes.
    {
	return (oop)(   (((unsigned char *)v__bytes)[0]      )
		+	(((unsigned char *)v__bytes)[1] <<  8)
		+	(((unsigned char *)v__bytes)[2] << 16)
		+	(((unsigned char *)v__bytes)[3] << 24) );

    }.
]

LargePositiveInteger digitLength
[
    ^bytes size
]

LargePositiveInteger digitAt: index
[
    ^bytes size < index ifTrue: [0] ifFalse: [bytes at: index]
]

LargePositiveInteger digitAt: index put: value 
[
    ^bytes at: index put: value
]

LargePositiveInteger replaceFrom: fromIndex to: toIndex with: anInteger startingAt: startIndex
[
    fromIndex to: toIndex do: [:index |
	bytes at: index put: (anInteger digitAt: startIndex).
	startIndex := startIndex + 1].
]

LargePositiveInteger highBitOfMagnitude
[
    | realLength lastDigit |
    realLength := self digitLength.
    [(lastDigit := self digitAt: realLength) = 0]
	whileTrue:
	   [(realLength := realLength - 1) = 0
		ifTrue: [^0]].
    ^lastDigit highBitOfPositiveReceiver + (8 * (realLength - 1))
]

LargePositiveInteger normalize
[
    "Check for leading zeroes and return shortened copy if so"
    | sLen val len oldLen |
    len := oldLen := self digitLength.
    [len = 0 ifTrue: [^0].
     (self digitAt: len) = 0]
	whileTrue: [len := len - 1].
    "Now check if in SmallInteger range"
    sLen := SmallInteger maxVal digitLength.
    (len <= sLen and: [(self digitAt: sLen) <= (SmallInteger maxVal digitAt: sLen)])
	ifTrue:
	   [val := 0.
	    len downTo: 1 do: [:i | val := (val * 256) + (self digitAt: i)].
	    ^val].
    "Return self, or a shortened copy"
    ^len < oldLen
	ifTrue:  [self growTo: len]
	ifFalse: [self]
]

LargePositiveInteger abs	[ ^self ]

LargePositiveInteger negative	[ ^false ]
