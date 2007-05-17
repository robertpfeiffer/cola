(define Block	(import "Block"))
(define DROP	(import "DROP"))
(define BRA	(import "BRA"))
(define BRI	(import "BRI"))
(define Integer	(import "Integer"))

(syntax select		; expr case0 case1 ... caseN
  (lambda (node comp)
    (let ((block   [Block new])
	  (finish  [comp newLabel])
	  (nindex  '2)
	  (nlimit  [node size])
	  (lindex  0)
	  (nlabels (- [[node size] _integerValue] 2))
	  (labels  (malloc (* nlabels 4))))
      [block add: [[BRI new] lhs: [`(long@ ,[Integer value_: labels] ,[node second]) translate: comp]]]
      (while (< nindex nlimit)
	(let ((label [comp newLabel]))
	  ;;[StdOut println: block]
	  ;;[StdOut println: [node at: nindex]]
	  ;;[StdOut println: label]
	  (set (long@ labels lindex) label)
	  [block add: label]
	  [block add: [[DROP new] lhs: [[node at: nindex] translate: comp]]]
	  [block add: [[BRA new] destination: finish]]
	(set lindex (+ lindex 1))
	(set nindex (+ nindex 2))))
      [block add: finish]
      [comp postProcess: (lambda (labels nlabels)
			   (for (i 0 1 (- nlabels 1))
			     (let ((label (long@ labels i)))
			       (set (long@ labels i) [label _address]))))
	    with: labels
	    with: nlabels]
      block)))

(define doit
  (lambda (n)
    (printf "selecting %d " n)
    (select n
      (printf "zero\n")
      (printf "one\n")
      (printf "two\n")
      (printf "three\n"))))

(let ()
  (doit 0)
  (doit 1)
  (doit 2)
  (doit 3)
  (doit 2)
  (doit 1)
  (doit 0))
