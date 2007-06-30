(define atoi	(dlsym "atoi"))

(define stack  (malloc 1024))
(define stackp stack)

(define push (lambda (x) (set (long@ stackp) x) (incr stackp 4)))
(define pop  (lambda (x) (incr stackp -4) (long@ stackp)))

(require 'calc.peg)

(while (yy-parse (yy-new [StdIn readStream])))
