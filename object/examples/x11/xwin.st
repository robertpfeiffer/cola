{ import:  st80 }

{ include "xwin-primdefs.h" }

Point : Magnitude ( x y )

Point x		[ ^x ]
Point y		[ ^y ]

Point x: abscissa y: ordinate
[
    self := self new.
    x := abscissa.
    y := ordinate.
]

Point _x	[ ^x _integerValue ]
Point _y	[ ^y _integerValue ]

Point zero		[ ^Point x: 0 y: 0 ]

Number @ aNumber	[ ^Point x: self y: aNumber ]

Point hash		[ ^x hash bitXor: (y * 6199) hash ]

Point = aPoint		[ ^x = aPoint x and: [y = aPoint y] ]
Point < aPoint		[ ^x < aPoint x and: [y < aPoint y] ]

Point + aPoint		[ ^self x: x + aPoint x y: y + aPoint y ]
Point - aPoint		[ ^self x: x - aPoint x y: y - aPoint y ]

Point printOn: aStream	[ aStream print: x; nextPut: $@; print: y ]


Rectangle : Object ( origin corner )

Rectangle origin: originPoint corner: cornerPoint
[
    self := self new.
    origin := originPoint.
    corner := cornerPoint.
]

Rectangle origin: originPoint extent: extent
[
    ^self origin: originPoint corner: originPoint + extent
]

Point corner: aPoint	[ ^Rectangle origin: self corner: aPoint ]
Point extent: aPoint	[ ^Rectangle origin: self extent: aPoint ]

Rectangle origin	[ ^origin ]
Rectangle corner	[ ^corner ]
Rectangle extent	[ ^corner - origin ]

Rectangle width		[ ^corner x - origin x ]
Rectangle height	[ ^corner y - origin y ]

Rectangle left		[ ^origin x ]
Rectangle right		[ ^corner x ]
Rectangle top		[ ^origin y ]
Rectangle bottom	[ ^corner y ]

Rectangle _x		[ ^origin _x ]
Rectangle _y		[ ^origin _y ]
Rectangle _w		[ ^self extent _x ]
Rectangle _h		[ ^self extent _y ]

Rectangle hash		[ ^origin hash * 419 bitXor: corner hash ]

Rectangle = aRectangle	[ ^origin = aRectangle origin and: [corner = aRectangle corner] ]

Rectangle containsPoint: aPoint
[
    ^origin <= aPoint and: [aPoint < corner]
]

Rectangle intersects: aRectangle
[
    | rOrigin rCorner |
    rOrigin := aRectangle origin.
    rCorner := aRectangle corner.
    rCorner x <= origin x ifTrue: [^false].
    rCorner y <= origin y ifTrue: [^false].
    rOrigin x >= corner x ifTrue: [^false].
    rOrigin y >= corner y ifTrue: [^false].
    ^ true
]

Rectangle printOn: aStream	[ aStream nextPut: $(; print: origin; nextPutAll: ' corner: '; print: corner; nextPut: $) ]


{ include <X11/Xlib.h> }
{ include <X11/keysymdef.h> }


X11Display : Object ( _dpy )

X11Display _dpy			[ ^_dpy ]
X11Display _dpy_: _display	[  _dpy := _display ]


X11Window : Object ( dpy _win )

X11Window withDisplay: aDisplay
[
    self := self new.
    dpy := aDisplay.
]

X11Window _win			[ ^_win ]
X11Window _win_: _window	[  _win := _window ]

X11Window display		[ ^dpy ]


X11Event : Object ( _event )

X11Event initialize
[
    super initialize.
    { self->v__event= (oop)_balloc(sizeof(XEvent)); }.
]

X11Event _event		[ ^_event ]

"event types"

X11Event keyPress		{ return _O(KeyPress); }
X11Event expose			{ return _O(Expose); }
X11Event unmapNotify		{ return _O(UnmapNotify); }
X11Event resizeRequest		{ return _O(ResizeRequest); }
X11Event configureNotify	{ return _O(ConfigureNotify); }

"event mask bits"

X11Event keyPressMask			{ return _O(KeyPressMask); }
X11Event exposureMask			{ return _O(ExposureMask); }
X11Event structureNotifyMask		{ return _O(StructureNotifyMask); }
X11Event resizeRedirectMask		{ return _O(ResizeRedirectMask); }
X11Event substructureNotifyMask		{ return _O(SubstructureNotifyMask); }
X11Event substructureRedirectMask	{ return _O(SubstructureRedirectMask); }
X11Event anyEventMask			{ return _O(0x1fffff); }

X11Event isKeyPress		[ ^self type == self keyPress ]
X11Event isExpose		[ ^self type == self expose ]
X11Event isUnmapNotify		[ ^self type == self unmapNotify ]
X11Event isResizeRequest	[ ^self type == self resizeRequest ]
X11Event isConfigureNotify	[ ^self type == self configureNotify ]

X11Event _type		{ return (oop)(((XEvent *)self->v__event)->type); }
X11Event type		[ ^SmallInteger value_: self _type ]

