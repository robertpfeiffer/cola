"THIS FILE WAS GENERATED AUTOMATICALLY -- DO NOT EDIT!"

{ import: Object }

{ import: Parser }

MyParser : Parser ()
MyParser start
[
	^(self Grammar)]
MyParser Grammar
[
	| g pos1 pos2 |
	^(((pos1 := input position)
		and: [(self Spacing)
		and: [(((pos2 := OrderedCollection new)
			and: [(((self Definition)) ifTrue: [pos2 add: result. 1])
			and: [[(self Definition)] whileTrue: [pos2 add: result].
			      result := pos2. 1]]) and: [g := result. 1])
		and: [(self EndOfFile)
		and: [(result := g)]]]]) or: [input position: pos1])
]
MyParser Definition
[
	| i pos1 pos2 |
	^(((pos1 := input position)
		and: [((self Identifier) and: [i := result. 1])
		and: [((pos2 := OrderedCollection new)
			and: [[(self Parameter)] whileTrue: [pos2 add: result].
				result := pos2])
		and: [(self LEFTARROW)
		and: [(self Expression)
		and: [(((self SEMICOLON)) ifTrue: [result := Array with: result] ifFalse: [result := #()])
		and: [(result := i)]]]]]]) or: [input position: pos1])
]
MyParser Parameter
[
	| pos1 |
	^(((pos1 := input position)
		and: [((input peek == 58) ifTrue: [result := input next])

		and: [(self Identifier)]]) or: [input position: pos1])
]
MyParser Expression
[
	| pos1 pos2 pos3 |
	^(((pos1 := input position)
		and: [(self Sequence)
		and: [((pos2 := OrderedCollection new)
			and: [[(((pos3 := input position)
				and: [(self SLASH)
				and: [(self Sequence)]]) or: [input position: pos3])
			] whileTrue: [pos2 add: result].
				result := pos2])]]) or: [input position: pos1])
]
MyParser Sequence
[
	| pos1 |
	^((pos1 := OrderedCollection new)
		and: [[(self Prefix)] whileTrue: [pos1 add: result].
			result := pos1])]
MyParser Prefix
[
	| pos1 |
	^((((pos1 := input position)
		and: [((((self AND)
			or: [(self NOT)])
			) ifTrue: [result := Array with: result] ifFalse: [result := #()])
		and: [(self Assignment)]]) or: [input position: pos1])

		or: [(self Store)])
]
MyParser Assignment
[
	| pos1 pos2 |
	^(((pos1 := input position)
		and: [(self Storable)
		and: [((pos2 := OrderedCollection new)
			and: [[(self Store)] whileTrue: [pos2 add: result].
				result := pos2])]]) or: [input position: pos1])
]
MyParser Storable
[
	| pos1 |
	^(((pos1 := input position)
		and: [(self Suffix)
		and: [(((self DOLLAR)) ifTrue: [result := Array with: result] ifFalse: [result := #()])]]) or: [input position: pos1])
]
MyParser Store
[
	| pos1 |
	^(((pos1 := input position)
		and: [(self COLON)
		and: [(self Identifier)]]) or: [input position: pos1])
]
MyParser Suffix
[
	| pos1 |
	^(((pos1 := input position)
		and: [(self Primary)
		and: [((((self QUESTION)
			or: [(self STAR)
			or: [(self PLUS)]])
			) ifTrue: [result := Array with: result] ifFalse: [result := #()])]]) or: [input position: pos1])
]
MyParser Primary
[
	| pos1 |
	^((self Invocation)
		or: [(((pos1 := input position)
			and: [(self OPEN)
			and: [(self Expression)
			and: [(self CLOSE)]]]) or: [input position: pos1])

		or: [(self Literal)
		or: [(self Class)
		or: [(self DOT)
		or: [(self Answer)]]]]])
]
MyParser Answer
[
	| pos1 |
	^(((pos1 := input position)
		and: [(self RIGHTARROW)
		and: [(self Identifier)]]) or: [input position: pos1])
]
MyParser Invocation
[
	| pos1 pos2 |
	^((((pos1 := input position)
		and: [(self Identifier)
		and: [(((pos2 := input position) and: [(self LEFTARROW)]) ifTrue: [input position: pos2] ifFalse: [1])]]) or: [input position: pos1])

		or: [(((pos1 := input position)
			and: [(self LANGLE)
			and: [(self Identifier)
			and: [((pos2 := OrderedCollection new)
				and: [[(self Argument)] whileTrue: [pos2 add: result].
					result := pos2])
			and: [(self RANGLE)]]]]) or: [input position: pos1])
		])
]
MyParser Argument
[
	^(self Identifier)]
MyParser Identifier
[
	| i pos1 pos2 pos3 pos4 |
	^(((pos1 := input position)
		and: [((((pos2 := input position)
			and: [(((pos3 := input position)
				and: [(self IdentStart)
				and: [((pos4 := OrderedCollection new)
					and: [[(self IdentCont)] whileTrue: [pos4 add: result].
						result := pos4])]]) or: [input position: pos3])
			])ifTrue: [result := pos2 text: input position])
		 and: [i := result. 1])
		and: [(self Spacing)
		and: [(result := i)]]]) or: [input position: pos1])
]
MyParser IdentStart
[
	^(self class: #[0 0 0 0 0 0 0 0 254 255 255 135 254 255 255 7 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0])]
MyParser IdentCont
[
	^((self IdentStart)
		or: [(self class: #[0 0 0 0 0 0 255 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0])])
]
MyParser Literal
[
	| pos1 pos2 pos3 pos4 |
	^((((pos1 := input position)
		and: [((input peek == 39) ifTrue: [result := input next])

		and: [((pos2 := OrderedCollection new)
			and: [[(((pos3 := input position)
				and: [(((pos4 := input position) and: [((input peek == 39) ifTrue: [result := input next])
				]) ifTrue: [input position: pos4] ifFalse: [1])
				and: [(self Char)]]) or: [input position: pos3])
			] whileTrue: [pos2 add: result].
				result := pos2])
		and: [((input peek == 39) ifTrue: [result := input next])

		and: [(self Spacing)]]]]) or: [input position: pos1])

		or: [(((pos1 := input position)
			and: [((input peek == 34) ifTrue: [result := input next])

			and: [((pos2 := OrderedCollection new)
				and: [[(((pos3 := input position)
					and: [(((pos4 := input position) and: [((input peek == 34) ifTrue: [result := input next])
					]) ifTrue: [input position: pos4] ifFalse: [1])
					and: [(self Char)]]) or: [input position: pos3])
				] whileTrue: [pos2 add: result].
					result := pos2])
			and: [((input peek == 34) ifTrue: [result := input next])

			and: [(self Spacing)]]]]) or: [input position: pos1])
		])
]
MyParser Class
[
	| pos1 pos2 pos3 pos4 |
	^(((pos1 := input position)
		and: [((input peek == 91) ifTrue: [result := input next])

		and: [((pos2 := OrderedCollection new)
			and: [[(((pos3 := input position)
				and: [(((pos4 := input position) and: [((input peek == 93) ifTrue: [result := input next])
				]) ifTrue: [input position: pos4] ifFalse: [1])
				and: [(self Range)]]) or: [input position: pos3])
			] whileTrue: [pos2 add: result].
				result := pos2])
		and: [((input peek == 93) ifTrue: [result := input next])

		and: [(self Spacing)]]]]) or: [input position: pos1])
]
MyParser Range
[
	| pos1 |
	^((((pos1 := input position)
		and: [(self Char)
		and: [((input peek == 45) ifTrue: [result := input next])

		and: [(self Char)]]]) or: [input position: pos1])

		or: [(self Char)])
]
MyParser Char
[
	| pos1 pos2 |
	^((((pos1 := input position)
		and: [((input peek == 92) ifTrue: [result := input next])

		and: [(self class: #[0 0 0 0 132 0 0 0 0 0 0 56 0 64 20 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0])]]) or: [input position: pos1])

		or: [(((pos1 := input position)
			and: [((input peek == 92) ifTrue: [result := input next])

			and: [(self class: #[0 0 0 0 0 0 7 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0])
			and: [(self class: #[0 0 0 0 0 0 255 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0])
			and: [(self class: #[0 0 0 0 0 0 255 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0])]]]]) or: [input position: pos1])

		or: [(((pos1 := input position)
			and: [((input peek == 92) ifTrue: [result := input next])

			and: [(self class: #[0 0 0 0 0 0 255 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0])
			and: [(((self class: #[0 0 0 0 0 0 255 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0])) ifTrue: [result := Array with: result] ifFalse: [result := #()])]]]) or: [input position: pos1])

		or: [(((pos1 := input position)
			and: [(((pos2 := input position) and: [((input peek == 92) ifTrue: [result := input next])
			]) ifTrue: [input position: pos2] ifFalse: [1])
			and: [(input atEnd not and: [result := input next. 1])
			]]) or: [input position: pos1])
		]]])
]
MyParser LEFTARROW
[
	| pos1 |
	^(((pos1 := input position)
		and: [((input peek == 61) ifTrue: [result := input next])

		and: [(self Spacing)]]) or: [input position: pos1])
]
MyParser RIGHTARROW
[
	| pos1 |
	^(((pos1 := input position)
		and: [(self string: '->')

		and: [(self Spacing)]]) or: [input position: pos1])
]
MyParser SLASH
[
	| pos1 |
	^(((pos1 := input position)
		and: [((input peek == 124) ifTrue: [result := input next])

		and: [(self Spacing)]]) or: [input position: pos1])
]
MyParser AND
[
	| pos1 |
	^(((pos1 := input position)
		and: [((input peek == 38) ifTrue: [result := input next])

		and: [(self Spacing)]]) or: [input position: pos1])
]
MyParser NOT
[
	| pos1 |
	^(((pos1 := input position)
		and: [((input peek == 33) ifTrue: [result := input next])

		and: [(self Spacing)]]) or: [input position: pos1])
]
MyParser QUESTION
[
	| pos1 |
	^(((pos1 := input position)
		and: [((input peek == 63) ifTrue: [result := input next])

		and: [(self Spacing)]]) or: [input position: pos1])
]
MyParser STAR
[
	| pos1 |
	^(((pos1 := input position)
		and: [((input peek == 42) ifTrue: [result := input next])

		and: [(self Spacing)]]) or: [input position: pos1])
]
MyParser PLUS
[
	| pos1 |
	^(((pos1 := input position)
		and: [((input peek == 43) ifTrue: [result := input next])

		and: [(self Spacing)]]) or: [input position: pos1])
]
MyParser OPEN
[
	| pos1 |
	^(((pos1 := input position)
		and: [((input peek == 40) ifTrue: [result := input next])

		and: [(self Spacing)]]) or: [input position: pos1])
]
MyParser CLOSE
[
	| pos1 |
	^(((pos1 := input position)
		and: [((input peek == 41) ifTrue: [result := input next])

		and: [(self Spacing)]]) or: [input position: pos1])
]
MyParser LANGLE
[
	| pos1 |
	^(((pos1 := input position)
		and: [((input peek == 60) ifTrue: [result := input next])

		and: [(self Spacing)]]) or: [input position: pos1])
]
MyParser RANGLE
[
	| pos1 |
	^(((pos1 := input position)
		and: [((input peek == 62) ifTrue: [result := input next])

		and: [(self Spacing)]]) or: [input position: pos1])
]
MyParser DOT
[
	| pos1 |
	^(((pos1 := input position)
		and: [((input peek == 46) ifTrue: [result := input next])

		and: [(self Spacing)]]) or: [input position: pos1])
]
MyParser SEMICOLON
[
	| pos1 |
	^(((pos1 := input position)
		and: [((input peek == 59) ifTrue: [result := input next])

		and: [(self Spacing)]]) or: [input position: pos1])
]
MyParser COLON
[
	| pos1 |
	^(((pos1 := input position)
		and: [((input peek == 58) ifTrue: [result := input next])

		and: [(self Spacing)]]) or: [input position: pos1])
]
MyParser DOLLAR
[
	| pos1 |
	^(((pos1 := input position)
		and: [((input peek == 36) ifTrue: [result := input next])

		and: [(self Spacing)]]) or: [input position: pos1])
]
MyParser Spacing
[
	| pos1 |
	^((pos1 := OrderedCollection new)
		and: [[((self Space)
			or: [(self Comment)])
		] whileTrue: [pos1 add: result].
			result := pos1])]
MyParser Comment
[
	| pos1 pos2 pos3 pos4 |
	^(((pos1 := input position)
		and: [((input peek == 35) ifTrue: [result := input next])

		and: [((pos2 := OrderedCollection new)
			and: [[(((pos3 := input position)
				and: [(((pos4 := input position) and: [(self EndOfLine)]) ifTrue: [input position: pos4] ifFalse: [1])
				and: [(input atEnd not and: [result := input next. 1])
				]]) or: [input position: pos3])
			] whileTrue: [pos2 add: result].
				result := pos2])
		and: [(self EndOfLine)]]]) or: [input position: pos1])
]
MyParser Space
[
	^(((input peek == 32) ifTrue: [result := input next])

		or: [((input peek == 9) ifTrue: [result := input next])

		or: [(self EndOfLine)]])
]
MyParser EndOfLine
[
	^((self string: '
')

		or: [((input peek == 10) ifTrue: [result := input next])

		or: [((input peek == 13) ifTrue: [result := input next])
		]])
]
MyParser EndOfFile
[
	| pos1 |
	^(((pos1 := input position) and: [(input atEnd not and: [result := input next. 1])
	]) ifTrue: [input position: pos1] ifFalse: [1])]
MyParser test
[
    self := self on: StdIn.
    self start ifTrue: [result println] ifFalse: ['FAIL' putln].
]

[ MyParser test ]
