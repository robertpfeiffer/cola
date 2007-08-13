(syntax List-elements	(lambda (node compiler) `(long@ ,[node second]  )))
(syntax List-size	(lambda (node compiler) `(long@ ,[node second] 1)))
(syntax List-capacity	(lambda (node compiler) `(long@ ,[node second] 2)))

(define List-new
  (lambda ()
    (let ((l (malloc 12)))
      (set (List-elements l) (malloc 16))
      (set (List-size     l) 0)
      (set (List-capacity l) 4)
      l)))

(define List-grow
  (lambda (l)
    (let ((s (* 2 (List-size l))))
      (set (List-elements l) (realloc (List-elements l) (* 4 s)))
      (set (List-capacity l) s)
      l)))

(syntax List-at		(lambda (node compiler) `(long@ (List-elements ,[node second]) ,[node third])))

(define List-append
  (lambda (l o)
    (let ((s (List-size l)))
      (if (== s (List-capacity l))
	  (List-grow l))
      (set (List-at l s) o)
      (set (List-size l) (+ 1 s)))
    o))

(define List-release-with
  (lambda (l r)
    (for (i 0 1 (- (List-size l) 1))
      (r (List-at l i)))
    (set (List-size l) 0)))

(define List-print
  (lambda (l)
    (printf "List[%d]{" (List-size l))
    (for (i 0 1 (- (List-size l) 1))
      (printf " %p" (List-at l i)))
    (printf " }")
    l))
