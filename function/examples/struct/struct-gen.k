(define program [WriteStream on: [String new: '1024]])

(define buf (malloc 1024))

(define append
  (lambda (fmt a b c d e f)
    (sprintf buf fmt a b c d e f)
    [program nextPutAll: [String value_: buf]]
    [program cr]))

(append "#include <stdio.h>")

(syntax #define
  (lambda (node comp)
    (or (== '3 [node size])
	(error "syntax error in #define"))
    (append "#define %s %s" [[[node second] asString] _stringValue] [[[node third] printString] _stringValue])
    '0))

(syntax #include
  (lambda (node comp)
    (let ((index '1)
	  (size  [node size]))
      (while (< index size)
	(append "#include <%s>" [[[node at: index] asString] _stringValue])
	(set index (+ index 2))))
    '0))

(define consts [OrderedCollection new])

(syntax const
  (lambda (node comp)
    [consts addLast: node]
    '0))

(define structs [OrderedCollection new])

(syntax struct
  (lambda (node comp)
    [structs addLast: node]
    '0))

(define generate
  (lambda (name)
    (append "")
    (append "char *_getter(int s) {")
    (append "  switch (s) {")
    (append "  case 1:	return \"char@\";")
    (append "  case 2:	return \"short@\";")
    (append "  case 4:	return \"int@\";")
    (append "  }")
    (append "  return \"unsupported@\";")
    (append "}")
    (append "#define getter(t, m)	_getter(sizeof(((t *)0)->m))")
    (append "#define offset(t, m)	((long)&((t *)0)->m)")
    (append "")
    (append "int main() {")
    (append "  printf(\";;; THIS FILE WAS GENERATED AUTOMATICALLY -- DO NOT EDIT!\\n\\n\");")
    (append "")
    (for (i '0 2 [[consts size] - '1])
      (let ((const [consts at: i]))
	(for (j '1 2 [[const size] - '1])
	  (let ((name [[[const at: j] asString] _stringValue]))
	    (append "  printf(\"(define %s %%d)\\n\", %s);" name name)))))
    (for (i '0 2 [[structs size] - '1])
      (let ((struct [structs at: i])
	    (name   [[[struct second] asString] _stringValue]))
	(for (j '2 2 [[struct size] - '1])
	  (let ((member [[[struct at: j] asString] _stringValue]))
	    (append "  printf(\"(syntax %s-%s (lambda (n) `(%%s (+ ,[n second] %%d))))\\n\", getter(%s, %s), offset(%s, %s));"
		    name member
		    name member
		    name member)))
	(append "  printf(\"(define %s_size %%d)\\n\", sizeof(%s));" name name)))
    (append "  return 0;")
    (append "}")
    (sprintf buf "%s-gen.c" name)
    (if 1
	[StdOut nextPutAll: [program contents]]
	(let ((file [File create: [String value_: buf]]))
	  [file nextPutAll: [program contents]]
	  [file close]))))
