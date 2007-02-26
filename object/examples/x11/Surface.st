{ import: st80 }
{ import: xwin }

{ import: Event }


X11EventMap : IdentityDictionary ()
[
    (X11EventMap := X11EventMap new)
	at: #KeyPress		put: #keyPressEvent:;
	at: #KeyRelease		put: #keyReleaseEvent:;
	at: #ButtonPress	put: #buttonPressEvent:;
	at: #ButtonRelease	put: #buttonReleaseEvent:;
	at: #Expose		put: #damageEvent:
]


Display : X11Display ()
[
    Display := Display open.
]

Display createWindow: bounds
[
    | win |
    win := self createWindow: bounds borderWidth: 0 border: 0 background: Display whitePixel.
    self changeWindowAttributes: win
	 mask: X11WindowAttributes cwEventMask
	 attributes: (X11WindowAttributes new eventMask: (X11Event anyEventMask bitXor: X11Event resizeRedirectMask)).
    self mapWindow: win.
    ^win
]


Surface : X11GC ()


Surface withBounds: bounds
[
    ^self withDrawable: (Display createWindow: bounds)
]

Surface keysymToCharacter: keysym
[
    | page code |
    page := keysym bitShift: -8.
    code := keysym bitAnd: 0xff.
    (page == 0x00) ifTrue: [^Character value: code].
    (page == 0xff and: [code < 0x20]) ifTrue: [^Character value: code].
    (page == 0xff and: [code = 0xff]) ifTrue: [^Character value: 0x7f].
    ^nil
]

Surface nextEvent
[
    | constructor event |
    constructor := nil.
    [constructor isNil]
	whileTrue:
	   [event := win nextEvent.
	    constructor := X11EventMap at: event name ifAbsent: []].
    ^self perform: constructor with: event
]

Surface keyPressEvent: event
[
    ^KeyPressEvent
	withPosition:	event xkeyPosition
	key:		(self keysymToCharacter: (Display keycodeToKeysym: event))
	modifiers:	event xkeyState
]

Surface keyReleaseEvent: event
[
    ^KeyReleaseEvent
	withPosition:	event xkeyPosition
	key:		(self keysymToCharacter: (Display keycodeToKeysym: event))
	modifiers:	event xkeyState
]

Surface buttonPressEvent: event
[
    ^ButtonPressEvent
	withPosition:	event xbuttonPosition
	button:		event xbuttonButton
	modifiers:	event xbuttonState
]

Surface buttonReleaseEvent: event
[
    ^ButtonReleaseEvent
	withPosition:	event xbuttonPosition
	button:		event xbuttonButton
	modifiers:	event xbuttonState
]

Surface damageEvent: event
[
    ^DamageEvent
	withPosition:	event xexposePosition
	extent:		event xexposeExtent
]

Surface foreground: pixel	[ self setForeground: pixel ]
Surface background: pixel	[ self setBackground: pixel ]

Surface flush			[ win display flush; sync ]

Surface close			[ win close ]
