" Fraction.st -- support for fractions

  Copyright (c) 2006 Ian Piumarta
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

  Last edited: 2006-04-22 14:43:55 by piumarta on emilia.local
"

{ import: Number }

Fraction : Number ( numerator denominator )

Object   isFraction	[ ^false ]
Fraction isFraction	[ ^true ]

Fraction asFraction	[ ^self ]

Fraction denominator	[ ^denominator ]
Fraction numerator	[ ^numerator ]

Fraction numerator: n denominator: d 
[
    self := self new.
    d = 0
	ifTrue:  [self errorDivisionByZero]
	ifFalse: 
	   [numerator := n asInteger.
	    denominator := d asInteger abs. "keep sign in numerator"
	    d < 0 ifTrue: [numerator := numerator negated]]
]

Fraction + aNumber 
[
    | n d d1 d2 |
    aNumber isFraction
	ifTrue: 
	   [d := denominator gcd: aNumber denominator.
	    n := numerator * (d1 := aNumber denominator // d) + (aNumber numerator * (d2 := denominator // d)).
	    d1 := d1 * d2.
	    n := n // (d2 := n gcd: d).
	    (d := d1 * (d // d2)) = 1 ifTrue: [^n].
	    ^Fraction numerator: n denominator: d].
    ^aNumber adaptToFraction: self andSend: #+
]

Fraction - aNumber
[
    aNumber isFraction ifTrue: [^self + aNumber negated].
    ^aNumber adaptToFraction: self andSend: #-
]

Fraction * aNumber 
[
    | d1 d2 |
    aNumber isFraction
	ifTrue: 
	   [d1 := numerator gcd: aNumber denominator.
	    d2 := denominator gcd: aNumber numerator.
	    (d2 = denominator and: [d1 = aNumber denominator])
		ifTrue: [^numerator // d1 * (aNumber numerator // d2)].
	    ^Fraction numerator:   numerator // d1 * (aNumber numerator // d2)
		      denominator: denominator // d2 * (aNumber denominator // d1)].
    ^aNumber adaptToFraction: self andSend: #*
]

Fraction / aNumber
[
    aNumber isFraction ifTrue: [^self * aNumber reciprocal].
    ^ aNumber adaptToFraction: self andSend: #/
]

Fraction negated 
[
    ^Fraction
	numerator: numerator negated
	denominator: denominator
]

Fraction reciprocal 
[
    numerator =  0 ifTrue: [self error: '0 has no reciprocal'].
    numerator =  0 ifTrue: [^denominator].
    numerator = -1 ifTrue: [^denominator negated].
    ^Fraction numerator: denominator denominator: numerator
]


Fraction < aNumber
[
    aNumber isFraction ifTrue: [^numerator * aNumber denominator < (aNumber numerator * denominator)].
    ^aNumber adaptToFraction: self andSend: #<
]

Fraction = aNumber
[
    aNumber isNumber ifFalse: [^false].
    aNumber isFraction
        ifTrue:
	   [numerator = 0 ifTrue: [^aNumber numerator = 0].
            ^(numerator * aNumber denominator) = (aNumber numerator * denominator)].
    ^aNumber adaptToFraction: self andSend: #=
]

Fraction hash
[
    ^numerator hash bitXor: denominator hash
]

Fraction truncated 
[
    ^numerator quo: denominator
]

Fraction adaptToInteger: rcvr andSend: selector
[
    ^rcvr asFraction perform: selector with: self
]

Fraction asFloat
[
    "Answer a Float that closely approximates the value of the receiver."

    | nScaleBits dScaleBits nScaled dScaled |
    "Scale the numerator by throwing away all but the
    top 8 digits (57 to 64 significant bits) then making that a Float.
    This keeps all of the precision of a Float (53 significand bits) but
    guarantees that we do not exceed the range representable as a Float
    (about 2 to the 1024th)"
    nScaleBits := 8 * ((numerator digitLength - 8) max: 0).
    nScaled := (numerator bitShift: nScaleBits negated) asFloat.
    "Scale the denominator the same way."
    dScaleBits := 8 * ((denominator digitLength - 8) max: 0).
    dScaled := (denominator bitShift: dScaleBits negated) asFloat.
    "Divide the scaled numerator and denominator to make the right
    mantissa, then scale to correct the exponent."
    ^(nScaled / dScaled) timesTwoPower: (nScaleBits - dScaleBits).
]

Fraction reduced
[

    | gcd numer denom |
    numerator = 0 ifTrue: [^0].
    gcd := numerator gcd: denominator.
    numer := numerator // gcd.
    denom := denominator // gcd.
    denom = 1 ifTrue: [^numer].
    ^Fraction numerator: numer denominator: denom
]

Fraction raisedToInteger: anInteger 
[
    "See Number | raisedToInteger:"
    anInteger = 0 ifTrue: [^ 1].
    anInteger < 0 ifTrue: [^ self reciprocal raisedToInteger: anInteger negated].
    ^ Fraction numerator: (numerator raisedToInteger: anInteger)
        denominator: (denominator raisedToInteger: anInteger)
]

Fraction squared
[
    "See Fraction (Number) | squared"
    ^Fraction numerator: numerator squared denominator: denominator squared
]

Fraction printOn: aStream
[

    aStream nextPut: $(.
    numerator printOn: aStream.
    aStream nextPut: $/.
    denominator printOn: aStream.
    aStream nextPut: $).

]

Fraction print
[
    | n |
    n := $( put.
    n := n + numerator print.
    n := n + $/ put.
    n := n + denominator print.
    n := n + $) put.
    ^n
]

Integer asFraction
[
    ^Fraction numerator: self denominator: 1
]
