" Views-events.st -- dispatch an event to a View

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

  Last edited: 2007-09-18 20:14:43 by piumarta on emilia
"

{ import: Views }

"TODO: this needs sideways composition"

CompositeView  applyTransform: aPointOrShape	[ ^aPointOrShape ]
ComposableView applyTransform: aPointOrShape	[ ^aPointOrShape ]
TransformView  applyTransform: aPointOrShape	[ ^aPointOrShape transformedBy: inverse ]

CompositeView  globalToLocal: aPointOrShape	[ ^containers first globalToLocal: aPointOrShape ]
ComposableView globalToLocal: aPointOrShape	[ ^container globalToLocal: aPointOrShape ]
TransformView  globalToLocal: aPointOrShape	[ ^(super globalToLocal: aPointOrShape) transformedBy: inverse ]

ComposableView handleEvent: anEvent	[ ^self handleEvent: anEvent at: anEvent localPosition ]
CompositeView  handleEvent: anEvent	[ ^self handleEvent: anEvent at: anEvent localPosition ]


ComposableView oldHandleEvent: anEvent at: aPoint
[
    | handler |
    ((self bounds containsPoint: aPoint) and: [handler := self propertyAt: anEvent name])
	ifTrue: [handler value: self value: anEvent].
    ^anEvent handled
	ifNil: 
	   [(anEvent dispatchTo: self)
		ifTrue:  [anEvent handled: self]
		ifFalse: [contents oldHandleEvent: anEvent at: (self applyTransform: aPoint)]].
]

CompositeView oldHandleEvent: anEvent at: aPoint
[
    (anEvent dispatchTo: self) ifTrue: [^anEvent handled: self].
    self do: [:v |
	anEvent localPosition: aPoint.
	(v oldHandleEvent: anEvent at: aPoint) ifTrue: [^v]].
    ^nil
]


ComposableView handleEvent: anEvent at: aPoint
[
    | handler |
    (self bounds containsPoint: aPoint) ifFalse: [^nil].
    contents handleEvent: anEvent at: (self applyTransform: aPoint).
    (handler := anEvent handled) ifTrue: [^handler].
    (handler := self propertyAt: anEvent name) ifTrue: [handler value: self value: anEvent].
    (handler := anEvent handled) ifTrue: [^handler].
    ^(anEvent dispatchTo: self) ifTrue: [anEvent handled: self]
]

CompositeView handleEvent: anEvent at: aPoint
[
    self do: [:v |
	| handler |
	anEvent localPosition: aPoint.
	v handleEvent: anEvent at: aPoint.
	(handler := anEvent handled) ifTrue: [^handler]].
    anEvent dispatchTo: self.
]


ComposableView transformedBounds	[ ^self bounds ]
CompositeView transformedBounds		[ ^self bounds ]
TransformView transformedBounds		[ ^self applyTransform: self bounds ]


CompositeView pointerMotionEvent :anEvent	[ ^nil ]
CompositeView pointerDownEvent :anEvent		[ ^nil ]
CompositeView pointerUpEvent :anEvent		[ ^nil ]
CompositeView keyDownEvent :anEvent		[ ^nil ]
CompositeView keyRepeatEvent :anEvent		[ ^nil ]
CompositeView keyUpEvent :anEvent		[ ^nil ]
CompositeView damageEvent :anEvent		[ ^nil ]

ComposableView pointerMotionEvent :anEvent	[ ^nil ]
ComposableView pointerDownEvent :anEvent	[ ^nil ]
ComposableView pointerUpEvent :anEvent		[ ^nil ]
ComposableView keyDownEvent :anEvent		[ ^nil ]
ComposableView keyRepeatEvent :anEvent		[ ^nil ]
ComposableView keyUpEvent :anEvent		[ ^nil ]
ComposableView damageEvent :anEvent		[ ^nil ]
