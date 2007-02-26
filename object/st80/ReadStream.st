" ReadStream.st -- read-only positionable Streams 

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

  Last edited: 2005-12-06 15:22:56 by piumarta on emilia.local
"

{ import: PositionableStream }

ReadStream : PositionableStream ()

ReadStream next
[
    "Answer the next object in the Stream represented by the
     receiver.  Fail if the collection of this stream is not an Array
     or a String.  Fail if the stream is positioned at its end, or if
     the position is out of bounds in the collection."
    ^self atEnd ifFalse: [collection at: (position := position + 1)].
]

ReadStream next: anInteger 
[
    "Answer the next anInteger elements of my collection.  Overriden for efficiency."
    | elements lastPosition |

    lastPosition := position + anInteger min: readLimit.
    elements := collection copyFrom: position + 1 to: lastPosition.
    position := lastPosition.
    ^elements
]

ReadStream readStream []

"----------------------------------------------------------------"

SequenceableCollection readStream
[
    ^ReadStream on: self
]
