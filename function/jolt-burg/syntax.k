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
