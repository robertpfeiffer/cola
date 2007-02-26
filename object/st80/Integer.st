" Integer.st -- support for integer arithmetic

  Copyright (c) 2005, 2006 Ian Piumarta
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

  Last edited: 2006-04-25 13:21:51 by piumarta on emilia.local
"

{ import: Number }

Object  isInteger	[ ^false ]
Integer isInteger	[ ^true ]

Integer asInteger	[ ^self ]

Integer normalize
[
    ^ self
]

Integer / aNumber
[
    | quoRem |
    aNumber isInteger
	ifTrue:
	   [quoRem := self digitDiv: aNumber abs neg: self negative ~~ aNumber negative.
	    ^(quoRem at: 2) = 0
		ifTrue:  [(quoRem at: 1) normalize]
		ifFalse: [(Fraction numerator: self denominator: aNumber) reduced]].
    ^aNumber adaptToInteger: self andSend: #/
]

Integer print
[
    | n |
    n := 0.
    self < 0 ifTrue: [$- put.  ^1 + self negated print].
    self >= 10 ifTrue: [n := n + (self // 10) print].
    ^n + (Character digitValue: self \\ 10) put.
]

Integer printOn: aStream radix: radix
[
    self < 0 ifTrue: [^aStream nextPut: $-; print: self negated].
    self >= radix ifTrue: [self // radix printOn: aStream radix: radix].
    aStream nextPut: (Character digitValue: self \\ radix).
]

"Integer>>/ Punts to Float until Fraction is fully loaded."

Fraction numerator: n denominator: d	[ ^n asFloat / d asFloat ]

Float reduced				[ ^self ]
