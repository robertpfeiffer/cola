{ import: Token }

Parser : Object ( result )

Parser result	[ ^result ]

Parser on: aCollection
[
    self := self new.
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
