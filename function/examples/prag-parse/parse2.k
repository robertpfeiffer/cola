;;; Regular, context-free parsing of internal representation inspired by Henry Baker's implementation [1] of META [2].
;;; 
;;; [1] Baker, Henry G.  "Pragmatic Parsing in Common Lisp".
;;;	ACM Lisp Pointers 4(2), April--June 1991, pp. 3--15.
;;; 
;;; [2] Schorre, D. V.  "META II: A Syntax-Oriented Compiler Writing Language".
;;;	Proc. 19'th Nat'l. Conf. of the ACM, August 1964, pp. D1.3-1--D1.3-11.

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

;;; Last edited: 2007-04-26 14:01:07 by piumarta on emilia

(define meta-compile 0)	; forward

(define meta-map	; poor man's mapcar
  (lambda (function expr)
    (let ((limit  [expr size])
	  (result [Expression new: limit])
	  (index  '0))
      (while (< index limit)
	[result at: index put: (function [expr at: index])]
	(set index [index + '1]))
      result)))

(define meta-other	; default matcher for non-meta constructs within pattern
  (lambda (expr)
    `(and (== ',expr [stream peek])
	  (let () [stream next] 1))))

(define meta-form	; matchers for meta constructs
  (lambda (node)
    (let ((type [node first])
	  (expr [node second]))
      (cond
       ((== type 'meta-repeat)		`(let () (while ,(meta-compile expr)) 1))
       ((== type 'meta-predicate)	expr)
       ((== type 'meta-alternate)	`(or  ,@(meta-map meta-compile expr)))
       ((== type 'meta-sequence)	`(and ,@(meta-map meta-compile expr)))
       ((== type 'meta-unify)		(if (and [expr isArray] (== '2 [expr size]))
					    `(and (,[expr first] [stream peek])
						  (let ()
						    (set ,[expr second] [stream next])
						    1))
					    [expr error: '"syntax error near #@"]))
       (1				(meta-other node))))))

(define meta-compile	; compile meta pattern
  (lambda (expr)
    (if (and [expr isArray] (== '2 [expr size]))
	(meta-form expr)
	(meta-other expr))))

(define meta-sequence-reader
  (method (stream)
    (let ((delim [stream next]))
      (cond
       ((== delim '${)	[Expression with: 'meta-alternate with: [self read: stream list: Expression delimited: '$}]])
       ((== delim '$[)	[Expression with: 'meta-sequence  with: [self read: stream list: Expression delimited: '$]]])
       ((== delim '$$)	[Expression with: 'meta-repeat    with: [self read: stream]])
       ((== delim '$@)	[Expression with: 'meta-unify     with: [self read: stream]])
       ((== delim '$!)	[Expression with: 'meta-predicate with: [self read: stream]])
       (1		[self error: stream unexpected: delim])))))

(define meta-sequence-illegal
  (method (stream)
    [self error: stream unexpected: [stream next]]))

;; make ? an active character that enables meta syntax for the following expression only and then compiles the result

(define meta-sequence-escape
  (method (stream)
    [stream next]
    [self save]
    [self readerAt: '$\\ put: [self readerAt: '$$]]
    [self readerAt: '${  put: meta-sequence-reader]  [self readerAt: '$} put: meta-sequence-illegal]
    [self readerAt: '$[  put: meta-sequence-reader]  [self readerAt: '$] put: meta-sequence-illegal]
    [self readerAt: '$$  put: meta-sequence-reader]
    [self readerAt: '$@  put: meta-sequence-reader]
    [self readerAt: '$!  put: meta-sequence-reader]
    (let ((result [self read: stream]))
      [self restore]
      (meta-compile result))))

[CokeScanner readerAt: '$? put: meta-sequence-escape withAttributes: 'id]		; allow ? to appear embedded in symbols

;;; Example: integer parsing (see [2, Section 1])

(define digit	(lambda (x) (and (<= '$0 x) (<= x '$9))))	; predicate

(define parse-int
  (lambda (string)
    (let ((stream [string readStream])
	  (s '1) (d  0) (n '0))
      (if ? [ { \+ [ \- !(set s '-1) ] !1 }
	      @(digit d) !(set n (send 'digitValue d))
	      $ [ @(digit d) !(set n (send '+ (send '* n '10) (send 'digitValue d))) ] ]
	  [s * n]
	  'error))))

[StdOut print: (parse-int '"0")]	[StdOut cr]
[StdOut print: (parse-int '"42")]	[StdOut cr]
[StdOut print: (parse-int '"+1")]	[StdOut cr]
[StdOut print: (parse-int '"-1")]	[StdOut cr]
[StdOut print: (parse-int '"+42")]	[StdOut cr]
[StdOut print: (parse-int '"-666")]	[StdOut cr]
[StdOut print: (parse-int '"-haha")]	[StdOut cr]
