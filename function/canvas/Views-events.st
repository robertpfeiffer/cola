{ import: Views }

"TODO: this needs sideways composition"

CompositeView applyTransform: aPointOrShape	[ ^aPointOrShape ]

ComposableView applyTransform: aPointOrShape	[ ^aPointOrShape ]

TransformView applyTransform: aPointOrShape
[
    translation	ifTrue: [aPointOrShape := aPointOrShape translatedBy: translation negated].
    rotation	ifTrue: [aPointOrShape := aPointOrShape rotatedBy: rotation negated about: Point zero].
    ^aPointOrShape
]


ComposableView handleEvent: anEvent	[ ^self handleEvent: anEvent at: anEvent localPosition ]
CompositeView  handleEvent: anEvent	[ ^self handleEvent: anEvent at: anEvent localPosition ]


ComposableView handleEvent: anEvent at: aPoint
[
    | handler |
    ((self bounds containsPoint: aPoint) and: [handler := self propertyAt: anEvent name])
	ifTrue: [handler value: self value: anEvent].
    ^anEvent handled
	ifNil: 
	   [(anEvent dispatchTo: self)
		ifTrue:  [anEvent handled: self]
		ifFalse: [contents handleEvent: anEvent at: (self applyTransform: aPoint)]].
]

CompositeView handleEvent: anEvent at: aPoint
[
    (anEvent dispatchTo: self) ifTrue: [^anEvent handled: self].
    self do: [:v |
	anEvent localPosition: aPoint.
	(v handleEvent: anEvent at: aPoint) ifTrue: [^v]].
    ^nil
]


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
