{ import: Object }
{ import: Event }
{ import: OS }

HostWindow : Object ( windowWidth windowHeight )

HostWindow width	[ ^windowWidth ]
HostWindow height	[ ^windowHeight ]
HostWindow dpi		[ ^75 ]

HostWindow extent	[ ^windowWidth , windowHeight ]
HostWindow bounds	[ ^Pair zero corner: self extent ]

HostWindow swapBuffers: clipRectangle
[
    self swapBuffers
]

HostWindow swapBuffers
[
    self subtypeResponsibility: 'swapBuffers'
]

HostWindow pointerDownEvent	:state :button :x :y	[ ^PointerDownEvent   new position: x,y; state: state; button: button; yourself ]
HostWindow pointerUpEvent	:state :button :x :y	[ ^PointerUpEvent     new position: x,y; state: state; button: button; yourself ]
HostWindow pointerMotionEvent	:state :unused :x :y	[ ^PointerMotionEvent new position: x,y; state: state; yourself ]
HostWindow keyDownEvent		:char  :unused :x :y	[ ^KeyDownEvent       new position: x,y; key: char; yourself ]
HostWindow keyRepeatEvent	:char  :unused :x :y	[ ^KeyRepeatEvent     new position: x,y; key: char; yourself ]
HostWindow keyUpEvent		:char  :unused :x :y	[ ^KeyUpEvent         new position: x,y; key: char; yourself ]
HostWindow damageEvent		:l     :t      :r :b	[ ^DamageEvent	      new position: l,t; width: r - l; height: b - t; yourself ]

HostWindow loadHostSupport
[
    (OS getenv: 'DISPLAY')	ifTrue: [^OS import: 'X11Window'].
    (OS system = 'win32')	ifTrue: [^OS import: 'WinWindow'].
    self error: 'no host window support for ', OS system
]

[
    HostWindow loadHostSupport
]
