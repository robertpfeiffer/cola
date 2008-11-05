{ import: Object }

ArrayedCollection growTo: newSize
[
    | newArray |
    newArray := self new: newSize.
    newArray replaceFrom: 0 to: (newSize min: self size) - 1 with: self startingAt: 0.
    ^newArray
]

SparseArray : ArrayedCollection ( elements )

SparseArray new
[
    self := self new: 8.
]

SparseArray new: initialCapacity
[
    self := super new: initialCapacity.
    elements := Array new: initialCapacity.
]

SparseArray at: index
[
    | bucket |
    bucket := index // 32.
    bucket := bucket >= elements size
	ifTrue:  [(elements := elements growTo: bucket + 1) at: bucket put: (Array new: 32)]
	ifFalse: [(elements at: bucket) ifNil: [elements at: bucket put: (Array new: 32)]].
    ^bucket at: index \\ 32.
]

SparseArray at: index put: anObject
[
    | bucket |
    bucket := index // 32.
    bucket := bucket >= elements size
	ifTrue:  [(elements := elements growTo: bucket + 1) at: bucket put: (Array new: 32)]
	ifFalse: [(elements at: bucket) ifNil: [elements at: bucket put: (Array new: 32)]].
    ^bucket at: index \\ 32 put: anObject.
]

SparseArray size
[
    ^elements size * 32
]

SparseArray printOn: aStream
[
    aStream nextPutAll: self debugName.
    aStream nextPut: $(.
    0 to: elements size - 1 do: [:bucket |
	(elements at: bucket)
	    ifTrue: [aStream print: bucket * 32 ; nextPutAll: '->'; print: (elements at: bucket)]].
    aStream nextPut: $).
]

[
    | s |
    s := SparseArray new.
    s	at:    1 put: #one;
	at:    2 put: #two;
	at:    4 put: #three;
	at:    8 put: #four;
	at:   16 put: #five;
	at:   32 put: #six;
	at:   64 put: #seven;
	at:  128 put: #eight;
	at:  256 put: #nine;
	at:  512 put: #ten;
	at: 1024 put: #eleven.
    s println.
]
