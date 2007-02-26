;; (define nfibs
;;   (lambda (n)
;;     (if (< n 2)
;; 	1
;; 	(+ (nfibs (- n 1)) (nfibs (- n 2)) 1))))

(define nfibs
  (lambda (n)
    (if (< n 2)
	(return 1))
    (return (+ (nfibs (- n 1)) (nfibs (- n 2)) 1))))

((_dlsym _RTLD_DEFAULT "printf") "%d\n" (nfibs 38))
