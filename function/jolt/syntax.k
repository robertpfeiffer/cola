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

(syntax addrof	; (addrof varName)  =>  address of varName
  (lambda (form comp)
    (or (and [[form size] = '2]
	     [[form second] isSymbol])
	[comp errorSyntax: form])
    [[comp lookupVariable: [form second]] translateLvalue: comp]))
