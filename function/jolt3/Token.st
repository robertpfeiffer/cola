{ import: Objects }

Tokens := [ nil ]

Token : Object ( value next properties nextToken )

Token new
[
    self := super new.
    nextToken := Tokens.
    Tokens := self.
]

Token printAllStats
[
    [Tokens] whileTrue: [Tokens := Tokens printStats]
]

Token printStats
[
    properties ifTrue: [properties size println].
    ^nextToken
]

Token value		[ ^value ]
Token next		[ ^next ]
Token next: aToken	[ ^next := aToken ]

Token propertyAt: aKey			[ ^properties ifTrue: [properties at: aKey ifAbsent: []] ]
Token propertyAt: aKey put: aValue	[ ^self properties at: aKey put: aValue ]
Token properties			[  properties ifFalse: [properties := SlotDictionary new].  ^properties ]

Token withValue: x
[
    self := self new.
    value := x.
]

Token withValue: x next: y
[
    self := self new.
    value := x.
    next := y.
]

Token printOn: aStream
[
    (value isInteger and: [9 <= value and: [value < 127]])
	ifTrue:  [aStream nextPut: value]
	ifFalse: [aStream nextPut: $<; print: value; nextPut: $>].
]

Token text: last	[ ^self merge: last as: String ]

Token merge: last as: type
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

"----------------------------------------------------------------"

TokenStream : Object ( input )

TokenStream tokenStream	[ ^self ]

TokenStream on: aToken
[
    self := self new.
    input := aToken.
]

TokenStream position			[ ^input ]
TokenStream position: aPosition		[  input := aPosition.  ^nil ]
TokenStream push: anObject		[  input := Token withValue: anObject next: input ]
TokenStream pushAll: aCollection	[  aCollection reverseDo: [:e | self push: e] ]
TokenStream pushGroup: aGroup		[  aGroup group next: input.  input := aGroup value ]
TokenStream atEnd			[ ^input isNil ]
TokenStream notAtEnd			[ ^input ]
TokenStream peekToken			[ ^input ]
TokenStream peek			[ ^input ifTrue: [input value] ]

TokenStream nextToken
[
    | token |
    input ifTrue: [input := (token := input) next].
    ^token
]

TokenStream next
[
    | token |
    input ifTrue: [input := (token := input) next].
    ^token ifTrue: [token value]
]

TokenStream matchString: aCollection
[
    | pos |
    (input and: [input value == aCollection first]) ifFalse: [^nil].
    pos := input.
    aCollection do: [:c | c == self next ifFalse: [^self position: pos]].
]

TokenStream printOn: aStream
[
    | tok |
    tok := input.
    [tok] whileTrue: [tok printOn: aStream.  tok := tok next].
]

"----------------------------------------------------------------"

TokenInputStream : TokenStream ( stream )

Object tokenStream	[ ^TokenInputStream on: self ]

TokenInputStream on: aCollection
[
    self := self new.
    stream := aCollection readStream.
    stream atEnd ifFalse: [input := Token withValue: stream next].
]

TokenInputStream atEnd		[ ^input isNil and: [stream atEnd] ]
TokenInputStream notAtEnd	[ ^input or: [stream atEnd not] ]

TokenInputStream nextToken
[
    | token next |
    input ifFalse: [^nil].
    token := input.
    input next ifFalse: [stream atEnd ifFalse: [input next: (next := Token withValue: stream next)]].
    input := input next.
    "StdErr tab; tab; nextPutAll: '>>> '; println: token."
    ^token
]

TokenInputStream next
[
    | token next |
    input ifFalse: [^nil].
    token := input.
    input next ifFalse: [stream atEnd ifFalse: [input next: (next := Token withValue: stream next)]].
    input := input next.
    "StdErr tab; tab; nextPutAll: '>>> '; println: token."
    ^token value
]

"----------------------------------------------------------------"

TokenGroup : Token ( group )

TokenGroup group	[ ^group ]

TokenGroup tokenStream	[ ^TokenStream on: value ]

TokenGroup new
[
    self := super new.
    group := self.
]

TokenGroup with: a
[
    self := self new.
    value := group := Token withValue: a.
]

TokenGroup withAll: aCollection
[
    self := self new.
    aCollection do: [:e | self add: e].
]

TokenGroup isGroup	[]
Token isGroup		[ ^nil ]

TokenGroup isSequenceableCollection	[]

TokenGroup concat: aTokenGroup
[
    | tail end |
    (tail := aTokenGroup value)
	ifTrue:
	   [end := aTokenGroup group.
	    value
		ifTrue:
		   [group next: tail.
		    group := end]
		ifFalse:
		   [value := tail.
		    group := end]]
]

TokenGroup addAll: aCollection
[
    aCollection do: [:e | self add: e]
]

TokenGroup addAll: aCollection from: start
[
    aCollection from: start do: [:e | self add: e]
]

TokenGroup add: anObject	[  self addLastToken: (Token withValue: anObject) ]
TokenGroup addLast: anObject	[ ^self addLastToken: (Token withValue: anObject) ]
TokenGroup addFirst: anObject	[ ^self addFirstToken: (Token withValue: anObject) ]

TokenGroup addFirstToken: aToken
[
    ^group == self
	ifTrue:  [group := value := aToken]
	ifFalse: [aToken next: value.  value := aToken]
]

TokenGroup addLastToken: aToken
[
    ^group == self
	ifTrue:  [group := value := aToken]
	ifFalse: [group := (group next: aToken)]
]

TokenGroup printOn: aStream
[
    | token |
    aStream nextPut: ${.
    group == self ifTrue: [^aStream nextPut: $}].
    token := value.
    [token] whileTrue: [aStream space; print: token.  token := token next].
    aStream space; nextPut: $}.
]

TokenGroup isEmpty	[ ^value isNil ]
TokenGroup notEmpty	[ ^value ]

TokenGroup size
[
    | size tok |
    size := 0.
    tok := value.
    [tok] whileTrue: [size := size + 1.  tok := tok next].
    ^size
]

TokenGroup hasSize: n
[
    | tok end |
    (n == 0 and: [value == nil  ]) ifTrue: [^self].
    (n == 1 and: [group == value]) ifTrue: [^self].
    tok := value.
    end := group next.
    [tok ~~ end and: [n > 0]] whileTrue: [tok := tok next.  n := n - 1].
    ^tok == end and: [n == 0]
]

TokenGroup first		[ ^value value ]
TokenGroup second		[ ^value next value ]
TokenGroup third		[ ^value next next value ]
TokenGroup fourth		[ ^value next next next value ]
TokenGroup fifth		[ ^value next next next next value ]

TokenGroup asString	[ ^value ifTrue: [value text: group next] ifFalse: [String new: 0] ]

TokenGroup do: unaryBlock
[
    | token |
    token := value.
    [token] whileTrue: [unaryBlock value: token value.  token := token next]
]

TokenGroup do: unaryBlock separatedBy: thunk
[
    | token |
    token := value.
    [token] whileTrue: [unaryBlock value: token value.  (token := token next) ifTrue: [thunk value]]
]

TokenGroup from: index do: unaryBlock
[
    | token |
    token := value.
    [token and: [index > 0]] whileTrue: [index := index - 1.  token := token next].
    [token] whileTrue: [unaryBlock value: token value.  token := token next].
]

TokenGroup from: index do: unaryBlock separatedBy: thunk
[
    | token |
    token := value.
    [token and: [index > 0]] whileTrue: [index := index - 1.  token := token next].
    [token] whileTrue: [unaryBlock value: token value.  (token := token next) ifTrue: [thunk value]].
]
