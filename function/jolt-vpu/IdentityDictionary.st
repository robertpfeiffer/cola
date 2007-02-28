{ import: Objects }

IdentityDictionary compare: anEntry with: anObject
[
    ^anEntry key == anObject key
]

IdentityDictionary at: aKey
[
    ^self at: aKey ifAbsent: [self errorKeyNotFound]
]

IdentityDictionary at: aKey ifAbsent: failBlock
[
    | assoc |
    ^(assoc := self findElement: aKey -> nil) notNil
	ifTrue:  [assoc value]
	ifFalse: [failBlock value]
]

IdentityDictionary at: aKey put: anObject
[
    ^(self add: aKey -> anObject) setValue: anObject
]

IdentityDictionary associationAt: aKey ifAbsent: errorBlock
[
    | assoc |
    assoc := self findElement: aKey -> nil.
    ^assoc notNil ifTrue: [assoc] ifFalse: [errorBlock value]
]

IdentityDictionary includesKey: aKey
[
    ^(self associationAt: aKey ifAbsent: []) notNil
]

IdentityDictionary removeKey: aKey ifAbsent: errorBlock
[
    super remove: aKey -> nil ifAbsent: [^errorBlock value].
    ^aKey
]

"
IdentityDictionary do: unaryBlock
[
    super do: [:assoc | unaryBlock value: assoc value]
]

IdentityDictionary printContentsOn: aStream
[
    aStream nextPutAll: '( '.
    super do: [:assoc | aStream print: assoc; space].
    aStream nextPut: $).
]
"

FastIdentityDictionary : IdentityDictionary ()

FastIdentityDictionary newList	[ ^Array new: 1 ]

FastIdentityDictionary grow: list at: listOffset
[
    list size >= 4
	ifTrue:  [self widen]
	ifFalse: [self deepen: list at: listOffset]
]
