{ import: Objects }

SequenceableCollection isSequenceableCollection       [ ^true ]
Object isSequenceableCollection                       [ ^false ]

SequenceableCollection first		[ ^self at: 0			]
SequenceableCollection first: anObject	[ ^self at: 0 put: anObject	]
SequenceableCollection second		[ ^self at: 1			]
SequenceableCollection second: anObject	[ ^self at: 1 put: anObject	]
SequenceableCollection third		[ ^self at: 2			]
SequenceableCollection third: anObject	[ ^self at: 2 put: anObject	]
SequenceableCollection fourth		[ ^self at: 3			]
SequenceableCollection fourth: anObject	[ ^self at: 3 put: anObject	]
SequenceableCollection fifth		[ ^self at: 4			]
SequenceableCollection fifth: anObject	[ ^self at: 4 put: anObject	]
SequenceableCollection last		[ ^self at: self size - 1	]

SequenceableCollection asString		[ ^self as: String ]

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
    0 to: self size - 1 do: [:key | self at: key put: value]
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
    | result |
    result := self new: self size.
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
    start to: self size - 1 do: [:offset | elementBlock value: (self at: offset)].
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

SequenceableCollection inject: result into: binaryBlock
[
    self do: [:element | result := binaryBlock value: result value: element].
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
    ^self replaceFrom: first to: last with: aCollection startingAt: 0
]

SequenceableCollection replaceFrom: first to: last with: aCollection startingAt: collectionStart
[
    0 to: last - first do: [:offset | self at: first + offset put: (aCollection at: collectionStart + offset)].
]

SequenceableCollection copy
[
    ^(self new: self size) replaceFrom: 0 to: self size - 1 with: self startingAt: 0
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
