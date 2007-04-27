;;; number.k -- extended syntax for numeric literals

;;; Copyright (c) 2006, 2007 Ian Piumarta
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

;;; Last edited: 2007-04-26 19:02:02 by piumarta on emilia

;; character constants

(define CokeEscapeTable	(import "CokeEscapeTable"))

(define dollar-reader
  (method (stream)
    [stream next]
    (let ((char [stream next]))
      (if (== '92 char)			; \
	  (let ((succ [stream next]))
	    (if succ
		(let ((escaped [CokeEscapeTable at: succ]))
		  (if escaped escaped succ))
		0))
	  char))))

[CokeScanner readerAt: '36 put: dollar-reader withAttribute: 'id]	; allow $ to appear embedded in symbols

;; explicit signs, non-decimal bases, and floating-point numbers

(define sign-reader
  (method (stream)
    (let ((peek1 [stream peek: '1]))
      (if (and (<= '$0 peek1) (<= peek1 '$9))
	  (let ((sign   [stream next])
		(number [self read: stream]))
	    (if (== '$- sign)
		[number negated]
		number))
	  [self xLetter: stream]))))	; - or + followed by non-digit starts a symbol

[CokeScanner readerAt: '$+ put: sign-reader withAttribute: 'id]	; allow + to appear embedded in symbols
[CokeScanner readerAt: '$- put: sign-reader withAttribute: 'id]	; allow - to appear embedded in symbols

;; non-decimal bases and floating-point literals

(define digit-reader
  (method (stream)
    (let ((radix      '10)
	  (value      [[stream next] digitValue])
	  (nextChar   0)
	  (digitValue 0))
      (or (!= value '0)
	  (if (== '$x [stream peek])
	      (let ()
		(set radix '16)
		[stream next])
	      (if (== '$b [stream peek])
		  (let ()
		    (set radix '2)
		    [stream next])
		  (or (== '$. [stream peek])	; '0.' is decimal float; 00. is octal float
		      (set radix '8)))))
      (while (and (set nextChar   [stream peek])
		  (set digitValue [nextChar digitValue])
		  (< digitValue radix))
	(set value [[value * radix] + digitValue])
	[stream next])
      (and (== '$. [stream peek])
	   (let ((multiplier ['1 asFloat]))
	     (set value [value asFloat])
	     (set radix [radix asFloat])
	     [stream next]
	     (while (and (set nextChar   [stream peek])
			 (set digitValue [nextChar digitValue])
			 (< digitValue radix))
	       (set multiplier [multiplier / radix])
	       (set value [value + [multiplier * digitValue]])
	       [stream next])))
      value)))

[CokeScanner readerAt: '$0 through: '$9 put: digit-reader withAttribute: 'id]	; allow digits to appear embedded in symbols
