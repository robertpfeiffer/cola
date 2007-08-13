{ import: Geometry }

Shape : Object ()

"----------------------------------------------------------------"

Rectangle : Shape ( origin corner )

Rectangle origin: o extent: e
[
    self := self new.
    origin := o.
    corner := o + e.
]

Rectangle origin: o corner: c
[
    self := self new.
    origin := o.
    corner := c.
]

Rectangle zero		[ ^Point zero corner: Point zero ]

Rectangle origin	[ ^origin ]
Rectangle origin: r	[  origin := r ]
Rectangle corner	[ ^corner ]
Rectangle corner: r	[  corner := r ]
Rectangle extent	[ ^corner - origin ]

Rectangle x		[ ^origin x ]
Rectangle y		[ ^origin y ]
Rectangle left		[ ^origin x ]
Rectangle bottom	[ ^origin y ]
Rectangle right		[ ^corner x ]
Rectangle top		[ ^corner y ]

Rectangle width		[ ^corner x - origin x ]
Rectangle height	[ ^corner y - origin y ]

Rectangle bottomLeft	[ ^origin ]
Rectangle topLeft	[ ^origin x @ corner y ]
Rectangle topRight	[ ^corner ]
Rectangle bottomRight	[ ^corner x @ origin y ]

Rectangle centre
[
    ^     (corner x - origin x / 2 + origin x)
	@ (corner y - origin y / 2 + origin y)
]

Rectangle normalised
[
    | ox oy cx cy |
    ox := origin x.
    oy := origin y.
    cx := corner x.
    cy := corner y.
    ^		(ox min: cx) @ (oy min: cy)
	corner: (ox max: cx) @ (oy max: cy)
]

Rectangle translateBy: aPoint
[
    origin translateBy: aPoint.
    corner translateBy: aPoint.
]

Rectangle translatedBy: aPoint
[
    ^(origin translatedBy: aPoint) corner: (corner translatedBy: aPoint)
]

Rectangle rotatedBy: radians about: centrePoint
[
    ^self asPolygon rotatedBy: radians about: centrePoint
]

Rectangle containsPoint: aPoint
[
    ^origin <= aPoint and: [aPoint <= corner]
]

Rectangle contains: aRectangle
[
    ^(self containsPoint: aRectangle origin) and: [self containsPoint: aRectangle corner]
]

Rectangle intersects: aRectangle 
[
    "Answer whether aRectangle intersects the receiver anywhere."
    | rOrigin rCorner |
    rOrigin := aRectangle origin.
    rCorner := aRectangle corner.
    rCorner x <= origin x ifTrue: [^false].
    rCorner y <= origin y ifTrue: [^false].
    rOrigin x >= corner x ifTrue: [^false].
    rOrigin y >= corner y ifTrue: [^false].
    ^true
]

Rectangle intersect: aRectangle
[
    "Answer the Rectangle in which the receiver overlaps with aRectangle."
    | aPoint left right top bottom |
    aPoint := aRectangle origin.
    left   := (aPoint x > origin x ifTrue: [aPoint] ifFalse: [origin]) x.
    bottom := (aPoint y > origin y ifTrue: [aPoint] ifFalse: [origin]) y.
    aPoint := aRectangle corner.
    right  := (aPoint x < corner x ifTrue: [aPoint] ifFalse: [corner]) x.
    top    := (aPoint y < corner y ifTrue: [aPoint] ifFalse: [corner]) y.
    ^(left <= right and: [bottom <= top])
	ifTrue:  [self origin: (left @ bottom) corner: (right @ top)]
	ifFalse: [Rectangle zero]
]

Rectangle union: aRectangle 
[
    "Answer the smallest Rectangle that contains both the receiver and aRectangle."
    ^self
	origin: (origin min: aRectangle origin)
	corner: (corner max: aRectangle corner)
]

