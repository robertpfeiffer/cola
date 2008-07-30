(define strdup (dlsym "strdup"))
(define SmallInteger		(import "SmallInteger"))

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
