{ import: Objects }

Point : Object ( x y )

Point asPoint []

Point x	[ ^x ]
Point y	[ ^y ]

Point withX: xx withY: yy
[
    self := self new.
    x := xx.
    y := yy.
]

PointZero := [ Point withX: 0 withY: 0 ]
PointOne  := [ Point withX: 1 withY: 1 ]

Point extent	[]

Point + aPoint	[ ^self withX: x + aPoint x withY: y + aPoint y ]
Point - aPoint	[ ^self withX: x - aPoint x withY: y - aPoint y ]
Point * aNumber	[ ^self withX: x * aNumber withY: y * aNumber ]
Point / aNumber	[ ^self withX: x / aNumber withY: y / aNumber ]

Point max: aPoint	[ ^self withX: (x max: aPoint x) withY: (y max: aPoint y) ]
Point min: aPoint	[ ^self withX: (x min: aPoint x) withY: (y min: aPoint y) ]

Point printOn: aStream
[
    aStream
	nextPut: $(; print: self x;
	nextPut: $,; print: self y;
	nextPut: $)
]

Number , aNumber	[ ^Point withX: self withY: aNumber ]

Point <  aPoint	[ ^x <  aPoint x and: [y <  aPoint y] ]
Point <= aPoint	[ ^x <= aPoint x and: [y <= aPoint y] ]
Point  = aPoint	[ ^x  = aPoint x and: [y  = aPoint y] ]
Point >  aPoint	[ ^x >  aPoint x and: [y >  aPoint y] ]

Point drawOn: aContext
[
    aContext fillRectangle: 0,0 extent: self
]
