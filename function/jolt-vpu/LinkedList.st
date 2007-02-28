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
