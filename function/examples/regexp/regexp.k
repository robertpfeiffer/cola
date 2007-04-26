;;; regexp.k -- NDA-based regexp compiler and engine

;;; Copyright (c) 2007 Ian Piumarta
;;; All rights reserved.
;;; 
;;; Permission is hereby granted, free of charge, to any person obtaining a
;;; copy of this software and associated documentation files (the 'Software'),
;;; to deal in the Software without restriction, including without limitation
;;; the rights to use, copy, modify, merge, publish, distribute, and/or sell
;;; copies of the Software, and to permit persons to whom the Software is
;;; furnished to do so, provided that the above copyright notice(s) and this
;;; permission notice appear in all copies of the Software and that both the
;;; above copyright notice(s) and this permission notice appear in supporting
;;; documentation.
;;;
;;; THE SOFTWARE IS PROVIDED 'AS IS'.  USE ENTIRELY AT YOUR OWN RISK.

;;; Last edited: 2007-04-25 18:59:33 by piumarta on emilia

(define calloc	(dlsym "calloc"))
(define memset	(dlsym "memset"))

(define re-syntax-error
  (lambda ()
    (printf "syntax error\n")
    (exit 0)))

(syntax incr
  (lambda (node comp)
    `(set ,[node second] (+ 1 ,[node second]))))

;;----------------------------------------------------------------

(syntax re-head		(lambda (node comp) `(long@ ,[node second]  )))
(syntax re-tail		(lambda (node comp) `(long@ ,[node second] 1)))

(define make-re		(lambda () (calloc 1 8)))
(define free-re		(lambda (re) (free re 8)))

;;----------------------------------------------------------------

(syntax state-accept	(lambda (node comp) `(long@ ,[node second]  )))
(syntax state-data	(lambda (node comp) `(long@ ,[node second] 1)))
(syntax state-next1	(lambda (node comp) `(long@ ,[node second] 2)))
(syntax state-next2	(lambda (node comp) `(long@ ,[node second] 3)))
(syntax state-stamp	(lambda (node comp) `(long@ ,[node second] 4)))

(define make-state
  (lambda (accept data next1 next2)
    (let ((state (calloc 1 20)))
      (set (state-accept state) accept)
      (set (state-data   state) data  )
      (set (state-next1  state) next1 )
      (set (state-next2  state) next2 )
      (set (state-stamp  state) 0     )
      state)))

(define state-set-next
  (lambda (state next)
    (if (state-next1 state)
	(if (state-next2 state)
	    (error "this cannot happen")
	    (set (state-next2 state) next))
	(set (state-next1 state) next))))

;;----------------------------------------------------------------

(syntax list-states	(lambda (node comp) `(long@ ,[node second]  )))
(syntax list-position	(lambda (node comp) `(long@ ,[node second] 1)))
(syntax list-size	(lambda (node comp) `(long@ ,[node second] 2)))
(syntax list-capacity	(lambda (node comp) `(long@ ,[node second] 3)))

(syntax list-states-at	(lambda (node comp) `(long@ (list-states ,[node second]) ,[node third])))

(define make-list
  (lambda ()
    (let ((list (malloc 16)))
      (set (list-position list)  0)
      (set (list-size     list)  0)
      (set (list-capacity list) 32)
      (set (list-states   list) (malloc (* 4 (list-capacity list))))
      list)))

(syntax list-append
  (lambda (node comp)
    `(let ((_list ,[node second]) (_state ,[node third]))
       (and (== (list-size _list) (list-capacity _list))
	    (let ()
	      (set (list-capacity _list) (* 2 (list-capacity _list)))
	      (set (list-states _list) (realloc (list-states _list) (* 4 (list-capacity _list))))))
       (set (list-states-at _list (list-size _list)) _state)
       (incr (list-size _list))
       _list)))

(syntax list-empty?
  (lambda (node comp)
    `(let ((_list ,[node second]))
       (== (list-position _list) (list-size _list)))))

(syntax list-remove
  (lambda (node comp)
    `(let ((_list ,[node second]))
       (if (== (list-position _list) (list-size _list))
	   (error "this list is empty")
	   (let ((element (list-states-at _list (list-position _list))))
	     (incr (list-position _list))
	     element)))))

(syntax list-remove-unchecked
  (lambda (node comp)
    `(let ((_list    ,[node second])
	   (element (list-states-at _list (list-position _list))))
       (incr (list-position _list))
       element)))

(syntax list-reset
  (lambda (node comp)
    `(let ((list ,[node second]))
       (set (list-position list) 0)
       (set (list-size     list) 0))))

