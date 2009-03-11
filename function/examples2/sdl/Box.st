{ import: Color }
{ import: Geometry }
{ import: Surface }

BoxList : LinkedList ( myBox )

BoxList forBox: aBox
[
    self := self new.
    myBox := aBox.
]

BoxList addFront: aBox			[ ^super addFirst: (aBox onList: self) ]
BoxList addBack: aBox			[ ^super addLast:  (aBox onList: self) ]
BoxList add: aBox inFrontOf: bBox	[ ^super add: (aBox onList: self) before: bBox ]
BoxList add: aBox behind: bBox		[ ^super add: (aBox onList: self) after: bBox ]

BoxList addFirst: aBox		[ ^self shouldNotImplement: #addFirst: ]
BoxList addLast: aBox		[ ^self shouldNotImplement: #addLast: ]
BoxList add: aBox		[ ^self shouldNotImplement: #add: ]

BoxList back			[ ^super last ]
BoxList front			[ ^super first ]
BoxList removeBack		[ ^super removeLast ]
BoxList removeFront		[ ^super removeFirst ]

BoxList detectFrontToBack: unaryBlock	[ ^super detect: unaryBlock ]

BoxList contentsFrontToBack	[ ^self asOrderedCollection ]

"----------------------------------------------------------------"

Box : Link ( myList position extent properties contents )

Box position	[ ^position ]
Box extent	[ ^extent ]

Box new
[
    self := super new.
    position := PointZero.
]

Box with: aBox
[
    self := self new.
    ^self add: aBox
]

Box position: aPoint	[ position := aPoint ]

Box extent: aPoint
[
    extent := aPoint.
    self layoutContents.
]

Box width	[ ^extent x ]
Box height	[ ^extent y ]

Box globalPosition	[ ^myList ifTrue: [position + myList globalPosition] ifFalse: [position] ]

Box layoutContents
[
    | layout |
    (layout := self layout) ifTrue: [layout layout: self]
]

Box onList: aList	[ myList := aList ]
Box removeFromList	[ myList remove: self ]

Box raise		[ prevLink ifTrue: [myList remove: self; addFront: self] ]
Box lower		[ nextLink ifTrue: [myList remove: self; addBack: self] ]

Box contents		[ ^contents ifTrue: [contents] ifFalse: [contents := BoxList forBox: self] ]

Box addFront: aBox		[ ^self contents addFront: aBox ]
Box addBack: aBox		[ ^self contents addBack:  aBox ]
Box add: aBox inFrontOf: bBox	[ ^self contents add: (aBox onList: self) inFrontOf: bBox ]
Box add: aBox behind: bBox	[ ^self contents add: (aBox onList: self) behind: bBox ]
Box add: aBox			[ ^self contents addBack:  aBox ]

Box isEmpty		[ ^self notEmpty not ]
Box notEmpty		[ ^contents and: [contents notEmpty] ]

Box back		[ ^contents ifTrue: [contents last] ]
Box front		[ ^contents ifTrue: [contents first] ]

Box do: unaryBlock		[ ^contents ifTrue: [contents do: unaryBlock] ]
Box doFrontToBack: unaryBlock	[ ^contents ifTrue: [contents do: unaryBlock] ]
Box doBackToFront: unaryBlock	[ ^contents ifTrue: [contents reverseDo: unaryBlock] ]

Box	globalPosition	[ ^position + myList globalPosition ]
BoxList	globalPosition	[ ^myBox globalPosition ]

Box includesGlobalPoint: aPoint
[
    | gpos |
    gpos := self globalPosition.
    ^gpos <= aPoint and: [aPoint < (gpos + extent)]
]

Box boxUnder: aPoint
[
    | box |
    (box := self subBoxUnder: aPoint)
	ifFalse:
	    [box := (position <= aPoint and: [aPoint < (position + extent)])
		 ifTrue: [self]].
    ^box
]

Box subBoxUnder: aPoint
[
    aPoint := aPoint - position.
    self doFrontToBack: [:box | (box := box boxUnder: aPoint) ifTrue: [^box]].
    ^nil
]

Box immediateBoxUnder: aPoint
[
    aPoint := aPoint - position.
    self doFrontToBack: [:box | (box position <= aPoint and: [aPoint < (box position + box extent)]) ifTrue: [^box]].
    ^nil
]

"----------------"

Box properties	[ ^properties ifTrue: [properties] ifFalse: [properties := IdentityDictionary new] ]

Box propertyAt: aSymbol put: aValue		[  self properties at: aSymbol put: aValue ]
Box propertyAt: aSymbol				[ ^properties ifTrue: [properties at: aSymbol ifAbsent: []] ]
Box propertyAt: aSymbol ifAbsent: valueBlock	[ ^properties ifTrue: [properties at: aSymbol ifAbsent: valueBlock] ]

Box resetProperties	[ properties := nil ]

Box background	[ ^self propertyAt: #background ]	Box background: aColor	 [ ^self propertyAt: #background put: aColor  ]
Box border	[ ^self propertyAt: #border     ]	Box border:     aColor	 [ ^self propertyAt: #border     put: aColor  ]
Box foreground	[ ^self propertyAt: #foreground ]	Box foreground: aColor	 [ ^self propertyAt: #foreground put: aColor  ]
Box layout	[ ^self propertyAt: #layout     ]	Box layout: aLayout	 [ ^self propertyAt: #layout     put: aLayout ]
Box motion	[ ^self propertyAt: #motion ]		Box motion: aHandler	 [ ^self propertyAt: #motion	 put: aHandler ]
Box buttonDown	[ ^self propertyAt: #buttonDown ]	Box buttonDown: aHandler [ ^self propertyAt: #buttonDown put: aHandler ]
Box buttonUp	[ ^self propertyAt: #buttonUp ]		Box buttonUp: aHandler	 [ ^self propertyAt: #buttonUp	 put: aHandler ]
Box keyDown	[ ^self propertyAt: #keyDown ]		Box keyDown: aHandler	 [ ^self propertyAt: #keyDown	 put: aHandler ]
Box keyUp	[ ^self propertyAt: #keyUp ]		Box keyUp: aHandler	 [ ^self propertyAt: #keyUp	 put: aHandler ]

Box printOn: aStream
[
    super printOn: aStream.
    aStream
	nextPut: $(;
	print: position;
	nextPut: $+;
	print: extent;
	nextPut: $)
]

"----------------"

Box drawOn: aContext
[
    | bg bd fg |
    bg := self drawBackgroundOn: aContext.
    fg := self drawForegroundOn: aContext.
    bd := self drawBorderOn:     aContext.
    (bg or: [fg or: [bd or: [self notEmpty]]]) ifFalse: [self drawInvalidOn: aContext].
]

Box drawBackgroundOn: aContext
[
    | bg |
    ^(bg := self background)
	ifTrue:
	    [aContext
		 saveColor;
		 color: bg; 
		 fillRectangle: position extent: extent;
		 restoreColor]
]

Box drawBorderOn: aContext
[
    | bd |
    ^(bd := self border)
	ifTrue:
	    [aContext
		 saveColor;
		 color: bd; 
		 drawRectangle: position extent: extent - (1,1);
		 restoreColor]
]

Box drawForegroundOn: aContext
[
    ^contents
	ifTrue:
	   [| fg |
	    fg := self foreground.
	    fg ifTrue: [aContext saveColor; color: fg].
	    self drawContentsOn: aContext.
	    fg ifTrue: [aContext restoreColor]]
]

Box drawContentsOn: aContext
[
    ^contents
	ifTrue:
	   [aContext saveTransform; translate: position.
	    self doBackToFront: [:box | box drawOn: aContext].
	    aContext restoreTransform]
]

Box drawInvalidOn: aContext
[
    | corner |
    corner := position + extent - (1,1).
    aContext
	saveColor;
	color: ColorRed; 
	fillRectangle: position extent: extent;
	color: ColorYellow; 
	drawRectangle: position extent: extent;
	drawLine:      position to: corner;
	drawLine:      position x , corner y to: corner x , position y;
	restoreColor
]

"----------------------------------------------------------------"

HandExtent := [ 1,1 ]
HandOffset := [ 0,0 ]


Hand : Box ( window focus eventHandlers )

Hand withWindow: aWindow
[
    self := self new.
    window := aWindow.
    eventHandlers := LinkedList new.
]

Hand globalPosition	[ ^position ]

"----------------------------------------------------------------"

Window : Box ( surface hand )

Window surface	[ ^surface ]

Window new: dimensions
[
    self := super new.
    surface := Surface new: dimensions.
    position := PointZero.
    extent := dimensions.
    self background: (Color withR: 47 withG: 79 withB: 79).
    hand := (Hand withWindow: self)
	position: dimensions / 2 - HandOffset;
	extent: HandExtent;
	background: ColorBlue;
	border: ColorGreen.
]

Window	globalPosition	[ ^PointZero ]

Window draw
[
    | context |
    context := surface newContext.
    self drawOn: context.
    hand drawOn: context.
    context flush.
]
