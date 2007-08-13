{ import: HostWindow }
{ import: Geometry }

{ include <X11/Xlib.h> }
{ include <X11/Xutil.h> }
{ include <X11/extensions/Xdbe.h> }

XWindow : HostWindow ( _dpy _win _buf _vis _gc _dbeMode windowWidth windowHeight )

XWindow extent
[
    ^windowWidth @ windowHeight
]

XWindow bounds
[
    ^Point zero corner: self extent
]

XWindow withExtent: extent	[ ^self withExtent: extent swapAction: 3 "XdbeCopied" ]

XWindow withExtent: extent swapAction: swapAction
[
    self   := super new.
    windowWidth  := extent x rounded.
    windowHeight := extent y rounded.
    {
        Display  *dpy  = XOpenDisplay(0);
	Window    root = DefaultRootWindow(dpy);
	Window    win  = XCreateSimpleWindow(dpy, root, 0, 0, ((long)self->v_windowWidth) >> 1, ((long)self->v_windowHeight) >> 1, 5, 0, 0);
        int       maj, min;
	Drawable  buf  = (XdbeQueryExtension(dpy, &maj ,&min)
			      ? XdbeAllocateBackBufferName(dpy, win, (long)v_swapAction >> 1)
			      : (printf("dbe disabled (server version %d.%d)\n", maj, min), win));
	GC        gc   = XDefaultGC(dpy, DefaultScreen(dpy));
	Visual   *vis  = DefaultVisual(dpy, DefaultScreen(dpy));
	{
	    XSetWindowAttributes xwa;
	    xwa.event_mask= 
	        KeyPressMask
	      | KeyReleaseMask
	      | ButtonPressMask
	      | ButtonReleaseMask
	   /* | EnterWindowMask */
	   /* | LeaveWindowMask */
	      | PointerMotionMask
	   /* | PointerMotionHintMask */
	   /* | Button1MotionMask */
	   /* | Button2MotionMask */
	   /* | Button3MotionMask */
	   /* | Button4MotionMask */
	   /* | Button5MotionMask */
	   /* | ButtonMotionMask */
	   /* | KeymapStateMask */
	      | ExposureMask
	   /* | VisibilityChangeMask */
	   /* | StructureNotifyMask */
	   /* | ResizeRedirectMask */
	   /* | SubstructureNotifyMask */
	   /* | SubstructureRedirectMask */
	   /* | FocusChangeMask */
	   /* | PropertyChangeMask */
	   /* | ColormapChangeMask */
	   /* | OwnerGrabButtonMask */
	      ;
	    XChangeWindowAttributes(dpy, win, CWEventMask, &xwa);
	}
	XSetWindowBackground(dpy, win, -1);
	XMapWindow(dpy, win);
	XFlush(dpy);
	self->v__dpy = (oop)dpy;
	self->v__win = (oop)win;
	self->v__buf = (oop)buf;
	self->v__gc  = (oop)gc;
	self->v__vis = (oop)vis;
    }.
    _dbeMode := swapAction _integerValue.
]

XWindow width	[ ^windowWidth ]
XWindow height	[ ^windowHeight ]

XWindow widthInMillimetres	[ ^SmallInteger value_: self _widthInMillimetres ]
XWindow heightInMillimetres	[ ^SmallInteger value_: self _heightInMillimetres ]

XWindow _widthInMillimetres	{ _return (oop)DisplayWidthMM((Display *)self->v__dpy, DefaultScreen((Display *)self->v__dpy)); }
XWindow _heightInMillimetres	{ _return (oop)DisplayHeightMM((Display *)self->v__dpy, DefaultScreen((Display *)self->v__dpy)); }

XWindow dpi			[ ^25.4 / self widthInMillimetres asFloat * self width ]

