;; quasiquotation as userland syntax

(define qq-object 0)    ;; forward

(define qq-atom
  (lambda (node)
    ;[StdOut nextPutAll: '"QQ-ATOM "][StdOut print: node][StdOut cr]
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
              (if (and [elt isArray]
                       (== [elt size]  '2)
                       (== [elt first] 'unquote-splicing))
                  [expr nextPut: [Expression with: 'send with: ''nextPutAll: with: '_ with: [elt second]]]
                  [expr nextPut: [Expression with: 'send with: ''nextPut:    with: '_ with: (qq-object elt)]]))
            (set posn [posn + '1]))
          [expr nextPut: '[_ contents]]
	  ;[StdOut nextPutAll: '" ===> "][StdOut print: [expr contents]][StdOut cr]
          [expr contents]))))

(define qq-object
  (lambda (node)
    ((if [node isArray] qq-list qq-atom) node)))

(syntax quasiquote
  (lambda (node compiler)
    (qq-object [node second])))

