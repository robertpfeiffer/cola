" OrderedCollection.st -- dynamic arrays

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

  Last edited: 2006-04-22 14:49:28 by piumarta on emilia.local
"

{ import: SequenceableCollection }

OrderedCollection  : SequenceableCollection ( array firstIndex lastIndex )

OrderedCollection species [ ^OrderedCollection ]

OrderedCollection new			[ ^self new: 2 ]
OrderedCollection new: anInteger	[ ^super new initialize: anInteger ]

OrderedCollection initialize: anInteger	[ self setCollection: (Array new: anInteger) ]

OrderedCollection setCollection: anArray
[
    array := anArray.
    self reset.
]

OrderedCollection size		[ ^lastIndex - firstIndex + 1 ]

OrderedCollection reset		[ lastIndex := (firstIndex := array size // 3 max: 1) - 1 ]

OrderedCollection at: anInteger
[
    | position |
    position := firstIndex + anInteger - 1.
    ^(anInteger < 1 or: [position > lastIndex]) ifTrue: [self errorNoSuchElement] ifFalse: [array at: position].
]

OrderedCollection at: anInteger put: anObject
[
    | position |
    position := firstIndex + anInteger - 1.
"
firstIndex print. $:  put.
lastIndex  print. $/  put.
self size  print. $@  put.
anInteger  print. $=  put.
position   print. $\n put.
"
    ^(anInteger < 1 or: [position > lastIndex]) ifTrue: [self errorNoSuchElement] ifFalse: [array at: position put: anObject].
]

OrderedCollection add: anObject	[ ^self addLast: anObject ]

OrderedCollection addFirst: anObject
[
    firstIndex = 1 ifTrue: [self makeRoomAtFirst].
    ^array at: (firstIndex := firstIndex - 1) put: anObject.
]

OrderedCollection addLast: anObject
[
    lastIndex = array size ifTrue: [self makeRoomAtLast].
    ^array at: (lastIndex := lastIndex + 1) put: anObject
]

OrderedCollection removeFirst
[
    | first |
    self emptyCheck.
    first := array at: firstIndex.
    array at: firstIndex put: nil.
    firstIndex := firstIndex + 1.
    ^first
]

OrderedCollection removeLast
[
    | last |
    self emptyCheck.
    last := array at: lastIndex.
    array at: lastIndex put: nil.
    lastIndex := lastIndex - 1.
    ^last
]

OrderedCollection do: unaryBlock
[
    0 to: lastIndex - firstIndex do: [:offset | unaryBlock value: (array at: firstIndex + offset)].
]

OrderedCollection doWithIndex: binaryBlock
[
    0 to: lastIndex - firstIndex do: [:offset | binaryBlock value: (array at: firstIndex + offset) value: (offset + 1)].
]

"The following are intended to cater well for OrderedCollections used
 as either queues (FIFO) or stacks (LIFO).  The goals are no dead
 space at the 'cold' end for FIFOs, implicit shrinking of the array
 for LIFOs, and contents gravitating to one end of the array according
 to the sense (front/back) of the first addition to the collection.
 While the following is not optimal ('never-empty' FIFOs will allocate
 new Arrays slightly too frequently) it is a very simple and adequate
 heuristic that meets the above goals."

OrderedCollection makeRoomAtFirst
[
    | delta newArray |
    (self size == 0 and: [array size > 0]) ifTrue: [^self resetToEnd].
    (self size * 2 < array size) ifTrue: [^self shiftToEnd].
    delta := self growSize.
    newArray := (Array new: self size + delta) replaceFrom: firstIndex + delta to: lastIndex + delta with: array startingAt: firstIndex.
    array := newArray.
    firstIndex := firstIndex + delta.
    lastIndex := lastIndex + delta.
]

OrderedCollection makeRoomAtLast
[
    (self size == 0 and: [array size > 0]) ifTrue: [^self resetToBeginning].
    (self size * 2 < array size) ifTrue: [^self shiftToBeginning].
    array := (Array new: self size + self growSize)
	replaceFrom: firstIndex to: lastIndex with: array startingAt: firstIndex;
	yourself.
]

OrderedCollection shiftToBeginning
[
    | delta |
    delta := firstIndex - 1.
    1 to: self size do: [:index | array at: index put: (array at: delta + index)].
    firstIndex := firstIndex - delta.
    lastIndex := lastIndex - delta.
]

OrderedCollection shiftToEnd
[
    | delta |
    delta := array size - lastIndex.
    lastIndex downTo: firstIndex do: [:index | array at: index + delta put: (array at: index)].
    firstIndex := firstIndex + delta.
    lastIndex := lastIndex + delta.
]

OrderedCollection growSize		[ ^array size ]

OrderedCollection resetToBegining	[ lastIndex := (firstIndex := 1) - 1 ]
OrderedCollection resetToEnd		[ firstIndex := (lastIndex := array size) + 1 ]
