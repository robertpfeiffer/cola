(define printf			(_dlsym _RTLD_DEFAULT "printf"))

(define nfibs
  (lambda (n)
    (if (< n 2) (return 1)
	(return (+ (nfibs (- n 1)) (nfibs (- n 2)) 1)))))

(let ()
  (printf "%d\n" (nfibs 38))
  (printf "%d\n" (nfibs 38))
  (printf "%d\n" (nfibs 38))
  (printf "%d\n" (nfibs 38))
  (printf "%d\n" (nfibs 38))
  (printf "%d\n" (nfibs 38))
  (printf "%d\n" (nfibs 38))
  (printf "%d\n" (nfibs 38))
  (printf "%d\n" (nfibs 38))
  (printf "%d\n" (nfibs 38)))
