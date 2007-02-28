{ import: Objects }

Link : Object ( prevLink nextLink )

Link prevLink		[ ^prevLink ]
Link prevLink: aLink	[ ^prevLink := aLink ]
Link nextLink		[ ^nextLink ]
Link nextLink: aLink	[ ^nextLink := aLink ]

Link unlink
[
    prevLink nextLink: nextLink.
    nextLink prevLink: prevLink.
]
