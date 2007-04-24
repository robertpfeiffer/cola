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

[CokeScanner scan: '36 using: dollar-reader withAttributes: 'id]	; allow $ to appear embedded in symbols

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

[CokeScanner scan: '$+ using: sign-reader withAttributes: 'id]	; allow + to appear embedded in symbols
[CokeScanner scan: '$- using: sign-reader withAttributes: 'id]	; allow - to appear embedded in symbols

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

[CokeScanner scan: '$0 through: '$9 using: digit-reader withAttributes: 'id]	; allow digits to appear embedded in symbols
