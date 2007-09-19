" geystar.st -- spinning stars spewing out of a sun-baked desert

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

  Last edited: 2007-09-18 20:11:17 by piumarta on emilia
"

{ import: HostWindow }
{ import: View }

GravityVector := [ 0.03 , -0.5 ]

Recycling := [ false ]


Particle : ShapedView ()

Particle new
[
    self := super withShape: (Polygon newStar: 5 innerRadius: Random next * 8.0 outerRadius: Random next * 16.0).
    self fillColour: Colour red.
]

"----------------------------------------------------------------"

ParticleView : TransformView ( translation rotation velocityVector rotationSpeed locked )

ParticleView new
[
    (self := super new) initialise.
]

ParticleView initialise
[
    translation := 500,20.
    rotation := 0.
    velocityVector := (Random next - 0.5 * 4.0) , (2.0 + Random next * 8.0).
    rotationSpeed := velocityVector x / -20.
]

ParticleView translation	[ ^translation ]
ParticleView rotation		[ ^rotation ]

ParticleView translation: aPair	[ translation := aPair.  self reposition ]
ParticleView rotation: aNumber	[ rotation := aNumber.  self reposition ]

ParticleView reposition		[ super translation: translation; rotateBy: rotation ]

ParticleView step
[
    translation y < 0
	ifTrue:
	   [| fillColour |
	    fillColour := contents first fillColour.
	    self initialise.
	    contents first fillColour: (Colour withR: fillColour g G: fillColour b B: fillColour r).
	    Recycling := true].
    rotation := rotation + rotationSpeed.
    locked
	ifFalse:
	   [translation := translation + velocityVector.
	    velocityVector := velocityVector + GravityVector].
    self reposition
]

"----------------------------------------------------------------"

World : View ( window polygons particles target targetPosition )

World new
[
    self := super new.
    particles := OrderedCollection new.
]

World bounds
[
    ^Rectangle origin: 0,0 corner: window extent
]

World pathOn: aCanvas
[
    ^aCanvas rectangle: (0,0 corner: window extent)
]

World setup
[
    | polygon rect |
    fillColour := Colour withR: 0.4 G: 0.6 B: 0.8.
    polygons := OrderedCollection new.
    1 timesRepeat:
       [polygon := ShapedView withShape: (Polygon newStar: 24 innerRadius: 10 outerRadius: 100).
	polygon fillColour: Colour yellow.
	polygon := ParticleView new add: polygon; yourself.
	polygon translation: 430,430; rotation: 0.
	self add: (polygons add: polygon)].
    "self add: (((0,0 corner: 300,400) shapedView fillColour: Colour blue lighter) transformView translation: 200,200)."
]

World step
[
    Recycling
	ifFalse:
	   [| pv |
	    pv := ParticleView new initialise.
	    pv add: Particle new.
	    self addFirst: pv.
	    particles add: pv].
    particles do: [:pv | pv step].
    polygons do: [:polygon | polygon rotateBy: 0.01745329251994329576].
]

World drawIn: clipRectangle
[
    | ctx view |
    clipRectangle
	ifTrue:
	   [ctx := window newCPainter.
"
	    ctx setSource: Colour white; rectangle: (10,10 extent: 100,100); fill.
	    ctx setSource: Colour red;   rectangle: (110,110 extent: 100,100); fill.
	    ctx setSource: Colour green; rectangle: (210,210 extent: 100,100); fill.
	    ctx setSource: Colour blue;  rectangle: (310,310 extent: 100,100); fill.
""
	    (clipRectangle contains: window bounds)
		ifFalse:
		   [ctx setSource: Colour black; rectangle: (clipRectangle outsetBy: 1.0) expanded; stroke.
		    ctx setClipRectangle: (clipRectangle outsetBy: 1.0) expanded].
"
	    self drawOn: ctx in: clipRectangle.
	    ctx destroy.
	    window swapBuffers"; sync".
	    {
#	      if 0
		static int count= 0;
		if ((count++ % 100) == 0) printf("%7ld %7ld %7ld\n", GC_get_heap_size(), GC_get_free_bytes(), GC_get_bytes_since_gc());
#	      endif
	    }]
]

World draw	[ self drawIn: window bounds ]

World run
[
    | evt |
    window := HostWindow withExtent: 1024,768"1600,1000".
    self setup.
    self draw.
    [window sync.
     self
	 step;
	 draw;
	 dispatchEvent: window pollEvent] repeat.
]

World drag: aView at: aPoint
[
    target := aView.
    targetPosition := aPoint.
]

World dispatchEvent: anEvent
[
    | view |
    anEvent ifFalse: [^self].
    anEvent handler: self.
    target
	ifTrue:  [self dragEvent: anEvent]
	ifFalse: [self handleEvent: anEvent].
]

World dragEvent: anEvent
[
    target translation: target translation + anEvent position - targetPosition.
    targetPosition := anEvent position.
    anEvent isPointerUpEvent
	ifTrue:
	   [target unlock.
	    target := targetPosition := nil].
]

ParticleView unlock	[ locked := false ]


ParticleView pointerDownEvent :anEvent
[
    StdOut print: anEvent position; tab; println: self bounds.
    (self bounds containsPoint: anEvent position) ifFalse: [^super pointerDownEvent :anEvent].
    locked := true.
    anEvent handler drag: self at: anEvent position.
]

[ World new run ]
