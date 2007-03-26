(define getenv (dlsym "getenv"))

(or (getenv "DISPLAY")
    (error "set your `DISPLAY' variable and try again"))

(define libX11 (dlopen "libX11"))

(define XOpenDisplay		(dlsym "XOpenDisplay"))
(define XCreateSimpleWindow	(dlsym "XCreateSimpleWindow"))
(define XDefaultRootWindow	(dlsym "XDefaultRootWindow"))
(define XDefaultScreen		(dlsym "XDefaultScreen"))

(define %x-default-depth	(dlsym "XDefaultDepth"))

(define XDefaultDepth
  (lambda (dpy)
    (%x-default-depth dpy (XDefaultScreen dpy))))

(define %x-default-visual	(dlsym "XDefaultVisual"))

(define XDefaultVisual
  (lambda (dpy)
    (%x-default-visual dpy (XDefaultScreen dpy))))

(define %x-default-gc		(dlsym "XDefaultGC"))

(define XDefaultGC
  (lambda (dpy)
    (%x-default-gc dpy (XDefaultScreen dpy))))

(define XFlush			(dlsym "XFlush"))
(define XSync			(dlsym "XSync"))
(define XMapWindow		(dlsym "XMapWindow"))
(define XDestroyWindow		(dlsym "XDestroyWindow"))
(define XClearArea		(dlsym "XClearArea"))
(define XDrawLines		(dlsym "XDrawLines"))
(define XFillPolygon		(dlsym "XFillPolygon"))
(define XDrawString		(dlsym "XDrawString"))
(define XLoadFont		(dlsym "XLoadFont"))
(define XPending		(dlsym "XPending"))
(define XNextEvent		(dlsym "XNextEvent"))
(define XChangeGC		(dlsym "XChangeGC"))
(define XSetWindowBackground	(dlsym "XSetWindowBackground"))
(define XChangeWindowAttributes	(dlsym "XChangeWindowAttributes"))

(dlclose libX11)

(syntax XPoint-new	(lambda (form compiler) `(malloc 4)))
(syntax XPoint-x	(lambda (form compiler) `(short@ ,[form second] 0)))
(syntax XPoint-y	(lambda (form compiler) `(short@ ,[form second] 1)))

(define %gcv (malloc 92))

(define XGC-setForeground	(lambda (dpy gc pixel) (set (int@ %gcv 2) pixel) (XChangeGC dpy gc  4 %gcv)))
(define XGC-setBackground	(lambda (dpy gc pixel) (set (int@ %gcv 3) pixel) (XChangeGC dpy gc  8 %gcv)))
(define XGC-setLineWidth	(lambda (dpy gc width) (set (int@ %gcv 4) width) (XChangeGC dpy gc 16 %gcv)))

(load "trig.k")

(define XPoint-setPolar
  (lambda (p r a)
    (let ((ca (cos a))
	  (sa (sin a)))
      (set (short@ p 0) (- (mul16 r ca) (mul16 r sa)))
      (set (short@ p 1) (+ (mul16 r sa) (mul16 r ca))))
    p))

(define polygon
  (let ((points (malloc 1024)))
    (XPoint-setPolar (+ points  0) 150   0)
    (XPoint-setPolar (+ points  4)  60  36)
    (XPoint-setPolar (+ points  8) 150  72)
    (XPoint-setPolar (+ points 12)  60 108)
    (XPoint-setPolar (+ points 16) 150 144)
    (XPoint-setPolar (+ points 20)  60 180)
    (XPoint-setPolar (+ points 24) 150 216)
    (XPoint-setPolar (+ points 28)  60 252)
    (XPoint-setPolar (+ points 32) 150 288)
    (XPoint-setPolar (+ points 36)  60 324)
    (XPoint-setPolar (+ points 40) 150   0)
    points))

(translate polygon polygon 200 200 11)

(define polygon2 (malloc 1024))

(define angle 0)

(define draw
  (lambda (dpy win gc)
    ;;(XDrawString dpy win gc 4 28 "unmap (iconify)" 15)
    ;;(XDrawString dpy win gc 4 42 "  me to exit.  " 15)
    (XClearArea dpy win 0 0 600 400 0)
    (rotate polygon2 polygon angle 200 200 11)
    (set angle (+ angle 1))
    (XGC-setLineWidth dpy gc 8)
    (XGC-setForeground dpy gc 0xff0000)
    (XDrawLines dpy win gc polygon2 11 0)
    (XGC-setForeground dpy gc 0xffff00)
    (XFillPolygon dpy win gc polygon2 11 0 0)
    (XSync dpy 0)))

(define doit
  (lambda (dname)
    (let ((dpy  (XOpenDisplay dname))
	  (root (XDefaultRootWindow dpy))
	  (win  (XCreateSimpleWindow dpy root
				     0 0 600 400
				     5
				     0 ; 0 arg count
				     ))
	  (gc   (XDefaultGC dpy))
	  (xwa  (malloc 60)))
      (set (int@ (+ xwa 40)) 0x1ffffff)	; event mask
      (XChangeWindowAttributes dpy win 2048 xwa)
      (XSetWindowBackground dpy win -1)
      (XMapWindow dpy win)
      (XSync dpy 0)
      (let ((evt (malloc 96)))
	(while 1
	  (if (XPending dpy)
	      (begin
		(XNextEvent dpy evt)
		(let ((type (int@ evt)))
		  (if (== 2 type) (return 0))
		  (if (== 4 type) (return 0))
		  0))
	      (draw dpy win gc))))
      (XDestroyWindow dpy win)
      (XFlush dpy))))

(doit 0)	; 0 => value of DISPLAY variable
