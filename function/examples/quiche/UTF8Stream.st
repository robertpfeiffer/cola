" UTF8Stream.st -- reading and writing UTF8-encoded strings

  Copyright (c) 2009 Ian Piumarta
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

  Last edited: 2009-03-07 20:18:15 by piumarta on emilia
"

{ import: Stream }

UTF8WriteStream : WriteStream ()

SequenceableCollection utf8writeStream	[ ^UTF8WriteStream on: self ]

UTF8WriteStream nextPut: anInteger
[
    anInteger < 0x000080 ifTrue: [^super nextPut: anInteger].
    anInteger < 0x000800 ifTrue: [^self  nextPrefix: 0xC0 put: anInteger >>  6;
				         nextSuffixPut:        anInteger].
    anInteger < 0x010000 ifTrue: [^self  nextPrefix: 0xE0 put: anInteger >> 12;
				         nextSuffixPut:        anInteger >> 6;
				         nextSuffixPut:        anInteger].
    anInteger < 0x110000 ifTrue: [^self  nextPrefix: 0xF0 put: anInteger >> 18;
				         nextSuffixPut:        anInteger >> 12;
				         nextSuffixPut:        anInteger >> 6;
				         nextSuffixPut:        anInteger].
    ^self error: 'illegal unicode value'
]

UTF8WriteStream nextPrefix: prefix put: bits	[ super nextPut: (prefix bitOr: bits) ]
UTF8WriteStream nextSuffixPut: bits		[ super nextPut: (0x80 bitOr: (bits bitAnd: 0x3F)) ]

"----------------"

UTF8ReadStream : ReadStream ()

SequenceableCollection utf8ReadStream	[ ^UTF8ReadStream on: self ]

UTF8ReadStream nextByte	[ ^super next ifNil: [self errorInvalidUTF8] ]

UTF8ReadStream errorInvalidUTF8	[ ^self error: 'invalid UTF-8 stream' ]

UTF8ReadStream next
[
    | c |
    (c := super next) ifFalse: [^nil].
    (c between: 0x00 and: 0x7f) ifTrue: [^c].
    (c between: 0xc0 and: 0xdf) ifTrue: [^self next1: c & 0x1f].
    (c between: 0xe0 and: 0xef) ifTrue: [^self next2: c & 0x0f].
    (c between: 0xf0 and: 0xf7) ifTrue: [^self next3: c & 0x07].
    ^self errorInvalidUTF8
]

UTF8ReadStream next1: c
[
    c := c << 6 + (self nextByte & 0x3f).
    ^c
]

UTF8ReadStream next2: c
[
    c := c << 6 + (self nextByte & 0x3f).
    c := c << 6 + (self nextByte & 0x3f).
    ^c
]

UTF8ReadStream next3: c
[
    c := c << 6 + (self nextByte & 0x3f).
    c := c << 6 + (self nextByte & 0x3f).
    c := c << 6 + (self nextByte & 0x3f).
    ^c
]
