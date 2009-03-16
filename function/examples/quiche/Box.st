" Box.st -- as the name implies

  Copyright (c) 2009 Ian Piumarta
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

  Last edited: 2009-03-16 13:59:05 by piumarta on emilia
"

{ import: Object }
{ import: Surface }
{ import: Colour }
{ import: Font }

Box : Object ( container prevLink nextLink surface origin width height depth changed properties firstLink lastLink )

Box container		[ ^container ]

Box prevLink		[ ^prevLink ]
Box prevLink: aLink	[  prevLink := aLink ]
Box nextLink		[ ^nextLink ]
Box nextLink: aLink	[  nextLink := aLink ]

Box onList: aList	[  container := aList ]
Box offList		[  container := prevLink := nextLink := nil ]

"----------------"

Box withOrigin: aPoint width: wd height: ht depth: dp
[
    self := super new.
    origin := aPoint.
    width  := wd.
    height := ht.
    depth  := dp.
    changed := self.
]

Box new				[ ^self withOrigin: PointZero width: 0 height: 0 depth: 0 ]

Box withExtent: aPoint		[ ^self withOrigin: PointZero width: aPoint x height: aPoint y depth: 0 ]
Box withBounds: aRectangle	[ ^self withOrigin: aRectangle origin width: aRectangle width height: aRectangle height depth: 0 ]

Box withSurface: aSurface
[
    self := self withOrigin: PointZero width: aSurface width height: aSurface height depth: aSurface depth.
    surface := aSurface.
    height := aSurface lineSkip - depth max: height.
]

Surface asBox	[ ^Box withSurface: self ]

Box surface		[ ^surface ]

Box surface: aSurface
[
    origin := PointZero.
    width := aSurface width.
    height := aSurface height.
    depth := aSurface depth.
    surface := aSurface.
    height := height + (aSurface lineSkip - height - depth max: 0).
    self layoutChanged.
]

Rectangle asBox		[ ^Box withOrigin: origin width: self width height: self height depth: 0 ]

Box origin		[ ^origin ]
Box width		[ ^width ]
Box width: aNumber	[  width := aNumber ]
Box height		[ ^height ]
Box height: aNumber	[  height := aNumber ]
Box depth		[ ^depth ]
Box depth: aNumber	[  depth := aNumber ]
Box totalHeight		[ ^height + depth ]

Box globalOrigin	[ ^origin + (container ifTrue: [container globalOrigin] ifFalse: [PointZero]) ]
Box globalBounds	[ ^self globalOrigin extent: width , (height + depth) ]

Box includesPoint: aPoint	[ ^origin <= aPoint
				      and: [aPoint x - origin x < width
						and: [aPoint y - origin y < (height + depth)]] ]

Box moveTo: aPoint
[
    origin := aPoint.
    self contentsChanged.
]

"----------------"

Box propertiesAt: aKey			[ ^properties ifTrue: [properties at: aKey ifAbsent: []] ]
Box propertiesAt: aKey put: aValue	[ ^aValue ifTrue: [self properties at: aKey put: aValue] ifFalse: [self propertiesRemoveKey: aKey] ]
Box properties				[ ^properties ifNil: [properties := IdentityDictionary new] ]
Box propertiesReset			[  properties := nil ]

Box propertiesRemoveKey: aKey
[
    properties ifFalse: [^nil].
    properties removeKey: aKey ifAbsent: [].
    properties isEmpty ifTrue: [properties := nil].
    ^nil
]

Box propertiesAt: aKey ifAbsent: aBlock		[ ^(self propertiesAt: aKey) ifNil: aBlock ]
Box propertiesAt: aKey initially: aBlock	[ ^(self propertiesAt: aKey) ifNil: [self propertiesAt: aKey put: aBlock value] ]

Box propertiesDo: binaryBlock		[  properties ifTrue: [properties do: [:assoc | binaryBlock value: assoc key value: assoc value]] ]

