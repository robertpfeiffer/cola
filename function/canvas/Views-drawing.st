" Views-drawing.st -- rendering Views with a Painter

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

  Last edited: 2007-09-18 20:15:07 by piumarta on emilia
"

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

CompositeView hAdvance
[
    self isEmpty ifTrue: [^0].
    ^self inject: 0 into: [:a :v | a + v hAdvance]
]

CompositeView referencePoint
[
    ^self isEmpty
	ifTrue:  [^Pair zero]
	ifFalse: [self first referencePoint]
]

"----------------------------------------------------------------"

ComposableView hAdvance		[ ^self bounds width ]
ComposableView referencePoint	[ ^Pair zero ]

"----------------------------------------------------------------"

TransformView drawOn: aCanvas in: clipRectangle
[
    aCanvas save; transform: transform.
    self drawContentsOn: aCanvas in: (clipRectangle boundsTransformedBy: inverse).
    aCanvas restore.
]

TransformView bounds		[ ^contents bounds boundsTransformedBy: transform ]
TransformView localBounds	[ ^contents bounds ]

TransformView hAdvance		[ ^contents hAdvance ]
TransformView referencePoint	[ ^self translation ]

"----------------------------------------------------------------"

View drawOn: aCanvas in: clipRectangle
[
    | fill stroke bounds |
    bounds := self bounds.
    (clipRectangle intersects: bounds)
	ifTrue:
	   [(fill := self fillColour)
		ifTrue:
		   [aCanvas setSource: fill.
		    self pathOn: aCanvas.
		    aCanvas fill].
	    self drawContentsOn: aCanvas in: (self bounds intersect: clipRectangle).
	    (stroke := self strokeColour)
		ifTrue:
		   [strokeWidth ifTrue: [aCanvas setStrokeWidth: strokeWidth].
		    aCanvas setSource: stroke.
		    self pathOn: aCanvas.
		    aCanvas stroke]]
]

ComposableView drawContentsOn: aCanvas in: clipRectangle
[
    | start end |
    ((start := self propertyAt: #selectionStart) and: [end := self propertyAt: #selectionEnd])
	ifTrue: [self drawSelectionFrom: start to: end on: aCanvas in: clipRectangle].
    contents drawOn: aCanvas in: clipRectangle.
]

ComposableView drawSelectionFrom: start to: end on: aCanvas in: clipRectangle
[
    | rect |
    aCanvas save; setSource: (self propertyAt: #selectionColour ifAbsent: [Colour green]).
    rect := start layoutBounds bottomLeft extent: 0,0.
    [start and: [start prevLink ~~ end]]
	whileTrue:
	   [| b |
	    b := start layoutBounds.
	    start isLineBreak
		ifTrue:
		   [rect encompass: clipRectangle right, rect bottom.
		    aCanvas rectangle: rect; fill.
		    rect := clipRectangle left,rect bottom extent: 0,0]
		ifFalse:
		   [(clipRectangle intersects: b)
			ifTrue:
			   [b left < rect left
				ifTrue:
				    [aCanvas rectangle: rect; fill.
				     rect := clipRectangle left,rect bottom extent: 0,0]
				ifFalse:
				    [rect encompass: b bottomLeft; encompass: b topRight]]].
	      start := start nextLink].
    aCanvas rectangle: rect; fill; restore.
]

View bounds		[ ^self shape bounds ]

View pathOn: aCanvas	[ ^self shape pathOn: aCanvas ]

View shape		[ ^self subtypeResponsibility: 'shape' ]

"----------------------------------------------------------------"

ShapedView hAdvance		[ ^shape hAdvance ]

ShapedView bounds		[ ^shape bounds ]

ShapedView pathOn: aCanvas	[  shape pathOn: aCanvas ]

"----------------------------------------------------------------"

ComposableView damaged	[ self damaged: self bounds ]
CompositeView damaged	[ self damaged: self bounds ]
TransformView damaged	[ self damaged: self localBounds ]

ComposableView damaged: aRectangle	[ "container ifTrue: ["container damaged: aRectangle"]" ]
CompositeView  damaged: aRectangle	[ containers do: [:v | v damaged: aRectangle] ]
TransformView  damaged: aRectangle	[ super damaged: (aRectangle boundsTransformedBy: transform) ]
