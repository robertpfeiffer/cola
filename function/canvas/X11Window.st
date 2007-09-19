" X11Window.st -- X11 host window support

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

  Last edited: 2007-09-18 20:12:07 by piumarta on emilia
"

{ import: HostWindow }
{ import: Geometry }

{ include <X11/Xlib.h> }
{ include <X11/Xutil.h> }
{ include <X11/extensions/Xdbe.h> }

X11Window : HostWindow ( _dpy _win _buf _vis _gc _dbeMode )

HostWindow withExtent: extent	[ ^X11Window withExtent: extent swapAction: 3 "XdbeCopied" ]

X11Window withExtent: extent swapAction: swapAction
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

X11Window swapBuffers
{
    if (self->v__buf != self->v__win)
    {
	XdbeSwapInfo info= { (Window)self->v__win, (XdbeSwapAction)(long)self->v__dbeMode };
	XdbeSwapBuffers((Display *)self->v__dpy, &info, 1);
    }
}

X11Window flush	{ XFlush((Display *)self->v__dpy); }
X11Window sync	{ XSync((Display *)self->v__dpy, False); }
X11Window purge	{ XSync((Display *)self->v__dpy, True); }

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
	v__string= (oop)_libid->balloc((long)v__n);
	strncpy((char *)v__string, buf, (long)v__n);
    }.
    ^String size_: _n value_: _string
]

{ input: X11WindowUCS4 }

PointerMotionEvent initXEvent: xev
[
    | x y |
    {
	XMotionEvent *xev = (XMotionEvent *)v_xev;
	v_x		  = (oop)(xev->x      << 1 | 1);
	v_y		  = (oop)(xev->y      << 1 | 1);
	self->v_state	  = (oop)(xev->state  << 1 | 1);
    }.
    globalPosition := localPosition := x , y.
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
   globalPosition := localPosition := x , y.
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
    globalPosition := localPosition := x , y.
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
    globalPosition := localPosition := x , y.
]

X11Window eventPending	{ _return XPending((Display *)self->v__dpy) ? v_self : 0; }

X11Window nextEvent_: _evt
{
    XNextEvent((Display *)self->v__dpy, (XEvent *)v__evt);
    _return v__evt;
}

X11Window pollEvent
[
    ^self eventPending
	ifTrue:  [self nextEvent]
        ifFalse: [^nil]
]

X11Window waitEvent
[
    | event |
    [event := self nextEvent] whileFalse.
    ^event
]

X11Window nextEvent
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

X11Window newContext
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
    self fillRectangle: (0,0 corner: canvasWidth,canvasHeight).
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

"----------------------------------------------------------------"

{ import: Cairo }

X11Window newPainter
[
    ^(Cairo withX11Window: self)
	translate:	 (0".5") , (windowHeight" - 0.5");
	scale:		 1 , -1
]

X11Window newCPainter
[
    ^(Cairo withX11Window: self)
	translate:	 (0".5") , (windowHeight" - 0.5");
	scale:		 1 , -1
]

Cairo withX11Window: xWindow	[ ^self withSurface_: xWindow _cairoSurface ]

{ include <cairo.h> }
{ include <cairo-features.h> }
{ include <cairo-xlib.h> }

libcairo _cairo_xlib_surface_create :_dpy :_drawable :_visual :_width :_height {
  cairo_surface_t * _;
  _=(cairo_surface_t *)cairo_xlib_surface_create((Display *)(long)v__dpy, (Drawable)(long)v__drawable, (Visual *)(long)v__visual, (int)(long)v__width, (int)(long)v__height);
  _return (oop)(long)_;
}
libcairo _cairo_xlib_surface_create_for_bitmap :_dpy :_bitmap :_screen :_width :_height {
  cairo_surface_t * _;
  _=(cairo_surface_t *)cairo_xlib_surface_create_for_bitmap((Display *)(long)v__dpy, (Pixmap)(long)v__bitmap, (Screen *)(long)v__screen, (int)(long)v__width, (int)(long)v__height);
  _return (oop)(long)_;
}
libcairo cairo_xlib_surface_set_size :surface :width :height [
    | _ |
    _ := self _cairo_xlib_surface_set_size : surface : width _integerValue : height _integerValue.
    ^_
]
libcairo _cairo_xlib_surface_set_size :_surface :_width :_height {
  cairo_xlib_surface_set_size((cairo_surface_t *)(long)v__surface, (int)(long)v__width, (int)(long)v__height);
}
libcairo cairo_xlib_surface_set_drawable :surface :drawable :width :height [
    | _ |
    _ := self _cairo_xlib_surface_set_drawable : surface : drawable : width _integerValue : height _integerValue.
    ^_
]
libcairo _cairo_xlib_surface_set_drawable :_surface :_drawable :_width :_height {
  cairo_xlib_surface_set_drawable((cairo_surface_t *)(long)v__surface, (Drawable)(long)v__drawable, (int)(long)v__width, (int)(long)v__height);
}
libcairo _cairo_xlib_surface_get_display :_surface {
  Display * _;
  _=(Display *)cairo_xlib_surface_get_display((cairo_surface_t *)(long)v__surface);
  _return (oop)(long)_;
}
libcairo _cairo_xlib_surface_get_drawable :_surface {
  Drawable _;
  _=(Drawable)cairo_xlib_surface_get_drawable((cairo_surface_t *)(long)v__surface);
  _return (oop)(long)_;
}
libcairo _cairo_xlib_surface_get_screen :_surface {
  Screen * _;
  _=(Screen *)cairo_xlib_surface_get_screen((cairo_surface_t *)(long)v__surface);
  _return (oop)(long)_;
}
libcairo _cairo_xlib_surface_get_visual :_surface {
  Visual * _;
  _=(Visual *)cairo_xlib_surface_get_visual((cairo_surface_t *)(long)v__surface);
  _return (oop)(long)_;
}
libcairo cairo_xlib_surface_get_depth :surface [
    | _ |
    _ := self _cairo_xlib_surface_get_depth : surface.
    ^SmallInteger value_: _
]
libcairo _cairo_xlib_surface_get_depth :_surface {
  int _;
  _=(int)cairo_xlib_surface_get_depth((cairo_surface_t *)(long)v__surface);
  _return (oop)(long)_;
}
libcairo cairo_xlib_surface_get_width :surface [
    | _ |
    _ := self _cairo_xlib_surface_get_width : surface.
    ^SmallInteger value_: _
]
libcairo _cairo_xlib_surface_get_width :_surface {
  int _;
  _=(int)cairo_xlib_surface_get_width((cairo_surface_t *)(long)v__surface);
  _return (oop)(long)_;
}
libcairo cairo_xlib_surface_get_height :surface [
    | _ |
    _ := self _cairo_xlib_surface_get_height : surface.
    ^SmallInteger value_: _
]
libcairo _cairo_xlib_surface_get_height :_surface {
  int _;
  _=(int)cairo_xlib_surface_get_height((cairo_surface_t *)(long)v__surface);
  _return (oop)(long)_;
}

X11Window _cairoSurface		[ ^libcairo _cairo_xlib_surface_create :_dpy :_buf :_vis :windowWidth :windowHeight ]