XWindow setClippingRectangle: aRectangle
[
    | x y w h |
    x := aRectangle x rounded.
    y := aRectangle y rounded.
    w := aRectangle width rounded.
    h := aRectangle height rounded.
    {
	XRectangle r = { (long)v_x >> 1, (long)v_y >> 1, (long)v_w >> 1, (long)v_h >> 1 };
	XSetClipRectangles((Display *)self->v__dpy, (GC)self->v__gc, 0, 0, &r, 1, Unsorted);
    }.
]

XWindow clear
[
    _win == _buf ifTrue: [{ XClearWindow((Display *)self->v__dpy, (Window)self->v__win); }].
]

XWindow fillStyle: styleString
[
    | _style |
    _style := styleString asString _stringValue.
    {
	XColor exact, screen;
	if (XAllocNamedColor((Display *)self->v__dpy,
			     DefaultColormap((Display *)self->v__dpy, DefaultScreen((Display *)self->v__dpy)),
			     (char *)v__style, &screen, &exact))
	    XSetForeground((Display *)self->v__dpy, (GC)self->v__gc, screen.pixel);
    }
]

XWindow backgroundStyle: styleString
[
    | _style |
    _style := styleString asString _stringValue.
    {
	XColor exact, screen;
	if (XAllocNamedColor((Display *)self->v__dpy,
			     DefaultColormap((Display *)self->v__dpy, DefaultScreen((Display *)self->v__dpy)),
			     (char *)v__style, &screen, &exact))
	    XSetWindowBackground((Display *)self->v__dpy, (Window)self->v__win, screen.pixel);
    }
]

XWindow setLineWidth: w
[
    w := w rounded.
    {
	XGCValues xgcv;
	xgcv.line_width= (long)v_w >> 1;
	XChangeGC((Display *)self->v__dpy, (GC)self->v__gc, GCLineWidth, &xgcv);
    }
]

XWindow swapBuffers
{
    if (self->v__buf != self->v__win)
    {
	XdbeSwapInfo info= { (Window)self->v__win, (XdbeSwapAction)(long)self->v__dbeMode };
	XdbeSwapBuffers((Display *)self->v__dpy, &info, 1);
    }
}

XWindow flush
{
    XFlush((Display *)self->v__dpy);
}

XWindow sync
{
    XSync((Display *)self->v__dpy, False);
}

XWindow purge
{
    XSync((Display *)self->v__dpy, True);
}

XWindow renderText: text in: aRectangle
[
    | width origin size start stop |
    width := aRectangle width.
    origin := aRectangle origin.
    size := text string size.
    start := 0.
    [start < size and: [origin y < aRectangle bottom]]
	whileTrue:
	   [stop := text stopIndex: width at: start.
	    self renderText: text from: start for: stop - start at: origin.
	    origin := origin + (0 @ text height).
	    start := stop].
]

XWindow renderText: text from: offset for: length at: aPoint
[
    | _string x y |
    _string := text string _stringValue.
    x 	    := aPoint x rounded.
    y 	    := aPoint y rounded.
    {
	XDrawString((Display *)self->v__dpy, (Drawable)self->v__buf, (GC)self->v__gc,
		    (long)v_x >> 1, (long)v_y >> 1,
		    (char *)v__string + ((long)v_offset >> 1), (long)v_length >> 1);
    }.
]

XWindow depth
{
    _return (oop)(XDefaultDepth((Display *)self->v__dpy, DefaultScreen((Display *)self->v__dpy)) << 1 | 1);
}

{ import: Event }

XEvent : Event ( _type )

XEvent _sizeof	{ _return (oop)(sizeof(XEvent) << 1 | 1); }

XEvent _type	[ ^_type ]
XEvent  type	[ ^SmallInteger value_: _type ]

XEvent asEvent
[
    | type |
    ^(type := self eventType) ifTrue: [type new initXEvent: self]
]