X11Event name
[
    | names type |
    names := #( NULL KeyPress KeyRelease ButtonPress ButtonRelease MotionNotify
		EnterNotify LeaveNotify FocusIn FocusOut KeymapNotify Expose
		GraphicsExpose NoExpose VisibilityNotify CreateNotify DestroyNotify
		UnmapNotify MapNotify MapRequest ReparentNotify ConfigureNotify
		ConfigureRequest GravityNotify ResizeRequest CirculateNotify
		CirculateRequest PropertyNotify SelectionClear SelectionRequest
		SelectionNotify ColormapNotify ClientMessage MappingNotify ).
    ^((type := self type) between: 1 and: names size)
	ifTrue:  [names at: type]
	ifFalse: ['ILLEGAL']
]

X11Event xkEscape	{ return _O(XK_Escape); }

X11Display keycodeToKeysym_: _event
{
  XEvent *event= (XEvent *)v__event;
  int     index= 0;
  KeySym  keySym;
  if (event->xkey.state & ShiftMask)
    ++index;
  keySym= XKeycodeToKeysym((Display *)self->v__dpy, event->xkey.keycode, index);
  if ((NoSymbol == keySym) && (index & 1))
    keySym= XKeycodeToKeysym((Display *)self->v__dpy, event->xkey.keycode, index - 1);
  return _O(keySym);
}

X11Display keycodeToKeysym: event	[ ^self keycodeToKeysym_: event _event ]

X11Window  keycodeToKeysym: event	[ ^dpy keycodeToKeysym: event ]

X11Event xkeyX			{ return _O(((XEvent *)self->v__event)->xkey.x); }
X11Event xkeyY			{ return _O(((XEvent *)self->v__event)->xkey.y); }
X11Event xkeyKeycode		{ return _O(((XEvent *)self->v__event)->xkey.keycode); }
X11Event xkeyState		{ return _O(((XEvent *)self->v__event)->xkey.state); }

X11Event xkeyPosition		[ ^Point x: self xkeyX y: self xkeyY ]

X11Event xbuttonX		{ return _O(((XEvent *)self->v__event)->xbutton.x); }
X11Event xbuttonY		{ return _O(((XEvent *)self->v__event)->xbutton.y); }
X11Event xbuttonButton		{ return _O(((XEvent *)self->v__event)->xbutton.button); }
X11Event xbuttonState		{ return _O(((XEvent *)self->v__event)->xbutton.state); }

X11Event xbuttonPosition	[ ^Point x: self xbuttonX y: self xbuttonY ]

X11Event xexposeX		{ return _O(((XEvent *)self->v__event)->xexpose.x); }
X11Event xexposeY		{ return _O(((XEvent *)self->v__event)->xexpose.y); }
X11Event xexposeW		{ return _O(((XEvent *)self->v__event)->xexpose.width); }
X11Event xexposeH		{ return _O(((XEvent *)self->v__event)->xexpose.height); }

X11Event xexposePosition	[ ^Point x: self xexposeX y: self xexposeY ]
X11Event xexposeExtent		[ ^Point x: self xexposeW y: self xexposeH ]

X11Event xresizerequestW	{ return _O(((XEvent *)self->v__event)->xresizerequest.width); }
X11Event xresizerequestH	{ return _O(((XEvent *)self->v__event)->xresizerequest.height); }

X11Event xresizerequestExtent	[ ^Point x: self xresizerequestW y: self xresizerequestH ]

X11Event xconfigureW		{ return _O(((XEvent *)self->v__event)->xconfigure.width); }
X11Event xconfigureH		{ return _O(((XEvent *)self->v__event)->xconfigure.height); }

X11Event xconfigureExtent	[ ^Point x: self xconfigureW y: self xconfigureH ]


X11GC : Object ( win _gc )

X11GC withDrawable: aWindow
[
    self := self new.
    win := aWindow.
    _gc := win display _createGC_: win _win.
]

X11Display _createGC_: _win
{
  XGCValues gcv;
  return (oop)XCreateGC((Display *)self->v__dpy, (Window)v__win, 0, &gcv);
}

X11Window createGC			[ ^X11GC withDrawable: self ]

X11GC setForeground: pixel		[ win display setForeground_: _gc _: pixel _integerValue ]
X11GC setBackground: pixel		[ win display setBackground_: _gc _: pixel _integerValue ]

X11Display setForeground_: _gc _: _pix	{ XSetForeground((Display *)self->v__dpy, (GC)v__gc, (unsigned long)v__pix); }
X11Display setBackground_: _gc _: _pix	{ XSetBackground((Display *)self->v__dpy, (GC)v__gc, (unsigned long)v__pix); }

X11GC drawString: aString at: aPoint
[
    win display drawString_: win _win _: _gc _: aPoint _x _: aPoint _y _: aString _bytes _: aString _size
]

