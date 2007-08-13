(syntax XPoint-new	(lambda (form compiler) `(malloc 4)))
(syntax XPoint-x	(lambda (form compiler) `(short@ ,[form second] 0)))
(syntax XPoint-y	(lambda (form compiler) `(short@ ,[form second] 1)))

(define XPoint-print
  (lambda (p)
    (printf "{%d,%d}" (XPoint-x p) (XPoint-y p))
    p))

(define XPoint-setPolar
  (lambda (p r a)
    (let ((ca (cos a))
	  (sa (sin a)))
      (set (short@ p 0) (- (*.16 r ca) (*.16 r sa)))
      (set (short@ p 1) (+ (*.16 r sa) (*.16 r ca))))
    p))
