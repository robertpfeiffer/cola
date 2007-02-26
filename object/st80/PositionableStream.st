" PositionableStream.st -- Streams over finite collections

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

  Last edited: 2006-01-05 19:03:29 by piumarta on margaux.local
"

{ import: Stream }

PositionableStream : Stream ( collection position readLimit )

PositionableStream on: aCollection
[
    self := self new.
    collection := aCollection.
    position := 0.			"otherwise WriteStream>>reset will barf sending #max:"
    readLimit := aCollection size.
    self reset
]

PositionableStream reset
[
    position := 0.
]

PositionableStream atEnd
[
    " Answer whether the receiver can access any more objects. "
    ^position >= readLimit
]

PositionableStream position: anInteger 
[
    " Set the current position for accessing the objects to be
      anInteger, as long as anInteger is within the bounds of the
      receiver's contents.  If it is not, create an error
      notification."
    (anInteger between: 0 and: readLimit)
        ifTrue:  [position := anInteger]
        ifFalse: [self positionError]
]

PositionableStream skip: anInteger
[
    " Set the receiver's position to be the current position +
      anInteger.  A subclass might choose to be more helpful and
      select the minimum of the receiver's size and position +n
      anInteger, or the maximum of 0 and position + anInteger, for the
      repositioning. "
    self position: position + anInteger
]

PositionableStream size
[
    ^readLimit
]

PositionableStream contents
[
    " Answer with a copy of my collection from 0 to readLimit. "
    ^collection copyFrom: 1 to: readLimit
]

PositionableStream collection
[
    " Answer my collection. "
    ^collection
]

PositionableStream peek
[
    | nextObject |
    self atEnd ifTrue: [^nil].
    nextObject := self next.
    position := position - 1.
    ^nextObject
]

PositionableStream next: anInteger 
[
    | elements |
    elements := collection species new: anInteger.
    1 to: anInteger do: [:index | elements at: index put: self next].
    ^elements
]

PositionableStream positionError
[
    self error: 'attempt to set Stream position beyond readable bounds'
]
