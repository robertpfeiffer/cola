" SequenceableCollection.st -- collections with absolute ordering of elements

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

  Last edited: 2008-06-26 12:48:08 by piumarta on emilia
"

{ import: Object }

SequenceableCollection isSequenceableCollection	[ ^true ]
Object isSequenceableCollection			[ ^false ]

SequenceableCollection anyElement	[ ^self first ]

SequenceableCollection first		[ ^self at: 0				]
SequenceableCollection first: anObject	[ ^self at: 0 		  put: anObject	]
SequenceableCollection second		[ ^self at: 1 		  		]
SequenceableCollection second: anObject	[ ^self at: 1 		  put: anObject	]
SequenceableCollection third		[ ^self at: 2 		  		]
SequenceableCollection third: anObject	[ ^self at: 2 		  put: anObject	]
SequenceableCollection fourth		[ ^self at: 3 		  		]
SequenceableCollection fourth: anObject	[ ^self at: 3 		  put: anObject	]
SequenceableCollection fifth		[ ^self at: 4 		  		]
SequenceableCollection fifth: anObject	[ ^self at: 4 		  put: anObject	]
SequenceableCollection last		[ ^self at: self size - 1		]
SequenceableCollection last: anObject	[ ^self at: self size - 1 put: anObject	]

SequenceableCollection at: index ifAbsent: errorBlock
[
    ^(index between: 0 and: self size - 1)
	ifTrue:  [self at: index]
	ifFalse: [errorBlock value]
]

SequenceableCollection asString		[ ^self as: String ]
SequenceableCollection asArray		[ ^self as: Array ]

SequenceableCollection as: newType
[
    ^(newType new: self size)
	replaceFrom: 0 to: self size - 1 with: self;
	yourself
]

SequenceableCollection withAll: aCollection
[
    ^(self new: aCollection size) replaceFrom: 0 to: aCollection size - 1 with: aCollection
]

SequenceableCollection withAll: aCollection with: anObject
[
    | aCollectionSize |
    aCollectionSize := aCollection size.
    (self := self new: aCollectionSize + 1)
	replaceFrom: 0 to: aCollectionSize - 1 with: aCollection;
	at: aCollectionSize put: anObject
]

SequenceableCollection with: anObject withAll: aCollection
[
    ^(self new: 1 + aCollection size)
	at: 0 put: anObject;
	replaceFrom: 1 to: aCollection size with: aCollection
]

SequenceableCollection with: anObject withAll: aCollection with: bnObject
[
    | aCollectionSize |
    aCollectionSize := aCollection size.
    self := self new: 2 + aCollectionSize.
    self at: 0 put: anObject;
	replaceFrom: 1 to: aCollectionSize with: aCollection;
	at: aCollectionSize + 1 put: bnObject
]

SequenceableCollection with: anObject with: bnObject withAll: aCollection
[
    ^(self new: 2 + aCollection size)
	at: 0 put: anObject;
	at: 1 put: bnObject;
	replaceFrom: 2 to: aCollection size + 1 with: aCollection
]

SequenceableCollection with: anObject with: bnObject withAll: aCollection from: startIndex
[
    ^(self new: 2 + aCollection size - startIndex)
	at: 0 put: anObject;
	at: 1 put: bnObject;
	replaceFrom: 2 to: aCollection size + 1 - startIndex with: aCollection startingAt: startIndex
]

SequenceableCollection with: anObject with: bnObject with: cnObject withAll: aCollection from: startIndex
[
    ^(self new: 3 + aCollection size - startIndex)
	at: 0 put: anObject;
	at: 1 put: bnObject;
	at: 2 put: cnObject;
	replaceFrom: 3 to: aCollection size + 2 - startIndex with: aCollection startingAt: startIndex
]

SequenceableCollection withAllFrom: firstValue to: lastValue
[
    firstValue println.  lastValue println.
    self := self new: lastValue - firstValue + 1.
    firstValue to: lastValue doWithIndex: [:val :ind | self at: ind put: val].
]

SequenceableCollection new: size withAll: value
[
    ^(self new: size) atAllPut: value; yourself
]

