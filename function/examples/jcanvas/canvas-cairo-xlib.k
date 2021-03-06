(dlopen "libcairo")

[Object _import: "cairo"]

(define cairo (import "cairo"))
(define Float (import "Float"))

(syntax Canvas-dpy		(lambda (node compiler) `(long@ ,[node second]  )))
(syntax Canvas-win		(lambda (node compiler) `(long@ ,[node second] 1)))
(syntax Canvas-buf		(lambda (node compiler) `(long@ ,[node second] 2)))
(syntax Canvas-gc		(lambda (node compiler) `(long@ ,[node second] 3)))
(syntax Canvas-path		(lambda (node compiler) `(long@ ,[node second] 4)))
(syntax Canvas-swapAction	(lambda (node compiler) `(long@ ,[node second] 5)))
(syntax Canvas-cairo-surface	(lambda (node compiler) `(long@ ,[node second] 6)))
(syntax Canvas-cairo		(lambda (node compiler) `(long@ ,[node second] 7)))

(define dbe-mode XdbeBackground)

(define Canvas-newWithSwapAction
  (lambda (swapAction)
    (let ((canv (malloc 32))
	  (dpy  (XOpenDisplay 0))
	  (root (XDefaultRootWindow dpy))
	  (vis  (XDefaultVisual dpy (XDefaultScreen dpy)))
	  (win  (XCreateSimpleWindow dpy root 0 0 600 400 5 0 0))
	  (buf  (if (and XdbeQueryExtension
			 (let ((x 0) (y 0)
			       (q (XdbeQueryExtension dpy (addrof x) (addrof y))))
			   (or q (printf "dbe disabled (server version %d.%d)\n" x y))
			   q))
		    (XdbeAllocateBackBufferName dpy win swapAction)
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
      (free xwa)
      (set (Canvas-dpy		 canv) dpy)
      (set (Canvas-win		 canv) win)
      (set (Canvas-buf		 canv) buf)
      (set (Canvas-gc		 canv) gc)
      (set (Canvas-path		 canv) (XPolygon-new 32))
      (set (Canvas-swapAction	 canv) swapAction)
      (set (Canvas-cairo-surface canv) [cairo _cairo_xlib_surface_create dpy buf vis 600 400])
      (set (Canvas-cairo	 canv) [cairo withSurface_: (Canvas-cairo-surface canv)])
      (XFlush dpy)
      canv)))

(define Canvas-new
  (lambda ()
    (Canvas-newWithSwapAction XdbeCopied)))

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

(define Canvas-dispatchOneEvent
  (lambda (c evt)
    (let ((type (XEvent-type evt)))
      (if (== 2 type) (document.onkeydown   (Event-fromXKeyEvent    evt)))
      (if (== 3 type) (document.onkeyup     (Event-fromXKeyEvent    evt)))
      (if (== 4 type) (document.onmousedown (Event-fromXButtonEvent evt)))
      (if (== 5 type) (document.onmouseup   (Event-fromXButtonEvent evt)))
      (if (== 6 type) (document.onmousemove (Event-fromXButtonEvent evt))))))

(define Canvas-waitForEvent
  (lambda (c)
    (XNextEvent (Canvas-dpy c) %Canvas-evt)
    (Canvas-dispatchOneEvent c %Canvas-evt)))

(define Canvas-handleEvents
  (lambda (c)
    (while (XPending (Canvas-dpy c))
      (Canvas-waitForEvent c))))

(define Canvas-handleEventsFor
  (lambda (c timeout)
    (let ((file [File withFd_: (XDisplay-fd (Canvas-dpy c)) name: '"X display connection"]))
      [file waitForInput: [SmallInteger value_: timeout]]
      (Canvas-handleEvents c))))

(define Canvas-clear
  (lambda (c)
    [(Canvas-cairo c) save]
    [(Canvas-cairo c) setSourceR: '1 G: '1 B: '1]
    ;[(Canvas-cairo c) paint]
    [(Canvas-cairo c) moveTo_:   0 _:   0]
    [(Canvas-cairo c) lineTo_: 600 _:   0]
    [(Canvas-cairo c) lineTo_: 600 _: 400]
    [(Canvas-cairo c) lineTo_:   0 _: 400]
    [(Canvas-cairo c) lineTo_:   0 _:   0]
    [(Canvas-cairo c) fill]
    [(Canvas-cairo c) restore]))

(define %Canvas-x 0)
(define %Canvas-y 0)

; primCanvas.beginPath()

(define Canvas-beginPath
  (lambda (c)
    [(Canvas-cairo c) newPath]))

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
    (let ((sx [[SmallInteger value_: w] / '2.0])
	  (sy [[SmallInteger value_: h] / '2.0])
	  (lw [(Canvas-cairo c) getLineWidth])
	  (sw [['2.0 * lw] / [sx + sy]]))
      [(Canvas-cairo c) save]
      [(Canvas-cairo c) newPath]
      [(Canvas-cairo c) translate_: (+ x (/ w 2)) _: (+ y (/ h 2))]
      [(Canvas-cairo c) scaleX: [[SmallInteger value_: w] / '2.0] Y: [[SmallInteger value_: h] / '2.0]]
      [(Canvas-cairo c) arcX: '0 Y: '0 R: '1 A1: '0  A2: '6.28318530718]
      [(Canvas-cairo c) setLineWidth: sw]
      [(Canvas-cairo c) stroke]
      [(Canvas-cairo c) restore])))

; primCanvas.fill()

(define Canvas-fill
  (lambda (c)
    [(Canvas-cairo c) fill]))

; primCanvas.fillEllipse(x, y, width, height)

(define Canvas-fillEllipse
  (lambda (c x y w h)
    [(Canvas-cairo c) save]
    [(Canvas-cairo c) newPath]
    [(Canvas-cairo c) translate_: (+ x (/ w 2)) _: (+ y (/ h 2))]
    [(Canvas-cairo c) scaleX: [[SmallInteger value_: w] / '2.0] Y: [[SmallInteger value_: h] / '2.0]]
    [(Canvas-cairo c) arcX: '0 Y: '0 R: '1 A1: '0  A2: '6.28318530718]
    [(Canvas-cairo c) fill]
    [(Canvas-cairo c) restore]))

; primCanvas.lineTo(y, y)

(define Canvas-lineTo
  (lambda (c x y)
    [(Canvas-cairo c) lineTo_: x _: y]))

; primCanvas.moveTo(x, y)

(define Canvas-moveTo
  (lambda (c x y)
    [(Canvas-cairo c) moveTo_: x _: y]))

; primCanvas.renderText(textBox, x, y) paints textBox in [startIndex, startIndex + charCount] on the screen at (x, y)

(define Canvas-renderText
  (lambda (c box x y)
    (let ((buf (malloc (+ 1 (Text-count box)))))
      (for (i 0 1 (- (Text-count box) 1))
	(set (char@ buf i) (char@ (Text-string box) i)))
      (set (char@ buf (Text-count box)) 0)
      [(Canvas-cairo c) moveTo_: x _: y]
      [(Canvas-cairo c) showText_: buf]
      (free buf))))

; primCanvas.repaint()

(define Canvas-repaint
  (lambda (c)
    (if (!= (Canvas-buf c) (Canvas-win c))
	(let ((info (malloc 8)))
	  (set (int@ info 0) (Canvas-win c))
	  (set (int@ info 1) (Canvas-swapAction c))
	  (XdbeSwapBuffers (Canvas-dpy c) info 1)))
    (XSync (Canvas-dpy c) 0)))

; primCanvas.setClippingRectangle(x,y,width,height)

(define Canvas-setClippingRectangle
  (lambda (c x y w h)
    [(Canvas-cairo c) rectangle_: x _: y _: w _: h]
    [(Canvas-cairo c) clip]))

; primCanvas.setFillStyle(fillStyle)

(define Canvas-fillStyle
  (lambda (c spec)
    (cond
     ((! (strcmp spec "black"))		[(Canvas-cairo c) setSourceR: '0 G: '0 B: '0])
     ((! (strcmp spec "blue"))		[(Canvas-cairo c) setSourceR: '0 G: '0 B: '1])
     ((! (strcmp spec "green"))		[(Canvas-cairo c) setSourceR: '0 G: '1 B: '0])
     ((! (strcmp spec "cyan"))		[(Canvas-cairo c) setSourceR: '0 G: '1 B: '1])
     ((! (strcmp spec "red"))		[(Canvas-cairo c) setSourceR: '1 G: '0 B: '0])
     ((! (strcmp spec "magenta"))	[(Canvas-cairo c) setSourceR: '1 G: '0 B: '1])
     ((! (strcmp spec "yellow"))	[(Canvas-cairo c) setSourceR: '1 G: '1 B: '0])
     ((! (strcmp spec "white"))		[(Canvas-cairo c) setSourceR: '1 G: '1 B: '1])
     (1					(printf "cannot parse colour %s\n" spec)))))

; primCanvas.setLineWidth(borderWidth)

(define Canvas-setLineWidth
  (lambda (c w)
    [(Canvas-cairo c) setLineWidth_: w]))

; primCanvas.stroke()

(define Canvas-stroke
  (lambda (c)
    [(Canvas-cairo c) stroke]))
