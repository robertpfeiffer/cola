" ArrayedCollection.st -- support for vectorlike collections

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

  Last edited: 2006-04-26 12:44:22 by piumarta on emilia.local
"

{ import: SequenceableCollection }

ArrayedCollection : SequenceableCollection ( size )

ArrayedCollection new: anInteger
[
    ^super new initialize: anInteger
]

ArrayedCollection new: capacity withAll: value
[
    ^(self new: capacity) atAllPut: value
]

ArrayedCollection initialize
[
    super initialize.
    size := 0.
]

ArrayedCollection initialize: anInteger
[
    super initialize: anInteger.
    size := anInteger.
]

ArrayedCollection with: anObject
[
    ^(self new: 1)
	at: 1 put: anObject;
	yourself
]

ArrayedCollection with: anObject with: anotherObject
[
    ^(self new: 2)
	at: 1 put: anObject;
	at: 2 put: anotherObject;
	yourself
]

ArrayedCollection withAll: aCollection
[
    self := self new: aCollection size.
    aCollection doWithIndex: [:e :i | self at: i put: e ].
]

ArrayedCollection size
[
    ^size
]

ArrayedCollection byteSize
[
    ^size * self elementSize
]

ArrayedCollection collect: unaryBlock
[
    | answer |
    answer := self species new: self size.
    self doWithIndex: [:elt :ind | answer at: ind put: (unaryBlock value: elt)].
    ^answer
]

ArrayedCollection _size
[
    ^size _integerValue
]