(syntax list-append-states
  (lambda (node comp)
    `(let ((_l ,[node second])
	   (_s ,[node third])
	   (_n (state-next1 _s)))
       (and _n
	    (let ()
	      (list-append _l _n)
	      (and (set _n (state-next2 _s))
		   (list-append _l _n)))))))

;;----------------------------------------------------------------

(define %re-do-charset
  (lambda (state c in out)
    (and (char@ (state-data state) c)
	 (list-append-states out state))
    0))

(define %re-do-any
  (lambda (state c in out)
    (list-append-states out state)
    0))

(define re-compile-alternate 0)	; forward

(define re-compile-literal
  (lambda (re string)
    (let ((c (char@ string)))
      (cond
       ((==   0 c)	(re-syntax-error))
       ((== $\( c)	(let ()
			  (set string (re-compile-alternate re (+ string 1)))
			  (or (== (char@ string) $\))
			      (re-syntax-error))))
       ((== $\[ c)	(let ((cset (calloc 1 256))
			      (flag 1)
			      (c    0)
			      (prev 0))
			  (incr string)
			  (and (== $\^ (char@ string))
			       (let ()
				 (memset (+ cset 1) 1 255)
				 (set flag 0)
				 (incr string)))
			  (while (and (set c (char@ string))
				      (!= $\] c))
			    (cond
			     ((== $\- c)  (let ()
					    (or prev (error "syntax error"))
					    (or (set c (char@ (incr string))) (error "syntax error"))
					    (for (i prev 1 c) (set (char@ cset i) flag))
					    (set prev 0)
					    (incr string)))
			     ((== $\\ c)  (let ()
					    (or (set prev (char@ (incr string))) (error "syntax error"))
					    (set (char@ cset prev) flag)
					    (incr string)))
			     (1		  (let ()
					    (set (char@ cset c) flag)
					    (set prev c)
					    (incr string)))))
			  (or c (error "syntax error"))
			  (set (re-head re) (make-state %re-do-charset cset 0 0))
			  (set (re-tail re) (re-head re))))
       ((== $\. c)	(let ()
			  (set (re-head re) (make-state %re-do-any 0 0 0))
			  (set (re-tail re) (re-head re))))
       ((== $\\ c)	(let ()
			  (or (set c (char@ (incr string))) (error "syntax error"))
			  (set (re-head re) (make-state 0 c 0 0))
			  (set (re-tail re) (re-head re))))
       (1		(let ()
			  (set (re-head re) (make-state 0 c 0 0))
			  (set (re-tail re) (re-head re))))))
    (+ 1 string)))

(define re-compile-element
  (lambda (re string)
    (set string (re-compile-literal re string))
    (let ((c (char@ string)))
      (cond
       ((== c $\?)	(let ((out (make-state 0 0 0 0))
			      (in  (make-state 0 0 (re-head re) out)))
			  (state-set-next (re-tail re) out)
			  (set (re-head re) in)
			  (set (re-tail re) out)
			  (+ string 1)))
       ((== c $\*)	(let ((s (make-state 0 0 (re-head re) 0)))
			  (state-set-next (re-tail re) s)
			  (set (re-head re) s)
			  (set (re-tail re) s)
			  (+ string 1)))
       ((== c $\+)	(let ((s (make-state 0 0 (re-head re) 0)))
			  (state-set-next (re-tail re) s)
			  (set (re-tail re) s)
			  (+ string 1)))
       (1		string)))))

(define re-compile-list
  (lambda (re string)
    (set string (re-compile-element re string))
    (let ((c 0))
      (while (and (set c (char@ string))
		  (!= $\| c)
		  (!= $\) c))
	(let ((re2 (make-re)))
	  (set string (re-compile-element re2 string))
	  (state-set-next (re-tail re) (re-head re2))
	  (set (re-tail re) (re-tail re2))
	  (free-re re2))))
    string))


(define re-compile-alternate
  (lambda (re string)
    (set string (re-compile-list re string))
    (while (== $\| (char@ string))
      (let ((re2   (make-re)))
	(set string (re-compile-list re2 (+ string 1)))
	(let ((split (make-state 0 0 (re-head re) (re-head re2)))
	      (join  (make-state 0 0 0 0)))
	  (state-set-next (re-tail re ) join)
	  (state-set-next (re-tail re2) join)
	  (set (re-head re) split)
	  (set (re-tail re) join)
	  (free-re re2))))
    string))

(define re-compile
  (lambda (string)
    (let ((re     (make-re)))
      (re-compile-alternate re string)
      (set (re-tail re) (state-set-next (re-tail re) (make-state 0 -1 0 0)))
      re)))

(define action-name
  (lambda (action)
    (if action
	(cond
	 ((== action %re-do-charset)	"set")
	 ((== action %re-do-any)	"any")
	 (1				"???"))
	"nop")))

(define %state-print
  (lambda (s stamp)
    (and s
	 (!= (state-stamp s) stamp)
	 (let ()
	   (set (state-stamp s) stamp)
	   (printf "%p %s %08lx %p %p\n" s (action-name (state-accept s)) (state-data s) (state-next1 s) (state-next2 s))
	   (%state-print (state-next1 s) stamp)
	   (%state-print (state-next2 s) stamp)))))

(define %state-stamp 0)

(define re-print
  (lambda (re)
    (%state-print (re-head re) (incr %state-stamp))))

;;----------------------------------------------------------------

(define %re-in  (make-list))
(define %re-out (make-list))

(define re-match
  (lambda (re string)
    (let ((n 0) (m -1))
      (list-reset %re-in)
      (list-append %re-in (re-head re))
      (while 1
	(let ((c (char@ string)))
	  (incr string)
	  (list-reset %re-out)
	  (while (not (list-empty? %re-in))
	    (let ((s (list-remove-unchecked %re-in))
		  (a (state-accept s)))
	      (if a
		  (and (a s c %re-in %re-out)
		       (set m n))
		  (let ((d (state-data s)))
		    (if d
			(if (== -1 d)
			    (set m n)
			    (and (== c d)
				 (list-append-states %re-out s)))
			(list-append-states %re-in s))))))
	  (incr n)
	  (if (or (list-empty? %re-out)
		  (== 0 c))
	      (return m))
	  (let ((t %re-in))
	    (set %re-in %re-out)
	    (set %re-out t)))))
    -1))