X11Display drawString_: _win _: _gc _: _x _: _y _: _string _: _length
{
  XDrawString((Display *)self->v__dpy, (Window)v__win, (GC)v__gc, (int)v__x, (int)v__y, (char *)v__string, (int)v__length);
}

X11GC drawRectangle: aRectangle
[
    win display drawRectangle_: win _win _: _gc _: aRectangle _x _: aRectangle _y _: aRectangle _w _: aRectangle _h.
]

X11Display drawRectangle_: _win _: _gc _: _x _: _y _: _w _: _h
{
  XDrawRectangle((Display *)self->v__dpy, (Window)v__win, (GC)v__gc, (int)v__x, (int)v__y, (int)v__w, (int)v__h);
}

X11GC fillRectangle: aRectangle
[
    win display fillRectangle_: win _win _: _gc _: aRectangle _x _: aRectangle _y _: aRectangle _w _: aRectangle _h.
]

X11Display fillRectangle_: _win _: _gc _: _x _: _y _: _w _: _h
{
  XFillRectangle((Display *)self->v__dpy, (Window)v__win, (GC)v__gc, (int)v__x, (int)v__y, (int)v__w, (int)v__h);
}


X11WindowAttributes : Object ( _xwa )

X11WindowAttributes initialize
[
    super initialize.
    { self->v__xwa= (oop)_balloc(sizeof(XSetWindowAttributes)); }.
]

X11WindowAttributes _xwa		[ ^_xwa ]

X11WindowAttributes cwEventMask		{ return _O(CWEventMask); }

X11WindowAttributes eventMask_: _mask	{ ((XSetWindowAttributes *)self->v__xwa)->event_mask= (long)v__mask; }

X11WindowAttributes eventMask: mask	[ self eventMask_: mask _integerValue ]


"----------------------------------------------------------------"

X11Display _open	{ return (oop)XOpenDisplay(0); }

X11Display open
[
    self := self new _dpy_: self _open.
    _dpy == nil ifTrue: [self error: 'could not open display'].
]

X11Display newWindow	[ ^X11Window withDisplay: self ]

X11Display _createSimpleWindow_: _x _: _y _: _w _: _h _: _bw _: _b _: _bg
{
  return (oop)XCreateSimpleWindow((Display *)self->v__dpy, DefaultRootWindow((Display *)self->v__dpy),
				  (int)v__x, (int)v__y, (int)v__w, (int)v__h,
				  (int)v__bw, (int)v__b, (int)v__bg);
}

X11Display createWindow: bounds borderWidth: borderWidth border: border background: background
[
    ^self newWindow
	_win_: (self _createSimpleWindow_: (bounds _x) _: (bounds _y) _: (bounds _w) _: (bounds _h)
		     _: borderWidth _integerValue
		     _: border _integerValue
		     _: background _integerValue)
]


X11Display flush		{ XFlush((Display *)self->v__dpy); }

X11Display sync			{ XSync((Display *)self->v__dpy, False); }

X11Display mapWindow_: _win	{ XMapWindow((Display *)self->v__dpy, (Window)v__win); }

X11Display mapWindow: window	[ self mapWindow_: window _win ]

X11Display destroyWindow_: _win	{ XDestroyWindow((Display *)self->v__dpy, (Window)v__win); }

X11Display destroyWindow: win	[ self destroyWindow_: win _win ]

X11Window close			[ dpy destroyWindow: self ]

X11Display nextEvent_: _event	{ XNextEvent((Display *)self->v__dpy, (XEvent *)v__event); }

X11Display nextEvent: event	[ self nextEvent_: event _event.  ^event ]

X11Display nextEvent		[ ^self nextEvent: X11Event new ]

X11Window nextEvent		[ ^dpy nextEvent ]

X11Window resize: extent	[ dpy resizeWindow_: _win _: extent _x _: extent _y ]

X11Display resizeWindow_: _win _: _w _: _h
{
  XResizeWindow((Display *)self->v__dpy, (Window)v__win, (int)v__w, (int)v__h);
}

X11Display setWindowBackground_: _win _: _bg
{
  XSetWindowBackground((Display *)self->v__dpy, (Window)v__win, (int)v__bg);
}

X11Display setWindowBackground: window pixel: pixel
[
    self setWindowBackground_: window _win _: pixel _integerValue
]

X11Display changeWindowAttributes_: _win _: _mask _: _xwa
{
  XChangeWindowAttributes((Display *)self->v__dpy, (Window)v__win, (unsigned long)v__mask, (XSetWindowAttributes *)v__xwa);
}

X11Display changeWindowAttributes: window mask: mask attributes: xwa
[
    ^self changeWindowAttributes_: window _win _: mask _integerValue _: xwa _xwa
]

X11Display blackPixel	{ return _O(BlackPixel((Display *)self->v__dpy, DefaultScreen((Display *)self->v__dpy))); }
X11Display whitePixel	{ return _O(WhitePixel((Display *)self->v__dpy, DefaultScreen((Display *)self->v__dpy))); }

X11Display close	{ XCloseDisplay((Display *)self->v__dpy); }