SequenceableCollection new: size atAllPut: value
[
    ^(self new: size) atAllPut: value; yourself
]

SequenceableCollection atAllPut: value
[
    0 to: self size - 1 do: [:key | self at: key put: value].
]

SequenceableCollection atAll: keyCollection put: value
[
    keyCollection do: [:key | self at: key put: value]
]

SequenceableCollection addAllLast: aCollection
[
    aCollection do: [:elt | self addLast: elt]
]

SequenceableCollection = aCollection
[   
    self == aCollection ifTrue: [^true].
    (aCollection isSequenceableCollection and: [self size == aCollection size]) ifFalse: [^false].
    self with: aCollection do: [:a :b | a = b ifFalse: [^false]].
    ^true
]

SequenceableCollection from: firstKey to: lastKey put: value
[
    firstKey to: lastKey do: [:key | self at: key put: value]
]

SequenceableCollection collect: elementBlock
[
    ^self collect: elementBlock as: self
]

SequenceableCollection collect: elementBlock as: resultType
[
    | result |
    result := resultType new: self size.
    self doWithIndex: [:e :i | result at: i put: (elementBlock value: e)].
    ^result
]

SequenceableCollection from: firstIndex collect: elementBlock
[
    ^self from: firstIndex to: self size - 1 collect: elementBlock
]

SequenceableCollection from: firstIndex to: lastIndex collect: elementBlock
[
    | result |
    result := self new: lastIndex - firstIndex + 1.
    firstIndex to: lastIndex do: [:i | result at: i - firstIndex put: (elementBlock value: (self at: i))].
    ^result
]

SequenceableCollection do: elementBlock			[ self from: 0 do: elementBlock ]
SequenceableCollection reverseDo: elementBlock		[ self from: 0 reverseDo: elementBlock ]
SequenceableCollection doWithIndex: elementIndexBlock	[ self from: 0 doWithIndex: elementIndexBlock ]
SequenceableCollection reverseDoWithIndex: eiBlock	[ self from: 0 reverseDoWithIndex: eiBlock ]
SequenceableCollection do: aBlock separatedBy: bBlock	[ self from: 0 do: aBlock separatedBy: bBlock ]

SequenceableCollection from: start do: elementBlock
[
    self from: start to: self size - 1 do: elementBlock
]

SequenceableCollection from: start to: stop do: elementBlock
[
    start to: stop do: [:offset | elementBlock value: (self at: offset)].
]

SequenceableCollection from: start reverseDo: elementBlock
[
    self size - 1 downTo: start do: [:offset | elementBlock value: (self at: offset)].
]

SequenceableCollection from: start doWithIndex: elementIndexBlock
[
    start to: self size - 1 do: [:offset | elementIndexBlock value: (self at: offset) value: offset].
]

SequenceableCollection from: start reverseDoWithIndex: elementIndexBlock
[
    self size - 1 downTo: start do: [:offset | elementIndexBlock value: (self at: offset) value: offset].
]

SequenceableCollection from: start do: elementBlock separatedBy: betweenBlock
[
    | first |
    first := true.
    self from: start do: [:e |
	first ifTrue: [first := false] ifFalse: [betweenBlock value].
	elementBlock value: e].
]

SequenceableCollection by2do: elementBlock	[ 0 by: 2 to: self size - 2 do: [:i | elementBlock value: (self at: i) value: (self at: i + 1)] ]

SequenceableCollection inject: result into: binaryBlock
[
    self do: [:element | result := binaryBlock value: result value: element].
    ^result
]

SequenceableCollection from: index inject: result into: binaryBlock
[
    self from: index do: [:element | result := binaryBlock value: result value: element].
    ^result
]

SequenceableCollection detect: unaryBlock
[
    ^self detect: unaryBlock ifAbsent: []
]

SequenceableCollection detect: unaryBlock ifAbsent: defaultBlock
[
    self do: [:element || detected | (detected := unaryBlock value: element) notNil ifTrue: [^detected]].
    ^defaultBlock value
]

