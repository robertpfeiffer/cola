{ import: Object }
{ import: Geometry }
{ import: Time }

Event : Object ( time handler handled globalPosition localPosition )

Event new
[
    self := super new.
    time := Time millisecondClockValue.
]

Event time			[ ^time ]

Event handler: anObject		[ ^handler := anObject ]
Event handler			[ ^handler ]

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

PointerEvent state: anObject	[ ^state := anObject ]
PointerEvent state		[ ^state ]

PointerEvent printMembersOn: aStream
[
    super printMembersOn: aStream.
    aStream space; print: state.
]

ButtonEvent : PointerEvent ( button )

ButtonEvent button: anObject	[ ^button := anObject ]
ButtonEvent button		[ ^button ]

ButtonEvent printMembersOn: aStream
[
    super printMembersOn: aStream.
    aStream space; print: button.
]

"----------------------------------------------------------------"

KeyEvent : Event ( state key ucs4 )

KeyEvent state: anObject	[ ^state := anObject ]
KeyEvent state			[ ^state ]

KeyEvent key: anObject		[ ^key := anObject ]
KeyEvent key			[ ^key ]

KeyEvent ucs4: anObject		[ ^ucs4 := anObject ]
KeyEvent ucs4			[ ^self modify: ucs4 ]

KeyEvent printMembersOn: aStream
[
    super printMembersOn: aStream.
    aStream space; print: state; space; print: key; space; print: ucs4.
]

KeyEvent modify: asciiCode
[
    asciiCode		ifFalse: [^nil].
    asciiCode >= 128	ifTrue:  [^asciiCode].
    self controlPressed	ifTrue:  [^asciiCode & 0x1F].
    "self shiftPressed	ifTrue:  [^asciiCode & 0xDF]."
    ^asciiCode
]

KeyEvent shiftPressed	[ ^state & 0x01 ~~ 0 ]
KeyEvent controlPressed	[ ^state & 0x04 ~~ 0 ]

"----------------------------------------------------------------"

ConfigureEvent : Event ( width height )

ConfigureEvent width: anObject	[ ^width := anObject ]
ConfigureEvent width		[ ^width ]

ConfigureEvent height: anObject	[ ^height := anObject ]
ConfigureEvent height		[ ^height ]

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
