;;; yy-compile.k -- PEG parser generator bootstrap
;;; 
;;; Copyright (c) 2007 by Ian Piumarta
;;; All rights reserved.
;;; 
;;; Permission is hereby granted, free of charge, to any person obtaining a
;;; copy of this software and associated documentation files (the 'Software'),
;;; to deal in the Software without restriction, including without limitation
;;; the rights to use, copy, modify, merge, publish, distribute, and/or sell
;;; copies of the Software, and to permit persons to whom the Software is
;;; furnished to do so, provided that the above copyright notice(s) and this
;;; permission notice appear in all copies of the Software.  Acknowledgement
;;; of the use of this Software in supporting documentation would be
;;; appreciated but is not required.
;;; 
;;; THE SOFTWARE IS PROVIDED 'AS IS'.  USE ENTIRELY AT YOUR OWN RISK.
;;; 
;;; Last edited: 2007-05-21 00:32:23 by piumarta on emilia

(require 'yy)

(syntax yyCheck
  (lambda (node compiler)
    `(let ((yypos0 (yy-pos yy)))
       ,@[node copyFrom: '1])))

(syntax yyReset
  (lambda (node compiler)
    '(set (yy-pos yy) yypos0)))

(syntax yyUpdate
  (lambda (node compiler)
    '(set yypos0 (yy-pos yy))))

(syntax yyReject
  (lambda (node compiler)
    `(if 1 (return (let ()
		     (yyReset)
		     0)))))

(define yy-expression 0)	; forward

(define yyMakeAlt
  (lambda (node index)
    (if (== [node size] index)
	'0
	`(if ,[node at: index] 1 (let () (yyReset) ,(yyMakeAlt node (+ index 2)))))))

(syntax yyAlt
  (lambda (node)
    `(yyCheck ,(yyMakeAlt node '1))))

(syntax yySeq
  (lambda (node)
    `(yyCheck (if (and ,@[node copyFrom: '1]) 1 (let () (yyReset) 0)))))

(syntax yyStar
  (lambda (node)
    `(yyCheck (while ,[node second] (yyUpdate)) 1)))

(syntax yyQuery
  (lambda (node)
    `(yyCheck (if ,[node second] 1 (let () (yyReset) 1)))))

(syntax yyPeekFor
  (lambda (node)
    `(yyCheck
       (let ((result ,[node second]))
	 (yyReset)
	 result))))

(syntax yyPeekNot
  (lambda (node)
    `(yyCheck
       (let ((result ,[node second]))
	 (yyReset)
	 (not result)))))

;;----------------------------------------------------------------

(define yyText
  (lambda (yy)
    (yy-makeText yy (yy-begin yy) (yy-end yy))
    (yy-text yy)))

;(define %make-temp% '0)

;(define make-temp (lambda () [['"_" , [(incr %make-temp% 2) printString]] asSymbol]))

;; end-of-file=	!.

(define yy-end-of-file
  (lambda (yy)
    (dprintf "yy-end-of-file\n")
    (yyPeekNot (yyMatchDot yy))))

;; end-of-line=	'\r\n' | '\n' | '\r'

(define yy-end-of-line
  (lambda (yy)
    (dprintf "yy-end-of-line\n")
    (yyMatchClass yy (yyMakeClass "\n\r"))))

;; comment=	'#' (!end-of-line .)* end-of-line

(define yy-comment
  (lambda (yy)
    (dprintf "yy-comment\n")
    (if (yySeq
	  (yyMatchChar yy $\;)
	  (yyStar (yySeq (yyPeekNot (yy-end-of-line yy)) (yyMatchDot yy)))
	  (yy-end-of-line yy))
	(dprintf "yy-comment ok\n")
	(let () (dprintf "yy-comment ko\n") 0))))

;; space=		' ' | '\t' | end-of-line

(define yy-space
  (lambda (yy)
    (dprintf "yy-space\n")
    (yyMatchClass yy (yyMakeClass " \t\n\r"))))

;; -=		(space | comment)*

(define yy--
  (lambda (yy)
    (dprintf "yy--\n")
    (yyStar (yyAlt (yy-space yy) (yy-comment yy)))
    (dprintf "yy-- ok\n")))

(define yy-EQUAL	(lambda (yy) (and (yyMatchChar yy $=) (yy-- yy))))
(define yy-AND		(lambda (yy) (and (yyMatchChar yy $&) (yy-- yy))))
(define yy-NOT		(lambda (yy) (and (yyMatchChar yy $!) (yy-- yy))))
(define yy-BAR		(lambda (yy) (and (yyMatchChar yy $|) (yy-- yy))))
(define yy-SEMICOLON	(lambda (yy) (and (yyMatchChar yy $;) (yy-- yy))))
(define yy-COLON	(lambda (yy) (and (yyMatchChar yy $:) (yy-- yy))))
(define yy-OPEN		(lambda (yy) (and (yyMatchChar yy $() (yy-- yy))))
(define yy-CLOSE	(lambda (yy) (and (yyMatchChar yy $)) (yy-- yy))))
(define yy-DOT		(lambda (yy) (and (yyMatchChar yy $.) (yy-- yy))))
(define yy-QUESTION	(lambda (yy) (and (yyMatchChar yy $?) (yy-- yy))))
(define yy-STAR		(lambda (yy) (and (yyMatchChar yy $*) (yy-- yy))))
(define yy-PLUS		(lambda (yy) (and (yyMatchChar yy $+) (yy-- yy))))
(define yy-BEGIN	(lambda (yy) (and (yyMatchChar yy $<) (yy-- yy))))
(define yy-END		(lambda (yy) (and (yyMatchChar yy $>) (yy-- yy))))

;; action=		'{' < [^}]* > '}' -

(define yy-action
  (lambda (yy)
    (dprintf "yy-action\n")
    (yySeq
      (yyMatchChar yy $\{)
      (yyStart yy)
      (yyStar (yySeq (yyPeekNot (yyMatchChar yy $\})) (yyMatchDot yy)))
      (yyStop yy)
      (yyMatchChar yy $\})
      (yy-- yy)
      )))

;; char=	'\\' [abefnrtv'"\[\]\\]
;; |		'\\' [0-3][0-7][0-7]
;; |		'\\' [0-7][0-7]?
;; |		!'\\' .

(define yy-char
  (lambda (yy)
    (dprintf "yy-char\n")
    (yyAlt
      (yySeq (yyMatchChar yy $\\) (yyMatchDot yy))
      (yyMatchDot yy))))

;; range=		char '-' char | char

(define yy-range
  (lambda (yy)
    (dprintf "yy-range\n")
    (yyAlt
      (yySeq (yy-char yy) (yyMatchChar yy $-) (yy-char yy))
      (yy-char yy))))

;; class=		'[' < ( !']' range )* > ']' -

(define yy-class
  (lambda (yy)
    (dprintf "yy-class\n")
    (yySeq
      (yyMatchChar yy $\[)
      (yyStart yy)
      (yyStar (yySeq (yyPeekNot (yyMatchChar yy $\])) (yy-range yy)))
      (yyStop yy)
      (yyMatchChar yy $\])
      (yy-- yy))))

;; literal=	['] < ( !['] char )* > ['] -
;; |		["] < ( !["] char )* > ["] -

(define yy-literal
  (lambda (yy)
    (dprintf "yy-literal\n")
    (yyAlt
      (yySeq (yyMatchChar yy $\') (yyStart yy) (yyStar (yySeq (yyPeekNot (yyMatchChar yy $\')) (yyMatchDot yy))) (yyStop yy) (yyMatchChar yy $\') (yy-- yy))
      (yySeq (yyMatchChar yy $\") (yyStart yy) (yyStar (yySeq (yyPeekNot (yyMatchChar yy $\")) (yyMatchDot yy))) (yyStop yy) (yyMatchChar yy $\") (yy-- yy)))))

;; identifier = < [-a-zA-Z_][-a-zA-Z_0-9]* > -

(define yy-identifier
  (lambda (yy)
    (dprintf "yy-identifier\n")
    (yySeq (yyStart yy)
	   (yyMatchClass yy (yyMakeClass "-a-zA-Z_"))
	   (yyStar (yyMatchClass yy (yyMakeClass "-a-zA-Z_0-9")))
	   (yyStop yy)
	   (yy-- yy))))

;; primary =	identifier COLON identifier !EQUAL
;; |		identifier !EQUAL
;; |		OPEN expression CLOSE
;; |		literal
;; |		class
;; |		DOT
;; |		action
;; |		BEGIN
;; |		END

(define yy-primary
  (lambda (yy)
    (dprintf "yy-primary\n")
    (yyAlt
      (yySeq (yy-identifier yy) (yy-COLON yy)			(yy-push yy [yyVariable withName: (yyText yy) rule: (yy-current yy)])
	     (yy-identifier yy) (yyPeekNot (yy-EQUAL yy))	(yy-push yy [yyName withRule: (yy-findRule yy (yyText yy)) variable: (yy-pop yy)]))
      (yySeq (yy-identifier yy) (yyPeekNot (yy-EQUAL yy))	(yy-push yy [yyName withRule: (yy-findRule yy (yyText yy))]))
      (yySeq (yy-OPEN yy) (yy-expression yy) (yy-CLOSE yy))
      (yySeq (yy-literal yy)					(yy-push yy [yyString withString: (yyText yy)]))
      (yySeq (yy-class yy)					(yy-push yy [yyClass withString: (yyText yy)]))
      (yySeq (yy-DOT yy)					(yy-push yy [yyDot new]))
      (yySeq (yy-action yy)					(yy-push yy [yyAction withText: (yyText yy) rule: (yy-current yy)]))
      (yySeq (yy-BEGIN yy)					(yy-push yy [yyPredicate withText: "(yyStart yy)"]))
      (yySeq (yy-END yy)					(yy-push yy [yyPredicate withText: "(yyStop yy)"]))
      )))

;; suffix = primary (QUESTION | STAR | PLUS)?

(define yy-suffix
  (lambda (yy)
    (dprintf "yy-suffix\n")
    (yySeq (yy-primary yy)
	   (yyQuery (yyAlt (yySeq (yy-QUESTION yy)		(yy-push yy [yyQuery with: (yy-pop yy)]))
			   (yySeq (yy-STAR yy)			(yy-push yy [yyStar  with: (yy-pop yy)]))
			   (yySeq (yy-PLUS yy)			(yy-push yy [yyPlus  with: (yy-pop yy)]))
			   )))))

;; prefix=	AND action
;; |		AND suffix
;; |		NOT suffix
;; |		    suffix

(define yy-prefix
  (lambda (yy)
    (dprintf "yy-prefix\n")
    (yyAlt (yySeq (yy-AND yy) (yy-action yy)	(yy-push yy [yyPredicate withText: (yyText yy)]))
	   (yySeq (yy-AND yy) (yy-suffix yy)	(yy-push yy [yyPeekFor with: (yy-pop yy)]))
	   (yySeq (yy-NOT yy) (yy-suffix yy)	(yy-push yy [yyPeekNot with: (yy-pop yy)]))
	   (yy-suffix yy))))

;; sequence = prefix ( prefix )*

(define yy-sequence
  (lambda (yy)
    (dprintf "yy-sequence\n")
    (yySeq
      (yy-prefix yy)
      (yyStar (yySeq (yy-prefix yy)		(let ((tail (yy-pop yy)) (seq (yy-pop yy))) (yy-push yy [seq appendSequence: tail])))))))

;; expression = sequence ( BAR sequence )*

(define yy-expression
  (lambda (yy)
    (dprintf "yy-expression\n")
    (yySeq
      (yy-sequence yy)
      (yyStar
        (yySeq (yy-BAR yy) (yy-sequence yy)	(let ((tail (yy-pop yy)) (alt (yy-pop yy))) (yy-push yy [alt appendAlternate: tail]))
	       )))))

;; definition = identifier EQUAL expression SEMICOLON?
;; |		'%{' ( !'%}' . )* '%}'
;; |		'%%' .*

(define yy-definition
  (lambda (yy)
    (dprintf "yy-definition\n")
    (yyAlt
      (yySeq
        (yy-identifier yy)		(yy-push yy (set (yy-current yy) (yy-findRule yy (yyText yy)))) (dprintf "RULE %s\n" (yyText yy))
	(yy-EQUAL      yy)
	(yy-expression yy)		(let ((expr (yy-pop yy)) (rule (yy-pop yy))) [rule setExpression: expr] (debug [StdOut println: rule]))
	(yyQuery (yy-SEMICOLON yy)))
      (yySeq
        (yyMatchString yy "%{")
	(yyStart yy)
	(yyStar
	  (yySeq
	    (yyPeekNot (yyMatchString yy "%}"))
	    (yyMatchDot yy)))
	(yyStop yy)
	(yyMatchString yy "%}")		(yy-addHeader yy (yyText yy)))
      (yySeq
        (yyMatchString yy "%%")
	(yyStart yy)
	(yyStar (yyMatchDot yy))
	(yyStop yy)			(yy-addFooter yy (yyText yy)))
      )))

;; grammar=	- definition* ( trailer | end-of-file )
;; trailer=	'##'

(define yy-peg
  (lambda (yy)
    (yy-- yy)
    (if (yy-definition yy) 1
	(if (or (yyMatchString yy "##")
		(yy-end-of-file yy))
	    0
	    (error "syntax error")))))

(define yy-compile 0)

(define compile-peg
  (lambda (stream output)
    (let ((yy (yy-new stream)))
      (while (yy-peg yy)
	(or (yy-start yy) (set (yy-start yy) (yy-current yy))))
      (printf "%d rules\n" (length (yy-rules yy)))
      (yy-compile yy output)
      (printf "parser written on %s\n" output))))

(require 'yy-compile)

(let ((files  [OrderedCollection new])
      (argv   [OS arguments])
      (output 0))
  (let ((arg 0))
    (while (and [argv notEmpty]
		[(set arg [argv removeFirst]) ~= '"--"])
      (if (and [arg = '"-o"] [argv notEmpty])
	  (set output [argv removeFirst])
	  (let ((file [File open: arg])
		(stream [file readStream]))
	    (or output (set output [arg , '".k"]))
	    (compile-peg stream [output _stringValue])
	    (set output 0))))))
