{ import: XCairo }
{ import: View }

GravityVector := [ 0.03 @ -0.5 ]

Recycling := [ false ]


Particle : ShapedView ()

Particle new
[
    self := super withShape: (Polygon newStar: 5 innerRadius: Random next * 8.0 outerRadius: Random next * 16.0).
    self fillColour: Colour red.
]

"----------------------------------------------------------------"

ParticleView : TransformView ( velocityVector rotationSpeed locked )

ParticleView initialise
[
    self translate: 500@20.
    self rotate: 0.
    velocityVector := (Random next - 0.5 * 4.0) @ (2.0 + Random next * 8.0).
    rotationSpeed := velocityVector x / -20.
]

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
    locked ifTrue: [^self].
    translation := translation + velocityVector.
    velocityVector := velocityVector + GravityVector.
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
    ^Rectangle origin: 0@0 corner: window extent
]

World pathOn: aCanvas
[
    ^aCanvas rectangle: (0@0 corner: window extent)
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
	polygon translate: 430@430.
	polygon rotate: 0.
	self add: (polygons add: polygon)].
    "self add: (((0@0 corner: 300@400) shapedView fillColour: Colour blue lighter) transformView translate: 200@200)."
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
    polygons do: [:polygon | polygon rotate: polygon rotation + 0.01745329251994329576].
]

World drawIn: clipRectangle
[
    | ctx view |
    clipRectangle
	ifTrue:
	   [ctx := window newCairoContext.
	    (clipRectangle contains: window bounds)
		ifFalse:
		   [ctx setSource: Colour black; rectangle: (clipRectangle outsetBy: 1.0) expanded; stroke.
		    ctx setClipRectangle: (clipRectangle outsetBy: 1.0) expanded].
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
    window := XWindow withExtent: 1024@768"1600@1000".
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
    anEvent context: self.
    target
	ifTrue:  [self dragEvent: anEvent]
	ifFalse: [self handleEvent: anEvent].
]

World dragEvent: anEvent
[
    target translate: (target translation translatedBy: anEvent position - targetPosition).
    targetPosition := anEvent position.
    anEvent isPointerUpEvent
	ifTrue:
	   [target unlock.
	    target := targetPosition := nil].
]

ParticleView unlock	[ locked := false ]


ParticleView pointerDownEvent :anEvent
[
    (self bounds containsPoint: anEvent localPosition) ifFalse: [^super pointerDownEvent :anEvent].
    locked := true.
    anEvent context drag: self at: anEvent position.
]

[ World new run ]