Box backgroundColour: aColour		[  self propertiesAt: #backgroundColour put: aColour; contentsChanged ]
Box backgroundColour			[ ^self propertiesAt: #backgroundColour ]
Box borderColour: aColour		[  self propertiesAt: #borderColour put: aColour; contentsChanged ]
Box borderColour			[ ^self propertiesAt: #borderColour ]
Box borderWidth: aNumber		[  self propertiesAt: #borderWidth put: aNumber; contentsChanged ]
Box borderWidth				[ ^self propertiesAt: #borderWidth ifAbsent: [0] ]

"----------------"

Box notEmpty	[ ^firstLink ]
Box isEmpty	[ ^firstLink not ]

Box firstOrNil	[ ^firstLink ]
Box lastOrNil	[ ^lastLink ]

Box prevInFlow	[ ^prevLink ifNil: [(container and: [container prevLink]) ifTrue: [container prevLink lastOrNil]] ]
Box nextInFlow	[ ^nextLink ifNil: [(container and: [container nextLink]) ifTrue: [container nextLink firstOrNil]] ]

Box addLast: aBox
[
    lastLink
	ifTrue:
	   [aBox prevLink: lastLink.
	    lastLink nextLink: aBox.
	    lastLink := aBox]
	ifFalse:
	   [lastLink := firstLink := aBox].
    aBox onList: self.
    self contentsChanged.
]

Box addFirst: aBox
[
    firstLink
	ifTrue:
	   [aBox nextLink: firstLink.
	    firstLink prevLink: aBox.
	    firstLink := aBox]
	ifFalse:
	   [lastLink := firstLink := aBox].
    aBox onList: self.
    self contentsChanged.
]

Box add: bBox before: aBox
[
    aBox == firstLink
	ifTrue:
	   [firstLink := bBox]
	ifFalse:
	   [bBox prevLink: aBox prevLink.
	    bBox prevLink nextLink: bBox].
    aBox prevLink: bBox.
    bBox nextLink: aBox.
    bBox onList: self.
    self contentsChanged.
]

Box add: bBox after: aBox
[
    aBox == lastLink
	ifTrue:
	   [lastLink := bBox]
	ifFalse:
	   [bBox nextLink: aBox nextLink.
	    bBox nextLink prevLink: bBox].
    aBox nextLink: bBox.
    bBox prevLink: aBox.
    bBox onList: self.
    self contentsChanged.
]

Box removeFirst
[
    | box |
    box := firstLink.
    box == lastLink
	ifTrue:  [firstLink := lastLink := nil]
	ifFalse: [(firstLink := box nextLink) prevLink: nil].
    box offList.
    self contentsChanged.
    ^box.
]

Box removeLast
[
    | box |
    box := lastLink.
    box == firstLink
	ifTrue:  [lastLink := firstLink := nil]
	ifFalse: [(lastLink := box prevLink) nextLink: nil].
    box offList.
    self contentsChanged.
    ^box.
]

Box remove: aBox
[
    aBox == firstLink ifTrue: [^self removeFirst].
    aBox == lastLink  ifTrue: [^self removeLast].
    aBox prevLink nextLink: aBox nextLink.
    aBox nextLink prevLink: aBox prevLink.
    aBox offList.
    self contentsChanged.
    ^aBox
]

Box splitAfter: aBox
[
    aBox nextLink ifFalse: [^self].
    container add: self copyEmpty after: self.
    [lastLink == aBox] whileFalse: [nextLink addFirst: self removeLast].
    ^nextLink.
]

Box unlink		[ container remove: self ]
Box linkBefore: aBox	[ aBox container add: self before: aBox ]
Box linkAfter: aBox	[ aBox container add: self after: aBox ]

Box copyEmpty
[
    | copy |
    copy := Box withOrigin: origin width: width height: height depth: depth.
    self propertiesDo: [:key :value | copy propertiesAt: key put: value].
    ^copy
]

Box contentsChanged []
"[
    changed
	ifFalse:
	   [changed := self.
	    container ifTrue: [container println contentsChanged]]
]"

Box layoutChanged
[
    changed
	ifFalse:
	   [changed := self.
	    container ifTrue: [container layoutChanged]]
]

Box		withAllNextDo: unaryBlock	[ [unaryBlock value: self.  self := nextLink] whileTrue ]
UndefinedObject withAllNextDo: unaryBlock	[ ]
Box		withAllPrevDo: unaryBlock	[ [unaryBlock value: self.  self := prevLink] whileTrue ]
UndefinedObject withAllPrevDo: unaryBlock	[ ]

Box to: aBox do: unaryBlock
[
    | box |
    box := self.
    [unaryBlock value: box.
     box and: [box ~~ aBox]]
	whileTrue:
	   [box := box nextLink]
]

Box do: unaryBlock			[ firstLink withAllNextDo: unaryBlock ]
Box reverseDo: unaryBlock		[ lastLink  withAllPrevDo: unaryBlock ]
Box inject: aValue into: binaryBlock	[ firstLink withAllNextDo: [:box | aValue := binaryBlock value: aValue value: box].  ^aValue ]

Box detect: aBlock			[ ^self detect: aBlock ifAbsent: [] ]
Box detect: aBlock ifAbsent: bBlock	[  self do: [:box | | e | (e := aBlock value: box) ifTrue: [^e]].  ^bBlock value ]

"----------------"

Box eventHandlersAt: name put: hdlr
[
    | handlers |
    handlers := self propertiesAt: #eventHandlers initially: [IdentityDictionary new].
    handlers at: name put: hdlr.
]

Box eventHandlersAt: name
[
    | handlers |
    (handlers := self propertiesAt: #eventHandlers) ifFalse: [^nil].
    ^handlers at: name ifAbsent: [].
]

"----------------"

Layout : Object ()

Layout layOut: aBox in: parentExtent	[ aBox layOutContents ]

HBox : Layout ()

HBox layOut: aBox in: parentExtent
[
    | b x y h d last |
    aBox layOutContents.
    b := aBox borderWidth asPoint.
    x := b x.
    y := b y.
    h := aBox inject: 0 into: [:maxH :box | maxH max: box height].
    d := aBox inject: 0 into: [:maxD :box | maxD max: box depth].
    aBox do: [:box |
	(last := box) moveTo: x , (y + h - box height).
	x := x + box width].
    x := x + b x.
    aBox width: x; height: y + h; depth: (last ifTrue: [last depth] ifFalse: [d]) + y.
    aBox contentsChanged.
]

Box hBox	[ self propertiesAt: #layout put: HBox ]

"----------------"

VBox : Layout ()

VBox layOut: aBox in: parentExtent
[
    | b x y r w h d box last |
    b := aBox borderWidth asPoint.
    x := b x.
    y := b y.
    r := parentExtent height - y.
    aBox width: parentExtent width - x - x.
    w := 0.
    (box := aBox firstVisible) ifTrue: [box layOutIn: aBox].
    [box]
	whileTrue: 
	   [box moveTo: x,y.
	    w := w max: box width.
	    y := y + box totalHeight.
	    box := ((last := box) nextLink and: [(y + (box nextLink layOutIn: aBox) totalHeight) <= r])
		ifTrue: [box nextLink]].
    d := last ifTrue: [last depth] ifFalse: [0].
    h := y - d.
    aBox height: h; depth: d; lastVisible: last.
    (box := aBox firstVisible) ifFalse: [^self].
    last := last ifTrue: [last nextLink].
    [box == last] whileFalse: [box := (box width: w; nextLink)].
]

Box vBox	[ self propertiesAt: #layout put: VBox ]

"----------------"

TBox : Layout ()

Box subsumeAllNext
[
    [self subsumeNextLink] whileTrue
]

Box subsumeNextLink
[
    [nextLink and: [nextLink isEmpty]] whileTrue: [nextLink unlink].
    nextLink ifFalse: [^nil].
    (lastLink and: [lastLink isNewline]) ifTrue: [^nil].
    self addLast: nextLink removeFirst.
    [nextLink and: [nextLink isEmpty]] whileTrue: [nextLink unlink].
]

Box isNewline	[ ^surface  and: [surface isNewline] ]
Box isBreak	[ ^prevLink and: [self isGlue and: [prevLink isGlue not]] ]
Box isGlue	[ ^surface  and: [surface isSpace or: [surface isNewline]] ]
Box isTab	[ ^surface  and: [surface isGlyph and: [surface unicode == 160]] ]

TBox layOut: aBox in: parentExtent
[
    | b lastBreak x y r h d width glue |
    aBox subsumeAllNext.
    aBox layOutContents.
    b := aBox borderWidth asPoint.
    x := b x.
    y := b y.
    r := parentExtent width - x - x.
    aBox do: [:box |
	x := x + box width.
	((box nextLink and: [x + box nextLink width > r]) or: [box isNewline])
	    ifTrue: [(aBox splitAfter: box) layoutChanged].
	box isBreak ifTrue: [lastBreak := box]].
    lastBreak ifTrue: [(aBox splitAfter: lastBreak) layoutChanged].
    width := aBox inject: 0 into: [:sum :box | sum + box width].
    glue  := aBox inject: 0 into: [:sum :box | sum + (box isGlue ifTrue: [box width] ifFalse: [0])].
    glue  := 1 + (glue > 0 ifTrue: [r - width / glue] ifFalse: [1]).
    [(aBox lastOrNil and: [aBox lastOrNil width == 0 and: [aBox nextLink]])] whileTrue: [aBox nextLink addFirst: aBox removeLast].
    (aBox lastOrNil and: [aBox lastOrNil isNewline]) ifTrue: [glue := 1].
    h := d := 0.
    aBox do: [:box |
	h := h max: box height.
	d := d max: box depth].
    x := b x.
    aBox do: [:box |
	box moveTo: x,(y + h - box height).
	x := x + (box isGlue ifTrue: [box width * glue] ifFalse: [box width])].
    x := x + b x.
    aBox width: x; height: y + h; depth: d + y.
    "aBox println flash."
]

Box flash		[ self flash: self width , (self height + self depth) ]
Box flash: extent	[ self flash: extent at: PointZero ]
Box flash: e at: p	[ container flash: e at: p + origin ]

Box tBox	[ self propertiesAt: #layout put: TBox ]

"----------------"

Box layout			[ ^self propertiesAt: #layout      ifAbsent: [Layout]  ]

Box layOut			[ self layOutIfChangedIn: self ]
Box layOutIfChangedIn: anExtent	[ changed ifTrue: [self layOutIn: anExtent] ]
Box layOutIn: anExtent		[ self layout layOut: self in: anExtent.  changed := nil ]
Box layOutContents		[ self layOutContentsIn: self ]
Box layOutContentsIn: anExtent	[ self do: [:box | box layOutIfChangedIn: anExtent] ]

"----------------"

SBox : Box ( firstVisible lastVisible )

Box  firstVisible: aBox	[]
SBox firstVisible: aBox	[ firstVisible := aBox ]

SBox firstVisible
[
    firstVisible ifFalse: [firstVisible := firstLink].
    ^firstVisible
]

Box firstVisible	[ ^firstLink ]

Box  lastVisible: aBox	[]
SBox lastVisible: aBox	[ lastVisible := aBox ]

SBox lastVisible
[
    lastVisible ifFalse: [lastVisible := lastLink].
    ^lastVisible
]

Box lastVisible
[
    ^lastLink
]

SBox drawContentsOn: aSurface at: aPoint
[
    firstVisible ifTrue: [firstVisible to: lastVisible do: [:box | box drawOn: aSurface at: aPoint]]
]

Box ensureVisible: aBox	[]
Box ensureVisible	[ container container ensureVisible: self ]

SBox oldEnsureVisible: aBox
[
    | cont h |
    cont := aBox container.
    (self isVisible: cont) ifTrue: [^self].
    firstVisible := aBox container.
    self layoutChanged; layOutIn: container.
]

SBox ensureVisible: aBox
[
    | cont h |
    cont := aBox container.
    (self isVisible: cont) ifTrue: [^self].
    firstLink to: self firstVisible do: [:box |
	box == cont
	    ifTrue:
	       [firstVisible := cont.
		^self layoutChanged]].
    [ firstVisible := firstVisible nextLink.
      self layoutChanged; layOutIn: container.
      self isVisible: aBox container ] whileFalse.
]

SBox isVisible: aBox	[ self firstVisible to: self lastVisible do: [:box | box == aBox ifTrue: [^self]].  ^nil ]

"----------------"

Box drawOn: aSurface at: aPoint
[
    | doa bg bd bw extent |
    aPoint := aPoint + origin.
    (doa := self propertiesAt: #drawOn:at:) ifTrue: [^doa value: aSurface value: aPoint].
    bg := changed ifTrue: [ColourYellow] ifFalse: [self backgroundColour].
    bd := self borderColour.
    bw := self borderWidth.
    extent := width , (height + depth).
    (bd and: [bw > 0]) ifFalse: [bw := 0.  bd := nil].
    bg		ifTrue:  [aSurface fillRectangle: ((aPoint extent: extent) insetBy: bw) withColour: bg].
    surface	ifTrue:  [ surface drawOn: aSurface at: aPoint].
    "properties  ifTrue:  [bd := ColourBlue]."
    bd		ifTrue:  [aSurface drawRectangle: (aPoint extent: extent - PointOne) withColour: bd].
    self drawContentsOn: aSurface at: aPoint.
"
    (surface not and: [self isEmpty])
	ifTrue: [aSurface fillRectangle: (aPoint extent: PointTwo) withColour: ColourRed]
"
]

Box drawContentsOn: aSurface at: aPoint
[
    self reverseDo: [:box | box drawOn: aSurface at: aPoint].
]

"----------------------------------------------------------------"

ActivatedHandler : Link ( handler box )

ActivatedHandler withHandler: aHandler box: aBox
[
    self := self new.
    handler := aHandler.
    box := aBox.
]

ActivatedHandler handler		[ ^handler ]
ActivatedHandler box			[ ^box ]

ActivatedHandler handle: anEvent	[ ^handler handle: anEvent for: box at: nil ]

"----------------"

Window : Box ( activatedHandlers )

Window flash: e at: p
[
    surface fillRectangle: (p extent: e) withColour: ColourRed; flush.
    surface fillRectangle: (p extent: e) withColour: ColourWhite; flush.
    surface fillRectangle: (p extent: e) withColour: ColourBlue; flush.
    surface fillRectangle: (p extent: e) withColour: ColourWhite; flush.
]

Window withExtent: aPoint
[
    self := super withSurface: (DisplaySurface withExtent: aPoint).
    self backgroundColour: (Colour grey: 0.80).
    activatedHandlers := LinkedList new.
]

Window eventHandlersAdd: handler forBox: aBox	[ activatedHandlers addFirst: (ActivatedHandler withHandler: handler box: aBox) ]
Window eventHandlersRemove: handler		[ activatedHandlers do: [:av | av handler == handler ifTrue: [^activatedHandlers remove: av]] ]
Window eventHandlersPopTo: handler		[ [activatedHandlers removeFirst handler == handler] whileFalse ]

Window draw
[
    super drawOn: surface at: 0,0.
    surface flush.
]

Window mainLoop
[
    self layOut; draw.
    [ | event |
      self dispatchEvent: surface nextEvent.
      [event := surface pollEvent] whileTrue: [self dispatchEvent: event].
      self layOut; draw]
	repeat.
]

Window dispatchEvent: anEvent
[
    anEvent source: self.
    activatedHandlers do: [:av | (av handle: anEvent) ifTrue: [^self]].
    self dispatchEvent: anEvent at: anEvent position.
]

Box dispatchEvent: anEvent at: aPoint
[
    | handler |
    (self includesPoint: aPoint) ifFalse: [^nil].
    aPoint := aPoint - origin.
    (handler := self eventHandlersAt: anEvent type)
	ifTrue:  [handler handle: anEvent for: self at: aPoint]
	ifFalse: [^self dispatchSubEvent: anEvent at: aPoint].
]

Box dispatchSubEvent: anEvent at: aPoint
[
    self do: [:box | (box dispatchEvent: anEvent at: aPoint) ifTrue: [^self]].
    ^nil
]

Box printOn: aStream
[
    super printOn: aStream.
    changed ifTrue: [aStream nextPut: $*].
    aStream
	nextPut: $(;
	print: origin; space;
	print: width; space;
	print: height; space;
	print: depth; space;
	print: surface; space;
	nextPutAll: '+'; print: self size;
	nextPut: $)
]

Box size	[ ^self inject: 0 into: [:sum :box | sum + 1] ]

"----------------"

ButtonHandler : EventHandler ( borderColour backgroundColour actionBlock )

ButtonHandler withAction: aBlock
[
    self := self new.
    actionBlock := aBlock.
]

ButtonHandler buttonDownEvent :event :box :point
[
    (backgroundColour := box backgroundColour) ifTrue: [box backgroundColour: (backgroundColour darker:  0.1)].
    (borderColour     := box borderColour)     ifTrue: [box borderColour:     (borderColour     lighter: 0.1)].
    event source eventHandlersAdd: self forBox: box.
]

ButtonHandler buttonUpEvent :event :box :point
[
    (box globalBounds includesPoint: event position) ifTrue: [actionBlock value].
    event source eventHandlersRemove: self.
    backgroundColour ifTrue: [box backgroundColour: backgroundColour].
    borderColour     ifTrue: [box borderColour:     borderColour].
]

"----------------"

HighlightHandler : EventHandler ()

HighlightHandler motionEvent :event :box :point
[
    event source eventHandlersAdd: self forBox: box.
    box borderWidth: 1.
    self state: #highlighted.
]

[ HighlightHandler state: #highlighted ]

HighlightHandler motionEvent :event :box :point
[
    (box globalBounds includesPoint: event position) ifTrue: [^self].
    event source eventHandlersRemove: self.
    box borderWidth: nil.
    self reset.
]

[ HighlightHandler state: #default ]

"----------------"

DragHandler : EventHandler ( target offset )

DragHandler withTarget: aBox
[
    self := self new.
    target := aBox.
]

DragHandler buttonDownEvent :event :box :point
[
    offset := target origin - event position.
    event source eventHandlersAdd: self forBox: box.
]

DragHandler motionEvent :event :box
[
    target moveTo: event position + offset.
]

DragHandler buttonUpEvent :event
[
    event source eventHandlersRemove: self.
]

"----------------"

ResizeHandler : DragHandler ()

ResizeHandler motionEvent :event :box
[
    super motionEvent :event :box.
    target resizeTo: box corner.
]

"----------------"

Box beHighlighted	[ self eventHandlersAt: #motionEvent put: (HighlightHandler new) ]
Box beDraggable		[ self beDraggable: self ]
Box beDraggable: aBox	[ self eventHandlersAt: #buttonDownEvent put: (DragHandler withTarget: aBox) ]
Box beResizable		[ self addFirst: ((Surface fromFile: 'resize16.bmp') asBox moveTo: width - 16 , (height + depth - 16);
					      eventHandlersAt: #buttonDownEvent put: (ResizeHandler withTarget: self)) ]

Box bigSep	[ self medSep; hLine; medSep ]
Box medSep	[ self addLast: (Box new height: 4) ]
Box smallSep	[ self addLast: (Box new height: 4) ]
Box hLine	[ self addLast: (Box new height: 1; backgroundColour: ColourWhite) ]
