" IdentityDictionary.st -- dictionaries mapping non-identical keys to values

  Copyright (c) 2006, 2007 Ian Piumarta
  All rights reserved.

  Permission is hereby granted, free of charge, to any person obtaining a
  copy of this software and associated documentation files (the 'Software'),
  to deal in the Software without restriction, including without limitation
  the rights to use, copy, modify, merge, publish, distribute, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, provided that the above copyright notice(s) and this
  permission notice appear in all copies of the Software and that both the
  above copyright notice(s) and this permission notice appear in supporting
  documentation.

  THE SOFTWARE IS PROVIDED 'AS IS'.  USE ENTIRELY AT YOUR OWN RISK.

  Last edited: 2007-11-05 09:27:24 by piumarta on emilia.local
"

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

IdentityDictionary at: aKey ifAbsentPut: anObject
[
    | lookup assoc |
    ^(assoc := self findElement: (lookup := aKey -> nil)) notNil
	ifTrue:  [assoc value]
	ifFalse: [(self add: lookup) setValue: anObject]
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

IdentityDictionary keys
[
    | keys |
    keys := OrderedCollection new.
    self do: [:assoc | keys add: assoc key].
    ^keys
]

IdentityDictionary keysDo: aBlock
[
    self do: [:assoc | aBlock value: assoc key]
]

IdentityDictionary valuesDo: aBlock
[
    self do: [:assoc | aBlock value: assoc value]
]

IdentityDictionary valuesReverseDo: aBlock
[
    self reverseDo: [:assoc | aBlock value: assoc value]
]

FastIdentityDictionary : IdentityDictionary ()

FastIdentityDictionary newList	[ ^Array new: 1 ]

FastIdentityDictionary grow: list at: listOffset
[
    list size >= 4
	ifTrue:  [self widen]
	ifFalse: [self deepen: list at: listOffset]
]
