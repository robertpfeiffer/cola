;; quasiquotation as userland syntax

(define qq-object 0)    ;; forward

(define list?
  (lambda (object)
    [object isArray]))

(define qq-atom
  (lambda (node)
    ['() with: 'quote with: node]))

(define qq-list
  (lambda (node)
    (if (and (== [node size]  '2)
             (== [node first] 'unquote))
        [node second]
        (let ((expr [['() new: '8] writeStream])
              (posn '0)
              (size [node size]))
          [expr nextPut: 'let]
          [expr nextPut: '((_ [['() new: '8] writeStream]))]
          (while [posn < size]
            (let ((elt [node at: posn]))
              (if (and (list? elt)
                       (== [elt size]  '2)
                       (== [elt first] 'unquote-splicing))
                  [expr nextPut: ['[_ nextPutAll: : 0] withParameters: ['() with: [elt second]]]]
                  [expr nextPut: ['[_ nextPut: : 0] withParameters: ['() with: (qq-object elt)]]]))
            (set posn [posn + '1]))
          [expr nextPut: '[_ contents]]
          [expr contents]))))

(define qq-object
  (lambda (node)
    ((if (list? node) qq-list qq-atom) node)))

(syntax quasiquote
  (lambda (node compiler)
    (qq-object [node second])))

