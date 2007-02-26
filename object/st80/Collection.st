" Collection.st -- aggregates that can be enumerated

  Copyright (c) 2005 Ian Piumarta
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

  Last edited: 2006-04-27 00:17:20 by piumarta on emilia.local
"

{ import: Object }

Collection  : Object ()

Collection isCollection	[ ^true ]
Object isCollection	[ ^false ]

Collection initialize: anInteger []

Collection species		[ ^self subclassResponsibility: 'species' ]
Collection add: anObject	[ ^self subclassResponsibility: 'add:' ]
Collection do: unaryBlock	[ ^self subclassResponsibility: 'do:' ]
Collection size			[ ^self subclassResponsibility: 'size' ]

Collection with: anObject	[ ^self new add: anObject; yourself ]
Collection withAll: aCollection	[ ^self new addAll: aCollection; yourself ]

Collection isEmpty	[ ^self size == 0 ]
Collection notEmpty	[ ^self isEmpty not ]

Collection hash
[
    "Answer a positive integer as far as possible unique to the
     contents of the receiver, but guaranteed identical for all
     collections having the same contents regardless of order."
    ^(self size > 10
	    ifTrue:  [self _vtable familyHash]
	    ifFalse: [self inject: self size * 275604541 + self familyHash into: [:prev :elt | prev bitXor: elt hash]])
	bitAnd: 0x3fffffff.
]

Collection = aCollection
[
    self == aCollection ifTrue: [^true].
    (aCollection isCollection and: [self species == aCollection species and: [self size == aCollection size]]) ifFalse: [^false].
    self do: [:elt | (aCollection includes: elt) ifFalse: [^false]].
    ^true
]

Collection as: collectionType
[
    ^collectionType withAll: self
]

Collection addAll: aCollection
[
    aCollection do: [:e | self add: e]
]

Collection growSize	[ ^self size max: 2 ]

Collection remove: oldObject
[
    ^self remove: oldObject ifAbsent: [self errorNotFound: oldObject].
]

Collection anyOne
[
    self emptyCheck.
    self do: [:element | ^element].
]

Collection emptyCheck
[
    self isEmpty ifTrue: [^self errorEmptyCollection].
]

Collection doWithIndex: binaryBlock
[
    | index |
    index := 0.
    self do: [:elt | binaryBlock value: elt value: (index := index + 1)].
]

Collection do: unaryBlock separatedBy: aBlock
[
    self doWithIndex: [:element :index |
	index > 1 ifTrue: [aBlock value].
	unaryBlock value: element].
]

Collection includes: anObject
[
    self do: [:elt | elt = anObject ifTrue: [^true]].
    ^false.
]

Collection collect: unaryBlock
[
    | answer |
    answer := self species new: self size.
    self do: [:elt | answer add: (unaryBlock value: elt)].
    ^answer
]

Collection detect: unaryBlock ifNone: errorBlock
[
    self do: [:elt | (unaryBlock value: elt) ifTrue: [^elt]].
    ^errorBlock value
]

Collection detect: unaryBlock
[
    self detect: unaryBlock ifNone: [self errorNotFound]
]

Collection inject: value into: binaryBlock
[
    | result |
    result := value.
    self do: [:elt | result := binaryBlock value: result value: elt].
    ^result.
]

Collection printOn: aStream
[
    self
        printNameOn: aStream;
        printElementsOn: aStream
]

Collection printNameOn: aStream
[
    super printOn: aStream
]

Collection printElementsOn: aStream
[
    aStream nextPutAll: '('.
    self do: [:element | aStream print: element; space].
    self isEmpty ifFalse: [aStream skip: -1].
    aStream nextPutAll: ')'
]

