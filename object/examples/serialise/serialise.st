{ import: st80 }

Object storeOn: aStream		[ self subclassResponsibility: 'storeOn:' ]

Character isBlank	[ ^self value between: 0 and: 32 ]


SequenceableCollection storeOn: aStream
[
    aStream nextPutAll: self debugName
]

Array storeOn: aStream
[
    aStream nextPutAll: '#('.
    self do: [:element | element storeOn: aStream] separatedBy: [aStream space].
    aStream nextPut: $).
]

Symbol storeOn: aStream
[
    self printOn: aStream.
]

String storeOn: aStream
[
    self printOn: aStream.
]

Integer storeOn: aStream
[
    self printOn: aStream
]

String load
[
    ^self readStream load
]

ReadStream load
[
    | c |
    [(c := self next) notNil and: [c isBlank]] whileTrue.
    c isNil   ifTrue: [^nil].
    c == $#   ifTrue: [^self loadSymbolOrArray].
    c == $'   ifTrue: [^self loadString].
    c isDigit ifTrue: [^self skip: -1; loadNumber].
    self error: 'illegal character in stored literal: ', (self skip: -1; upToEnd)
]

ReadStream loadSymbolOrArray
[
    | c |
    (c := self next) isNil ifTrue: [^self error: 'store string ended while scanning Symbol or Array'].
    c == $(   ifTrue: [^self loadArray].
    c == $'   ifTrue: [^self loadString asSymbol].
    self error: 'illegal character in stored literal: ', (self skip: -1; upToEnd)
]

ReadStream loadArray
[
    | array object c |
    array := OrderedCollection new.
    [[(c := self next) notNil and: [c isBlank]] whileTrue.
     c isNil ifTrue: [self error: 'store string ended while scanning Array'].
     c == $)]
	whileFalse:
	   [object := (self skip: -1; load).
	    object isNil ifTrue: [self error: 'store string ended while scanning Array'].
	    array add: object].
    ^array asArray
]

ReadStream loadString
[
    | string object c |
    string := (String new: 32) writeStream.
    [(c := self next) notNil and: [c ~~ $']] whileTrue: [string nextPut: c].
    c isNil ifTrue: [self error: 'store string ended while scanning String'].
    ^string contents
]

ReadStream loadNumber
[
    | number object c |
    number := 0.
    [(c := self next) notNil and: [c isDigit]] whileTrue: [number := number * 10 + c digitValue].
    self skip: -1.
    ^number
]

ReadStream upToEnd
[
    ^collection copyFrom: position + 1 to: readLimit - 1
]

[
    | original stream string copy |
    original := #(one two 'three' 4 5 (six 7 eight) 9 () () () 10).
    original println.
    stream   := (String new: 32) writeStream.
    #(one two 'three' 4 5 (six 7 eight) 9 () () () 10) storeOn: stream.
    string   := stream contents.
    string println.
    copy     := string load.
    original println.
    copy     println.
    (original = copy ifTrue: ['success'] ifFalse: ['** FAILURE **']) putln.
]
