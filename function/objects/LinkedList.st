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

  Last edited: 2007-02-28 14:32:09 by piumarta on emilia
"

{ import: Objects }

LinkedList : Object ( firstLink lastLink )

LinkedList first	[ ^firstLink ]
LinkedList last		[ ^lastLink ]

LinkedList addFirst: aLink
[
    firstLink isNil ifTrue: [^firstLink := lastLink := aLink].
    firstLink prevLink: aLink.
    aLink     nextLink: firstLink.
    firstLink := aLink.
    ^aLink.
]

LinkedList addLast: aLink
[
    firstLink isNil ifTrue: [^firstLink := lastLink := aLink].
    lastLink nextLink: aLink.
    aLink    prevLink: lastLink.
    lastLink := aLink.
    ^aLink.
]

LinkedList remove: aLink
[
    aLink == firstLink ifTrue: [^self removeFirst].
    aLink == lastLink  ifTrue: [^self removeLast].
    aLink unlink.
    ^aLink
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
