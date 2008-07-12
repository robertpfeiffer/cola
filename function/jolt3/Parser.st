{ import: Token }

Parser : Object ( result )

Parser result	[ ^result ]

Parser parse: aCollection
[
    ^self start :aCollection tokenStream
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
    pos := input position.
    aCollection do: [:e | e == input peek ifTrue: [input nextToken] ifFalse: [^input position: pos]].
    result := aCollection
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
