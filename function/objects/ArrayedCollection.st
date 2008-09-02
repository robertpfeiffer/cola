" ArrayedCollection.st -- behaviour common to all vector-like collections

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

  Last edited: 2008-07-29 14:06:09 by piumarta on emilia
"

{ import: Objects }

ArrayedCollection with: a
[
    ^(self new: 1)
	at: 0 put: a;
	yourself
]

ArrayedCollection with: a with: b
[
    ^(self new: 2)
	at: 0 put: a;
	at: 1 put: b;
	yourself
]

ArrayedCollection with: a with: b with: c
[
    ^(self new: 3)
	at: 0 put: a;
	at: 1 put: b;
	at: 2 put: c;
	yourself
]

ArrayedCollection with: a with: b with: c with: d
[
    ^(self new: 4)
	at: 0 put: a;
	at: 1 put: b;
	at: 2 put: c;
	at: 3 put: d;
	yourself
]

ArrayedCollection with: a with: b with: c with: d with: e
[
    ^(self new: 5)
	at: 0 put: a;
	at: 1 put: b;
	at: 2 put: c;
	at: 3 put: d;
	at: 4 put: e;
	yourself
]

ArrayedCollection new: capacity
[
    self := super new.
    size := capacity.
]

ArrayedCollection isEmpty
[
    ^size == 0.
]

ArrayedCollection size
[
    ^size.
]

ArrayedCollection sortContents
[
    self isEmpty ifFalse: [self sortFrom: 0 to: self size - 1].
]

ArrayedCollection sortFrom: index to: limit
[
    | element next |
    element := self at: index.
    index < limit ifFalse: [^element].
    next := self sortFrom: index + 1 to: limit.
    element < next ifTrue: [^element].
    self at: index put: next.
    self at: index + 1 put: element.
    self sortFrom: index + 1 to: limit.
    ^next
]

ArrayedCollection compare: anArray
[
    | first last |
    self == anArray		ifTrue: [^  0].
    first := 0.
    last := (self size min: anArray size) - 1.
    first to: last do: [:index |
	| cmp |
	cmp := (self at: index) compare: (anArray at: index).
	cmp == 0 ifFalse: [^cmp]].
    ^self size - anArray size
]
