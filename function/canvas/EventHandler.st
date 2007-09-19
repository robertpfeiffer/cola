" EventHandler.st -- modal interpretation of events

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

  Last edited: 2007-09-18 20:19:08 by piumarta on emilia
"

{ import: Object }

EventHandler : Object ( previous world )

EventHandler withWorld: aWorld
[
    self := super new.
    world := aWorld.
]

EventHandler previous: anEventHandler	[  previous := anEventHandler ]
EventHandler previous			[ ^previous ]

EventHandler activate	[ world pushEventHandler: self ]
EventHandler deactivate	[ world popEventHandler: self ]

EventHandler handleEvent: anEvent
[
    ^self perform: anEvent name with: anEvent
]

EventHandler pointerMotionEvent :anEvent	[ ^world handleEvent: anEvent ]
EventHandler pointerDownEvent :anEvent		[ ^world handleEvent: anEvent ]
EventHandler pointerUpEvent :anEvent		[ ^world handleEvent: anEvent ]
EventHandler keyDownEvent :anEvent		[ ^world handleEvent: anEvent ]
EventHandler keyRepeatEvent :anEvent		[ ^world handleEvent: anEvent ]
EventHandler keyUpEvent :anEvent		[ ^world handleEvent: anEvent ]
EventHandler damageEvent :anEvent		[ ^world handleEvent: anEvent ]

"----------------------------------------------------------------"

FocusedEventHandler : EventHandler ( focus )

FocusedEventHandler withWorld: aWorld focus: aView
[
    self := super withWorld: aWorld.
    focus := aView
]

FocusedEventHandler handleEvent: anEvent
[
    | handler |
    anEvent localPosition: (focus globalToLocal: anEvent position).
    super handleEvent: anEvent.  (handler := anEvent handled) ifTrue: [^handler].
    focus handleEvent: anEvent.  (handler := anEvent handled) ifTrue: [^handler].
    ^anEvent handled: self
]

"----------------"

DraggingEventHandler : FocusedEventHandler ( reference )

DraggingEventHandler withWorld: aWorld focus: aView reference: aPoint
[
    self := super withWorld: aWorld focus: aView.
    reference := aPoint
]

DraggingEventHandler pointerUpEvent :anEvent
[
    self deactivate.
    ^anEvent handled: self
]

DraggingEventHandler pointerMotionEvent :anEvent
[
    | newRef |
    focus damaged.
    focus translateBy: (newRef := anEvent position) - reference.
    focus damaged.
    reference := newRef.
    ^anEvent handled: self
]

EventHandler beginDragging: aView from: anEvent
[
    (DraggingEventHandler withWorld: world focus: aView reference: anEvent position) activate.
    ^anEvent handled: self
]