XEvent eventType
[
    {
    	switch (((XEvent *)self)->type)
    	  {
    	  case KeyPress:	_return v_KeyDownEvent;
    	  case KeyRelease:	_return v_KeyUpEvent;
    	  case ButtonPress:	_return v_PointerDownEvent;
    	  case ButtonRelease:	_return v_PointerUpEvent;
    	  case Expose:		_return v_DamageEvent;
    	  case MotionNotify:
	    while (XCheckTypedEvent(((XMotionEvent *)self)->display, MotionNotify, (XEvent *)self));
	    _return v_PointerMotionEvent;
	  }
    	_return 0;
    }.
    "force imports"
    KeyDownEvent.
    KeyRepeatEvent.
    KeyUpEvent.
    PointerDownEvent.
    PointerUpEvent.
    PointerMotionEvent.
    DamageEvent.
]

XEvent keyString
[
    | _string _n |
    {
	char buf[32];
	v__n= (oop)XLookupString((XKeyEvent *)self, buf, sizeof(buf), 0, 0);
	v__string= (oop)_balloc((long)v__n);
	strncpy((char *)v__string, buf, (long)v__n);
    }.
    ^String size_: _n value_: _string
]

{ input: XWindowUCS4 }

PointerMotionEvent initXEvent: xev
[
    | x y |
    {
	XMotionEvent *xev = (XMotionEvent *)v_xev;
	v_x		  = (oop)(xev->x      << 1 | 1);
	v_y		  = (oop)(xev->y      << 1 | 1);
	self->v_state	  = (oop)(xev->state  << 1 | 1);
    }.
    globalPosition := localPosition := x @ y.
]

ButtonEvent initXEvent: xev
[
    | x y |
    {
	XButtonEvent *xev = (XButtonEvent *)v_xev;
	v_x		  = (oop)(xev->x      << 1 | 1);
	v_y		  = (oop)(xev->y      << 1 | 1);
	self->v_state	  = (oop)(xev->state  << 1 | 1);
	self->v_button	  = (oop)(xev->button << 1 | 1);
    }.
   globalPosition := localPosition := x @ y.
]

KeyEvent initXEvent: xev
[
    | x y ucs4val position |
    ucs4val := xev ucs4.
    {
	XKeyEvent *xev	= (XKeyEvent *)v_xev;
	v_x		= (oop)(xev->x	     << 1 | 1);
	v_y		= (oop)(xev->y	     << 1 | 1);
	self->v_state	= (oop)(xev->state   << 1 | 1);
	self->v_key	= (oop)(xev->keycode << 1 | 1);
	self->v_ucs4	= (oop)(   v_ucs4val         );
    }.
    globalPosition := localPosition := x @ y.
]

DamageEvent initXEvent: xev
[
    | x y |
    {
	XExposeEvent *xev = (XExposeEvent *)v_xev;
	v_x		  = (oop)(xev->x      << 1 | 1);
	v_y		  = (oop)(xev->y      << 1 | 1);
	self->v_width	  = (oop)(xev->width  << 1 | 1);
	self->v_height	  = (oop)(xev->height << 1 | 1);
    }.
    globalPosition := localPosition := x @ y.
]

XWindow eventPending	{ _return XPending((Display *)self->v__dpy) ? v_self : 0; }

XWindow nextEvent_: _evt
{
    XNextEvent((Display *)self->v__dpy, (XEvent *)v__evt);
    _return v__evt;
}

XWindow pollEvent
[
    ^self eventPending
	ifTrue:  [self nextEvent]
        ifFalse: [^nil]
]

XWindow waitEvent
[
    | event |
    [event := self nextEvent] whileFalse.
    ^event
]

XWindow nextEvent
[
    | xEvent event position |
    self nextEvent_: (xEvent := XEvent new).
    event := xEvent asEvent.
    position := event position. 
    position y: windowHeight - position y.
    event position: position; localPosition: position.
    ^event
]

"----------------------------------------------------------------"

XGC : Object ( _dpy _buf _gc canvasWidth canvasHeight )

XWindow newContext
[
    ^XGC withDisplay_: _dpy window_: _buf width: windowWidth height: windowHeight
]

