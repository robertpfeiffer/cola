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

(syntax Text-string	(lambda (node compiler) `(long@ ,[node second] 0)))
(syntax Text-start	(lambda (node compiler) `(long@ ,[node second] 1)))
(syntax Text-count	(lambda (node compiler) `(long@ ,[node second] 2)))
(syntax Text-charWidth	(lambda (node compiler) `(long@ ,[node second] 3)))
(syntax Text-charHeight	(lambda (node compiler) `(long@ ,[node second] 4)))

(syntax Text-new	(lambda (node compiler) `(GC_malloc 20)))

; primCanvas.createTextBox(string, startIndex, charCount) -> textBox on [startIndex, startIndex + charCount] in string

(define Canvas-createTextBox
  (lambda (c string startIndex charCount)
    (let ((t (Text-new)))
      (set (Text-string     t) string)
      (set (Text-start      t) startIndex)
      (set (Text-count      t) charCount)
      (set (Text-charWidth  t)  6)	; default
      (set (Text-charHeight t) 13)	; default
      t)))

; primCanvas.renderText(textBox, x, y) paints textBox in [startIndex, startIndex + charCount] on the screen at (x, y)

(define Canvas-renderText
  (lambda (c box x y)
    (XDrawString (Canvas-dpy c) (Canvas-buf c) (Canvas-gc c) x y (Text-string box) (Text-count box))))

; textBox.getBounds(offset) -> bounding rectangle for char at startIndex + offset (or nil if offset >= charCount)

;; (define Text-getBounds
;;   (lambda (t offset)
;;     (if (and (< 0 offset) (< offset (Text-count t)))
;; 	(let ((w (Text-charWidth  t))
;; 	      (h (Text-charHeight t)))
;; 	  (XRectangle-new (* w offset) (* h offset) (* w (+ 1 offset)) (* h (+ 1 offset))))
;; 	0)))

; textBox.getIndex(point) -> index of char in [ startIndex , startIndex + charCount ] nearest to point

; textBox.stopIndex(textBox, pixelWidth) -> indexOfLastChar in [ startIndex, startIndex + charCount ]  < pixelWidth

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
    (Canvas-renderText c (Canvas-createTextBox c text 0 (strlen text)) pos-x pos-y)
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
