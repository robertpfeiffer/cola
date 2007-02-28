" Link.st -- one node in a LinkedList

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

  Last edited: 2007-02-28 14:32:26 by piumarta on emilia
"

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
