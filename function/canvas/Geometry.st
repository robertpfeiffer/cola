{ import: Object }


Number radiansToDegrees	[ ^self *  0.01745329251994329576 ]
Number degreesToRadians	[ ^self * 57.29577951308232087684 ]


Point : Object ( x y )

Number @ aNumber
[
    ^Point x: self y: aNumber
]

Point x: xValue y: yValue
[
    self := self new.
    x := xValue.
    y := yValue.
]

Point r: r theta: theta
[
    self := self new.
    x := r * theta cos.
    y := r * theta sin.
]

Point zero	[ ^0@0 ]
Point unit	[ ^1@1 ]

Point x		[ ^x ]
Point y		[ ^y ]
Point x: xVal	[  x := xVal ]
Point y: yVal	[  y := yVal ]
Point r		[ ^((x * x) + (y * y)) sqrt ]
Point theta	[ ^57.2957795201 * (x atan2: y) ]

Point asPoint	[ ]
Number asPoint	[ ^self @ self ]

Point + aPoint	[ ^Point x: x + aPoint x y: y + aPoint y ]
Point - aPoint	[ ^Point x: x - aPoint x y: y - aPoint y ]
Point * aPoint	[ ^Point x: x * aPoint x y: y * aPoint y ]
Point / aPoint	[ ^Point x: x / aPoint x y: y / aPoint y ]

Point <  aPoint	[ ^x <  aPoint x and: [y <  aPoint y] ]
Point <= aPoint	[ ^x <= aPoint x and: [y <= aPoint y] ]

Point min: aPoint
[
    "Answer the lower left corner of the rectangle uniquely defined by the receiver and aPoint."
    ^(x min: aPoint x) @ (y min: aPoint y)
]

Point max: aPoint
[
    "Answer the upper right corner of the rectangle uniquely defined by the receiver and aPoint."
    ^(x max: aPoint x) @ (y max: aPoint y)
]

Point negated
[
    ^x negated @ y negated
]

Point truncated
[
    ^(x isSmallInteger and: [y isSmallInteger])
	ifTrue:  [self]
	ifFalse: [self x: x truncated y: y truncated]
]

Point floor
[
    ^(x isSmallInteger and: [y isSmallInteger])
	ifTrue:  [self]
	ifFalse: [self x: x floor y: y floor]
]

Point ceiling
[
    ^(x isSmallInteger and: [y isSmallInteger])
	ifTrue:  [self]
	ifFalse: [self x: x ceiling y: y ceiling]
]

Point translateBy: aPoint
[
    x := x + aPoint x.
    y := y + aPoint y.
]

Point translatedBy: aPoint
[
    ^(x + aPoint x) @ (y + aPoint y)
]

Point rotatedBy: radians about: centrePoint
[
    | cx cy dx dy sa ca |
    cx := centrePoint x.
    cy := centrePoint y.
    dx := x - cx.
    dy := y - cy.
    sa := radians sin.
    ca := radians cos.
    ^     (cx + ((dx * ca) - (dy * sa)))
	@ (cy + ((dx * sa) + (dy * ca)))
]

Point printOn: aStream
[
    aStream print: x; nextPut: $@; print: y
]
