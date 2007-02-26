" SequenceableCollection.st -- collections that can be indexed

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

  Last edited: 2006-04-26 21:35:06 by piumarta on emilia.local
"

{ import: Collection }

SequenceableCollection : Collection ()

SequenceableCollection isSequenceableCollection [ ^true ]
Object isSequenceableCollection [ ^false ]

SequenceableCollection hash
[
    "Answer a positive integer as far as possible unique to the
     contents of the receiver, but guaranteed identical for all
     collections having the same contents in the same order."
    ^(self size > 10
	    ifTrue:  [self species identityHash]
	    ifFalse: [self inject: self size * 103 + self species identityHash into: [:prev :elt | (prev * 82 bitXor: elt hash) bitAnd: 16r000FFFFF]])
	bitAnd: 0x000FFFFF.
]

SequenceableCollection = aCollection
[
    self == aCollection ifTrue: [^true].
    (aCollection isSequenceableCollection and: [self species == aCollection species and: [self size == aCollection size]]) ifFalse: [^false].
    self with: aCollection do: [:a :b | a = b ifFalse: [^false]].
    ^true
]

SequenceableCollection atAllPut: anObject		[ 1 to: self size do: [:index | self at: index put: anObject] ]
SequenceableCollection atAll: indices put: anObject	[ indices do: [:index | self at: index put: anObject] ]

SequenceableCollection first	[ ^self at: 1 ]
SequenceableCollection second	[ ^self at: 2 ]
SequenceableCollection third	[ ^self at: 3 ]
SequenceableCollection fourth	[ ^self at: 4 ]
SequenceableCollection fifth	[ ^self at: 5 ]
SequenceableCollection last	[ ^self at: self size ]

SequenceableCollection lastIndexOf: anObject
[
    ^self lastIndexOf: anObject startingAt: 1
]

SequenceableCollection lastIndexOf: anObject startingAt: firstIndex
[
    | index |
    index := 0.
    firstIndex to: self size do: [:i | anObject = (self at: i) ifTrue: [index := i]].
    ^index
]

SequenceableCollection from: pos to: last put: anObject
[
    [pos <= last]
	whileTrue:
	   [self at: pos put: anObject.
	    pos := pos + 1].
]

SequenceableCollection do: unaryBlock
[
    1 to: self size do: [:index | unaryBlock value: (self at: index)]
]

SequenceableCollection with: aSequenceableCollection do: binaryBlock
[
    1 to: self size do: [:index | binaryBlock value: (self at: index) value: (aSequenceableCollection at: index)]
]

SequenceableCollection , aCollection
[
    ^(self species new: self size + aCollection size)
	replaceFrom: 1 to: self size with: self;
	replaceFrom: self size + 1 to: self size + aCollection size with: aCollection;
	yourself.
]

SequenceableCollection swap: oneIndex with: anotherIndex
[
    "Move the element at oneIndex to anotherIndex, and vice-versa."
    | element |
    element := self at: oneIndex.
    self at: oneIndex put: (self at: anotherIndex).
    self at: anotherIndex put: element.
]

SequenceableCollection replaceFrom: start to: stop with: aCollection
[
    ^self replaceFrom: start to: stop with: aCollection startingAt: 1
]

SequenceableCollection replaceFrom: start to: stop with: aCollection startingAt: startIndex
[
    start to: stop do: [:index |
	self at: index put: (aCollection at: startIndex).
	startIndex := startIndex + 1].
]

SequenceableCollection copyFrom: start to: stop 
[
    " Answer a copy of a subset of the receiver, starting from element
      at index start until element at index stop. "
    | newSize |
    newSize := stop - start + 1.
    ^(self species new: newSize)
        replaceFrom: 1
        to: newSize
        with: self
        startingAt: start
]

SequenceableCollection copyFrom: start
[
    ^self copyFrom: start to: self size
]

SequenceableCollection collect: unaryBlock startingAt: offset
[
    | answer |
    answer := self species new: self size - offset + 1.
    offset to: self size do: [:index | answer add: (unaryBlock value: (self at: index))].
    ^answer
]

SequenceableCollection injectFirstInto: binaryBlock
[
    | result |
    result := self isEmpty ifFalse: [self first].
    2 to: self size do: [:index | result := binaryBlock value: result value: (self at: index)].
    ^result.
]

SequenceableCollection beginsWith: prefix
[
    " Answer whether the receiver begins with the given prefix. "
    self size < prefix size ifTrue: [^false].
    prefix doWithIndex: [:element :index | (self at: index) = element ifFalse: [^false]].
    ^true
]

SequenceableCollection endsWith: suffix
[
    " Answer whether the receiver ends with the given suffix. "
    | start |
    self size < suffix size ifTrue: [^false].
    start := self size - suffix size.
    1 to: suffix size do: [:index | (self at: start + index) = (suffix at: index) ifFalse: [^false]].
    ^true
]

SequenceableCollection withoutSuffix: suffix
[
    ^(self endsWith: suffix)
	ifTrue:  [self copyFrom: 1 to: self size - suffix size]
	ifFalse: [self]
]

SequenceableCollection asByteArray
[
    ^ByteArray withAll: self
]

SequenceableCollection asWordArray
[
    ^WordArray withAll: self
]
