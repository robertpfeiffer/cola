" Number.st -- support for arithmetic

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

  Last edited: 2006-04-01 15:37:05 by piumarta on emilia.local
"

{ import: Magnitude }

Number : Magnitude ()

Number // aNumber
[
    ^(self / aNumber) floor
]

Number \\ aNumber
[
    ^self - (self // aNumber * aNumber)
]

Number negative		[ ^self < 0 ]

Number negated		[ ^0 - self ]

Number abs		[ ^self < 0 ifTrue: [self negated] ifFalse: [self] ]

Number floor
[
    | truncation |
    truncation := self truncated.
    self >= 0 ifTrue: [^truncation].
    ^self = truncation
	ifTrue:  [truncation]
	ifFalse: [truncation - 1]
]

Number quo: aNumber	[ ^(self / aNumber) truncated ]

Number adaptToFloat: aFloat andSend: operator
[
    ^aFloat perform: operator with: self asFloat
]

Number printOn: aStream
[
    ^self printOn: aStream radix: 10
]
