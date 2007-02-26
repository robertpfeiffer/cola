" Stream.st -- protocol common to all kinds of Stream

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

  Last edited: 2005-12-06 15:27:33 by piumarta on emilia.local
"

{ import: Object }
{ import: OrderedCollection }

Stream : Object ()

Stream size			[ ^self subclassResponsibility: 'size' ]

Stream nextPut: anObject	[ ^self subclassResponsibility: 'nextPut:' ]

Stream nextPutAll: aCollection	[ aCollection do: [:element | self nextPut: element] ]

Stream next: anInteger
[
    "Answer the next anInteger number of objects readable from the receiver."
    | elements |
    elements := OrderedCollection new: anInteger.
    anInteger timesRepeat: [elements addLast: self next].
    ^elements.
]

Stream print: anObject		[ anObject printOn: self ]

Stream isEmpty			[ ^self size == 0 ]
Stream notEmpty			[ ^self isEmpty not ]
