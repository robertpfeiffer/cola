" Views-world.st -- support for a windowful, windowful world

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

  Last edited: 2007-11-12 15:32:06 by piumarta on emilia.local
"

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
	ctx rectangle: aRectangle; setSource: Colour white; fill.  window swapBuffers; flush.  OS sleep: 0.020000.
	ctx rectangle: aRectangle; setSource: Colour blue;  fill.  window swapBuffers; flush.  OS sleep: 0.020000.
    ].
    "
    damage := damage ifTrue: [damage union: aRectangle] ifFalse: [aRectangle].
    "
    2 timesRepeat: [
	ctx rectangle: damage; setSource: Colour white; fill.  window swapBuffers; flush.  OS sleep: 0.020000.
	ctx rectangle: damage; setSource: Colour green; fill.  window swapBuffers; flush.  OS sleep: 0.020000.
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
	ctx rectangle: clipRectangle; setSource: Colour white; fill.  window swapBuffers; sync.  OS sleep: 0.020000.
	ctx rectangle: clipRectangle; setSource: Colour red;   fill.  window swapBuffers; sync.  OS sleep: 0.020000.
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
