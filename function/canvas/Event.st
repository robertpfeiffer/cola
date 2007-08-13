{ import: Object }
{ import: Geometry }

Event : Object ( context handled globalPosition localPosition )

Event context: anObject		[ ^context := anObject ]
Event context			[ ^context ]

Event handled: aHandler		[ ^handled := aHandler ]
Event handled			[ ^handled ]

Event position: aPoint		[ ^globalPosition := aPoint ]
Event position			[ ^globalPosition ]

Event localPosition: aPoint	[ ^localPosition := aPoint ]
Event localPosition		[ ^localPosition ]

Event printOn: aStream
[
    super printOn: aStream.
    aStream nextPut: $(.
    self printMembersOn: aStream.
    aStream nextPut: $).
]

Event printMembersOn: aStream
[
    aStream print: globalPosition; nextPut: $(; print: localPosition; nextPut: $)
]

"----------------------------------------------------------------"

PointerEvent : Event ( state )

PointerEvent printMembersOn: aStream
[
    super printMembersOn: aStream.
    aStream space; print: state.
]

ButtonEvent : PointerEvent ( button )

ButtonEvent printMembersOn: aStream
[
    super printMembersOn: aStream.
    aStream space; print: button.
]

"----------------------------------------------------------------"

KeyEvent : Event ( state key ucs4 )

KeyEvent ucs4	[ ^ucs4 ]

KeyEvent printMembersOn: aStream
[
    super printMembersOn: aStream.
    aStream space; print: state; space; print: key; space; print: ucs4.
]

"----------------------------------------------------------------"

ConfigureEvent : Event ( width height )

ConfigureEvent printMembersOn: aStream
[
    super printMembersOn: aStream.
    aStream space; print: width; space; print: height.
]

"----------------------------------------------------------------"

PointerMotionEvent : PointerEvent ()
Event			isPointerMotionEvent	[ ^false]
PointerMotionEvent	isPointerMotionEvent	[ ^true]
PointerMotionEvent	name			[ ^#pointerMotionEvent ]

PointerDownEvent : ButtonEvent ()
Event			isPointerDownEvent	[ ^false ]
PointerDownEvent	isPointerDownEvent	[ ^true]
PointerDownEvent	name			[ ^#pointerDownEvent ]

PointerUpEvent : ButtonEvent ()
Event			isPointerUpEvent	[ ^false ]
PointerUpEvent		isPointerUpEvent	[ ^true ]
PointerUpEvent		name			[ ^#pointerUpEvent ]

KeyDownEvent : KeyEvent ()
Event			isKeyDownEvent		[ ^false ]
KeyDownEvent		isKeyDownEvent		[ ^true ]
KeyDownEvent		name			[ ^#keyDownEvent ]

KeyRepeatEvent : KeyEvent ()
Event			isKeyRepeatEvent	[ ^false ]
KeyRepeatEvent		isKeyRepeatEvent	[ ^true ]
KeyRepeatEvent		name			[ ^#keyRepeatEvent ]

KeyUpEvent : KeyEvent ()
Event			isKeyUpEvent		[ ^false ]
KeyUpEvent		isKeyUpEvent	 	[ ^true ]
KeyUpEvent		name			[ ^#keyUpEvent ]

DamageEvent : ConfigureEvent ()
Event			isDamageEvent		[ ^false ]
DamageEvent		isDamageEvent		[ ^true ]
DamageEvent		name			[ ^#damageEvent ]

"----------------------------------------------------------------"

Event dispatchTo: aView
[
    ^aView perform: self name with: self
]
