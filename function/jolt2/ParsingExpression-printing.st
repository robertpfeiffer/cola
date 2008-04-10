{ import: ParsingExpression }

PeAny printOn: aStream	[ aStream nextPutAll: '.' ]

PeIdentity printOn: aStream	[ aStream nextPutAll: '=='; print: value ]
PeEquality printOn: aStream	[ aStream nextPutAll: '=' ; print: value ]
PeClass    printOn: aStream	[ aStream nextPutAll: '=' ; print: value ]
PeSequence printOn: aStream	[ aStream nextPutAll: '=*'; print: value ]
PeStructure printOn: aStream	[ aStream nextPutAll: '=#('; print: value; nextPut: $) ]

PeNot printOn: aStream		[ aStream nextPutAll: '!' ; print: value ]

PeZeroOne  printOn: aStream	[ aStream print: value; nextPut: $? ]
PeZeroMore printOn: aStream	[ aStream print: value; nextPut: $* ]
PeOneMore  printOn: aStream	[ aStream print: value; nextPut: $+ ]

ParsingExpression isUnresolved	[ ^nil ]
PeUnresolved isUnresolved	[]

PeName printOn: aStream
[
    aStream print: name.
    value isUnresolved ifTrue: [aStream nextPutAll: '!!!']
]

PeRule printOn: aStream		[ aStream print: name; nextPutAll: ' = '; print: value ]

ParsingExpressionMultiple printOn: aStream
[
    aStream nextPut: $(.
    value do: [:pe | pe printOn: aStream] separatedBy: [aStream nextPutAll: self delimiter].
    aStream nextPut: $).
]

PeAnd delimiter	[ ^' ' ]
PeOr  delimiter	[ ^' | ' ]

PeTextResult printOn: aStream
[
    value printOn: aStream.
    aStream nextPut: $$.
]

PeAction	printOn: aStream	[ aStream nextPutAll: '{'; print: value; nextPutAll: '}' ]
PeStoreResult	printOn: aStream	[ aStream nextPutAll: '->'; print: value ]
PeSetResult	printOn: aStream	[ aStream nextPutAll: '<-#' ]

PeSave		printOn: aStream	[ aStream nextPutAll: '@='; print: size; space; print: value ]
PePush		printOn: aStream	[ aStream nextPutAll: '@+'; print: value ]
PePop		printOn: aStream	[ aStream nextPutAll: '@-'; print: value ]

PeItemResult printOn: aStream
[
    value printOn: aStream.
    aStream nextPutAll: ' <item>'.
]


PeCollectResult printOn: aStream
[
    aStream nextPut: $+.
    super printOn: aStream.
]

PeCollectResults printOn: aStream
[
    aStream nextPut: ${; print: index; nextPut: $}.
    value printOn: aStream.
]
