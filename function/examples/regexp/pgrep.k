(load "regexp.k")

(define strlen	(dlsym "strlen"))
(define fdopen	(dlsym "fdopen"))
(define fgets	(dlsym "fgets"))

(define grep1
  (lambda (re line)
    (let ((ptr line))
      (while 1
	(if (>= (re-match re ptr) 0)
	    (return (printf "%s\n" line))
	    (if (char@ ptr)
		(incr ptr)
		(return 0)))))))

(define grep
  (lambda (re stream)
    (let ((line (malloc 1024)))
      (while (fgets line 1024 stream)
	(let ((len (strlen line)))
	  (and len
	       (== $\n (char@ line (- len 1)))
	       (set (char@ line (- len 1)) 0))
	  (grep1 re line))))))

(define verbose 0)

(let ((args [OS arguments]))
  (and [args notEmpty] [[args first] = '"-v"]
       (set verbose [args removeFirst]))
  (and [args isEmpty]
       (error "no regexp given on command line"))
  (let ((re (re-compile [[args removeFirst] _elements])))
    (and verbose (re-print re))
    (grep re (fdopen 0 "r"))
    (and verbose (printf "%d + %d\n" (list-capacity %re-in) (list-capacity %re-out)))))
