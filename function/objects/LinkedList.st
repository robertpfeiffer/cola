" LinkedList.st -- explicitly-chained lists of objects

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

  Last edited: 2009-01-28 09:53:01 by piumarta on emilia
"

{ import: Objects }

LinkedList : SequenceableCollection ( firstLink lastLink )

LinkedList first	[ ^firstLink ]
LinkedList last		[ ^lastLink ]

LinkedList addFirst: aLink
[
    aLink reset.
    firstLink isNil ifTrue: [^firstLink := lastLink := aLink].
    firstLink prevLink: aLink.
    aLink     nextLink: firstLink.
    firstLink := aLink.
    ^aLink.
]

LinkedList addLast: aLink
[
    aLink reset.
    lastLink isNil ifTrue: [^firstLink := lastLink := aLink].
    lastLink nextLink: aLink.
    aLink    prevLink: lastLink.
    lastLink := aLink.
    ^aLink.
]

LinkedList add: aLink
[
    ^self addLast: aLink
]

LinkedList add: aLink before: anotherLink
[
    aLink reset.
    anotherLink == firstLink
	ifTrue:
	   [aLink nextLink: anotherLink.
	    anotherLink prevLink: aLink.
	    ^firstLink := aLink].
    (firstLink and: [anotherLink prevLink]) ifFalse: [self error: 'cannot add link'].
    aLink prevLink: anotherLink prevLink.
    aLink nextLink: anotherLink.
    anotherLink prevLink nextLink: aLink.
    anotherLink prevLink: aLink.
    ^aLink
]

LinkedList add: aLink after: anotherLink
[
    aLink reset.
    anotherLink == lastLink
	ifTrue:
	   [aLink prevLink: anotherLink.
	    anotherLink nextLink: aLink.
	    ^lastLink := aLink].
    (lastLink and: [anotherLink nextLink]) ifFalse: [self error: 'cannot add link'].
    aLink nextLink: anotherLink nextLink.
    aLink prevLink: anotherLink.
    anotherLink nextLink prevLink: aLink.
    anotherLink nextLink: aLink.
    ^aLink
]

LinkedList remove: aLink
[
    aLink == firstLink ifTrue: [^self removeFirst].
    aLink == lastLink  ifTrue: [^self removeLast].
    aLink unlink.
    ^aLink
]

LinkedList removeFirst
[
    | aLink |
    aLink := firstLink.
    (firstLink := firstLink nextLink)
	ifTrue:  [firstLink prevLink: nil]
	ifFalse: [lastLink := nil].
    ^aLink unlinked
]

LinkedList removeLast
[
    | aLink |
    aLink := lastLink.
    (lastLink := lastLink prevLink)
	ifTrue:  [lastLink nextLink: nil]
	ifFalse: [firstLink := nil].
    ^aLink unlinked
]

LinkedList size
[
    | size link |
    size := 0.
    link := firstLink.
    [link]
	whileTrue:
	   [link := link nextLink.
	    size := size + 1].
    ^size
]

LinkedList from: index do: unaryBlock
[
    | link count |
    link := firstLink.
    count := index.
    [(count := count - 1) >= 0 and: [link]] whileTrue: [link := link nextLink].
    [link]
	whileTrue:
	   [unaryBlock value: link.
	    link := link nextLink].
]

LinkedList do: unaryBlock
[
    | link |
    link := firstLink.
    [link notNil]
	whileTrue:
	   [unaryBlock value: link.
	    link := link nextLink]
]

LinkedList reverseDo: unaryBlock
[
    | link |
    link := lastLink.
    [link notNil]
	whileTrue:
	   [unaryBlock value: link.
	    link := link prevLink]
]

LinkedList collect: unaryBlock
[
    | list |
    list := self new.
    self do: [:elt | list add: (unaryBlock value: elt)].
    ^list
]

LinkedList select: unaryBlock
[
    | list |
    list := self new.
    self do: [:elt | (unaryBlock value: elt) ifTrue: [list add: elt]].
    ^list
]

LinkedList detect: unaryBlock
[
    | link |
    link := firstLink.
    [link notNil]
	whileTrue:
	   [(unaryBlock value: link) ifTrue: [^link].
	    link := link nextLink].
    ^nil
]

LinkedList inject: answer into: binaryBlock
[
    | link |
    link := firstLink.
    [link]
	whileTrue:
	   [answer := binaryBlock value: answer value: link.
	    link := link nextLink].
    ^answer
]

Link to: bLink inject: answer into: binaryBlock
[
    | aLink |
    aLink := self.
    [aLink and: [answer := binaryBlock value: answer value: aLink.
		 aLink ~~ bLink]]
	whileTrue: [aLink := aLink nextLink].
    ^answer
]

Link upTo: bLink inject: answer into: binaryBlock
[
    | aLink |
    aLink := self.
    [aLink and: [aLink ~~ bLink]]
	whileTrue:
	   [answer := binaryBlock value: answer value: aLink.
	    aLink := aLink nextLink].
    ^answer
]

LinkedList isEmpty	[ ^firstLink isNil ]
LinkedList notEmpty	[ ^firstLink ]

LinkedList at: index
[
    | link |
    index >= 0
	ifTrue:
	   [link := firstLink.
	    [link and: [(index := index - 1) > 0]] whileTrue: [link := link nextLink].
	    ^link].
    ^super at: index
]
