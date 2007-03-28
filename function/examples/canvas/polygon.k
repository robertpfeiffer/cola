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

;; (syntax XPoint-points		(lambda (form compiler)	`(long@ ,[form second]  )))
;; (syntax XPoint-size		(lambda (form compiler)	`(long@ ,[form second] 1)))
;; (syntax XPoint-capacity	(lambda (form compiler)	`(long@ ,[form second] 2)))
;; (syntax XPoint-at		(lambda (form compiler)	`(+ (XPoint-points ,[form second]) (* 4 ,[form third]))))

;; (syntax XPoint-clear
;;   (lambda (form compiler)
;;     `(set (XPoint-size ,[form second]) 0)))

;; (define XPoint-grow
;;   (lambda (pg x y)
;;     (let ((ps (* 2 (XPoint-size pg)))
;; 	  (pp (realloc (XPoint-points pg) (* 4 ps))))
;;       (set (XPoint-points pg) pp)
;;       (set (XPoint-size   pg) ps))
;;     pg))

;; (define XPoint-add-xy
;;   (lambda (pg x y)
;;     (let ((ps (XPoint-size pg)))
;;       (and (== ps (XPoint-capacity pg))
;; 	   (XPoint-grow pg))
;;       (set (XPoint-x (XPoint-at pg ps)) x)
;;       (set (XPoint-y (XPoint-at pg ps)) y)
;;       (set (XPoint-size pg) (+ 1 ps)))
;;     pg))

;; (define XPoint-xAt	(lambda (p i) (XPoint-x (XPoint-at p i))))
;; (define XPoint-yAt	(lambda (p i) (XPoint-y (XPoint-at p i))))

;; (define XPoint-new
;;   (lambda (s)
;;     (let ((m (malloc (+ 4 (* 4 s))))
;; 	  (p (malloc 12)))
;;       (set (XPoint-points   p) m)
;;       (set (XPoint-size     p) s)
;;       (set (XPoint-capacity p) s)
;;       p)))



;; (syntax XRectangle-points		(lambda (form compiler)	`(long@ ,[form second]  )))
;; (syntax XRectangle-size		(lambda (form compiler)	`(long@ ,[form second] 1)))
;; (syntax XRectangle-capacity	(lambda (form compiler)	`(long@ ,[form second] 2)))
;; (syntax XRectangle-at		(lambda (form compiler)	`(+ (XRectangle-points ,[form second]) (* 4 ,[form third]))))

;; (syntax XRectangle-clear
;;   (lambda (form compiler)
;;     `(set (XRectangle-size ,[form second]) 0)))

;; (define XRectangle-grow
;;   (lambda (pg x y)
;;     (let ((ps (* 2 (XRectangle-size pg)))
;; 	  (pp (realloc (XRectangle-points pg) (* 4 ps))))
;;       (set (XRectangle-points pg) pp)
;;       (set (XRectangle-size   pg) ps))
;;     pg))

;; (define XRectangle-add-xy
;;   (lambda (pg x y)
;;     (let ((ps (XRectangle-size pg)))
;;       (and (== ps (XRectangle-capacity pg))
;; 	   (XRectangle-grow pg))
;;       (set (XPoint-x (XRectangle-at pg ps)) x)
;;       (set (XPoint-y (XRectangle-at pg ps)) y)
;;       (set (XRectangle-size pg) (+ 1 ps)))
;;     pg))

;; (define XRectangle-xAt	(lambda (p i) (XPoint-x (XRectangle-at p i))))
;; (define XRectangle-yAt	(lambda (p i) (XPoint-y (XRectangle-at p i))))

;; (define XRectangle-new
;;   (lambda (s)
;;     (let ((m (malloc (+ 4 (* 4 s))))
;; 	  (p (malloc 12)))
;;       (set (XRectangle-points   p) m)
;;       (set (XRectangle-size     p) s)
;;       (set (XRectangle-capacity p) s)
;;       p)))

