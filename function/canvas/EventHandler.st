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
