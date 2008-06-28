{ import: Objects }

ParserToken : Object ( value next )

ParserToken value	[ ^value ]
ParserToken next	[ ^next ]

ParserToken next: aParserToken	[ ^next := aParserToken ]

ParserToken withValue: x
[
    self := self new.
    value := x.
]

ParserToken withValue: x next: y
[
    self := self new.
    value := x.
    next := y.
]

ParserToken printOn: aStream
[
    aStream nextPut: $(.
    [1] whileTrue: [value printOn: aStream.  (self := next) ifTrue: [aStream space]].
    aStream nextPut: $).
]

ParserToken text: last	[ ^self merge: last as: String ]

ParserToken merge: last as: type
[
    | size token merged |
    size := 0.
    token := self.
    [token == last] whileFalse: [size := size + 1.  token := token next].
    merged := type new: size.
    token := self.
    0 to: size - 1 do: [:i | merged at: i put: token value.  token := token next].
    ^merged
]

ParserToken to: last inject: result into: binaryBlock
[
    [self == last]
	whileFalse:
	   [result := binaryBlock value: result value: value.
	    self := next].
    ^result
]

"----------------------------------------------------------------"

ParserStream : Object ( stream input )

ParserStream on: aCollection
[
    self := self new.
    stream := aCollection readStream.
    stream atEnd ifFalse: [input := ParserToken withValue: stream next].
]

ParserStream position			[ ^input ]
ParserStream position: aPosition	[  input := aPosition.  ^nil ]
ParserStream atEnd			[ ^input isNil and: [stream atEnd] ]

ParserStream peek			[ ^input ifTrue: [input value] ]

ParserStream next
[
    | object next |
    input ifFalse: [^nil].
    object := input value.
    input next ifFalse: [stream atEnd ifFalse: [input next: (next := ParserToken withValue: stream next)]].
    input := input next.
    ^object
]

ParserStream push: anObject	[ input := ParserToken withValue: anObject next: input ]

Object parserStream		[ ^ParserStream on: self ]
ParserStream parserStream	[ ^self ]

"----------------------------------------------------------------"

Parser : Object ( input result output )

Parser on: aCollection
[
    self := self new.
    input := aCollection parserStream.
    output := WriteStream on: (Array new: 1024).
]

"
Parser identical
[
    | anObject |
    anObject := input next.
    anObject == input peek ifFalse: [^nil].
    result := input next.
]
"
"
Parser range
[
    | hi lo tok |
    lo := input next.
    hi := input next.
    tok := input peek.
    (lo <= tok and: [tok <= hi]) ifFalse: [^nil].
    result := input next.
]
"

Parser class: charClass
[
    (input peek and: [0 ~~ (charClass bitAt: input peek)]) ifFalse: [^nil].
    result := input next.
]

Parser string: aCollection
[
    | pos |
    pos := input position.
    aCollection do: [:e | e == input peek ifTrue: [input next] ifFalse: [^input position: pos]].
    result := aCollection
]

Parser includes
[
    | aCollection |
    aCollection := input next.
    (aCollection includes: input peek) ifFalse: [^nil].
    result := input next.
]
