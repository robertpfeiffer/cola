(load "libx11.k")
(load "libcairo.k")

(define xdbe-action 3)

(define dpy  (XOpenDisplay 0))
(define root (XDefaultRootWindow dpy))
(define win  (XCreateSimpleWindow dpy root 0 0 600 400 5 0 -1))
(define buf  (let ((x 0) (y 0))
	       (if (XdbeQueryExtension dpy (addrof x) (addrof y))
		   (XdbeAllocateBackBufferName dpy win xdbe-action)
		   win)))

(define xdbe (!= win buf))

(let ((xwa  (malloc 60)))
  (set (int@ (+ xwa 40))
       (| (<< 1  0)	;; KeyPressMask
	  (<< 1  1)	;; KeyReleaseMask
	  (<< 1  2)	;; ButtonPressMask
	  (<< 1  3)	;; ButtonReleaseMask
	  ;;(<< 1  4)	;; EnterWindowMask
	  ;;(<< 1  5)	;; LeaveWindowMask
	  (<< 1  6)	;; PointerMotionMask
	  ;;(<< 1  7)	;; PointerMotionHintMask
	  ;;(<< 1  8)	;; Button1MotionMask
	  ;;(<< 1  9)	;; Button2MotionMask
	  ;;(<< 1 10)	;; Button3MotionMask
	  ;;(<< 1 11)	;; Button4MotionMask
	  ;;(<< 1 12)	;; Button5MotionMask
	  ;;(<< 1 13)	;; ButtonMotionMask
	  ;;(<< 1 14)	;; KeymapStateMask
	  (<< 1 15)	;; ExposureMask
	  (<< 1 16)	;; VisibilityChangeMask
	  ;;(<< 1 17)	;; StructureNotifyMask
	  ;;(<< 1 18)	;; ResizeRedirectMask
	  ;;(<< 1 19)	;; SubstructureNotifyMask
	  ;;(<< 1 20)	;; SubstructureRedirectMask
	  ;;(<< 1 21)	;; FocusChangeMask
	  ;;(<< 1 22)	;; PropertyChangeMask
	  ;;(<< 1 23)	;; ColormapChangeMask
	  ;;(<< 1 24)	;; OwnerGrabButtonMask
	  ))
  (XChangeWindowAttributes dpy win 2048 xwa))

(XMapWindow dpy win)