SequenceableCollection reverseDetect: unaryBlock ifAbsent: defaultBlock
[
    self reverseDo: [:element || detected | (detected := unaryBlock value: element) notNil ifTrue: [^detected]].
    ^defaultBlock value
]

SequenceableCollection with: aCollection do: elementBlock
[
    self size == aCollection size ifFalse: [self error: 'collection sizes differ'].
    0 to: self size - 1 do: [:offset | elementBlock value: (self at: offset) value: (aCollection at: offset)].
]

SequenceableCollection with: aCollection with: bCollection do: elementBlock
[
    (self size == aCollection size and: [self size == bCollection size]) ifFalse: [self error: 'collection sizes differ'].
    0 to: self size - 1 do: [:offset | elementBlock value: (self at: offset) value: (aCollection at: offset) value: (bCollection at: offset)].
]

SequenceableCollection with: aCollection doWithIndex: elementsIndexBlock
[
    self size == aCollection size ifFalse: [self error: 'collection sizes differ'].
    0 to: self size - 1 do: [:offset | elementsIndexBlock value: (self at: offset) value: (aCollection at: offset) value: offset].
]

SequenceableCollection with: aCollection replace: elementsBlock
[
    self with: aCollection doWithIndex: [:a :b :i | self at: i put: (elementsBlock value: a value: b)]
]

SequenceableCollection replaceFrom: first to: last with: aCollection
[
    self replaceFrom: first to: last with: aCollection startingAt: 0
]

SequenceableCollection replaceFrom: first to: last with: aCollection startingAt: collectionStart
[
    0 to: last - first do: [:offset | self at: first + offset put: (aCollection at: collectionStart + offset)].
]

SequenceableCollection copy
[
    ^(self new: self size) replaceFrom: 0 to: self size - 1 with: self startingAt: 0
]

SequenceableCollection copyWithFirst: firstObject
[
    ^(self new: self size + 1)
	at:          0 put: firstObject;
	replaceFrom: 1 to:  self size with: self startingAt: 0
]

SequenceableCollection copyFrom: first
[
    ^self copyFrom: first to: self size - 1
]

SequenceableCollection copyFrom: first to: last
[
    | size |
    size := 0 max: last - first + 1.
    ^(self new: size) replaceFrom: 0 to: size - 1 with: self startingAt: first
]

SequenceableCollection trimmed
[
    ^self copyFrom: 1 to: self size - 2
]

SequenceableCollection , aCollection
[
    ^(self new: self size + aCollection size)
	replaceFrom: 0 to: self size - 1 with: self;
	replaceFrom: self size to: self size + aCollection size - 1 with: aCollection
]

SequenceableCollection indexOf: anObject ifAbsent: errorBlock
[
    self doWithIndex: [:element :index | element == anObject ifTrue: [^index]].
    ^errorBlock value
]

SequenceableCollection concatenated
[
    | result |
    result := (self first new: 4) writeStream.
    self do: [:elt | result nextPutAll: elt].
    ^result contents
]

SequenceableCollection flattened
[
    | result |
    result := (self new: 4) writeStream.
    self flattenOn: result.
    ^result contents
]

Object flattenOn: aStream
[
    aStream nextPut: self
]

SequenceableCollection flattenOn: aStream
[
    aStream collection _vtable == self _vtable
	ifTrue:  [self do: [:elt | elt flattenOn: aStream]]
	ifFalse: [super flattenOn: aStream]
]

CharacterClass : ByteArray ()

CharacterClass includes: aCharacter	[ ^aCharacter and: [0 ~~ (self bitAt: aCharacter)] ]

SequenceableCollection asCharacterClass
[
    | stream class complement c prev |
    class := CharacterClass new: 32 withAll: 0.
    (stream := self readStream) atEnd ifTrue: [class].
    (complement := stream peek == $^) ifTrue: [stream next].
    [c := stream next]
	whileTrue:
	   [(c == $- and: [prev and: [stream atEnd not]])
		ifTrue:
		   [prev to: stream next do: [:n | class setBit: n].
		    prev := nil]
		ifFalse:
		   [class setBit: (prev := c)]].
    complement ifTrue: [class invertBits].
    ^class
]
