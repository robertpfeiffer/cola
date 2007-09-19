" Geometry.st -- ordered Pairs of numbers

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

  Last edited: 2007-09-18 20:18:13 by piumarta on emilia
"

{ import: Object }


Number radiansToDegrees	[ ^self *  0.01745329251994329576 ]
Number degreesToRadians	[ ^self * 57.29577951308232087684 ]


Pair : Collection ( first second )

Object isPair	[ ^nil ]
Pair isPair	[ ^self ]

Number , anObject	[ ^Pair x: self y: anObject ]

Pair first: xValue second: yValue
[
    self := self new.
    first := xValue.
    second := yValue.
]

Pair with: xValue with: yValue
[
    self := self new.
    first := xValue.
    second := yValue.
]

Pair x: xValue y: yValue
[
    self := self new.
    first := xValue.
    second := yValue.
]

Pair r: r theta: theta
[
    self := self new.
    first  := r * theta cos.
    second := r * theta sin.
]

Pair zero	[ ^0,0 ]
Pair unit	[ ^1,1 ]

Pair first		[ ^first ]
Pair first: anObject	[  first := anObject ]
Pair x			[ ^first ]
Pair x: anObject	[  first := anObject ]
Pair width		[ ^first ]
Pair width: anObject	[  first := anObject ]

Pair second		[ ^second ]
Pair second: anObject	[  second := anObject ]
Pair y			[ ^second ]
Pair y: anObject	[  second := anObject ]
Pair height		[ ^second ]
Pair height: anObject	[  second := anObject ]

Pair last		[ ^second ]
Pair last: anObject	[  second := anObject ]

Pair size		[ ^2 ]

Pair r		[ ^((first * first) + (second * second)) sqrt ]
Pair theta	[ ^57.2957795201 * (first atan2: second) ]

Pair asPair	[ ]
Object asPair	[ ^self , self ]

Pair + aPair	[ ^Pair first: first + aPair first second: second + aPair second ]
Pair - aPair	[ ^Pair first: first - aPair first second: second - aPair second ]
Pair * aPair	[ ^Pair first: first * aPair first second: second * aPair second ]
Pair / aPair	[ ^Pair first: first / aPair first second: second / aPair second ]

Pair <  aPair	[ ^first <  aPair first and: [second <  aPair second] ]
Pair  = aPair	[ ^first  = aPair first and: [second  = aPair second] ]
Pair <= aPair	[ ^first <= aPair first and: [second <= aPair second] ]

Pair precedes: aPair	[ ^second > aPair second or: [second = aPair second and: [first > aPair first]] ]
Pair follows: aPair	[ ^second < aPair second or: [second = aPair second and: [first < aPair first]] ]

Pair min: aPair
[
    "Answer the lower left corner of the rectangle uniquely defined by the receiver and aPair."
    ^(first min: aPair first) , (second min: aPair second)
]

Pair max: aPair
[
    "Answer the upper right corner of the rectangle uniquely defined by the receiver and aPair."
    ^(first max: aPair first) , (second max: aPair second)
]

Pair reciprocal
[
    ^(1.0 / first) , (1.0 / second)
]

Pair negated
[
    ^first negated , second negated
]

Pair truncated
[
    ^(first isSmallInteger and: [second isSmallInteger])
	ifTrue:  [self]
	ifFalse: [self first: first truncated second: second truncated]
]

Pair floor
[
    ^(first isSmallInteger and: [second isSmallInteger])
	ifTrue:  [self]
	ifFalse: [self first: first floor second: second floor]
]

Pair ceiling
[
    ^(first isSmallInteger and: [second isSmallInteger])
	ifTrue:  [self]
	ifFalse: [self first: first ceiling second: second ceiling]
]

Pair translateBy: aPair
[
    first := first + aPair first.
    second := second + aPair second.
]

Pair scaledBy: aPair
[
    ^(first * aPair first) , (second * aPair second)
]

Pair translatedBy: aPair
[
    ^(first + aPair first) , (second + aPair second)
]

Pair rotatedBy: radians about: centrePair
[
    | cx cy dx dy sa ca |
    cx := centrePair x.
    cy := centrePair y.
    dx := first  - cx.
    dy := second - cy.
    sa := radians sin.
    ca := radians cos.
    ^     (cx + ((dx * ca) - (dy * sa)))
	, (cy + ((dx * sa) + (dy * ca)))
]

Pair transformedBy: aTransform
[
    ^aTransform transform: self
]

Pair printOn: aStream
[
    aStream print: first; nextPutAll: ' , '; print: second
]

Pair do: unaryBlock
[
    unaryBlock value: first; value: second
]

Pair at: index
[
    ^index == 0
	ifTrue: [first]
	ifFalse:
	    [index == 1
		 ifTrue: [second]
		 ifFalse: [self errorOutOfBounds: index ]]
]

Pair at: index put: aValue
[
    ^index == 0
	ifTrue: [first := aValue]
	ifFalse:
	    [index == 1
		 ifTrue: [second := aValue]
		 ifFalse: [self errorOutOfBounds: index ]]
]

Pair , anObject	[ ^OrderedCollection with: first with: second with: anObject ]
