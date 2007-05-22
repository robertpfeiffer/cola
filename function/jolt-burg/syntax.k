;;; syntax.k -- useful transformations for active AST nodes

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

;;; Last edited: 2007-05-18 14:54:09 by piumarta on emilia

(syntax begin
  (lambda (node compiler)
    `(let () ,@[node copyFrom: '1])))

(define _cond
  (lambda (node idx)
    (if [idx >= [node size]]
	'0
	`(if ,[[node at: idx] first]
	     ,[[node at: idx] second]
	     ,(_cond node [idx + '1])))))

(syntax cond	; (cond (val expr)...)
  (lambda (node compiler)
    (_cond node '1)))

(syntax for	; (for (variable from step to) body...)
  (lambda (node compiler)
    (let ((spec  [node second])
	  (body  [node copyFrom: '2])
	  (var   [spec first])
	  (init  [spec second])
	  (step  [spec third])
	  (limit [spec fourth]))
      `(let ((,var ,init))
	 (while (<= ,var ,limit)
	   ,@body
	    (set ,var (+ ,var ,step)))))))

(syntax method	; (method (formals...) body...)  =>  (lamdba (_closure _self self formals...) body...)
  (lambda (node compiler)
    (or (and [[node size] >= '2]
	     [[node second] isArray])
	[compiler errorSyntax: node])
    `(lambda (_closure _self self ,@[node second])
       ,@[node copyFrom: '2])))

(syntax addrof	; (addrof varName)  =>  address of varName
  (lambda (node compiler)
    (or (and [[node size] = '2]
	     [[node second] isSymbol])
	[compiler errorSyntax: node])
    [[compiler lookupVariable: [node second]] translateLvalue: compiler]))

(syntax incr ; (incr lvalue [count])
  (lambda (node)
    `(set ,[node second]
	  (+ ,[node second]
	     ,(if (== '3 [node size])
		  [node third]
		  '1)))))
