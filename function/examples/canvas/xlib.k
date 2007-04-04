(define getenv (dlsym "getenv"))

(or (getenv "DISPLAY")
    (error "set your `DISPLAY' variable and try again"))

(define libX11 (dlopen "libX11"))

(define XOpenDisplay		(_dlsym libX11 "XOpenDisplay"))
(define XCreateSimpleWindow	(_dlsym libX11 "XCreateSimpleWindow"))
(define XDefaultRootWindow	(_dlsym libX11 "XDefaultRootWindow"))
(define XDefaultScreen		(_dlsym libX11 "XDefaultScreen"))

(define %x-default-depth	(_dlsym libX11 "XDefaultDepth"))

(define XDefaultDepth
  (lambda (dpy)
    (%x-default-depth dpy (XDefaultScreen dpy))))

(define %x-default-visual	(_dlsym libX11 "XDefaultVisual"))

(define XDefaultVisual
  (lambda (dpy)
    (%x-default-visual dpy (XDefaultScreen dpy))))

(define %x-default-gc		(_dlsym libX11 "XDefaultGC"))

(define XDefaultGC
  (lambda (dpy)
    (%x-default-gc dpy (XDefaultScreen dpy))))

(define %x-default-colormap	(_dlsym libX11 "XDefaultColormap"))

(define XDefaultColormap
  (lambda (dpy)
    (%x-default-colormap dpy (XDefaultScreen dpy))))

(define XFlush			(_dlsym libX11 "XFlush"))
(define XSync			(_dlsym libX11 "XSync"))
(define XMapWindow		(_dlsym libX11 "XMapWindow"))
(define XDestroyWindow		(_dlsym libX11 "XDestroyWindow"))
(define XClearArea		(_dlsym libX11 "XClearArea"))
(define XClearWindow		(_dlsym libX11 "XClearWindow"))
(define XDrawLines		(_dlsym libX11 "XDrawLines"))
(define XFillPolygon		(_dlsym libX11 "XFillPolygon"))
(define XDrawString		(_dlsym libX11 "XDrawString"))
(define XDrawArc		(_dlsym libX11 "XDrawArc"))
(define XFillArc		(_dlsym libX11 "XFillArc"))
(define XLoadFont		(_dlsym libX11 "XLoadFont"))
(define XPending		(_dlsym libX11 "XPending"))
(define XNextEvent		(_dlsym libX11 "XNextEvent"))
(define XChangeGC		(_dlsym libX11 "XChangeGC"))
(define XSetWindowBackground	(_dlsym libX11 "XSetWindowBackground"))
(define XGetWindowAttributes	(_dlsym libX11 "XGetWindowAttributes"))
(define XChangeWindowAttributes	(_dlsym libX11 "XChangeWindowAttributes"))
(define XCreateColormap		(_dlsym libX11 "XCreateColormap"))
(define XLookupColor		(_dlsym libX11 "XLookupColor"))
(define XParseColor		(_dlsym libX11 "XParseColor"))
(define XAllocNamedColor	(_dlsym libX11 "XAllocNamedColor"))
(define XSetClipRectangles	(_dlsym libX11 "XSetClipRectangles"))

(define libXext (dlopen "libXext"))

(define XdbeQueryExtension		(_dlsym libXext "XdbeQueryExtension"))
(define XdbeAllocateBackBufferName	(_dlsym libXext "XdbeAllocateBackBufferName"))
(define XdbeSwapBuffers			(_dlsym libXext "XdbeSwapBuffers"))

(define %gcv (malloc 92))

(define XGC-setForeground	(lambda (dpy gc pixel) (set (int@ %gcv 2) pixel) (XChangeGC dpy gc  4 %gcv)))
(define XGC-setBackground	(lambda (dpy gc pixel) (set (int@ %gcv 3) pixel) (XChangeGC dpy gc  8 %gcv)))
(define XGC-setLineWidth	(lambda (dpy gc width) (set (int@ %gcv 4) width) (XChangeGC dpy gc 16 %gcv)))

(syntax XColor-new	(lambda (node compiler) `(malloc 12)))
(syntax XColor-pixel	(lambda (node compiler) `(long@ ,[node second])))

(syntax XDisplay-fd	(lambda (node compiler) `(long@ ,[node second] 2)))
