;;; quasiquote.k -- quasiquotation as userland syntax

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

;;; Last edited: 2007-11-28 07:09:12 by piumarta on emilia.local

(define qq-object 0)    ;; forward

(define qq-atom
  (lambda (node)
    ;;[StdOut nextPutAll: '"QQ-ATOM "][StdOut print: node][StdOut cr]
    [Expression with: 'quote with: node]))

(define qq-list
  (lambda (node)
    ;;[StdOut nextPutAll: '"QQ-LIST "][StdOut print: node][StdOut cr]
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
	  (let ((result [expr contents]))
	    ;;[StdOut nextPutAll: '"  QQ-LIST ===> "][StdOut print: result][StdOut cr]
	    result)))))

(define qq-object
  (lambda (node)
    ;;[StdOut nextPutAll: '"QQ-OBJECT "][StdOut print: node][StdOut cr]
    ((if [node isArray] qq-list qq-atom) node)))

(syntax quasiquote
  (lambda (node compiler)
    ;;[StdOut nextPutAll: '"QUASIQUOTE "][StdOut print: node][StdOut cr]
    (let ((result (qq-object [node second])))
      ;;[StdOut nextPutAll: '"QQ ===> "][StdOut print: result][StdOut cr]
      result)))

