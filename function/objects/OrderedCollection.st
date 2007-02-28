" OrderedCollection.st -- dynamically-extensible array-like collections

  Copyright (c) 2006, 2007 Ian Piumarta
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

  Last edited: 2007-02-28 14:29:16 by piumarta on emilia
"

{ import: Objects }

OrderedCollection : SequenceableCollection ( firstIndex lastIndex array )

OrderedCollection new	[ ^(self new: 4) removeAll ]

OrderedCollection new: size
[
    self := super new.
    array := Array new: size.
    firstIndex := 0.
    lastIndex := size.
]

OrderedCollection size			[ ^lastIndex - firstIndex ]

OrderedCollection add: anObject		[ ^self addLast: anObject ]

OrderedCollection addFirst: anObject
[
    firstIndex == 0 ifTrue: [self makeRoomAtFirst].
    firstIndex := firstIndex - 1.
    array at: firstIndex put: anObject.
    ^anObject
]

OrderedCollection addLast: anObject
[
    lastIndex == array size ifTrue: [self makeRoomAtLast].
    array at: lastIndex put: anObject.
    lastIndex := lastIndex + 1.
    ^anObject
]

OrderedCollection makeRoomAtFirst
[
    | delta newArray |
    delta := array size.
    (self size == 0 and: [delta > 0]) ifTrue: [^self resetToEnd].
    (self size * 2 < delta) ifTrue: [^self shiftToEnd].
    newArray := (array new: self size + delta) replaceFrom: firstIndex + delta to: lastIndex + delta - 1 with: array startingAt: firstIndex.
    array := newArray.
    firstIndex := firstIndex + delta.
    lastIndex := lastIndex + delta.
]

OrderedCollection makeRoomAtLast
[
    (self size == 0 and: [array size > 0]) ifTrue: [^self resetToBeginning].
    (self size * 2 < array size) ifTrue: [^self shiftToBeginning].
    array := (array new: self size + array size)
	replaceFrom: firstIndex to: lastIndex - 1 with: array startingAt: firstIndex;
	yourself.
]

OrderedCollection resetToBeginning	[ firstIndex := lastIndex := 0]
OrderedCollection resetToEnd		[ firstIndex := lastIndex := array size ]

OrderedCollection removeFirst
[
    | first |
    self emptyCheck.
    first := array at: firstIndex.
    firstIndex := firstIndex + 1.
    ^first
]

OrderedCollection removeLast
[
    | last |
    self emptyCheck.
    lastIndex := lastIndex - 1.
    last := array at: lastIndex.
    ^last
]

OrderedCollection removeAll
[
    firstIndex := lastIndex := 0.
]

OrderedCollection indexOf: anObject ifAbsent: errorBlock
[
    self doWithIndex: [:element :index | element == anObject ifTrue: [^index]].
    ^errorBlock value
]

OrderedCollection removeAll: aCollection ifAbsent: errorBlock
[
    aCollection do: [:element | self remove: element ifAbsent: [^errorBlock value]]
]

OrderedCollection remove: anObject ifAbsent: errorBlock
[
    ^self removeAtIndex: (self indexOf: anObject ifAbsent: [^errorBlock value])
]

OrderedCollection removeAtIndex: offset
[
    | arrayOffset |
    arrayOffset := firstIndex + offset.
    (offset >= 0 and: [arrayOffset < lastIndex]) ifFalse: [^self errorOutOfBounds: offset].
    arrayOffset to: lastIndex - 2 do: [:i | array at: i put: (array at: 1 + i)].
    lastIndex := lastIndex - 1.
]

OrderedCollection at: offset
[
    | arrayOffset |
    arrayOffset := firstIndex + offset.
    ^(offset >= 0 and: [arrayOffset < lastIndex])
	ifTrue:  [array at: arrayOffset]
	ifFalse: [self errorOutOfBounds: offset]
]

OrderedCollection at: offset put: anObject
[
    | arrayOffset |
    arrayOffset := firstIndex + offset.
    ^(offset >= 0 and: [arrayOffset < lastIndex])
	ifTrue:  [array at: arrayOffset put: anObject]
	ifFalse: [self errorOutOfBounds: offset]
]

OrderedCollection do: unaryBlock
[
    firstIndex to: lastIndex - 1 do: [:index | unaryBlock value: (array at: index)]
]
