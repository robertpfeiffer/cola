(define no-op (lambda () 0))

(define document.onmousedown no-op)
(define document.onmouseup   no-op)
(define document.onmousemove no-op)
(define document.onkeydown   no-op)
(define document.onkeyup     (lambda (evt) (exit 0)))

(load "list.k")
(load "xlib.k")
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
