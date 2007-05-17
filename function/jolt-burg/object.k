;;; object.k -- support for operations on objects

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

;;; Last edited: 2007-05-15 18:51:11 by piumarta on emilia

(define SmallInteger		(import "SmallInteger"))
(define OrderedCollection	(import "OrderedCollection"))

;; message send syntax (replaces the bogus version defined in boot.k which cannot cope with ':)

(syntax send ; (send selector receiver args...)
  (lambda (node compiler)
    (or [[node size] >= '3] [compiler errorSyntax: node])
    (let ((selector [node second])
	  (receiver [node third]))
      `(let ((__r ,receiver))
	 (let ((__c (_bind ,selector __r)))
	   ((long@ __c) __c __r __r ,@[node copyFrom: '3]))))))

;; define a new object type

(define make-getter
  (lambda (offset)
    `(lambda (_closure _self self)
       (long@ (+ _self ,[SmallInteger value_: offset])))))

(define make-setter
  (lambda (offset)
    `(lambda (_closure _self self value)
       (set (long@ (+ _self ,[SmallInteger value_: offset])) value))))

(define make-accessors
  (lambda (offset slotNames)
    (let ((accessors [OrderedCollection new])
	  (slotIndex '0)
	  (slotSize  [slotNames size]))
      (while [slotIndex < slotSize]
	(let ((slotName [slotNames at: slotIndex]))
	  [accessors add: `[[proto _vtable] methodAt: ', slotName		put: ,(make-getter offset) with: 0]]
	  [accessors add: `[[proto _vtable] methodAt: ',[slotName append: '":"]	put: ,(make-setter offset) with: 0]]
	  (set slotIndex [slotIndex + '1])
	  (set offset (+ 4 offset))))
      accessors)))

(syntax define-type	; name base (slots...)
  (lambda (form compiler)
    (or (and (== '4 [form size])
	     [[form at: '1] isSymbol]
	     [[form at: '2] isSymbol]
	     [[form at: '3] isArray])
	[compiler errorSyntax: form])
    (let ((protoName [form at: '1])
	  (baseName  [form at: '2])
	  (slotNames [form at: '3])
	  (base      (import [baseName _stringValue]))
	  (baseSize  [base _sizeof])
	  (slotSize  (* 4 [[slotNames size] _integerValue]))
	  (protoSize (+ baseSize slotSize)))
      `(define ,protoName
	 (let ((proto [(import ,[baseName asString]) _delegated]))	; this is the new type
	   [[proto _vtable] methodAt: '_sizeof    put: (lambda (_closure _self self) ,[SmallInteger value_: protoSize]) with: 0]
	   [[proto _vtable] methodAt: '_debugName put: (lambda (_closure _self self) ,[protoName asString])		  with: 0]
	   (export ,[protoName asString] proto)	; export new type to Pepsi global namespace
	   ,@(make-accessors baseSize slotNames)
	   proto)))))

;; add, replace or override a method

(define add-method	; type selector implementation
  (lambda (type selector implementation)
    [[type _vtable] methodAt: selector put: implementation with: 0]))

;; method definitions

(syntax define-send ; selector type args... expr
  (lambda (form compiler)
    (let ((selector [form second])
	  (type     [form third])
	  (args     [form copyFrom: '3 to: [[form size] - '2]])
	  (expr     [form last]))
      `(add-method ,type ,selector (lambda (_closure _self self ,@args) ,expr)))))
