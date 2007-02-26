" WriteStream.st -- write-only positionable Streams 

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

  Last edited: 2006-01-13 09:34:32 by piumarta on emilia.local
"

{ import: PositionableStream }

WriteStream : PositionableStream ( writeLimit )

WriteStream on: aCollection
[
    self := super on: aCollection.
    writeLimit := aCollection size.
    readLimit := 0.
]

WriteStream reset
[
    readLimit := readLimit max: position.
    super reset
]

WriteStream resetToStart
[
    readLimit := position := 0
]

WriteStream nextPut: anObject
[
    " Insert the argument at the next position in the Stream
      represented by the receiver.  Fail if the collection of this
      stream is not an Array or a String.  Fail if the stream is
      positioned at its end, or if the position is out of bounds in
      the collection.  Fail if the argument is not of the right type
      for the collection. "
    ^position >= writeLimit
        ifTrue:  [self pastEndPut: anObject]
        ifFalse: [collection at: (position := position + 1) put: anObject].
]

WriteStream pastEndPut: anObject
[
    " Grow the collection by creating a new bigger collection and then
      copy over the contents from the old one.  We grow by doubling
      the size but the growth is kept between 20 and 1000000.  Finally
      we put anObject at the current write position. "
    | oldSize grownCollection |
    oldSize := collection size.
    grownCollection := collection new: oldSize + ((oldSize max: 20) min: 1000000).
    collection := grownCollection replaceFrom: 1 to: oldSize with: collection startingAt: 1.
    writeLimit := collection size.
    ^collection at: (position := position + 1) put: anObject.
]

WriteStream size
[
    ^readLimit := readLimit max: position
]

WriteStream tab  	[ self nextPut: $\t ]
WriteStream nl   	[ self nextPut: $\n ]
WriteStream cr   	[ self nextPut: $\r ]
WriteStream space	[ self nextPut: $   ]

WriteStream tab:   n	[ n timesRepeat: [self tab  ] ]
WriteStream nl:    n	[ n timesRepeat: [self nl   ] ]
WriteStream cr:    n	[ n timesRepeat: [self cr   ] ]
WriteStream space: n	[ n timesRepeat: [self space] ]

WriteStream contents
[
    readLimit := readLimit max: position.
    ^super contents
]

WriteStream position: anInteger 
[
    readLimit := readLimit max: position.
    super position: anInteger
]

WriteStream writeStream []

"----------------------------------------------------------------"

SequenceableCollection writeStream
[
    ^WriteStream on: self
]

OrderedCollection writeStream
[
    ^WriteStream on: self asArray
]
