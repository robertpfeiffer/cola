{ import: Object }

Event : Object ( position )

Event position	[ ^position ]

Event withPosition: aPoint
[
    self := self new.
    position := aPoint.
]


DamageEvent : Event ( extent )

DamageEvent extent	[ ^extent ]

DamageEvent withPosition: pPoint extent: ePoint
[
    self := super withPosition: pPoint.
    extent := ePoint.
]

DamageEvent dispatchTo: aWindow at: aPoint	[ ^aWindow handleDamageEvent: self at: aPoint ]


InputEvent : Event ( modifiers )

InputEvent modifiers	[ ^modifiers ]

InputEvent withPosition: aPoint modifiers: modifierMask
[
    self := self withPosition: aPoint.
    modifiers := modifierMask.
]


KeyEvent : InputEvent ( key )

KeyEvent key	[ ^key ]

KeyEvent withPosition: aPoint key: keyNumber modifiers: modifierMask
[
    self := self withPosition: aPoint modifiers: modifierMask.
    key := keyNumber.
]


KeyPressEvent : KeyEvent ()

KeyPressEvent dispatchTo: aWindow at: aPoint	[ ^aWindow handleKeyPressEvent: self at: aPoint ]


KeyReleaseEvent : KeyEvent ()

KeyReleaseEvent dispatchTo: aWindow at: aPoint	[ ^aWindow handleKeyReleaseEvent: self at: aPoint ]


ButtonEvent : InputEvent ( button )

ButtonEvent button	[ ^button ]

ButtonEvent withPosition: aPoint button: buttonNumber modifiers: modifierMask
[
    self := self withPosition: aPoint modifiers: modifierMask.
    button := buttonNumber.
]


ButtonPressEvent : ButtonEvent ()

ButtonPressEvent dispatchTo: aWindow at: aPoint	[ ^aWindow handleButtonPressEvent: self at: aPoint ]


ButtonReleaseEvent : ButtonEvent ()

ButtonReleaseEvent dispatchTo: aWindow at: aPoint	[ ^aWindow handleButtonReleaseEvent: self at: aPoint ]
