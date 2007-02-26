{ import: st80 }

{ import: Event }
{ import: Surface }


Window : Object ( bounds preHandlers postHandlers foreground background contents )

Window foreground: aColor	[ foreground := aColor ]
Window background: aColor	[ background := aColor ]
Window bounds			[ ^bounds ]

Window withBounds: aRectangle
[
    self := self new.
    bounds := aRectangle.
]

Window withExtent: aPoint	[ ^self withBounds: (Point zero corner: aPoint) ]

Window add: subWindow
[
    contents isNil ifTrue: [contents := OrderedCollection new].
    contents add: subWindow.
    subWindow parent: self.
]

Window redisplay	[ self topWindow redisplay: bounds ]

Window redisplay: aRectangle on: aSurface
[
    (bounds intersects: aRectangle)
	ifTrue:
	   [self displayBackgroundOn: aSurface.
	    contents notNil ifTrue: [contents do: [:w | w redisplay: aRectangle on: aSurface]].
	    self displayOn: aSurface]
]

Window displayBackgroundOn: aSurface
[
    background notNil ifTrue: [aSurface foreground: background; fillRectangle: bounds]
]

Window displayOn: aSurface	[]

Window pre: event do: aBlock
[
    preHandlers isNil ifTrue: [preHandlers := IdentityDictionary new].
    preHandlers at: event family put: aBlock
]

Window post: event do: aBlock
[
    postHandlers isNil ifTrue: [postHandlers := IdentityDictionary new].
    postHandlers at: event family put: aBlock
]

Window handleKeyPressEvent:      event at: aPoint	[ ^self handleGenericEvent: event at: aPoint ]
Window handleKeyReleaseEvent:    event at: aPoint	[ ^self handleGenericEvent: event at: aPoint ]
Window handleButtonPressEvent:   event at: aPoint	[ ^self handleGenericEvent: event at: aPoint ]
Window handleButtonReleaseEvent: event at: aPoint	[ ^self handleGenericEvent: event at: aPoint ]

Window handleGenericEvent: event at: aPoint
[
    (bounds containsPoint: aPoint) ifFalse: [^false].
    (self handleEvent: event at: aPoint in: preHandlers) ifTrue: [^true].
    contents isNil ifTrue: [^false].
    ^(contents detect: [:w | event dispatchTo: w at: aPoint] ifNone: []) notNil
	or: [self handleEvent: event at: aPoint in: postHandlers]
]

Window handleEvent: anEvent at: aPoint in: handlers
[
    | aBlock |
    handlers isNil ifTrue: [^false].
    aBlock := handlers at: anEvent family ifAbsent: [].
    aBlock isNil ifTrue: [^false].
    aBlock value: self value: anEvent.
    ^true.
]

Window do: aBlock
[
    aBlock value: self.
    self contentsDo: aBlock.
]

Window contentsDo: aBlock
[
    contents notNil ifTrue: [contents do: [:w | w do: aBlock]]
]


SubWindow : Window ( parent )

SubWindow parent: aWindow	[  parent := aWindow ]
SubWindow topWindow		[ ^parent topWindow ]
SubWindow exitMainLoop		[  parent exitMainLoop ]
SubWindow close			[  parent remove: self; redisplay: bounds ]


TopWindow : Window ( surface running )

TopWindow initialize
[
    super initialize.
    self pre: DamageEvent do: [:w :e | w redisplay: (e position extent: e extent) ]
]

TopWindow surface	[ ^surface ]

TopWindow topWindow	[ ^self ]

TopWindow open
[
    surface := Surface withBounds: bounds.
    bounds := Point zero corner: bounds extent.
]

TopWindow close		[ surface close ]

TopWindow redisplay: aRectangle
[
    self redisplay: aRectangle on: surface
]

TopWindow mainLoop
[
    running := true.
    [running] whileTrue: [self dispatchNextEvent].
]

TopWindow exitMainLoop	[ running := false ]

TopWindow dispatchNextEvent		[ self dispatchEvent: surface nextEvent ]
TopWindow dispatchEvent: anEvent	[ anEvent dispatchTo: self at: anEvent position ]

TopWindow handleDamageEvent: event at: aPoint
[
    self redisplay: (aPoint extent: event extent)
]


Box : SubWindow ()

Box displayOn: aSurface
[
    foreground notNil ifTrue: [aSurface foreground: foreground; fillRectangle: bounds].
]


Text : SubWindow ( string )

Text string: aString
[
    string := aString
]

Text displayOn: aSurface
[
    foreground notNil ifTrue: [aSurface foreground: foreground; drawString: string at: bounds origin]
]


Paragraph : SubWindow ( lines )

Paragraph initialize
[
    super initialize.
    lines := OrderedCollection new.
    lines addLast: String new.
]

Paragraph addLine: aString
[
    lines addFirst: aString
]

Paragraph append: aCharacter
[
    aCharacter = $\r	ifTrue: [^self newLine; redisplay].
    aCharacter = $\b	ifTrue: [^self deleteCharacter; redisplay].
    aCharacter = $\177	ifTrue: [^self deleteCharacter; redisplay].
    lines addLast: (lines removeLast, aCharacter asString).
    self redisplay.
]

Paragraph newLine
[
    lines addLast: String new.
    lines size > (bounds height // 16) ifTrue: [lines removeFirst].
]

Paragraph deleteCharacter
[
    | line |
    lines last isEmpty ifTrue: [^self deleteLine].
    line := lines removeLast.
    lines addLast: (line copyFrom: 1 to: line size - 1).
]

Paragraph deleteLine
[
    lines size > 1 ifTrue: [lines removeLast]
]

Paragraph displayBackgroundOn: aSurface	[]

Paragraph displayOn: aSurface
[
    background notNil
	ifTrue:
	   [aSurface foreground: background; fillRectangle: bounds].
    foreground notNil
	ifTrue:
	   [| x y |
	    aSurface foreground: foreground.
	    x := bounds left + 8.
	    y := bounds top + 16.
	    lines do: [:line |
		aSurface drawString: line at: x@y.
		y := y + 16]].
]


[
    | win |
    win := TopWindow withBounds: (100@100 extent: 400@400).
"
    win add: ((sub := Paragraph withBounds: (0@0 extent: 200@200))
		  on: KeyPressEvent
		  do: [:w :e | | ascii | (ascii := e key) > 0 ifTrue: [para append: (Character value: ascii)]]).
"
    win
	add: ((Text withBounds: (100@40 extent: 200@20))
		  foreground: 0x0000ff;
		  string: 'Click the green box for a thrill.');
	add: ((Text withBounds: (100@60 extent: 200@20))
		  foreground: 0x0000ff;
		  string: 'Click the background to exit.');
	add: ((Box  withBounds: (100@100 extent: 50@50))
		  foreground: 0x00ff00;
		  pre: ButtonPressEvent   do: [:w :e | w foreground: 0xff0000; redisplay];
		  pre: ButtonReleaseEvent do: [:w :e | w foreground: 0x00ff00; redisplay]);
	add: ((Paragraph withBounds: (10@200 extent: 380@190))
		  addLine: 'You can type stuff into this box.';
		  background: 0x303030;
		  foreground: 0xffa500;
		  pre: KeyPressEvent do: [:w :e | e key notNil ifTrue: [w append: e key]]);
	post: ButtonReleaseEvent do: [:w :e | w exitMainLoop];
	open;
	mainLoop;
	close.
]
