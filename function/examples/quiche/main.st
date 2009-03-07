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
    | bg bd bw extent |
    aPoint := aPoint + origin.
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

IdentityDictionary from: start to: stop put: aValue
[
    start to: stop do: [:key | self at: key put: aValue].
]

TextActions := [ IdentityDictionary new
		     at:  $A - 64		put: #xBOL;
		     at:  $B - 64		put: #xLeft;
		     at:  $D - 64		put: #xDelete;
		     at:  $E - 64		put: #xEOL;
		     at:  $F - 64		put: #xRight;
		     at:  $H - 64		put: #xBackspace;
		     at:  $I - 64		put: #xTab;
		     at:  $J - 64		put: #xNewline;
		     at:  $M - 64		put: #xNewline;
		     at:  $N - 64		put: #xDown;
		     at:  $P - 64		put: #xUp;
		     at:  $S - 64		put: #xSlanted;
		     at:  $U - 64		put: #xUnderlined;
		     at:      127		put: #xBackspace;
		     at:   0xF700		put: #xUp;
		     at:   0xF701		put: #xDown;
		     at:   0xF702		put: #xLeft;
		     at:   0xF703		put: #xRight;
		     at:   0xF72c		put: #xPageUp;
		     at:   0xF72d		put: #xPageDown;
		     yourself ]

TextEditor : EventHandler ( dot mark )

Box beEditable
[
    ^self beEditable: self
]

Box beEditable: aBox
[
    | editor |
    self addFirst: ((Surface fromFile: 'caret16.bmp') asBox width: 0; height: 13; depth: 0).
    editor := TextEditor withDot: firstLink.
    aBox
	eventHandlersAt: #keyDownEvent	  put: editor;
	eventHandlersAt: #buttonDownEvent put: editor;
	propertiesAt:    #editor          put: editor
]

TextEditor withDot: aBox
[
    self := self new.
    dot := aBox.
]

Box isGlyph	[ ^surface and: [surface isGlyph] ]
Box isGraphic	[ ^surface and: [surface isGlyph not] ]

TextEditor buttonDownEvent :event :box :point
[
    | target |
    box := dot container container.
    (target := box lineAtPoint: point) ifFalse: [^nil].
    (target := target columnAtPoint: point) ifFalse: [^nil].
    self resetSelection.
    event source eventHandlersAdd: self forBox: box.
    target == dot
	ifFalse:
	   [dot container remove: dot; layoutChanged.
	    target container add: dot before: target; layoutChanged].
]

TextEditor motionEvent :event :box :point
[
    | target |
    box := dot container container.
    point := event position - box globalOrigin.
    (target := box lineAtPoint: point) ifFalse: [^nil].
    (target := target columnAtPoint: point) ifFalse: [^nil].
    target isGlyph ifFalse: [^nil].
    target == mark ifTrue: [^self].
    self selectTo: target.
]

TextEditor selectTo: newMark
[
    mark ifTrue: [self resetSelection].
    newMark == dot ifTrue: [^nil].
    mark := newMark.
    self selectionDo: [:box | (box backgroundColour: ColourGreen; container) layoutChanged].
]

TextEditor resetSelection
[
    mark ifFalse: [^self].
    self selectionDo: [:box | (box backgroundColour: nil; container) layoutChanged].
    mark := nil.
]

TextEditor selectionDo: unaryBlock
[
    | from to |
    mark ifFalse: [^nil].
    from := self selectionStart.
    to   := self selectionEnd.
    [ unaryBlock value: from.
      from ~~ to ]
	whileTrue:
	   [from := from nextInFlow].
]

TextEditor selectionStart
[
    | fwd rev |
    fwd := rev := dot.
    dot == mark ifTrue: [self error: 'the selection is empty'].
    [ fwd == mark ifTrue: [^dot nextInFlow].
      rev == mark ifTrue: [^mark].
      fwd ifTrue: [fwd := fwd nextInFlow].
      rev ifTrue: [rev := rev prevInFlow].
      (fwd or: [rev]) ]
	whileTrue.
    [StdErr nextPutAll: 'the mark cannot be found\n'].
    ^dot
]

TextEditor selectionEnd
[
    | fwd rev |
    fwd := rev := dot.
    [ fwd == mark ifTrue: [^mark].
      rev == mark ifTrue: [^dot prevInFlow].
      fwd ifTrue: [fwd := fwd nextInFlow].
      rev ifTrue: [rev := rev prevInFlow].
      (fwd or: [rev]) ]
	whileTrue.
    [StdErr nextPutAll: 'the mark cannot be found\n'].
    ^dot
]

