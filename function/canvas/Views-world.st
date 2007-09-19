{ import: HostWindow }
{ import: Views }
{ import: EventHandler }

WorldView : View ( window eventHandler damage stepper )

WorldView new
[
    self := super new.
    eventHandler := EventHandler withWorld: self.
]

WorldView window: aWindow	[  window := aWindow ]
WorldView window		[ ^window ]

WorldView bounds		[ ^Rectangle origin: 0,0 corner: window extent ]

WorldView current		[ ^self ]

WorldView pathOn: aCanvas	[ ^aCanvas rectangle: (0,0 corner: window extent) ]

WorldView layoutChanged: source	[]

WorldView damaged: aRectangle
[
    | ctx |
    aRectangle := aRectangle expanded intersect: window bounds.
    "
    ctx := window newPainter.
    2 timesRepeat: [
	ctx rectangle: aRectangle; setSource: Colour white; fill.  window swapBuffers; flush.  OS usleep: 20000.
	ctx rectangle: aRectangle; setSource: Colour blue;  fill.  window swapBuffers; flush.  OS usleep: 20000.
    ].
    "
    damage := damage ifTrue: [damage union: aRectangle] ifFalse: [aRectangle].
    "
    2 timesRepeat: [
	ctx rectangle: damage; setSource: Colour white; fill.  window swapBuffers; flush.  OS usleep: 20000.
	ctx rectangle: damage; setSource: Colour green; fill.  window swapBuffers; flush.  OS usleep: 20000.
    ].
    ctx destroy.
    "
]

WorldView forceToScreen
[
    self forceToScreen: window bounds.
    damage := nil.
]

WorldView forceDamageToScreen
[
    damage
	ifTrue:
	   [self forceToScreen: (damage expanded outsetBy: (1,1)).
	    damage := nil].
]

WorldView forceToScreen: clipRectangle
[
    | ctx |
    ctx := window newPainter.
    clipRectangle := clipRectangle expanded.
    (clipRectangle contains: window bounds)
	ifFalse:
	    [ctx setClipRectangle: clipRectangle].
    "
    2 timesRepeat: [
	ctx rectangle: clipRectangle; setSource: Colour white; fill.  window swapBuffers; sync.  OS usleep: 20000.
	ctx rectangle: clipRectangle; setSource: Colour red;   fill.  window swapBuffers; sync.  OS usleep: 20000.
    ].
    "
    self drawOn: ctx in: (clipRectangle outsetBy: (1,1)).
    ctx destroy.
    window swapBuffers: clipRectangle.
]

WorldView open
[
    self open: 1024,768
]

WorldView open: extent
[
    window := HostWindow withExtent: extent.
    self forceToScreen.
]

WorldView restart	[ WorldRestart value ]

WorldView run
[
    [self current mainLoop.
     StdOut nextPutAll: '\nrestart\n']
	repeat
]

WorldRestart := [ nil ]

WorldView mainLoop
[
    WorldRestart := [^nil].
    [self current dispatchEvent: self current waitEvent; forceDamageToScreen] repeat.
]

WorldView waitEvent
[
    ^stepper
	ifTrue:  [self current step.  window pollEvent]
	ifFalse: [window waitEvent]
]
    
WorldView dispatchEvent: anEvent
[
    | view |
    anEvent ifFalse: [^self].
    anEvent handler: eventHandler.
    eventHandler handleEvent: anEvent.
]

WorldView pushEventHandler: anEventHandler
[
    anEventHandler previous: eventHandler.
    eventHandler := anEventHandler.
]

WorldView popEventHandler: anEventHandler
[
    eventHandler == anEventHandler ifFalse: [self error: 'non-LIFO event handlers'].
    eventHandler := eventHandler previous.
]

WorldView globalToLocal: aPointOrShape
[
    ^aPointOrShape
]

"----------------------------------------------------------------"

ComposableView withTitle: titleString
[
    | inset nameView titleView closeBox titleBounds top title |
    inset := 5.
    nameView := titleString stringView bold.
    titleView := nameView transformView translation: 15,0.
    titleView := titleView transformView.
    closeBox := titleView add: ((Pair zero corner: 10,10) shapedView fillColour: Colour red).
    (top := self transformView)
	add: (titleView transformView translation: self bounds topLeft + inset asPair);
	add: (title := (self bounds topLeft corner: self bounds topRight + (0,(inset * 2 + titleView bounds top)))
		  shapedView fillColour: Colour grey lighter lighter).
    title
	propertyAt: #pointerDownEvent
	put: [:v :event | event handler beginDragging: top from: event].
    closeBox
	propertyAt: #pointerDownEvent
	put: [:v :e | e handled: v].
    closeBox
	propertyAt: #pointerUpEvent
	put: [:v :e | top close].
    ^top
]

ComposableView close		[ container close: self ]

CompositeView close: aView	[ containers first close: aView ]
ComposableView close: aView	[ container close: self ]

WorldView close: aView		[ self remove: aView; forceToScreen ]
