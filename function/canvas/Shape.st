" Shape.st -- collections of vertices and/or contours

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

  Last edited: 2007-09-18 20:16:55 by piumarta on emilia
"

{ import: Geometry }

Shape : Object ()

Shape layoutWidth	[ ^self width ]
Shape layoutHeight	[ ^self height ]

Shape width		[ ^self bounds width ]
Shape height		[ ^self bounds height ]

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

Rectangle zero		[ ^Pair zero corner: Pair zero ]

Rectangle origin	[ ^origin ]
Rectangle origin: r	[  origin := r ]
Rectangle corner	[ ^corner ]
Rectangle corner: r	[  corner := r ]
Rectangle extent	[ ^corner - origin ]

"
Rectangle first		[ ^origin ]
Rectangle second	[ ^self topLeft ]
Rectangle third		[ ^corner ]
Rectangle fourth	[ ^self bottomRight ]
Rectangle last		[ ^self bottomRight ]
Rectangle size		[ ^4 ]

Rectangle do: unaryBlock	[ unaryBlock value: origin; value: self topLeft; value: corner; value: self bottomRight ]

Rectangle at: index		[ ^self perform: #((first  second  third  fourth ) at: index ifAbsent: [#errorOutOfBounds:]) ]
Rectangle at: index put: aPair	[ ^self perform: #((first: second: third: fourth:) at: index ifAbsent: [#errorOutOfBounds:]) with: aPair ]
"

Rectangle x		[ ^origin x ]
Rectangle y		[ ^origin y ]
Rectangle left		[ ^origin x ]
Rectangle bottom	[ ^origin y ]
Rectangle right		[ ^corner x ]
Rectangle top		[ ^corner y ]

Rectangle width		[ ^corner x - origin x ]
Rectangle height	[ ^corner y - origin y ]

Rectangle bottomLeft	[ ^origin ]
Rectangle topLeft	[ ^origin x , corner y ]
Rectangle topRight	[ ^corner ]
Rectangle bottomRight	[ ^corner x , origin y ]

Rectangle centre
[
    ^     (corner x - origin x / 2 + origin x)
	, (corner y - origin y / 2 + origin y)
]

Rectangle normalised
[
    | ox oy cx cy |
    ox := origin x.
    oy := origin y.
    cx := corner x.
    cy := corner y.
    ^		(ox min: cx) , (oy min: cy)
	corner: (ox max: cx) , (oy max: cy)
]

Rectangle translateBy: aPair
[
    origin translateBy: aPair.
    corner translateBy: aPair.
]

Rectangle scaledBy: aPair
[
    ^(origin * aPair) corner: (corner * aPair)
]

Rectangle translatedBy: aPair
[
    ^(origin translatedBy: aPair) corner: (corner translatedBy: aPair)
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
	ifTrue:  [self origin: (left , bottom) corner: (right , top)]
	ifFalse: [Rectangle zero]
]

Rectangle union: aRectangle 
[
    "Answer the smallest Rectangle that contains both the receiver and aRectangle."
    ^self
	origin: (origin min: aRectangle origin)
	corner: (corner max: aRectangle corner)
]

Rectangle insetBy: aPairOrScalar
[
    | inset |
    inset := aPairOrScalar asPair.
    ^self origin: origin + inset corner: corner - inset
]

Rectangle outsetBy: aPairOrScalar
[
    | outset |
    outset := aPairOrScalar asPair.
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

Rectangle encompassing: aPoint
[
    ^(self containsPoint: aPoint)
	ifTrue:  [self]
	ifFalse: [self origin: (origin min: aPoint) corner: (corner max: aPoint)]
]

Rectangle proportionsIn: outerRectangle
[
    | w h l b r t |
    outerRectangle := self union: outerRectangle.
    w := 1.0 / outerRectangle width.
    h := 1.0 / outerRectangle height.
    l := self left   - outerRectangle left   * w.
    b := self bottom - outerRectangle bottom * h.
    r := 1 - (outerRectangle right  - self right  * w).
    t := 1 - (outerRectangle top    - self top    * h).
    ^l,b corner: r,t
]

Rectangle * aPoint
[
    aPoint := aPoint asPair.
    ^self origin * aPoint corner: self corner * aPoint
]

Rectangle / aPoint
[
    aPoint := aPoint asPair.
    ^self origin / aPoint corner: self corner / aPoint
]

Rectangle followsPoint: aPoint
[
    ^self top < aPoint y or: [self bottom < aPoint y and: [self left > aPoint x]]
]

Rectangle printOn: aStream
[
    aStream nextPut: $(; print: origin; nextPutAll: ' corner: '; print: corner; nextPut: $)
]

"----------------------------------------------------------------"

Pair extent: extent
[
    ^Rectangle origin: self extent: extent
]

Pair corner: corner
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
	self add: (Pair r:     (i isEven ifTrue: [outerRadius] ifFalse: [innerRadius])
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

Polygon translateBy: aPair
[
    vertices := vertices collect: [:p | p translatedBy: aPair].
]

Rectangle asPolygon
[
    ^Polygon new
	add: origin;
	add: origin x , corner y;
	add: corner;
	add: corner x , origin y;
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
    ^           (ax min: (bx min: (cx min: dx))) , (ay min: (by min: (cy min: dy)))
	corner: (ax max: (bx max: (cx max: dx))) , (ay max: (by max: (cy max: dy)))
]

Rectangle transformedBy: transform
[
    ^Polygon new
	add: (self bottomLeft  transformedBy: transform);
	add: (self topLeft     transformedBy: transform);
	add: (self topRight    transformedBy: transform);
	add: (self bottomRight transformedBy: transform);
	yourself
]

Rectangle boundsTransformedBy: transform
[
    ^(self transformedBy: transform) bounds
]
