{ import: Token }

Memo : Object ( success result next )

Memo success	[ ^success ]
Memo result	[ ^result ]
Memo next	[ ^next ]

Memo withSuccess: ok result: anObject next: aToken
[
    self := self new.
    success := ok.
    result := anObject.
    next := aToken.
]

UndefinedObject memoAt: aSymbol put: anObject	[ ^nil ]

Token memoAt: aSymbol put: aMemo
[
    properties ifFalse: [properties := MemoDictionary new].
    properties at: aSymbol put: aMemo.
]

Token			memoAt: aSymbol	[ ^properties memoAt: aSymbol ]
UndefinedObject		memoAt: aSymbol	[ ^nil ]
SlotDictionary		memoAt: aSymbol	[ ^self at: aSymbol ]
IdentityDictionary	memoAt: aSymbol	[ ^self at: aSymbol ifAbsent: [] ]

Parser : Object ( result )

Parser result	[ ^result ]

Parser parse: aCollection
[
    ^self start :aCollection tokenStream
]

Parser memoized: ruleName :input
[
    ^input peekToken memoAt: ruleName
]

Parser memoize: ruleName at: token success: ok result: anObject :input
[
    token memoAt: ruleName put: (Memo withSuccess: ok result: anObject next: input position)
]

Parser beginStructure: inputStream
[
    | struct |
    ^((struct := inputStream peek) and: [struct isSequenceableCollection]) ifTrue: [struct tokenStream]
]

Parser class: charClass :input
[
    | tok |
    ((tok := input peekToken) and: [0 ~~ (charClass bitAt: tok value)]) ifFalse: [^nil].
    result := input next.
]

Parser string: aCollection :input
[
    | pos |
    ^input matchString: aCollection.
"
    pos := input position.
    aCollection do: [:e | e == input peek ifTrue: [input nextToken] ifFalse: [^input position: pos]].
    result := aCollection.
"
]

Parser apply :input
[
    | selector |
    (selector := input next) ifFalse: [self error: 'cannot apply nothing at all'].
    selector isSymbol ifFalse: [self error: 'cannot apply non-selector'].
    ^self perform: selector with: input
]

Parser error :input
[
    self error: input next, ' near: ', input printString
]
