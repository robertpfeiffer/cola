;;; quasiquotation as userland syntax

;; baseline: stream-based construction

(define qq-object 0)    ;; forward

(define list?
  (lambda (object)
    [object isArray]))

(define qq-atom
  (lambda (node)
    [Expression with: 'quote with: node]))

(define qq-list
  (lambda (node)
    (if (and (== [node size]  '2)
             (== [node first] 'unquote))
        [node second]
        (let ((expr [[Expression new: '8] writeStream])
              (posn '0)
              (size [node size]))
          [expr nextPut: 'let]
          [expr nextPut: '((_ [[Expression new: '8] writeStream]))]
          (while [posn < size]
            (let ((elt [node at: posn]))
              (if (and (list? elt)
                       (== [elt size]  '2)
                       (== [elt first] 'unquote-splicing))
                  [expr nextPut: ['[_ nextPutAll: : 0] withParameters: [Expression with: [elt second]]]]
                  [expr nextPut: ['[_ nextPut: : 0] withParameters: [Expression with: (qq-object elt)]]]))
            (set posn [posn + '1]))
          [expr nextPut: '[_ contents]]
          [expr contents]))))

(define qq-object
  (lambda (node)
    ((if (list? node) qq-list qq-atom) node)))

(syntax quasiquote
  (lambda (node compiler)
    (qq-object [node second])))

;; optimised cases for
;;	absence of unquotation (quasiquote -> quote)
;;	absence of splicing (stream -> fixed array)

(define qq2-object 0)    ;; forward
(define qq2-quoted 0)    ;; forward

(define qq2-atom
  (lambda (node)
    ;;[StdOut nextPutAll: '"QQ2-ATOM "][StdOut print: node][StdOut cr]
    [Expression with: 'quote with: node]))

(define qq2-init-list
  (lambda (node)
    ;;[StdOut nextPutAll: '" QQ2-INIT-LIST "][StdOut print: node][StdOut cr]
    (let ((inits [Expression new: [node size]])
	  (index '0)
	  (limit [node size]))
      (while [index < limit]
	;;[inits at: index put: `(send 'at:put: _ ',index ,(qq2-quoted [node at: index]))]
	[inits at: index put: [Expression with: 'send with: ''at:put: with: '_
			          with: [Expression with: 'quote with: index]
			          with: (qq2-quoted [node at: index])]]
	(set index (+ index 2)))
      ;;[StdOut nextPutAll: '" INITS ===> "][StdOut print: inits][StdOut cr]
      inits)))

(define qq2-list-fixed		;; build a fixed-length list with unquotes only
  (lambda (node)
    ;;[StdOut nextPutAll: '"QQ2-LIST-FIXED "][StdOut print: node][StdOut cr]
    (if [node isEmpty]
	[Expression with: 'quote with: [Expression new: '0]]
	(let ((expr `(let ((_ [Expression new: ',[node size]])) ,@(qq2-init-list node) _)))
	  ;;[StdOut nextPutAll: '" FIXED ===> "][StdOut print: expr][StdOut cr]
	  expr))))

(define qq2-list-variable	;; build a variable-length list with unquote-splicings
  (lambda (node)
    ;;[StdOut nextPutAll: '"QQ2-LIST-VARIABLE "][StdOut print: node][StdOut cr]
    (let ((expr [[Expression new: '8] writeStream])
	  (posn '0)
	  (size [node size]))
      [expr nextPut: 'let]
      [expr nextPut: '((_ [[Expression new: '8] writeStream]))]
      (while [posn < size]
	(let ((elt [node at: posn]))
	  ;;[StdOut nextPutAll: '"\n\n\nUNQUOTE SPLICING: <"]
	  ;;[StdOut print:      elt]
	  ;;[StdOut space]
	  ;;[StdOut print:      (if (and [elt isArray] (== [elt size]  '2) (== [elt first] 'unquote-splicing)) 'YES 'NO)]
	  ;;[StdOut nextPutAll: '">\n\n\n"]
	  (if (and [elt isArray]
		   (== [elt size]  '2)
		   (== [elt first] 'unquote-splicing))
	      [expr nextPut: [Expression with: 'send with: ''nextPutAll: with: '_ with: [elt second]]]
	      [expr nextPut: [Expression with: 'send with: ''nextPut:    with: '_ with: (qq2-object elt)]]))
	(set posn [posn + '1]))
      [expr nextPut: '[_ contents]]
      ;;[StdOut nextPutAll: '" VARIABLE ===> "][StdOut print: [expr contents]][StdOut cr]
      [expr contents])))

(define qq2-list-splice?
  (lambda (node)
    (and [node isArray]
	 (== [node size]  '2)
	 (== [node first] 'unquote-splicing))))

(define qq2-list-variable?
  (lambda (node)
    ;;[StdOut nextPutAll: '"QQ2-LIST-VARIABLE? "][StdOut print: node][StdOut cr]
    (let ((index '0)
	  (limit [node size]))
      (while [index < limit]
	(if (qq2-list-splice? [node at: index])
	    (return 1))
	(set index (+ 2 index))))
    ;;[StdOut nextPutAll: '"QQ2-LIST-VARIABLE? ===> 0"][StdOut cr]
    0))

(define qq2-list
  (lambda (node)
    ;;[StdOut nextPutAll: '"QQ2-LIST "][StdOut print: node][StdOut cr]
    (if (and (== [node size]  '2)
             (== [node first] 'unquote))
        [node second]
	((if (qq2-list-variable? node) qq2-list-variable qq2-list-fixed) node))))

(define qq2-object
  (lambda (node)
    ;;[StdOut nextPutAll: '"QQ2-OBJECT "][StdOut print: node][StdOut cr]
    ((if [node isArray] qq2-list qq2-atom) node)))

(define qq2-unquoted?
  (lambda (node)
    (if (![node isArray]) (return 0))
    (if (and (== [node size] '2)
	     (or (== [node first] 'unquote)
		 (== [node first] 'unquote-splicing)))
	(return 1))
    (let ((index '0)
	  (limit [node size]))
      (while [index < limit]
	(if (qq2-unquoted? [node at: index])
	    (return 1))
	(set index (+ index 2))))
    0))

(define qq2-quoted
  (lambda (node)
    ;;[StdOut nextPutAll: '"QQ2-QUOTED "][StdOut print: node][StdOut cr]
    (if (qq2-unquoted? node)
	(qq2-object node)
	[Expression with: 'quote with: node])))

(syntax quasiquote
  (lambda (node compiler)
    (let ((rewrite (qq2-quoted [node second])))
      ;;[StdOut print: rewrite]
      ;;[StdOut cr]
      rewrite)))
