{ import: Views }

CompositeView drawOn: aCanvas in: clipRectangle
[
    self reverseDo: [:view | view drawOn: aCanvas in: clipRectangle]
]

CompositeView pathOn: aCanvas in: clipRectangle
[
    self reverseDo: [:view | view pathOn: aCanvas in: clipRectangle]
]

CompositeView bounds
[
    | rect |
    self isEmpty ifTrue: [^Rectangle zero].
    rect := self first bounds.
    self from: 1 do: [:v | rect := rect union: v bounds].
    ^rect
]

"----------------------------------------------------------------"

TransformView drawOn: aCanvas in: clipRectangle
[
    | clip |
    aCanvas save.
    clip := clipRectangle.
    translation
	ifTrue:
	   [clip := clip translatedBy: translation negated.
	    aCanvas translate: translation].
    rotation
	ifTrue:
	   [clip := clip boundsRotatedBy: rotation negated about: Point zero.
	    aCanvas rotate: rotation].
    contents drawOn: aCanvas in: clip.
    aCanvas restore.
]

TransformView bounds
[
    | rect |
    rect := contents bounds.
    rotation	ifTrue: [rect := rect boundsRotatedBy: rotation about: Point zero].
    translation	ifTrue: [rect := rect translatedBy: translation].
    ^rect
]

"----------------------------------------------------------------"

View drawOn: aCanvas in: clipRectangle
[
    | bounds |
    bounds := self bounds.
    (bounds intersects: clipRectangle)
	ifTrue:
	   [fillColour
		ifTrue:
		   [aCanvas setSource: fillColour.
		    self pathOn: aCanvas.
		    aCanvas fill].
	    contents drawOn: aCanvas in: clipRectangle.
	    strokeColour
		ifTrue:
		   [strokeWidth ifTrue: [aCanvas setStrokeWidth: strokeWidth].
		    aCanvas setSource: strokeColour.
		    self pathOn: aCanvas.
		    aCanvas stroke]]
]

View bounds
[
    self subtypeResponsibility: 'bounds'
]

View pathOn: aCanvas
[
    self subtypeResponsibility: 'pathOn: aCanvas'
]

"----------------------------------------------------------------"

ShapedView bounds		[ ^shape bounds ]

ShapedView pathOn: aCanvas	[ shape pathOn: aCanvas ]
