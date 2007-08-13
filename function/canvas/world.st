{ import: XCairo }
{ import: View }
{ import: Text }

"----------------------------------------------------------------"

World : View ( window )

World bounds	[ ^Rectangle origin: 0@0 corner: window extent ]

World pathOn: aCanvas	[ ^aCanvas rectangle: (0@0 corner: window extent) ]

World draw
[
    self drawIn: window bounds.
]

World drawIn: clipRectangle
[
    | ctx view font |
    clipRectangle
	ifTrue:
	   [ctx := window newCairoContext.
	    (clipRectangle contains: window bounds)
		ifFalse:
		   [ctx setSource: Colour black; rectangle: (clipRectangle outsetBy: 1.0) expanded; stroke.
		    ctx setClipRectangle: (clipRectangle outsetBy: 1.0) expanded].
	    self drawOn: ctx in: clipRectangle.
	    ctx destroy.
	    window swapBuffers]
]

World setup
[
    | text |
    self fillColour: (Colour withR: 0.4 G: 0.6 B: 0.8).
    self add: (text := 'Hello, world' asText transformView translate: 100@100).
    text propertyAt: #pointerDownEvent put: [:view :event | self startDragging: view at: event position].
]

World startDragging: aView at: position
[
    self
	propertyAt: #pointerMotionEvent
	put: [:view :event |
	    aView translate: aView translation + event position - position.
	    position := event position.
	    self draw];
	propertyAt: #pointerUpEvent
	put: [:view :event |
	    self
		removeProperty: #pointerMotionEvent;
		removeProperty: #pointerUpEvent]
]

World run
[
    | evt |
    window := XWindow withExtent: 1024@768"1600@1000".
    self setup.
    self draw.
    [self dispatchEvent: window waitEvent] repeat.
]

World dispatchEvent: anEvent
[
    | view |
    anEvent ifFalse: [^self].
    anEvent context: self.
    self handleEvent: anEvent.
]

[ World new run ]
