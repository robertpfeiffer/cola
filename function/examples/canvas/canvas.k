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

(define XFlush			(_dlsym libX11 "XFlush"))
(define XSync			(_dlsym libX11 "XSync"))
(define XMapWindow		(_dlsym libX11 "XMapWindow"))
(define XDestroyWindow		(_dlsym libX11 "XDestroyWindow"))
(define XClearArea		(_dlsym libX11 "XClearArea"))
(define XDrawLines		(_dlsym libX11 "XDrawLines"))
(define XFillPolygon		(_dlsym libX11 "XFillPolygon"))
(define XDrawString		(_dlsym libX11 "XDrawString"))
(define XLoadFont		(_dlsym libX11 "XLoadFont"))
(define XPending		(_dlsym libX11 "XPending"))
(define XNextEvent		(_dlsym libX11 "XNextEvent"))
(define XChangeGC		(_dlsym libX11 "XChangeGC"))
(define XSetWindowBackground	(_dlsym libX11 "XSetWindowBackground"))
(define XChangeWindowAttributes	(_dlsym libX11 "XChangeWindowAttributes"))

(define libXext (dlopen "libXext"))

(define XdbeQueryExtension		(_dlsym libXext "XdbeQueryExtension"))
(define XdbeAllocateBackBufferName	(_dlsym libXext "XdbeAllocateBackBufferName"))
(define XdbeSwapBuffers			(_dlsym libXext "XdbeSwapBuffers"))

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

(define outer 300)	;(define outer 200)
(define inner 120)	;(define inner  80)

(define polygon
  (let ((points (malloc 1024)))
    (XPoint-setPolar (+ points  0) outer   0)
    (XPoint-setPolar (+ points  4) inner  36)
    (XPoint-setPolar (+ points  8) outer  72)
    (XPoint-setPolar (+ points 12) inner 108)
    (XPoint-setPolar (+ points 16) outer 144)
    (XPoint-setPolar (+ points 20) inner 180)
    (XPoint-setPolar (+ points 24) outer 216)
    (XPoint-setPolar (+ points 28) inner 252)
    (XPoint-setPolar (+ points 32) outer 288)
    (XPoint-setPolar (+ points 36) inner 324)
    (XPoint-setPolar (+ points 40) outer   0)
    points))

(define pos-x 200)
(define pos-y 200)

(translate polygon polygon pos-x pos-y 11)

(define polygon2 (malloc 1024))

(define angle 0)

(define draw
  (lambda (dpy win gc)
    ;;(XClearArea dpy win 0 0 600 400 0)
    (rotate polygon2 polygon angle pos-x pos-y 11)
    (set angle (+ angle 1))
    ;(XGC-setLineWidth dpy gc 4)
    ;(XGC-setForeground dpy gc 0xff0000)
    ;(XDrawLines dpy win gc polygon2 11 0)
    (XGC-setForeground dpy gc 0xffff00)
    (XFillPolygon dpy win gc polygon2 11 0 0)
    (XSync dpy 0)))

(define mouse-x 0)
(define mouse-y 0)
(define tracking 0)

(define mouse-down
  (lambda (x y)
    (set mouse-x x)
    (set mouse-y y)
    (set tracking 1)))

(define mouse-up
  (lambda (x y)
    (set tracking 0)))

(define mouse-move
  (lambda (x y)
    (if tracking
	(begin
	  (let ((dx (- x mouse-x))
		(dy (- y mouse-y)))
	    (set mouse-x x)
	    (set mouse-y y)
	    (translate polygon polygon dx dy 11)
	    (set pos-x (+ pos-x dx))
	    (set pos-y (+ pos-y dy)))))))

(define doit
  (lambda (dname)
    (let ((dpy  (XOpenDisplay dname))
	  (root (XDefaultRootWindow dpy))
	  (win  (XCreateSimpleWindow dpy root
				     0 0 600 400
				     5
				     0 ; 0 arg count
				     ))
	  (buf  (if (and XdbeQueryExtension
			 (let ((x 0)(y 0))
			   (XdbeQueryExtension dpy (addrof x) (addrof y))))
		    (XdbeAllocateBackBufferName dpy win 1)
		    win))
	  (gc   (XDefaultGC dpy))
	  (xwa  (malloc 60)))
      (set (int@ (+ xwa 40))	;; event mask
	   (| (<< 1  0)		;; KeyPressMask
	      (<< 1  1) 	;; KeyReleaseMask
	      (<< 1  2) 	;; ButtonPressMask
	      (<< 1  3) 	;; ButtonReleaseMask
	      (<< 0  4) 	;; EnterWindowMask
	      (<< 0  5) 	;; LeaveWindowMask
	      (<< 1  6) 	;; PointerMotionMask
	      (<< 0  7) 	;; PointerMotionHintMask
	      (<< 0  8) 	;; Button1MotionMask
	      (<< 0  9) 	;; Button2MotionMask
	      (<< 0 10)		;; Button3MotionMask
	      (<< 0 11)		;; Button4MotionMask
	      (<< 0 12)		;; Button5MotionMask
	      (<< 0 13)		;; ButtonMotionMask
	      (<< 0 14)		;; KeymapStateMask
	      (<< 1 15)		;; ExposureMask
	      (<< 1 16)		;; VisibilityChangeMask
	      (<< 0 17)		;; StructureNotifyMask
	      (<< 0 18)		;; ResizeRedirectMask
	      (<< 0 19)		;; SubstructureNotifyMask
	      (<< 0 20)		;; SubstructureRedirectMask
	      (<< 0 21)		;; FocusChangeMask
	      (<< 0 22)		;; PropertyChangeMask
	      (<< 0 23)		;; ColormapChangeMask
	      (<< 0 24)))	;; OwnerGrabButtonMask
      (XChangeWindowAttributes dpy win 2048 xwa)
      (XSetWindowBackground dpy win -1)
      (XMapWindow dpy win)
      (XSync dpy 0)
      (let ((evt  (malloc 96))
	    (info (malloc 8)))
	(set (int@ info 0) win)
	(set (int@ info 1) 1)	; XdbeBackground
	(while 1
	  (if (XPending dpy)
	      (begin
		(XNextEvent dpy evt)
		(let ((type (int@ evt)))
		  (if (== 2 type) (return 0))
		  (if (== 4 type) (mouse-down (int@ evt 8) (int@ evt 9)))
		  (if (== 5 type) (mouse-up   (int@ evt 8) (int@ evt 9)))
		  (if (== 6 type) (mouse-move (int@ evt 8) (int@ evt 9)))
		  0))
	      (begin
		(if (== win buf) (XClearArea dpy win 0 0 600 400 0))
		(draw dpy buf gc)
		(if (!= win buf) (XdbeSwapBuffers dpy info 1))))))
      (XDestroyWindow dpy buf)
      (XDestroyWindow dpy win)
      (XFlush dpy))))

(doit 0)	; 0 => value of DISPLAY variable


(dlclose libXext)
(dlclose libX11)