TextEditor deleteSelection
[
    mark ifFalse: [^self].
    self deleteFrom: self selectionStart to: self selectionEnd.
    mark := nil.
]

TextEditor deleteFrom: first to: last
[
    [ | dead cont |
      dead := first.
      cont := dead container.
      first := dead nextInFlow.
      dead unlink.
      cont isEmpty ifTrue: [cont unlink].
      dead ~~ last ]
	whileTrue
]

TextEditor buttonUpEvent :event :box :point
[
    event source eventHandlersRemove: self
]

Box lineAtPoint: aPoint
[
    | first y minDy minBox |
    (first := self firstVisible) ifFalse: [^nil].
    aPoint := aPoint - origin.
    y := aPoint y.
    minDy  := (first origin y + (first height + first depth / 2) - y) abs.
    minBox := first.
    first to: self lastVisible do: [:box | (box origin y - y) abs < minDy ifTrue:  [minDy := ((minBox := box) origin y + (box height + box depth / 2) - y) abs]].
    ^minBox
]

Box columnAtPoint: aPoint
[
    | x minDx minBox |
    firstLink ifFalse: [^nil].
    aPoint := aPoint - origin.
    x := aPoint x.
    minBox := firstLink.
    minDx  := (minBox origin x - x) abs.
    self do: [:box | ((box origin x - x) abs < minDx and: [box width > 0])
			 ifTrue: [minDx := ((minBox := box) origin x - x) abs]].
    ^minBox
]

