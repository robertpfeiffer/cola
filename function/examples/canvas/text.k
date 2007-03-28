(syntax Text-new	(lambda (node compiler) `(GC_malloc 20)))

(syntax Text-string	(lambda (node compiler) `(long@ ,[node second] 0)))
(syntax Text-start	(lambda (node compiler) `(long@ ,[node second] 1)))
(syntax Text-count	(lambda (node compiler) `(long@ ,[node second] 2)))
(syntax Text-charWidth	(lambda (node compiler) `(long@ ,[node second] 3)))
(syntax Text-charHeight	(lambda (node compiler) `(long@ ,[node second] 4)))

; textBox.getBounds(offset) -> bounding rectangle for char at startIndex + offset (or nil if offset >= charCount)

(define Text-getBounds
  (lambda (t offset)
    (if (and (< 0 offset) (< offset (Text-count t)))
	(let ((w (Text-charWidth  t))
	      (h (Text-charHeight t)))
	  (XRectangle-new (* w offset) 0 w h))
	0)))

; textBox.getIndex(point) -> index of char in [ startIndex , startIndex + charCount ] nearest to point

(define Text-getIndex
  (lambda (t p)
    (let ((x (XPoint-x p))
	  (c (Text-count t))
	  (w (Text-charWidth t)))
      (if (and (< 0 x) (< x (* w c)))
	  (/ x w)
	  -1))))

; textBox.stopIndex(textBox, pixelWidth) -> indexOfLastChar in [ startIndex, startIndex + charCount ]  < pixelWidth

(define Text-stopIndex
  (lambda (t x)
    (let ((c (Text-count t))
	  (w (Text-charWidth t)))
      (if (and (<= 0 x) (< x (* w c)))
	  (/ x w)
	  (- c 1)))))
