{ import: Objects }

SmallInteger toFixed: n
[
    ^self asString
]

Float toFixed: n
[
    | r |
    n = 0 ifTrue: [^self truncated asString].
    r := self asString.
    ^r copyFrom: 0 to: (r indexOf: $. ifAbsent: ["impossible"]) + n
]