TextEditor keyDownEvent :event :box :point
[
    dot container layoutChanged.
    self perform: (TextActions at: event code ifAbsent: [event code > 0 ifTrue: [#xInsert] ifFalse: [#xIgnore]]) with: event.
    dot container layoutChanged.
    dot container container ensureVisible: dot.
]

TextEditor xBold	[ self applyStyle: Family boldStyleMask ]
TextEditor xSlanted	[ self applyStyle: Family italicStyleMask ]
TextEditor xUnderlined	[ self applyStyle: Family underlineStyleMask ]

TextEditor applyStyle: styleMask
[
    self selectionDo: [:box |
	box isGlyph
	    ifTrue:
	       [box surface: (box surface withStyle: (box surface style bitXor: styleMask)).
		box container layoutChanged]]
]

TextEditor applySize: size
[
    self selectionDo: [:box |
	box isGlyph
	    ifTrue:
	       [box surface: (box surface withSize: size).
		box container layoutChanged]]
]

TextEditor xIgnore	:event	[ (event code printStringBase: 16) putln ]
TextEditor xInsert	:event	[ self deleteSelection.  dot container add: (DefaultFont glyphAt: event code) asBox before: dot ]
TextEditor xTab		:event	[ self deleteSelection.  dot container add: ((DefaultFont glyphAt: 160) asBox width: (DefaultFont glyphAt: 32) width * 8) before: dot ]
TextEditor xNewline	:event	[ self deleteSelection.  dot container add: (DefaultFont glyphAt: 10) asBox before: dot ]

TextEditor xBackspace :event
[
    mark ifTrue: [^self deleteSelection].
    dot prevLink ifTrue: [^dot prevLink unlink].
    dot container prevLink ifFalse: [^self].
    dot container prevLink notEmpty ifTrue: [dot container prevLink removeLast; layoutChanged].
    [dot container prevLink and: [dot container prevLink isEmpty]] whileTrue: [dot container prevLink unlink].
]

TextEditor xDelete :event
[
    mark ifTrue: [^self deleteSelection].
    dot nextLink ifTrue: [^dot nextLink unlink].
    dot container nextLink ifFalse: [^self].
    dot container nextLink notEmpty ifTrue: [dot container nextLink removeFirst; layoutChanged].
    [dot container nextLink and: [dot container nextLink isEmpty]] whileTrue: [dot container nextLink unlink].
]

TextEditor xUp :event
[
    | cont |
    self resetSelection.
    cont := dot container.
    (cont prevLink and: [cont prevLink notEmpty])
	ifTrue:  [cont prevLink add: dot unlink before: (cont prevLink columnAtPoint: dot origin)]
	ifFalse: [cont addFirst: dot unlink].
]

"
TextEditor xUp :event
[
    | cont |
    self resetSelection.
    cont := dot container.
    (cont prevLink and: [cont prevLink notEmpty])
	ifTrue:  [cont prevLink add: dot unlink before: (cont prevLink columnAtPoint: dot origin)]
	ifFalse: [cont addFirst: dot unlink].
    dot container container ensureVisible: dot.
]
"

TextEditor xPageUp :event
[
    | cont |
    self resetSelection.
    cont := dot container container firstVisible.
    16 timesRepeat: [cont prevLink ifTrue: [cont := cont prevLink]].
    cont notEmpty
	ifTrue:  [cont add: dot unlink before: (cont columnAtPoint: dot origin)]
	ifFalse: [cont addFirst: dot unlink].
    dot container container firstVisible: cont; layoutChanged.
]

TextEditor xDown :event
[
    | cont |
    self resetSelection.
    cont := dot container.
    (cont nextLink and: [cont nextLink notEmpty])
	ifTrue:  [cont nextLink add: dot unlink before: (cont nextLink columnAtPoint: dot origin)]
	ifFalse: [cont addLast: dot unlink].
]

TextEditor xPageDown :event
[
    | cont |
    "16 timesRepeat: [self xDown :event]."
    self resetSelection.
    cont := dot container container lastVisible.
    cont ifTrue: [cont := cont nextLink].
    cont ifFalse: [^nil].
    cont addFirst: dot unlink.
    dot container container firstVisible: cont; lastVisible: nil; layoutChanged.
]

TextEditor xLeft :event
[
    | prev |
    prev := mark ifTrue: [self selectionStart] ifFalse: [dot prevInFlow].
    self resetSelection.
    prev ifTrue: [dot unlink linkBefore: prev].
]

TextEditor xRight :event
[
    | next |
    next := mark ifTrue: [self selectionEnd] ifFalse: [dot nextInFlow].
    self resetSelection.
    next ifTrue: [dot unlink linkAfter: next].
]

TextEditor xBOL :event
[
    | prev |
    self resetSelection.
    [prev := dot prevLink] whileTrue: [dot unlink linkBefore: prev].
]

TextEditor xEOL :event
[
    | next |
    self resetSelection.
    [(next := dot nextLink) and: [next nextLink]] whileTrue: [dot unlink linkAfter: next].
]

TextEditor save: text as: name
[
    name := name asString.
    (name endsWith: '.doq') ifFalse: [name := name , '.doq'].
    (File create: name) write: text asDoqString; close.
    StdOut nextPutAll: 'saved: '; nextPutAll: name; cr.
]

TextEditor oldLoad: text as: name
[
    | file string |
    [dot container prevLink] whileTrue: [dot container prevLink unlink].
    [dot container nextLink] whileTrue: [dot container nextLink unlink].
    [dot prevLink] whileTrue: [dot prevLink unlink].
    [dot nextLink] whileTrue: [dot nextLink unlink].
    dot container layoutChanged.
    name := name asString.
    (name endsWith: '.doq') ifFalse: [name := name , '.doq'].
    file := File openIfPresent: name.
    file ifFalse: [^StdErr nextPutAll: 'cannot open: '; nextPutAll: name; cr].
    string := file contents.
    file close.
    (DoqReadStream on: string) appendContentsTo: dot container.
    StdOut nextPutAll: 'loaded: '; nextPutAll: name; cr.
]

TextEditor load: text as: name
[
    | file string |
    self resetSelection.
    name := name asString.
    (name endsWith: '.doq') ifFalse: [name := name , '.doq'].
    file := File openIfPresent: name.
    file ifFalse: [^StdErr nextPutAll: 'cannot open: '; nextPutAll: name; cr].
    string := file contents.
    file close.
    text removeFirst; addFirst: (string asParagraph: text); layoutChanged; layOut.
    StdOut nextPutAll: 'loaded: '; nextPutAll: name; cr.
    ^text propertiesAt: #editor
]

TextEditor loadBMP: text as: name
[
    | surface |
    name := name asString.
    ((name endsWith: '.bmp') or: [name endsWith: '.BMP']) ifFalse: [name := name , '.bmp'].
    surface := Surface fromFile: name.
    surface ifFalse: [^nil].
    (surface asBox propertiesAt: #bmpName put: name; yourself) linkBefore: dot.
    dot container layoutChanged.
]

"----------------"

{ import: PostScriptStream }

TextEditor print: text as: name
[
    | stream |
    stream := PostScriptStream on: (String new: 1024).
    text do: [:box | box printTextOn: stream].
    name := name asString.
    (name endsWith: '.ps') ifFalse: [name := name , '.ps'].
    (File create: name) write: stream contents; close.
]

SBox printTextOn: aStream
[
    | p y |
    y := 0.
    aStream beginDocument; beginPage: (p := 1).
    self do: [:box |
	box layOutIn: self.
	y := y + (box printTextLineOn: aStream).
	(box nextLink and: [y + box nextLink totalHeight > 684])
	    ifTrue:
	       [aStream endPage: p.
		StdOut nextPutAll: 'PAGE '; print: p; cr.
		aStream beginPage: (p := p + 1).
		y := 0]].
    aStream endPage: p; endDocument.
    StdOut nextPutAll: 'PAGE '; print: p; cr.
]

Box printTextLineOn: aStream
[
    | h d |
    h := self inject: 0 into: [:ht :box | ht max: box height].
    d := self inject: 0 into: [:dp :box | dp max: box depth].
    aStream origin: 0,h.
    self do: [:box | box printTextElementOn: aStream].
    aStream origin: 0,d.
    ^h + d
]

Box printTextElementOn: aStream
[
    (prevLink not or: [prevLink isGlue or: [prevLink isTab or: [prevLink isGraphic]]])
	ifTrue: [aStream moveToX: origin x].
    width > 0 ifTrue: [surface printTextElementOn: aStream].
]

Surface printTextElementOn: aStream	[ aStream nextPutSurface: self ]

Glyph printTextElementOn: aStream
[
    (unicode between: 32 and: 126) ifFalse: [^nil].
    aStream ensureFont: font; nextPutUnicode: unicode.
]

"----------------"

Box asString
[
    | stream |
    stream := WriteStream on: (String new: 64).
    self asStringOn: stream.
    ^stream contents.
]

Box asStringOn: aStream
[
    self isGlyph ifTrue: [aStream nextPut: surface unicode].
    self do: [:box | box asStringOn: aStream].
]

TextEditor printInfo
[
    dot nextLink println
]

"----------------------------------------------------------------"

{ import: UTF8Stream }

DoqWriteStream : UTF8WriteStream ( currentFont )

DoqWriteStream nextPutUnicode: aCode
[
    aCode == 160 ifTrue: [aCode := 9].
    self nextPut: aCode.
    aCode == $\\ ifTrue: [self nextPut: aCode].
]

DoqWriteStream ensureFont: aFont	[ currentFont == aFont ifFalse: [self nextPutFont: (currentFont := aFont)] ]

DoqWriteStream nextPutFont: aFont
[
    self nextPutAll: '\\f'; nextPutArg: aFont name; nextPutArg: aFont style printString; nextPutArg: aFont pointSize printString
]

DoqWriteStream nextPutBMP: name		[ self nextPutAll: '\\g'; nextPutArg: name ]
DoqWriteStream nextPutArg: aString	[ self nextPutAll: aString; nextPut: $\\ ]

Box asDoqString
[
    | stream |
    stream := DoqWriteStream on: (String new: 64).
    self asDoqStringOn: stream.
    ^stream contents.
]

Box asDoqStringOn: aStream
[
    | name |
    surface
	ifTrue:
	   [(name := self propertiesAt: #bmpName)
		ifTrue:  [aStream nextPutBMP: name]
		ifFalse: [surface asDoqStringOn: aStream]].
    self do: [:box | box asDoqStringOn: aStream].
]

Glyph asDoqStringOn: aStream
[
    aStream ensureFont: font.
    aStream nextPutUnicode: unicode.
]

Surface asDoqStringOn: aStream
[
    StdOut nextPutAll: 'unknown surface not written\n'
]

TitleFont := [ #Arial roman @ 16 ]

Box withTitle: titleString
[
    | frame |
    ^(frame := Box new vBox)
	addLast: ((titleString asText: TitleFont) hBox backgroundColour: ColourWhite; borderWidth: 2; beDraggable: frame);
	addLast: self;
	addLast: ((Box withExtent: 10,10) backgroundColour: ColourBlue)
]

"----------------"

DoqReadStream : UTF8ReadStream ( currentFont )

DoqReadStream on: aString
[
    self := super on: aString.
    currentFont := DefaultFont.
]

DoqReadStream appendContentsTo: aList	[ [self atEnd] whileFalse: [self appendNextTo: aList] ]

DoqReadStream appendNextTo: aList
[
    | c |
    c := super next.
    c := c == $\\ ifTrue: [self escape] ifFalse: [self character: c].
    c ifTrue: [aList addLast: c].
]

DoqReadStream character: c
[
    c == 9 ifTrue: [c := 160].
    c == 160 ifTrue: [^(currentFont glyphAt: c) asBox width: (currentFont glyphAt: 32) width * 8].
    ^(currentFont glyphAt: c) asBox
]

DoqReadStream escape
[
    | c |
    ((c := super next) not or: [c == $\\]) ifTrue: [^self character: $\\].
    ^self perform: (String with: c) asSymbol
]

DoqReadStream nextArgument
[
    | c argument |
    argument := WriteStream on: (String new: 16).
    [self atEnd not and: [(c := super next) ~~ $\\]]  whileTrue: [argument nextPut: c].
    ^argument contents
]

DoqReadStream f
[
    | name style size |
    name := self nextArgument.
    style := Integer fromString: self nextArgument.
    size := Integer fromString: self nextArgument.
    currentFont := ((Family withName: name asSymbol) withStyle: style) withSize: size.
    ^nil
]

DoqReadStream g
[
    | name sfc |
    name := self nextArgument.
    name println.
    sfc := Surface fromFile: name.
    ^sfc ifTrue: [sfc asBox propertiesAt: #bmpName put: name; yourself]
]

SequenceableCollection asText	[ ^self asText: DefaultFont ]

SequenceableCollection asText: font
[
    | box |
    box := Box new hBox.
    (DoqReadStream on: self) appendContentsTo: box.
    ^box
]

SequenceableCollection asParagraph	[ ^self asParagraph: nil ]

SequenceableCollection asParagraph: frame
[
    | v h |
    (v := SBox new vBox) addLast: (h := Box new tBox).
    (DoqReadStream on: self) appendContentsTo: h.
    h beEditable: (frame ifNil: [v]).
    ^v
]

Box beButton: aBlock
[
    self
	eventHandlersAt: #buttonDownEvent put: (ButtonHandler withAction: aBlock);
	backgroundColour: (Colour fromHex: 0xE7EBCF);
	borderColour: ColourGreen;
	beHighlighted
]

{ input: SampleText.st }

Box bigSep	[ self medSep; hLine; medSep ]
Box medSep	[ self addLast: (Box new height: 4) ]
Box smallSep	[ self addLast: (Box new height: 4) ]
Box hLine	[ self addLast: (Box new height: 1; backgroundColour: ColourWhite) ]

[
    | window w h frame face text name editor |

    (OS argumentAt: 1) = '-landscape'
	ifTrue:  [h := 612.  w := 792]
	ifFalse: [w := 612.  h := 792].

    face := #Times roman @ 14.
    window := Window withExtent: (w + 56) , (h - 6).
    window addFirst: ((Box withBounds: (52,26 extent: (w) , (h - 36)))
			  backgroundColour: ColourWhite;
			  addFirst: ((text := Box withBounds: (36,36 extent: (w - 72) , (h - 108)))
					 backgroundColour: ColourWhite;
					 borderWidth: 10;
					 addLast: (SampleText asParagraph: text))).
    editor := text propertiesAt: #editor.
    window
	addLast: ((frame := Box new) width: (w + 48); height: 16; depth: 2; backgroundColour: ColourWhite; moveTo: 4, 4;
		      addLast: ((name := 'file name' asText) beEditable: frame));
	addLast: (Box new vBox width: 1; moveTo: 4, 26;
		      addLast: (' load '   asText beButton: [editor := editor load: text as: name]);
		      addLast: (' save '   asText beButton: [editor save: text as: name]);
		      smallSep;
		      addLast: (' image '  asText beButton: [editor loadBMP: text as: name]);
		      smallSep;
		      addLast: (' print '  asText beButton: [editor print: text as: name]);
		      bigSep;
		      addLast: ('   7pt '  asText beButton: [editor applySize:  7]);
		      addLast: (' 10pt '   asText beButton: [editor applySize: 10]);
		      addLast: (' 14pt '   asText beButton: [editor applySize: 14]);
		      addLast: (' 20pt '   asText beButton: [editor applySize: 20]);
		      addLast: (' 28pt '   asText beButton: [editor applySize: 28]);
		      addLast: (' 40pt '   asText beButton: [editor applySize: 40]);
		      smallSep;
		      addLast: (' bold '   asText beButton: [editor xBold]);
		      addLast: (' italic ' asText beButton: [editor xSlanted]);
		      bigSep;
		      addLast: (' info '   asText beButton: [editor printInfo]);
		      bigSep;
		      addLast: (' quit '   asText beButton: [OS exit: 0]);
		      yourself);
	layOut;
	draw;
	mainLoop.
]

{ include <SDL/SDL_main.h> }