Rectangle unionIfNotNil: aRectangle 
[
    "Answer the smallest Rectangle that contains both the receiver and aRectangle."
    aRectangle ifFalse: [^self].
    (self contains: aRectangle) ifTrue: [^self].
    (aRectangle contains: self) ifTrue: [^aRectangle].
    ^self origin: (origin min: aRectangle origin) corner: (corner max: aRectangle corner)
]

Rectangle insetBy: aPointOrScalar
[
    | inset |
    inset := aPointOrScalar asPoint.
    ^self origin: origin + inset corner: corner - inset
]

Rectangle outsetBy: aPointOrScalar
[
    | outset |
    outset := aPointOrScalar asPoint.
    ^self origin: origin - outset corner: corner + outset
]

Rectangle expanded
[
    origin := origin floor.
    corner := corner ceiling.
]

Rectangle encompass: aPoint
[
    origin := origin min: aPoint.
    corner := corner max: aPoint.
]


Rectangle printOn: aStream
[
    aStream nextPut: $(; print: origin; nextPutAll: ' corner: '; print: corner; nextPut: $)
]

"----------------------------------------------------------------"

Point extent: extent
[
    ^Rectangle origin: self extent: extent
]

Point corner: corner
[
    ^Rectangle origin: self corner: corner
]


"----------------------------------------------------------------"

Polygon : Shape ( vertices )

Polygon new
[
    self := super new.
    vertices := OrderedCollection new.
]

Polygon newStar: numVertices innerRadius: innerRadius outerRadius: outerRadius
[
    self := self new.
    0 to: numVertices * 2 - 1 do: [:i |
	self add: (Point r:     (i isEven ifTrue: [outerRadius] ifFalse: [innerRadius])
			 theta: Float pi * i / numVertices)]
]

Polygon add: aPoint		[ vertices addLast: aPoint ]
Polygon addAll: pointCollection	[ vertices addAll: pointCollection ]

Polygon pathOn: aCanvas
[
    vertices isEmpty ifTrue: [^nil].
    aCanvas moveTo: vertices last.
    vertices do: [:p | aCanvas lineTo: p].
]

Polygon centre	[ ^self bounds centre ]

Polygon bounds
[
    | rect |
    vertices isEmpty ifTrue: [^nil].
    rect := vertices first corner: vertices first.
    vertices from: 1 do: [:p | rect := rect encompass: p].
    ^rect
]

Polygon rotateBy: radians about: centrePoint
[
    vertices := vertices collect: [:p | p rotatedBy: radians about: centrePoint].
]

Polygon rotatedBy: radians about: centrePoint
[
    ^self new addAll: (vertices collect: [:p | p rotatedBy: radians about: centrePoint])
]

Polygon translateBy: aPoint
[
    vertices := vertices collect: [:p | p translatedBy: aPoint].
]

Rectangle asPolygon
[
    ^Polygon new
	add: origin;
	add: origin x @ corner y;
	add: corner;
	add: corner x @ origin y;
	yourself
]

"----------------------------------------------------------------"

Rectangle pathOn: aCanvas
[
    aCanvas rectangle: self
]

Rectangle bounds
[
    ^self
]

Rectangle boundsRotatedBy: radians about: centrePoint
[
    | a b c d ax ay bx by cx cy dx dy |
    a :=      origin      rotatedBy: radians about: centrePoint.  ax := a x.  ay := a y.
    b := self topLeft     rotatedBy: radians about: centrePoint.  bx := b x.  by := b y.
    c :=      corner      rotatedBy: radians about: centrePoint.  cx := c x.  cy := c y.
    d := self bottomRight rotatedBy: radians about: centrePoint.  dx := d x.  dy := d y.
    ^           (ax min: (bx min: (cx min: dx))) @ (ay min: (by min: (cy min: dy)))
	corner: (ax max: (bx max: (cx max: dx))) @ (ay max: (by max: (cy max: dy)))
]
