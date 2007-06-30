


(exit 0)



(define pragma
  (lambda (stream)
    (printf "you can't have no stinkin pragmas here\n")))

(define include
  (lambda (stream)
    (let ((file [CokeScanner read: stream]))
      (printf "INCLUDING %s\n" [file _stringValue]))))

(define echo
  (lambda (stream)
    (let ((c 0))
      (while (!= '$# (set c [stream next]))
	[StdOut nextPut: c]))))

(define foo
  (method (stream)
    [stream next]
    (let ((command [CokeScanner read: stream]))
      ([command _eval] stream))))

(define bar
  (method (stream)
    [stream next]
    [['"__tmp__" , [[stream position] printString]] asSymbol]))

[CokeScanner readerAt: '$# put: bar withAttribute: 'id]		; allow # to appear embedded in symbols

[StdOut println: '#]
[StdOut println: '#]
[StdOut println: '#]