XGC withDisplay_: _d window_: _w width: w height: h
[
    self := self new.
    _dpy := _d.
    _buf := _w.
    canvasWidth  :=  w.
    canvasHeight :=  h.
    {
	GC gc= XCreateGC((Display *)self->v__dpy, (Drawable)self->v__buf, 0, 0);
	self->v__gc= (oop)gc;
    }
]

XGC setSourceColour: aColour
[
    | pixel |
    pixel := ((aColour r * 255) rounded << 16)
	+    ((aColour g * 255) rounded <<  8)
	+    ((aColour b * 255) rounded      ).
    {
	XGCValues gcv;
	gcv.foreground= (long)v_pixel >> 1;
	XChangeGC((Display *)self->v__dpy, (GC)self->v__gc, GCForeground, &gcv);
    }
]

XGC paint
[
    self fillRectangle: (0@0 corner: canvasWidth@canvasHeight).
]

XGC fillRectangle: rect
[
    | x y w h |
    x := rect x.
    y := rect y.
    w := rect width.
    h := rect height.
    {
	XFillRectangle((Display *)self->v__dpy, (Drawable)self->v__buf, (GC)self->v__gc,
		       (long)v_x >> 1, (long)v_y >> 1, (long)v_w >> 1, (long)v_h >> 1);
    }
]

XGC drawRectangle: rect
[
    | x y w h |
    x := rect x.
    y := rect y.
    w := rect width.
    h := rect height.
    {
	XDrawRectangle((Display *)self->v__dpy, (Drawable)self->v__buf, (GC)self->v__gc,
		       (long)v_x >> 1, (long)v_y >> 1, (long)v_w >> 1, (long)v_h >> 1);
    }
]

XGC pixmap: pix at: origin
[
    | x y w h s |
    x := origin x.
    y := origin y.
    w := pix width.
    h := pix height.
    s := pix _drawable.
    {
	XCopyArea((Display *)self->v__dpy, (Drawable)v_s, (Drawable)self->v__buf, (GC)self->v__gc,
		  0, 0, (long)v_w >> 1, (long)v_h >> 1, (long)v_x >> 1, (long)v_y >> 1);
    }
]

XGC showText: t at: p
[
    | x y s l |
    x := p x + 2.
    y := p y + 13.
    s := t _stringValue.
    l := t size.
    {
	XDrawString((Display *)self->v__dpy, (Drawable)self->v__buf, (GC)self->v__gc,
		  (long)v_x >> 1, (long)v_y >> 1, (char *)v_s, (long)v_l >> 1);
    }
]

XGC showText: t from: start to: stop at: p
[
    | x y s l |
    x := p x + 1.
    y := p y + 13.
    s := t _stringValue.
    l := (stop min: t size) - start.
    {
	XDrawString((Display *)self->v__dpy, (Drawable)self->v__buf, (GC)self->v__gc,
		  (long)v_x >> 1, (long)v_y >> 1, (char *)v_s + ((long)v_start >> 1), (long)v_l >> 1);
    }
]

XGC fill
[
]

XGC destroy
{
    XFreeGC((Display *)self->v__dpy, (GC)self->v__gc);
}

XWindow newImage: extent
[
    ^XPixmap withDisplay_: _dpy window_: _win width: extent x height: extent y depth: self depth
]

"----------------------------------------------------------------"

XPixmap : Object ( _dpy _buf pixmapWidth pixmapHeight )

XPixmap withDisplay_: _d window_: _win width: w height: h depth: d
[
    self := self new.
    _dpy := _d.
    pixmapWidth := w.
    pixmapHeight := h.
    {
	self->v__buf= (oop)XCreatePixmap((Display *)self->v__dpy, (Drawable)v__win, (long)v_w >> 1, (long)v_h >> 1, (long)v_d >> 1);
    }
]

XPixmap _drawable	[ ^_buf ]
XPixmap width		[ ^pixmapWidth ]
XPixmap height		[ ^pixmapHeight ]

XPixmap newContext
[
    ^XGC withDisplay_: _dpy window_: _buf width: pixmapWidth height: pixmapHeight
]
