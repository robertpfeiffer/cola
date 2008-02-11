;;; structure.k -- create data structures from 'ASCII art'

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

;;; Last edited: 2007-12-07 08:57:26 by piumarta on emilia

(define Integer (import "Integer"))
(define IdentityDictionary (import "IdentityDictionary"))

(define anchor 0)
(define row 0)
(define width 0)
(define column 0)
(define bitpos 0)
(define bitmap 0)
(define fields 0)

(define structure-begin
  (lambda (parser)
    (set bitmap [IdentityDictionary new])
    (set fields [OrderedCollection new])
    (set anchor [parser readPosition])
    (set row '0)
    (set width '0)
    (set column '0)))

(define structure-field
  (lambda (parser)
    (let ((start [bitmap at: column])
	  (end   [bitmap at: (set column [[parser readPosition] - anchor])]))
      [fields add: [Array with: [parser @ '0] with: row with: start with: end]])))

(define structure-end
  (lambda (name)
    (let ((with [WriteStream on: [Expression new: '16]]))
      [with nextPut: '(_ ,[node second])]
      (while [fields notEmpty]
	(let ((field  	[fields removeFirst])
	      (member 	[field first])
	      (getter 	[[name , '-] , member])
	      (setter 	['set- , getter])
	      (offset 	[field second])
	      (start  	[field third])
	      (stop   	[field fourth])
	      (width	[stop - start])
	      (mask	[['1 << width] - '1])
	      (designator `(long@ oop ,[offset / '32]))
	      (decoder	`(ntohl ,designator))
	      (encoder	`(ntohl ,designator))
	      (value	'value))
	  (if (< stop  '32) (set decoder `(>> ,decoder ,['32 - stop])))
	  (if (< width '32) (set decoder `(&  ,decoder ,mask)))
	  [`(define ,getter (lambda (oop) ,decoder)) _eval]
	  (if (< stop  '32) (set value   `(<< ,value ,['32 - stop])))
	  (set encoder `(& ,encoder ,['4294967295 - [mask << ['32 - stop]]]))
	  [`(define ,setter (lambda (oop value) (set ,designator (htonl (| ,encoder ,value))))) _eval]
	  [with nextPut: `(,member (,getter _))]))
      [`(syntax ,['with- , name] (lambda (node) `(let (,@[with contents]) ,',@[node copyFrom: '2]))) _eval])))

'{
  structure :=
    error	= ->[parser error: ['"syntax error near: " , [parser contents]]]
    eol		= '\r''\n'* | '\n''\r'*
    space	= [ \t]
    comment	= [-+] (!eol .)* eol
    ws		= (space | comment | eol)*
    _		= space*
    letter	= [a-zA-Z]
    digit	= [0-9]
    identifier	= < letter (letter | digit)* > _	-> [[parser text] asSymbol]
    number	= < digit+ > _				-> [Integer fromString: [parser text] base: '10]
    columns	= '|'	 				-> (structure-begin parser)
		   ( _  number->0			-> [bitmap at: column put: (set bitpos [parser @ '0])]
		       (number->0)* '|'			-> (let () (set bitpos [parser @ '0]) (set column [[parser readPosition] - anchor]))
		   )+ eol ws				-> [bitmap at: column put: (set width [bitpos + '1])]
    row		= ( number->0				-> (set row [parser @ '0])
		    ) ? '|'				-> (let () (set anchor [parser readPosition]) (set column '0))
		  _ ( identifier->0 '|'			-> (structure-field parser)
		      _ )+ eol ws			-> (set row [row + width])
    name	= identifier->0 (!eol .)* eol		-> (structure-end [parser @ '0])
    diagram	= ws columns row+ name | error
}
