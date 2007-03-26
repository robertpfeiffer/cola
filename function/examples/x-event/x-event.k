(define getenv (dlsym "getenv"))

;; (define _dlopen (dlsym "dlopen"))
;; (define dlerror (dlsym "dlerror"))
;; (define dlclose (dlsym "dlclose"))

;; (define %dlopen-prefixes
;;   (let ((table (malloc 64)))
;;     (set (long@ table 0) "/usr/lib/")
;;     (set (long@ table 1) "/usr/local/lib/")
;;     (set (long@ table 2) "/usr/X11R6/lib/")
;;     (set (long@ table 3) "/usr/lib/X11/")
;;     (set (long@ table 4) "")
;;     (set (long@ table 5) 0)
;;     table))

;; (define %dlopen-suffixes
;;   (let ((table (malloc 64)))
;;     (set (long@ table 0) ".so")
;;     (set (long@ table 1) ".dylib")
;;     (set (long@ table 2) "")
;;     (set (long@ table 3) 0)
;;     table))

;; (define dlopen
;;   (lambda (name)
;;     (let ((path   (malloc 1024))
;; 	  (prefix 0))
;;       (while (long@ %dlopen-prefixes prefix)
;; 	(let ((suffix 0))
;; 	  (while (long@ %dlopen-suffixes suffix)
;; 	    (sprintf path "%s%s%s" (long@ %dlopen-prefixes prefix) name (long@ %dlopen-suffixes suffix))
;; 	    (let ((handle (_dlopen path (or _RTLD_NOW _RTLD_GLOBAL))))
;; 	      (if handle
;; 		  (let ()
;; 		    (herald path)
;; 		    (free path)
;; 		    (return handle))))
;; 	      (set suffix (+ 1 suffix))))
;; 	(set prefix (+ 1 prefix)))
;;       (free path))
;;     (error (dlerror))))

"----------------------------------------------------------------"

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
(define XDrawString		(dlsym "XDrawString"))
(define XLoadFont		(dlsym "XLoadFont"))
(define XNextEvent		(dlsym "XNextEvent"))
(define XChangeGC		(dlsym "XChangeGC"))
(define XSetWindowBackground	(dlsym "XSetWindowBackground"))
(define XChangeWindowAttributes	(dlsym "XChangeWindowAttributes"))

(dlclose libX11)

(define event-names
  (let ((table (malloc 1024)))
    (set (long@ table  0) "undefined")
    (set (long@ table  1) "undefined")
    (set (long@ table  2) "KeyPress")
    (set (long@ table  3) "KeyRelease")
    (set (long@ table  4) "ButtonPress")
    (set (long@ table  5) "ButtonRelease")
    (set (long@ table  6) "MotionNotify")
    (set (long@ table  7) "EnterNotify")
    (set (long@ table  8) "LeaveNotify")
    (set (long@ table  9) "FocusIn")
    (set (long@ table 10) "FocusOut")
    (set (long@ table 11) "KeymapNotify")
    (set (long@ table 12) "Expose")
    (set (long@ table 13) "GraphicsExpose")
    (set (long@ table 14) "NoExpose")
    (set (long@ table 15) "VisibilityNotify")
    (set (long@ table 16) "CreateNotify")
    (set (long@ table 17) "DestroyNotify")
    (set (long@ table 18) "UnmapNotify")
    (set (long@ table 19) "MapNotify")
    (set (long@ table 20) "MapRequest")
    (set (long@ table 21) "ReparentNotify")
    (set (long@ table 22) "ConfigureNotify")
    (set (long@ table 23) "ConfigureRequest")
    (set (long@ table 24) "GravityNotify")
    (set (long@ table 25) "ResizeRequest")
    (set (long@ table 26) "CirculateNotify")
    (set (long@ table 27) "CirculateRequest")
    (set (long@ table 28) "PropertyNotify")
    (set (long@ table 29) "SelectionClear")
    (set (long@ table 30) "SelectionRequest")
    (set (long@ table 31) "SelectionNotify")
    (set (long@ table 32) "ColormapNotify")
    (set (long@ table 33) "ClientMessage")
    (set (long@ table 34) "MappingNotify")
    table))

(define doit
  (lambda (dname)
    (let ((dpy  (XOpenDisplay dname))
	  (root (XDefaultRootWindow dpy))
	  (win  (XCreateSimpleWindow dpy root
				     0 0 100 100
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
	(while
	  (begin
	    (XNextEvent dpy evt)
	    (let ((type (int@ evt)))
	      (and (== 12 type)
		   (begin
		     (XDrawString dpy win gc 4 28 "unmap (iconify)" 15)
		     (XDrawString dpy win gc 4 42 "  me to exit.  " 15)
		     (XSync dpy 0)))
	      (printf "%3d %s\n" type (long@ event-names type))
	      (!= 18 type)))))
      (XDestroyWindow dpy win)
      (XFlush dpy))))

(doit 0)	; 0 => value of DISPLAY variable
