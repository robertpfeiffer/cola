; primCanvas.beginPath()
; primCanvas.createClippingCanvas(x, y, width, height)
; primCanvas.createTextBox(textString)
; primCanvas.drawEllipse(x, y, width, height)
; primCanvas.fill()
; primCanvas.fillEllipse(x, y, width, height)
; primCanvas.lineTo(y, y)
; primCanvas.moveTo(x, y)
; primCanvas.renderText(textBox, x, y, compositionWidth)
; primCanvas.repaint()
; primCanvas.setClippingRectangle(x,y,width,height)
; primCanvas.setFillStyle(fillStyle)
; primCanvas.setLineWidth(borderWidth)
; primCanvas.stroke()

(load "xlib.k")
(load "trig.k")
(load "point.k")
(load "polygon.k")

(define outer 300)	;(define outer 200)
(define inner 120)	;(define inner  80)

(define polygon
  (let ((p (XPolygon-new 11)))
    (XPoint-setPolar (XPolygon-at p  0) outer   0)
    (XPoint-setPolar (XPolygon-at p  1) inner  36)
    (XPoint-setPolar (XPolygon-at p  2) outer  72)
    (XPoint-setPolar (XPolygon-at p  3) inner 108)
    (XPoint-setPolar (XPolygon-at p  4) outer 144)
    (XPoint-setPolar (XPolygon-at p  5) inner 180)
    (XPoint-setPolar (XPolygon-at p  6) outer 216)
    (XPoint-setPolar (XPolygon-at p  7) inner 252)
    (XPoint-setPolar (XPolygon-at p  8) outer 288)
    (XPoint-setPolar (XPolygon-at p  9) inner 324)
    (XPoint-setPolar (XPolygon-at p 10) outer   0)
    p))

(define pos-x 200)
(define pos-y 200)

(XPolygon-translate polygon polygon pos-x pos-y)

(define polygon2 (XPolygon-new (XPolygon-size polygon)))

(define angle 0)

(define draw
  (lambda (dpy win gc)
    ;;(XClearArea dpy win 0 0 600 400 0)
    (XPolygon-rotate polygon2 polygon pos-x pos-y angle)
    (set angle (+ angle 1))
    ;(XGC-setLineWidth dpy gc 4)
    ;(XGC-setForeground dpy gc 0xff0000)
    ;(XDrawLines dpy win gc (XPolygon-points polygon2) (XPolygon-size polygon2) 0)
    (XGC-setForeground dpy gc 0xffff00)
    (XFillPolygon dpy win gc (XPolygon-points polygon2) (XPolygon-size polygon2) 0 0)
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
	    (XPolygon-translate polygon polygon dx dy)
	    (set pos-x (+ pos-x dx))
	    (set pos-y (+ pos-y dy)))))))

(define doit
  (lambda (dname)
    (let ((dpy  (XOpenDisplay dname))
	  (root (XDefaultRootWindow dpy))
	  (win  (XCreateSimpleWindow dpy root 0 0 600 400 5 0 0))
	  (buf  (if (and XdbeQueryExtension
			 (let ((x 0)(y 0))
			   (XdbeQueryExtension dpy (addrof x) (addrof y))))
		    (XdbeAllocateBackBufferName dpy win 1)
		    win))
	  (gc   (XDefaultGC dpy))
	  (xwa  (malloc 60)))
      (set (int@ (+ xwa 40))	; event mask
	   (| (<< 1  0)	; KeyPressMask
	      (<< 1  1)	; KeyReleaseMask
	      (<< 1  2)	; ButtonPressMask
	      (<< 1  3)	; ButtonReleaseMask
	     ;(<< 1  4)	; EnterWindowMask
	     ;(<< 1  5)	; LeaveWindowMask
	      (<< 1  6)	; PointerMotionMask
	     ;(<< 1  7)	; PointerMotionHintMask
	     ;(<< 1  8)	; Button1MotionMask
	     ;(<< 1  9)	; Button2MotionMask
	     ;(<< 1 10)	; Button3MotionMask
	     ;(<< 1 11)	; Button4MotionMask
	     ;(<< 1 12)	; Button5MotionMask
	     ;(<< 1 13)	; ButtonMotionMask
	     ;(<< 1 14)	; KeymapStateMask
	      (<< 1 15)	; ExposureMask
	      (<< 1 16)	; VisibilityChangeMask
	     ;(<< 1 17)	; StructureNotifyMask
	     ;(<< 1 18)	; ResizeRedirectMask
	     ;(<< 1 19)	; SubstructureNotifyMask
	     ;(<< 1 20)	; SubstructureRedirectMask
	     ;(<< 1 21)	; FocusChangeMask
	     ;(<< 1 22)	; PropertyChangeMask
	     ;(<< 1 23)	; ColormapChangeMask
	     ;(<< 1 24)	; OwnerGrabButtonMask
	      ))
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
