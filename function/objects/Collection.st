{ import: Objects }

Collection isEmpty	[ ^self size == 0 ]
Collection notEmpty	[ ^self isEmpty not ]

Collection emptyCheck
[
    self isEmpty ifTrue: [self error: 'this collection is empty']
]

Collection addAll: aCollection		[ aCollection do: [:elt | self add: elt] ]
Collection removeAll: aCollection	[ aCollection do: [:elt | self remove: elt] ]

Collection printOn: aStream
[
    aStream nextPutAll: self debugName.
    self printContentsOn: aStream.
]

Collection printContentsOn: aStream
[
    aStream nextPut: $(.
    self do: [:element | element printOn: aStream] separatedBy: [aStream space].
    aStream nextPut: $).
]

Collection do: elementBlock separatedBy: betweenBlock
[
    | first |
    first := true.
    self do: [:element |
	first ifTrue: [first := false] ifFalse: [betweenBlock value].
	elementBlock value: element].
]

Collection includes: anObject
[
    self do: [:element | element == anObject ifTrue: [^true]].
    ^false
]

Collection readStream	[ ^ReadStream on: self ]
Collection writeStream	[ ^WriteStream on: self ]