(define sfc (send '_cairo_xlib_surface_create libcairo dpy buf (XDefaultVisual dpy (XDefaultScreen dpy)) 600 400))

(define evt (malloc 96))

(define tracking 0)

(define mouse-x 0)
(define mouse-y 0)

(define pos-x 10.0)
(define pos-y 10.0)

(define start-tracking
  (lambda (x y)
    (define tracking 1)
    (set mouse-x x)
    (set mouse-y y)))

(define stop-tracking
  (lambda (x y)
    (set tracking 0)))

(define do-tracking
  (lambda (x y)
    (if tracking
	(let ((dx (- x mouse-x))
	      (dy (- y mouse-y)))
	  (set pos-x [pos-x + [SmallInteger value_: dx]])
	  (set pos-y [pos-y + [SmallInteger value_: dy]])
	  (set mouse-x x)
	  (set mouse-y y)))))

(define angle 0.0)

(define info (malloc 8))

(set (int@ info 0) win)
(set (int@ info 1) xdbe-action)

(define draw
  (lambda ()
    (let ((cr (send '_cairo_create libcairo sfc)))
      (send 'cairo_set_source_rgb libcairo cr 1.0 1.0 1.0)
      (send 'cairo_paint libcairo cr)
      (send 'cairo_set_source_rgb libcairo cr 1.0 0.0 0.0)
      (send 'cairo_rectangle libcairo cr pos-x pos-y 100.0 100.0)
      (send 'cairo_set_font_size libcairo cr 20.0)
      (send '_cairo_rotate libcairo cr angle)
      (set angle [angle + '0.00872664611111111111])
      (send '_cairo_show_text libcairo cr "Dude dis be smoe UTF8!")
      (send '_cairo_stroke libcairo cr)
      (send '_cairo_destroy libcairo cr))
    (if xdbe
	(XdbeSwapBuffers dpy info 1)
	(XFlush dpy))))

(draw)

(while 1
  (XNextEvent dpy evt)
  (let ((type (int@ evt)))
    (if (== type 3) (exit 0))
    (if (== type 4) (start-tracking (int@ evt 8) (int@ evt 9)))
    (if (== type 5) (stop-tracking  (int@ evt 8) (int@ evt 9)))
    (if (== type 6)
	(begin
	  (do-tracking (int@ evt 8) (int@ evt 9))
	  (draw)))))

(exit 0)

(define no-op (lambda () 0))

(define document.onmousedown no-op)
(define document.onmouseup   no-op)
(define document.onmousemove no-op)
(define document.onkeydown   no-op)
(define document.onkeyup     (lambda (evt) (exit 0)))

(load "list.k")
(load "trig.k")
(load "point.k")
(load "polygon.k")
(load "text.k")
(load "canvas.k")

(define polygon
  (let ((p     (XPolygon-new 11))
	(outer 300)	;(define outer 200)
	(inner 120))	;(define inner  80)
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

(define polygon2 (XPolygon-new (XPolygon-size polygon)))

(define pos-x 200)
(define pos-y 200)

(XPolygon-translate polygon polygon pos-x pos-y)

(define angle 0)

(define text (malloc 1024))
(define textBox 0)

(define strlen (dlsym "strlen"))

(define draw
  (lambda (c)
    ;;(XClearArea dpy win 0 0 600 400 0)
    (XPolygon-rotate polygon2 polygon pos-x pos-y angle)
    (set angle (+ angle 1))
    ;(XGC-setLineWidth dpy gc 4)
    ;(XGC-setForeground dpy gc 0xff0000)
    ;(XDrawLines dpy win gc (XPolygon-points polygon2) (XPolygon-size polygon2) 0)
    (Canvas-clear c)
    (Canvas-fillStyle c "yellow")
    (Canvas-beginPath c)
    (Canvas-moveTo c (XPolygon-xAt polygon2 0) (XPolygon-yAt polygon2 0))
    (for (i 1 1 (- (XPolygon-size polygon2) 1))
      (Canvas-lineTo c (XPolygon-xAt polygon2 i) (XPolygon-yAt polygon2 i)))
    (Canvas-fill c)
    (sprintf text "(%d,%d)" pos-x pos-y)
    (Canvas-fillStyle c "black")
    (let ((box (Canvas-createTextBox c text 0 (strlen text))))
      (Canvas-renderText c box pos-x pos-y)
      (Canvas-setLineWidth c 1)
      (Canvas-fillStyle c "red")
      (let ((r (Text-getBounds box 2)))
	(XRectangle-translate-xy r pos-x pos-y)
	(Canvas-drawEllipse c (XRectangle-x r) (XRectangle-y r) (XRectangle-width r) (XRectangle-height r))))
    (Canvas-repaint c)))

(define mouse-x  0)
(define mouse-y  0)
(define tracking 0)

(define mouse-down
  (lambda (evt)
    (set mouse-x (Event-x evt))
    (set mouse-y (Event-y evt))
    (set tracking 1)))

(define mouse-up
  (lambda (evt)
    (set tracking 0)))

(define mouse-move
  (lambda (evt)
    (if tracking
	(begin
	  (let ((x  (Event-x evt))
		(y  (Event-y evt))
		(dx (- x mouse-x))
		(dy (- y mouse-y)))
	    (set mouse-x x)
	    (set mouse-y y)
	    (XPolygon-translate polygon polygon dx dy)
	    (set pos-x (+ pos-x dx))
	    (set pos-y (+ pos-y dy)))))))

(let ((c (Canvas-new)))
  (set document.onmousedown mouse-down)
  (set document.onmouseup   mouse-up)
  (set document.onmousemove mouse-move)
  (set textBox (Canvas-createTextBox c text))
  (while 1
    (Canvas-handleEvents c)
    (draw c)))
