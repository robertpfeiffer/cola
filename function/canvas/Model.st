{ import: Object }

Model : Object ( dependents messages )

Model new
[
    self := super new.
    dependents := OrderedCollection new.
    messages := IdentityDictionary new.
]

Model addDependent: anObject			[ dependents add: anObject ]
Model addDependent: anObject message: aSelector	[ dependents add: anObject.  messages at: anObject put: aSelector ]
Model removeDependent: anObject			[ dependents remove: anObject.  messages removeKey: anObject ifAbsent: [] ]

Model changed
[
    dependents do: [:dependent |
	| message |
	message := messages at: dependent ifAbsent: [#update:].
	dependent perform: message with: self]
]
