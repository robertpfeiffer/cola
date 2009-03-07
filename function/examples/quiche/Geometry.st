{ import: Objects }

Point : Magnitude ( x y )

Point x	[ ^x ]
Point y	[ ^y ]

Point withX: xNumber Y: yNumber
[
    self := self new.
    x := xNumber.
    y := yNumber.
]

Number , aNumber	[ ^Point withX: self Y: aNumber ]

PointZero := [ 0,0 ]
PointOne  := [ 1,1 ]
PointTwo  := [ 2,2 ]

Point + aPoint		[ ^self withX: x + aPoint x Y: y + aPoint y ]
Point - aPoint		[ ^self withX: x - aPoint x Y: y - aPoint y ]

Point * aPointOrNumber
[
    | aPoint |
    aPoint := aPointOrNumber asPoint.
    ^self withX: x * aPoint x Y: y * aPoint y.
]

Point isZero	[ ^x = 0 and: [y = 0] ]

Point < aPoint	[ ^x < aPoint x and: [y < aPoint y] ]
Point = aPoint	[ ^x = aPoint x and: [y = aPoint y] ]

Point max: aPoint	[ ^Point withX: (x max: aPoint x) Y: (y max: aPoint y) ]

Point negated	[ ^x negated , y negated ]

Point asPoint	[ ^self ]
Number asPoint	[ ^self, self ]

Point printOn: aStream	[ aStream print: x; nextPut: $,; print: y ]

"----------------"

Rectangle : Object ( origin extent )

Rectangle origin	[ ^origin ]
Rectangle extent	[ ^extent ]
Rectangle corner	[ ^origin + extent ]

Rectangle extent: aPoint	[ extent := aPoint ]
Rectangle corner: aPoint	[ extent := aPoint println - origin println ]

Rectangle withOrigin: o extent: e
[
    self := self new.
    origin := o.
    extent := e.
]

Rectangle withOrigin: o corner: c
[
    self := self new.
    origin := o.
    extent := c - o.
]

Point extent: aPoint	[ ^Rectangle withOrigin: self extent: aPoint ]
Point corner: aPoint	[ ^Rectangle withOrigin: self corner: aPoint ]

RectangleZero	:= [ PointZero extent: PointZero ]

Rectangle width		[ ^extent x ]
Rectangle height	[ ^extent y ]
Rectangle left		[ ^origin x ]
Rectangle top		[ ^origin y ]
Rectangle right		[ ^origin x + extent x ]
Rectangle bottom	[ ^origin y + extent y ]

Rectangle includesPoint: aPoint		[ ^origin <= aPoint and: [aPoint < self corner] ]
Rectangle includesLocalPoint: aPoint	[ ^PointZero <= aPoint and: [aPoint < extent] ]

Rectangle translatedBy: aPoint		[ ^origin + aPoint extent: extent ]
Rectangle translatedTo: aPoint		[ ^aPoint extent: extent ]

Rectangle insetBy: aPointOrNumber
[
    | insetPoint |
    insetPoint := aPointOrNumber asPoint.
    ^origin + insetPoint extent: extent - (insetPoint * 2).
]

Rectangle printOn: aStream	[ aStream nextPut: $(; print: origin; nextPutAll: ' extent: '; print: extent; nextPut: $) ]
