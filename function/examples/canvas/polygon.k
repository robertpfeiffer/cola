(syntax XPolygon-points		(lambda (form compiler)	`(long@ ,[form second]  )))
(syntax XPolygon-size		(lambda (form compiler)	`(long@ ,[form second] 1)))
(syntax XPolygon-capacity	(lambda (form compiler)	`(long@ ,[form second] 2)))
(syntax XPolygon-at		(lambda (form compiler)	`(+ (XPolygon-points ,[form second]) (* 4 ,[form third]))))

(syntax XPolygon-clear
  (lambda (form compiler)
    `(set (XPolygon-size ,[form second]) 0)))

(define XPolygon-grow
  (lambda (pg x y)
    (let ((ps (* 2 (XPolygon-size pg)))
	  (pp (realloc (XPolygon-points pg) (* 4 ps))))
      (set (XPolygon-points pg) pp)
      (set (XPolygon-size   pg) ps))
    pg))

(define XPolygon-add-xy
  (lambda (pg x y)
    (let ((ps (XPolygon-size pg)))
      (and (== ps (XPolygon-capacity pg))
	   (XPolygon-grow pg))
      (set (XPoint-x (XPolygon-at pg ps)) x)
      (set (XPoint-y (XPolygon-at pg ps)) y)
      (set (XPolygon-size pg) (+ 1 ps)))
    pg))

(define XPolygon-xAt	(lambda (p i) (XPoint-x (XPolygon-at p i))))
(define XPolygon-yAt	(lambda (p i) (XPoint-y (XPolygon-at p i))))

(define XPolygon-new
  (lambda (s)
    (let ((m (malloc (+ 4 (* 4 s))))
	  (p (malloc 12)))
      (set (XPolygon-points   p) m)
      (set (XPolygon-size     p) s)
      (set (XPolygon-capacity p) s)
      p)))

(define XPolygon-free
  (lambda (p)
    (free (XPolygon-points p))
    (free p)))

(define XPolygon-print
  (lambda (in)
    (let ((n (XPolygon-size in))
	  (i 0))
      (printf "XPolygon[%d]={")
      (while (< i n)
	(XPoint-print (XPolygon-at in i))
	(set i (+ 1 i)))
      (printf "}"))
    in))

(define XPolygon-translate
  (lambda (out in x y)
    (or (== (XPolygon-size in) (XPolygon-size out))
	(error "XPolygon-translate: input/output size mismatch"))
    (let ((n (XPolygon-size in))
	  (i 0))
      (while (< i n)
	(let ((ix (XPoint-x (XPolygon-at in i)))
	      (iy (XPoint-y (XPolygon-at in i)))
	      (ox (+ x ix))
	      (oy (+ y iy)))
	  (set (XPoint-x (XPolygon-at out i)) ox)
	  (set (XPoint-y (XPolygon-at out i)) oy))
	(set i (+ 1 i))))
    out))

(define XPolygon-rotate
  (lambda (out in x y a)
    (or (== (XPolygon-size in) (XPolygon-size out))
	(error "XPolygon-rotate: input/output size mismatch"))
    (let ((n (XPolygon-size in))
	  (i 0))
      (while (< i n)
	(let ((ix (XPoint-x (XPolygon-at in i)))
	      (iy (XPoint-y (XPolygon-at in i)))
	      (dx (- ix x))
	      (dy (- iy y))
	      (sa (sin a))
	      (ca (cos a))
	      (ox (+ x (- (*.16 dx ca) (*.16 dy sa))))
	      (oy (+ y (+ (*.16 dx sa) (*.16 dy ca)))))
	  (set (XPoint-x (XPolygon-at out i)) ox)
	  (set (XPoint-y (XPolygon-at out i)) oy))
	(set i (+ 1 i))))
    out))

;;;----------------------------------------------------------------


(define GC_malloc	(dlsym "GC_malloc"))

(syntax XRectangle-x		(lambda (form compiler)	`(short@ ,[form second] 0)))
(syntax XRectangle-y		(lambda (form compiler)	`(short@ ,[form second] 1)))
(syntax XRectangle-width	(lambda (form compiler)	`(short@ ,[form second] 2)))
(syntax XRectangle-height	(lambda (form compiler)	`(short@ ,[form second] 3)))

(syntax XRectangle-origin	(lambda (form compiler)	`(+ ,[form second] 0)))

(define XRectangle-translate-xy
  (lambda (r x y)
    (set (XRectangle-x r) (+ (XRectangle-x r) x))
    (set (XRectangle-y r) (+ (XRectangle-y r) y))))

(define XRectangle-new
  (lambda (x y w h)
    (let ((r (GC_malloc 8)))
      (set (XRectangle-x      r) x)
      (set (XRectangle-y      r) y)
      (set (XRectangle-width  r) w)
      (set (XRectangle-height r) h)
      r)))
