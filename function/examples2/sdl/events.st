{ import: Event }
{ import: Box }
{ import: Text }

EventHandler : Link ()

EventHandler performEvent: anEvent for: aBox
[
    anEvent handler: aBox.
    ^self perform: anEvent name with: anEvent
]

EventHandler keyDown	:anEvent	[ ^nil ]
EventHandler keyUp	:anEvent	[ ^nil ]
EventHandler motion	:anEvent	[ ^nil ]
EventHandler resize	:anEvent	[ ^nil ]
EventHandler buttonDown	:anEvent	[ ^nil ]
EventHandler buttonUp	:anEvent	[ ^nil ]

EventHandler unlink	[ super unlink   deactivate ]
EventHandler unlinked	[ super unlinked deactivate ]

EventHandler deactivate	[]

Box eventHandler: eh	[  self propertyAt: #eventHandler put: eh ]
Box eventHandler	[ ^self propertyAt: #eventHandler ]

"----------------------------------------------------------------"

Window nextEvent		[ ^surface nextEvent ]
Window dispatchEvent: anEvent	[ hand dispatchEvent: anEvent ]

Hand dispatchEvent: anEvent
[
    | handler |
    self position: anEvent position - HandOffset.
    anEvent hand: self.
    anEvent window: window.
    anEvent target: ((window subBoxUnder: anEvent position) ifNil: [window]).
    eventHandlers do: [:evh | (evh performEvent: anEvent for: self) ifTrue: [^self]].
    ^anEvent target handleEvent: anEvent
]

Box handleEvent: anEvent
[
    | evh |
    (evh := self propertyAt: anEvent name ifAbsent: [self eventHandler])
	ifTrue: [(evh performEvent: anEvent for: self) ifTrue: [^self]].
    ^myList handleEvent: anEvent
]

BoxList handleEvent: anEvent	[ ^myBox handleEvent: anEvent ]

Window handleEvent: anEvent
[
    | evh |
    ^(evh := self propertyAt: anEvent name ifAbsent: [self eventHandler])
	ifTrue: [evh performEvent: anEvent for: self].
]

"----------------------------------------------------------------"

Hand addEventHandler: eh	[ eventHandlers addFirst: eh ]
Hand removeEventHandler: eh	[ eventHandlers remove: eh.  ^nil ]
Hand removeEventHandlers: eh	[ [eventHandlers removeFirst == eh] whileFalse.  ^nil ]

Box embedIn: aBox
[
    position := self globalPosition - aBox globalPosition.
    aBox addFront: self removeFromList.
]

BoxList embedIn: aBox		[ [self notEmpty] whileTrue: [self back embedIn: aBox] ]

"----------------------------------------------------------------"

Box printOn: aStream
[
    super printOn: aStream.
    aStream nextPut: $<; print: self identityHash; nextPut: $>.
    myList ifTrue: [aStream nextPut: $(; print: self globalPosition; space; print: self globalPosition + extent; nextPut: $)].
]

"----------------------------------------------------------------"

ButtonTextColor		:= [ ColorBlack     ]
ButtonOffColor		:= [ Color gray: 90 ]
ButtonStandbyColor	:= [ ColorGreen     ]
ButtonOnColor		:= [ Color gray: 80 ]

ButtonHandler : EventHandler ( block button )

ButtonHandler withAction: aBlock
[
    self := super new.
    block := aBlock.
]

ButtonHandler activate: anEvent
[
    (button := anEvent handler)
	border:     ButtonStandbyColor;
	background: (anEvent leftButtonDown ifTrue: [ButtonOnColor] ifFalse: [ButtonOffColor]).
    anEvent hand addEventHandler: self.
]

ButtonHandler deactivate	"sent implicitly when handler removed from hand"
[
    button background: ButtonOffColor; border: nil.
    button := nil
]

ButtonHandler motion :anEvent
[
    button ifFalse: [^self activate: anEvent].
    (button includesGlobalPoint: anEvent position) ifFalse: [^anEvent hand removeEventHandler: self]
]

ButtonHandler buttonDown :anEvent
[
    button ifFalse: [self activate: anEvent].
    button background: ButtonOnColor.
]

ButtonHandler buttonUp :anEvent
[
    block value: anEvent.
    button background: ButtonOffColor.
    ^nil "pass event to enclosing handler"
]

Box newButton: labelString action: actionBlock
[
    | label handler |
    label := labelString asText foreground: ButtonTextColor; position: (2,2).
    handler := ButtonHandler withAction: actionBlock.
    ^Box new
	add:        label;
	extent:     label extent + (4,4);
	background: ButtonOffColor;
	motion:     handler
]

"----------------"

MenuHandler : EventHandler ( menu position )

MenuHandler new
[
    ^self withMenu: (Box new extent: 4,4)
]

MenuHandler withMenu: aBox
[
    self := super new.
    menu := aBox.
]

MenuHandler label: labelString action: actionBlock
[
    menu add: (Box newButton: labelString action: actionBlock); beMenu
]

MenuHandler buttonDown :anEvent
[
    position
	ifFalse:
	   [menu position: (position := anEvent position).
	    anEvent handler addFront: menu.
	    anEvent hand addEventHandler: self].
]

MenuHandler buttonUp :anEvent
[
    anEvent position = position
	ifFalse:
	   [anEvent hand removeEventHandlers: self.
	    menu removeFromList.
	    position := nil].
]

Box beMenu
[
    | x y wh h |
    wh := PointZero.
    self do: [:box | wh := wh max: box extent].
    x := y := 2.
    h := wh y.
    self do: [:box |
	box position: x,y; extent: wh.
	y := y + h].
    self extent: wh + (4,4).
]
