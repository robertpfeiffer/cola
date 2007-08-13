{ import: Views }

"TODO: this needs sideways composition"

CompositeView propertyAt: aKey	[ ^self propertyAt: aKey ifAbsent: [] ]
ComposableView propertyAt: aKey	[ ^self propertyAt: aKey ifAbsent: [] ]


CompositeView propertyAt: aKey ifAbsent: errorBlock
[
    properties ifFalse: [^errorBlock value].
    ^properties at: aKey ifAbsent: errorBlock
]

ComposableView propertyAt: aKey ifAbsent: errorBlock
[
    properties ifFalse: [^errorBlock value].
    ^properties at: aKey ifAbsent: errorBlock
]


CompositeView propertyAt: aKey put: aValue	[ ^(properties ifNil: [properties := IdentityDictionary new]) at: aKey put: aValue ]
ComposableView propertyAt: aKey put: aValue	[ ^(properties ifNil: [properties := IdentityDictionary new]) at: aKey put: aValue ]


CompositeView removeProperty: aKey		[ properties ifTrue: [properties removeKey: aKey ifAbsent: []] ]
ComposableView removeProperty: aKey		[ properties ifTrue: [properties removeKey: aKey ifAbsent: []] ]
