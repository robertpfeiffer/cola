" HostWindow.st -- common behaviour for top-level graphical windows

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

  Last edited: 2007-09-18 20:17:35 by piumarta on emilia
"

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
    self subtypeResponsibility: 'swapBuffers:'
]

HostWindow swapBuffers
[
    self swapBuffers: self bounds
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
