{ import: Objects }

Association : Object ( key value )

Association key		[ ^key ]
Association value	[ ^value ]

Object -> anObject
[
    ^Association withKey: self value: anObject
]

Association withKey: aKey value: aValue
[
    self := self new.
    key := aKey.
    value := aValue.
]

Association setValue: aValue
[
    ^value := aValue.
]

Association identityHash
[
    ^key identityHash
]

Association printOn: aStream
[
    aStream nextPut: $(; print: key; nextPutAll: ' -> '; print: value; nextPut: $)
]
