" Model.st -- objects with dependents

  Copyright (c) 2007 Ian Piumarta
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

  Last edited: 2007-09-18 20:17:04 by piumarta on emilia
"

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
