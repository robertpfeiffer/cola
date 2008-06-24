{ import: Objects }

Event : Object ( hand window target handler position state )

Event hand		[ ^hand ]
Event window		[ ^window ]
Event target		[ ^target ]
Event handler		[ ^handler ]
Event position		[ ^position ]
Event state		[ ^state ]

Event hand: aHand	[  hand := aHand ]
Event window: aWindow	[  window := aWindow ]
Event target: aBox	[  target := aBox ]
Event handler: aBox	[  handler := aBox ]

Event withX: xx withY: yy state: ss
[
    self := self new.
    position := xx,yy.
    state    := ss.
]

Event printOn: aStream	[ super printOn: aStream.  aStream nextPut: $(; print: state; nextPut: $) ]


KeyEvent : Event ( ucs4 )

KeyEvent ucs4	[ ^ucs4 ]

KeyEvent withX: xx withY: yy state: ss detail: dd dx: dx dy: dy
[
    self := super withX: xx withY: yy state: ss.
    ucs4 := dd.
]

KeyEvent printOn: aStream	[ super printOn: aStream.  aStream nextPut: $(; print: ucs4; nextPut: $) ]

KeyDownEvent : KeyEvent()		KeyDownEvent	name [ ^#keyDown ]
KeyUpEvent : KeyEvent()			KeyUpEvent	name [ ^#keyUp ]


ButtonEvent : Event ( button )

ButtonEvent button	[ ^button ]

ButtonEvent withX: xx withY: yy state: ss detail: dd dx: dx dy: dy
[
    self := super withX: xx withY: yy state: ss.
    button := dd.
]

ButtonEvent printOn: aStream	[ super printOn: aStream.  aStream nextPut: $(; print: button; nextPut: $) ]

ButtonDownEvent : ButtonEvent ()	ButtonDownEvent	name [ ^#buttonDown ]
ButtonUpEvent : ButtonEvent ()		ButtonUpEvent	name [ ^#buttonUp ]


MotionEvent : Event ( buttons delta )		MotionEvent	name [ ^#motion ]

MotionEvent delta		[ ^delta ]

MotionEvent leftButtonDown	[ ^0 ~~ (buttons bitAnd: 1) ]

MotionEvent printOn: aStream	[ super printOn: aStream.  aStream nextPutAll: '('; print: buttons; space; nextPutAll: '+'; print: delta; nextPut: $) ]

MotionEvent withX: xx withY: yy state: ss detail: dd dx: dxx dy: dyy
[
    self := super withX: xx withY: yy state: ss.
    delta := dxx,dyy.
    buttons := dd.
]

ResizeEvent : Event ()			ResizeEvent	name [ ^#resize ]

ResizeEvent withX: xx withY: yy state: ss detail: dd dx: dxx dy: dyy
[
    self := super withX: xx withY: yy state: ss.
]
