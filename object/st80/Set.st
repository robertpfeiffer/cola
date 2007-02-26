" Set.st -- uncounted, unorder collections of unequal elements

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

  Last edited: 2005-12-19 10:27:18 by piumarta on margaux.local
"

{ import: Collection }

Set : Collection ( tally array )

Set new		[ ^self new: 2 ]
Set new: size	[ ^super new initialize: size ]

Set initialize: size
[
    tally := 0.
    array := Array new: size.
]

Set size	[ ^tally ]

Set add: newObject
[
    | index |
    newObject isNil ifTrue: [self error: 'Sets cannot meaningfully contain nil as an element'].
    index := self findElementOrNil: newObject.
    (array at: index) isNil ifTrue: [self atNewIndex: index put: newObject].
    ^newObject
]

Set findElementOrNil: anObject
[
    "Answer the index of a first slot containing either a nil
     (indicating an empty slot) or an element that matches the given
     object.  Answer the index of that slot or zero.  Fail if neither
     a match nor an empty slot is found. "
    | index |
    index := self scanFor: anObject.
    index < 0 ifTrue: [self error: 'there is no free space in this Set'].
    ^index
]

Set scanFor: anObject
[
    "Scan the array for the first slot containing either a nil
     (indicating an empty slot) or an element that matches anObject.
     Answer the index of that slot or 0 if no slot is found.  This
     method will be overridden in various subtypes that have
     different interpretations for matching elements. "
    | finish start |
    finish := array size.
    start := anObject hash \\ finish + 1.
    "search from (hash mod size) to the end"
    start to: finish do: [:index |
	| element |
	((element := array at: index) isNil or: [element = anObject])
	    ifTrue: [^index]].
    "search from start to (hash mod size)"
    1 to: start do: [:index |
	| element |
        ((element := array at: index) isNil or: [element = anObject])
	    ifTrue: [^index]].
    ^0.	"no match AND no empty slot"
]

Set atNewIndex: index put: anObject
[
    array at: index put: anObject.
    tally := tally + 1.
    self fullCheck.
]

Set fullCheck
[
    "Keep array at least 1/4 free for decent hash behaviour."
    (array size - tally) < (1 max: (array size // 4)) ifTrue: [self grow]
]

Set growSize	[ ^array size ]

Set grow
[
    "Grow the elements array and reinsert the old elements."
    | oldElements oldSize |
    oldElements := array.
    oldSize := array size.
    array := Array new: oldSize + self growSize.
    tally := 0.
    oldElements do: [:element | element isNil ifFalse: [self noCheckAdd: element]]
]

Set noCheckAdd: anObject
[
    array at: (self findElementOrNil: anObject) put: anObject.
    tally := tally + 1.
]

Set remove: oldObject ifAbsent: aBlock
[
    | index |
    index := self findElementOrNil: oldObject.
    (array at: index) == nil ifTrue: [^aBlock value].
    array at: index put: nil.
    tally := tally - 1.
    self fixCollisionsFrom: index.
    ^oldObject
]

Set fixCollisionsFrom: index
[
    "The element at index has been removed and replaced by nil.
     This method moves forward from there, relocating any entries
     that had been placed below due to collisions with this one"
    | length oldIndex newIndex element |
    oldIndex := index.
    length := array size.
    [oldIndex = length
            ifTrue: [oldIndex := 1]
            ifFalse: [oldIndex := oldIndex + 1].
     (element := self keyAt: oldIndex) == nil]
        whileFalse: 
           [newIndex := self findElementOrNil: element.
            oldIndex = newIndex ifFalse: [self swap: oldIndex with: newIndex]].
]

Set keyAt: index
[
    "May be overridden by subclasses so that fixCollisions will work."
    ^array at: index
]

Set swap: oneIndex with: otherIndex
[
    "May be overridden by subclasses so that fixCollisions will work."
    array swap: oneIndex with: otherIndex.
]

Set do: unaryBlock
[
    tally = 0 ifFalse: [array do: [:element | element isNil ifFalse: [unaryBlock value: element]]]
]

Set like: anObject
[
    | index |
    index := self scanFor: anObject.
    ^index < 1 ifFalse: [array at: index]
]
