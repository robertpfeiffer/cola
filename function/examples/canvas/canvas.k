(syntax Canvas-dpy	(lambda (node compiler) `(long@ ,[node second]  )))
(syntax Canvas-win	(lambda (node compiler) `(long@ ,[node second] 1)))
(syntax Canvas-buf	(lambda (node compiler) `(long@ ,[node second] 2)))
(syntax Canvas-gc	(lambda (node compiler) `(long@ ,[node second] 3)))
(syntax Canvas-path	(lambda (node compiler) `(long@ ,[node second] 4)))

(define Canvas-new
  (lambda ()
    (let ((canv (malloc 20))
	  (dpy  (XOpenDisplay 0))
	  (root (XDefaultRootWindow dpy))
	  (win  (XCreateSimpleWindow dpy root 0 0 600 400 5 0 0))
	  (buf  (if (and XdbeQueryExtension
			 (let ((x 0) (y 0)
			       (q (XdbeQueryExtension dpy (addrof x) (addrof y))))
			   (or q (printf "dbe disabled (server version %d.%d)\n" x y))
			   q))
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
      (set (Canvas-dpy  canv) dpy)
      (set (Canvas-win  canv) win)
      (set (Canvas-buf  canv) buf)
      (set (Canvas-gc   canv) gc)
      (set (Canvas-path canv) (XPolygon-new 32))
      (XFlush dpy)
      canv)))

(define GC_malloc	(dlsym "GC_malloc"))

(syntax Event-x		(lambda (node compiler) `(int@ ,[node second] 0)))
(syntax Event-y		(lambda (node compiler) `(int@ ,[node second] 1)))
(syntax Event-detail1	(lambda (node compiler) `(int@ ,[node second] 2)))
(syntax Event-detail2	(lambda (node compiler) `(int@ ,[node second] 3)))

(define Event-new	(lambda (x y a b)
			  (let ((e (GC_malloc 16)))
			    (set (Event-x	e) x)
			    (set (Event-y	e) y)
			    (set (Event-detail1 e) a)
			    (set (Event-detail2 e) b)
			    e)))

(syntax XEvent-type		(lambda (node compiler) `(int@ ,[node second])))

(syntax XKeyEvent-x		(lambda (node compiler) `(int@ ,[node second]  8)))
(syntax XKeyEvent-y		(lambda (node compiler) `(int@ ,[node second]  9)))
(syntax XKeyEvent-state		(lambda (node compiler) `(int@ ,[node second] 12)))
(syntax XKeyEvent-keycode	(lambda (node compiler) `(int@ ,[node second] 13)))

(syntax XButtonEvent-x		(lambda (node compiler) `(int@ ,[node second]  8)))
(syntax XButtonEvent-y		(lambda (node compiler) `(int@ ,[node second]  9)))
(syntax XButtonEvent-state	(lambda (node compiler) `(int@ ,[node second] 12)))
(syntax XButtonEvent-button	(lambda (node compiler) `(int@ ,[node second] 13)))

(define Event-fromXKeyEvent	(lambda (e) (Event-new (XKeyEvent-x    e) (XKeyEvent-y    e) (XKeyEvent-state    e) (XKeyEvent-keycode   e))))
(define Event-fromXButtonEvent	(lambda (e) (Event-new (XButtonEvent-x e) (XButtonEvent-y e) (XButtonEvent-state e) (XButtonEvent-button e))))

(define %Canvas-evt (malloc 96))

(define Canvas-handleEvents
  (lambda (c)
    (while (XPending (Canvas-dpy c))
      (begin
	(XNextEvent (Canvas-dpy c) %Canvas-evt)
	(let ((type (XEvent-type %Canvas-evt)))
	  (if (== 2 type) (document.onkeydown   (Event-fromXKeyEvent    %Canvas-evt)))
	  (if (== 3 type) (document.onkeyup     (Event-fromXKeyEvent    %Canvas-evt)))
	  (if (== 4 type) (document.onmousedown (Event-fromXButtonEvent %Canvas-evt)))
	  (if (== 5 type) (document.onmouseup   (Event-fromXButtonEvent %Canvas-evt)))
	  (if (== 6 type) (document.onmousemove (Event-fromXButtonEvent %Canvas-evt))))))))

(define Canvas-clear
  (lambda (c)
    (if (== (Canvas-win c) (Canvas-buf c))
	(XClearWindow (Canvas-dpy c) (Canvas-win c)))
    (XPolygon-clear (Canvas-path c))))

