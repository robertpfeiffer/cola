{ import: Model }

Button : Model ( state group onBlock offBlock )

Button new
[
    self := super new.
    state := false.
    onBlock := offBlock := [:b|].
]

Button state			[ ^state ]
Button onBlock: unaryBlock	[  onBlock  := unaryBlock ]
Button offBlock: unaryBlock	[  offBlock := unaryBlock ]

Button toggle	[ state ifTrue: [self off] ifFalse: [self on] ]
Button on	[ state ifFalse: [state := true.   self changed.  onBlock  value: self ] ]
Button off	[ state ifTrue:  [state := false.  self changed.  offBlock value: self ] ]

"----------------"

ButtonGroup : Model ( buttons selected )

ButtonGroup new
[
    self := super new.
    buttons := OrderedCollection new.
]

ButtonGroup add: aButton
[
    buttons add: aButton.
    aButton addDependent: self.
]

ButtonGroup update: aButton
[
    aButton state ifFalse: [^self].
    buttons do: [:b | (b ~~ aButton and: [b state]) ifTrue: [b toggle]].
    selected := aButton.
    self changed.
]

"----------------------------------------------------------------"

{ import: Views }

ButtonView : ShapedView ( button )

ButtonView withShape: aShape button: aButton
[
    self := super withShape: aShape.
    self propertyAt: #offColour put: Colour white.
    self propertyAt: #onColour put: (Colour white darker: 0.3).
    fillColour := Colour white.
    button := aButton.
    button addDependent: self message: #update:.
]

ButtonView pressed
[
    button toggle.
]

ButtonView update: aButton
[
    fillColour := self propertyAt: (aButton state ifTrue: [#onColour] ifFalse: [#offColour]).
    self damaged.
]

Shape buttonView: aButton	[ ^ButtonView withShape: self button: aButton ]

"----------------------------------------------------------------"

{ import: EventHandler }

ButtonEventHandler : FocusedEventHandler ( savedFillColour )

ButtonEventHandler withWorld: aWorld focus: aView
[
    self := super withWorld: aWorld focus: aView.
    focus fillColour: ((savedFillColour := focus fillColour) darker: 0.2); damaged.
]

ButtonEventHandler pointerMotionEvent :anEvent
[
    (focus bounds containsPoint: anEvent localPosition)
	ifFalse:
	   [focus fillColour: savedFillColour; damaged.
	    self deactivate].
    ^anEvent handled: self
]

ButtonEventHandler pointerUpEvent :anEvent
[
    focus pressed.
    savedFillColour := focus fillColour.
    "focus fillColour: ((savedFillColour := focus fillColour) darker: 0.2); damaged."
    self deactivate.
]

EventHandler beginButton: aView
[
    (ButtonEventHandler withWorld: world focus: aView) activate
]