(define Canvas-setClipRectangle
  (lambda (c x y w h)
    (let ((r (XRectangle-new)))
      (set (XRectangle-x      r) x)
      (set (XRectangle-y      r) y)
      (set (XRectangle-width  r) w)
      (set (XRectangle-height r) h)
      (XSetClipRectangles (Canvas-dpy c) (Canvas-gc c) 0 0 r 1 0))))

(define %Canvas-x 0)
(define %Canvas-y 0)

; primCanvas.beginPath()

(define Canvas-beginPath
  (lambda (c)
    (XPolygon-clear (Canvas-path c))))

; primCanvas.createClippingCanvas(x, y, width, height)

(define Canvas-createClippingCanvas
  (lambda (c x y w h)
    (printf "Canvas-createClippingCanvas %d %d %d %d\n" x y w h)
    c))

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

; primCanvas.drawEllipse(x, y, width, height)

(define Canvas-drawEllipse
  (lambda (c x y w h)
    (XDrawArc (Canvas-dpy c) (Canvas-buf c) (Canvas-gc c) x y w h 0 23040)))

; primCanvas.fill()

(define Canvas-fill
  (lambda (c)
    (let ((path (Canvas-path c)))
      (XFillPolygon (Canvas-dpy c) (Canvas-buf c) (Canvas-gc c) (XPolygon-points path) (XPolygon-size path) 0 0)
      (XPolygon-clear path))))

; primCanvas.fillEllipse(x, y, width, height)

(define Canvas-fillEllipse
  (lambda (c x y w h)
    (XFillArc (Canvas-dpy c) (Canvas-buf c) (Canvas-gc c) x y w h 0 23040)))

; primCanvas.lineTo(y, y)

(define Canvas-lineTo
  (lambda (c x y)
    (let ((path (Canvas-path c))
	  (size (XPolygon-size path)))
      (if (== 0 size)
	  (XPolygon-add-xy path %Canvas-x %Canvas-y))
      (XPolygon-add-xy path (set %Canvas-x x) (set %Canvas-y y)))))

; primCanvas.moveTo(x, y)

(define Canvas-moveTo
  (lambda (c x y)
    (set %Canvas-x x)
    (set %Canvas-y y)))

; primCanvas.renderText(textBox, x, y) paints textBox in [startIndex, startIndex + charCount] on the screen at (x, y)

(define Canvas-renderText
  (lambda (c box x y)
    (XDrawString (Canvas-dpy c) (Canvas-buf c) (Canvas-gc c) x (+ -1 y (Text-charHeight box)) (Text-string box) (Text-count box))))

; primCanvas.repaint()

(define Canvas-repaint
  (lambda (c)
    (if (!= (Canvas-buf c) (Canvas-win c))
	(let ((info (malloc 8)))
	  (set (int@ info 0) (Canvas-win c))
	  (set (int@ info 1) 1)	; XdbeBackground
	  (XdbeSwapBuffers (Canvas-dpy c) info 1)))
    (XSync (Canvas-dpy c) 0)))

; primCanvas.setClippingRectangle(x,y,width,height)

(define Canvas-setClippingRectangle
  (lambda (c x y w h)
    (printf "Canvas-setClippingRectangle %d %d %d %d\n" x y w h)))

; primCanvas.setFillStyle(fillStyle)

(define %Canvas-exact  (XColor-new))
(define %Canvas-screen (XColor-new))

(define Canvas-fillStyle
  (lambda (c spec)
    (if (XAllocNamedColor (Canvas-dpy c) (XDefaultColormap (Canvas-dpy c)) spec %Canvas-screen %Canvas-exact)
	  (XGC-setForeground (Canvas-dpy c) (Canvas-gc c) (XColor-pixel %Canvas-screen))
	  (printf "could not allocate color %s\n" spec))))

; primCanvas.setLineWidth(borderWidth)

(define Canvas-setLineWidth
  (lambda (c w)
    (XGC-setLineWidth (Canvas-dpy c) (Canvas-gc c) w)))

; primCanvas.stroke()

(define Canvas-stroke
  (lambda (c)
    (let ((path (Canvas-path c)))
      (XDrawLines (Canvas-dpy c) (Canvas-buf c) (Canvas-gc c) (XPolygon-points path) (XPolygon-size path) 0)
      (XPolygon-clear path))))
