;;; yy-tree.k -- PEG parser generator data structures
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
;;; Last edited: 2007-05-21 15:30:41 by piumarta on emilia

(define strdup (dlsym "strdup"))

(define YYDEBUG 0)

(syntax dprintf	(if YYDEBUG (lambda (node) `(printf ,@[node copyFrom: '1])) (lambda (node) '1)))
(syntax debug	(if YYDEBUG (lambda (node) [node second])		    (lambda (node) '1)))
(syntax yydebug	(if YYDEBUG (lambda (node) [node second])		    (lambda (node) '1)))

(define-type yyNode Object (next))

(define [yyNode printOn: aStream]
  [self error: [[self debugName] , '".printOn:"]])

(define _countNodes
  (lambda (node)
    (let ((count 0))
      (while node
	(incr count)
	(set node [node next]))
      count)))


(define-type yyRule yyNode (name variables expression id used actions))

(define [yyRule withName: name]
  (let ((rule [self new]))
    (dprintf "make rule %p '%s'\n" rule name)
    [rule name: (strdup name)]
    [rule variables: 0]
    [rule expression: 0]
    [rule actions: [OrderedCollection new]]
    rule))

(define [yyRule setExpression: expr]
  (let ()
    (dprintf "rule set expr %s = %s\n" [self name] [[expr printString] _stringValue])
    (and [self expression] (error "rule '%s' redefined" [self name]))
    [self expression: expr]))

(define [yyRule _countVariables]
  (_countNodes [self variables]))

(define [yyRule printOn: aStream]
  (let ()
    [aStream nextPutAll: [String value_: [self name]]]
    [aStream nextPutAll: '" ="]
    [[self expression] printOn: aStream]))


(define-type yyVariable yyNode (name value offset))

(define [yyVariable withName: name rule: rule]
  (let ((var    [rule variables])
	(offset 1))
    (while (and var (strcmp [var name] name))
      (incr offset)
      (set var [var next]))
    (or var
	(let ()
	  (set var [self new])
	  [var name: (strdup name)]
	  [var offset: offset]
	  [var next: [rule variables]]
	  [rule variables: var]))
    var))

(define [yyVariable printOn: aStream]
  (let ()
    [aStream nextPutAll: [String value_: [self name]]]
    [aStream nextPutAll: '"."]
    [aStream print: [SmallInteger value_: [self offset]]]
    [aStream nextPutAll: '":"]))

(define-type yyAction yyNode (text list name rule))

(define yyActionCount '0)

(define [yyAction withText: text rule: rule]
  (let ((action [self new]))
    (dprintf "make action %s\n" text)
    [action text: (strdup text)]
    [action rule: rule]
    (let ((name '"_"))
      (set name [name , [(incr yyActionCount 2) printString]])
      (set name [name , '"_"])
      (set name [name , [String value_: [rule name]]])
      [action name: [name _stringValue]])
    [[rule actions] add: action]
    action))

(define [yyAction printOn: aStream]
  (let ()
    [aStream nextPutAll: '" {"]
    [aStream nextPutAll: [String value_: [self text]]]
    [aStream nextPutAll: '"}"]))


(define-type yyName yyNode (rule variable))

(define [yyName withRule: aRule]
  [self withRule: aRule variable: 0])

(define [yyName withRule: aRule variable: var]
  (let ((name [self new]))
    [name rule: aRule]
    [name variable: var]
    [aRule used: 1]
    name))

(define [yyName printOn: aStream]
  (let ()
    [aStream space]
    [aStream nextPutAll: [String value_: [[self rule] name]]]))


(define-type yyDot yyNode ())

(define [yyDot printOn: aStream]
  [aStream nextPutAll: '" ."])


(define-type yyString yyNode (string))

(define [yyString withString: aString]
  (let ((s [self new]))
    (dprintf "make string %s\n" aString)
    [s string: (strdup aString)]
    s))

(define [yyString printOn: aStream]
  (let ()
    [aStream space]
    [aStream nextPut: '$\"]
    [aStream nextPutAll: [String value_: [self string]]]
    [aStream nextPut: '$\"]))


(define-type yyClass yyString ())

(define [yyClass printOn: aStream]
  (let ()
    [aStream space]
    [aStream nextPut: '$\[]
    [aStream nextPutAll: [String value_: [self string]]]
    [aStream nextPut: '$\]]))


(define-type yyPredicate yyNode (text))

(define [yyPredicate withText: aString]
  (let ((p [self new]))
    (dprintf "make predicate %s\n" aString)
    [p text: (strdup aString)]
    p))

(define [yyPredicate printOn: aStream]
  (let ()
    [aStream space]
    [aStream nextPutAll: '" &{"]
    [aStream nextPutAll: [String value_: [self text]]]
    [aStream nextPut: '$\}]))


(define-type yySequence yyNode (first last))

(define [yySequence with: aNode]
  (let ((s [self new]))
    (dprintf "make sequence %s\n" aNode)
    [s first: aNode]
    [s last: aNode]
    s))

(define [yySequence appendSequence: aNode]
  (let ()
    [[self last] next: aNode]
    [self last: aNode]
    self))

(define [yyNode appendSequence: aNode]
  [[yySequence with: self] appendSequence: aNode])

(define [yySequence printOn: aStream]
  (let ((node [self first]))
    [aStream nextPutAll: '" ("]
    [node printOn: aStream]
    (while (set node [node next])
      [node printOn: aStream])
    [aStream nextPutAll: '" )"]))


(define-type yyAlternate yyNode (first last))

(define [yyAlternate with: aNode]
  (let ((s [self new]))
    (dprintf "make alternate %s\n" [[aNode printString] _stringValue])
    [s first: aNode]
    [s last: aNode]
    s))

(define [yyAlternate appendAlternate: aNode]
  (let ()
    (dprintf "Alt %s appendAlternate %s\n" [[self printString] _stringValue] [[aNode printString] _stringValue])
    [[self last] next: aNode]
    [self last: aNode]
    self))

(define [yyNode appendAlternate: aNode]
  (let ()
    (dprintf "Node %s appendAlternate %s\n" [[self printString] _stringValue] [[aNode printString] _stringValue])
    [[yyAlternate with: self] appendAlternate: aNode]))

(define [yyAlternate printOn: aStream]
  (let ((node [self first]))
    [node printOn: aStream]
    (while (set node [node next])
      [aStream nextPutAll: '" |"]
      [node printOn: aStream])))


(define-type yyPlus yyNode (element))

(define [yyPlus with: anElement]
  (let ((p [self new]))
    [p element: anElement]
    p))

(define [yyPlus printOn: aStream]
  (let ()
    [[self element] printOn: aStream]
    [aStream nextPut: '$\+]))


(define-type yyQuery yyPlus ())

(define [yyQuery isQuery] 1)
(define [yyNode  isQuery] 0)

(define [yyQuery printOn: aStream]
  (let ()
    [[self element] printOn: aStream]
    [aStream nextPut: '$\?]))


(define-type yyStar yyPlus ())

(define [yyStar isStar] 1)
(define [yyNode isStar] 0)

(define [yyStar printOn: aStream]
  (let ()
    [[self element] printOn: aStream]
    [aStream nextPut: '$\*]))


(define-type yyPeekFor yyPlus ())

(define [yyPeekFor printOn: aStream]
  (let ()
    [aStream nextPutAll: '" &"]
    [[self element] printOn: aStream]))


(define-type yyPeekNot yyPlus ())

(define [yyPeekNot printOn: aStream]
  (let ()
    [aStream nextPutAll: '" !"]
    [[self element] printOn: aStream]))

;;; yy.k -- parser support
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
;;; Last edited: 2007-05-21 00:31:55 by piumarta on emilia

(define strlen		(dlsym "strlen"))
(define memset		(dlsym "memset"))
(define memcpy		(dlsym "memcpy"))
(define memmove		(dlsym "memmove"))
(define GC_malloc	(dlsym "GC_malloc"))

(syntax yy-thunk-func	(lambda (node)	`(long@ ,[node second]  )))
(syntax yy-thunk-begin	(lambda (node)	`(long@ ,[node second] 1)))
(syntax yy-thunk-end	(lambda (node)	`(long@ ,[node second] 2)))
(syntax yy-thunk_sizeof	(lambda (node)	'12))

(syntax yy-buf		(lambda (node)	`(long@ ,[node second]   )))
(syntax yy-buflen	(lambda (node)	`(long@ ,[node second]  1)))
(syntax yy-pos		(lambda (node)	`(long@ ,[node second]  2)))
(syntax yy-limit	(lambda (node)	`(long@ ,[node second]  3)))
(syntax yy-stream	(lambda (node)	`(long@ ,[node second]  4)))
(syntax yy-thunks	(lambda (node)	`(long@ ,[node second]  5)))
(syntax yy-thunkslen	(lambda (node)	`(long@ ,[node second]  6)))
(syntax yy-thunkpos	(lambda (node)	`(long@ ,[node second]  7)))
(syntax yy-begin	(lambda (node)	`(long@ ,[node second]  8)))
(syntax yy-end		(lambda (node)	`(long@ ,[node second]  9)))
(syntax yy-stack	(lambda (node)	`(long@ ,[node second] 10)))
(syntax yy-stacklen	(lambda (node)	`(long@ ,[node second] 11)))
(syntax yy-stackpos	(lambda (node)	`(long@ ,[node second] 12)))
(syntax yy-text		(lambda (node)	`(long@ ,[node second] 13)))
(syntax yy-textlen	(lambda (node)	`(long@ ,[node second] 14)))
(syntax yy-rules	(lambda (node)	`(long@ ,[node second] 15)))
(syntax yy-current	(lambda (node)	`(long@ ,[node second] 16)))
(syntax yy-start	(lambda (node)	`(long@ ,[node second] 17)))
(syntax yy-labels	(lambda (node)	`(long@ ,[node second] 18)))
(syntax yy-output	(lambda (node)	`(long@ ,[node second] 19)))
(syntax yy-indent	(lambda (node)	`(long@ ,[node second] 20)))
(syntax yy-actions	(lambda (node)	`(long@ ,[node second] 21)))
(syntax yy-headers	(lambda (node)	`(long@ ,[node second] 22)))
(syntax yy-footer	(lambda (node)	`(long@ ,[node second] 23)))
(syntax yy-svals	(lambda (node)	`(long@ ,[node second] 24)))
(syntax yy-svalslen	(lambda (node)	`(long@ ,[node second] 25)))
(syntax yy-svalpos	(lambda (node)	`(long@ ,[node second] 26)))
(syntax yy-result	(lambda (node)	`(long@ ,[node second] 27)))
(syntax yy-refill	(lambda (node)	`(long@ ,[node second] 28)))
(syntax yy_sizeof	(lambda (node)	'116))

(define yy-alloc (lambda () (GC_malloc (yy_sizeof))))

(define yy-reset
  (lambda (yy)
    (set (yy-begin    yy) (yy-pos yy))
    (set (yy-end      yy) (yy-pos yy))
    (set (yy-thunkpos yy) 0)
    (set (yy-stackpos yy) 0)
    (set (yy-svalpos  yy) 0)
    (set (yy-result   yy) 0)))

(syntax buffer-full-check	; (buffer-full-check buffer position capacity)
  (lambda (node comp)
    (or (== '4 [node size]) [comp errorSyntax: node])
    (let ((buffer   [node second])
	  (position [node third])
	  (capacity [node fourth]))
      `(while (>= ,position ,capacity)
	 (let ((_newcap (* 2 ,capacity))
	       (_buffer (GC_malloc _newcap)))
	   (debug (printf "grow buffer %p to %d\n" _buffer _newcap))
	   (memcpy _buffer ,buffer ,capacity)
	   (set ,buffer _buffer)
	   (set ,capacity _newcap))))))

(define yyrefill
  (lambda (yy)
    (buffer-full-check (yy-buf yy) (yy-limit yy) (yy-buflen yy))
    (let ((c [(yy-stream yy) next]))
      (and c (let ()
	       (set (char@ (yy-buf yy) (yy-limit yy)) (>> c 1))
	       ;;[StdOut nextPut: '$<][StdOut nextPut: c][StdOut nextPut: '$>]
	       (incr (yy-limit yy)))))))

(define yy-new
  (lambda (stream)
    (let ((yy (yy-alloc)))
      (set (yy-buflen 	 yy) 8192)
      (set (yy-buf    	 yy) (GC_malloc (yy-buflen yy)))
      (set (yy-pos    	 yy) 0)
      (set (yy-limit  	 yy) 0)
      (set (yy-stream 	 yy) stream)
      (set (yy-thunkslen yy) (* 8 (yy-thunk_sizeof)))
      (set (yy-thunks    yy) (GC_malloc (yy-thunkslen yy)))
      (set (yy-stacklen  yy) 32)
      (set (yy-stack     yy) (GC_malloc (yy-stacklen yy)))
      (set (yy-text	 yy) 0)
      (set (yy-textlen   yy) 0)
      (set (yy-rules     yy) 0)
      (set (yy-current   yy) 0)
      (set (yy-start     yy) 0)
      (set (yy-labels    yy) 0)
      (set (yy-output    yy) 0)
      (set (yy-indent    yy) 0)
      (set (yy-actions   yy) 0)
      (set (yy-headers   yy) 0)
      (set (yy-footer    yy) 0)
      (set (yy-svalslen  yy) 16)
      (set (yy-svals     yy) (GC_malloc (yy-svalslen yy)))
      (set (yy-footer    yy) 0)
      (set (yy-refill    yy) yyrefill)
      (yy-reset yy)
      yy)))

(syntax yyStart
  (lambda (node)
    `(let ()
       (set (yy-begin ,[node second]) (yy-pos ,[node second]))
       1)))

(syntax yyStop
  (lambda (node)
    `(let ()
       (set (yy-end ,[node second]) (yy-pos ,[node second]))
       1)))

(define yy-makeText
  (lambda (yy begin end)
    (debug (printf "makeText %d %d\n" begin end))
    (let ((yyleng (- end begin)))
      (and (< yyleng 0) (set yyleng 0))
      (and (>= yyleng (yy-textlen yy))
	   (set (yy-text yy) (GC_malloc (set (yy-textlen yy) (+ yyleng 1)))))
      (memcpy (yy-text yy) (+ (yy-buf yy) begin) yyleng)
      (set (char@ (yy-text yy) yyleng) 0)
      (yy-text yy))))

(define yyDo
  (lambda (yy func begin end)
    (debug (printf "yyDo %p %p %d %d\n" yy func begin end))
    (buffer-full-check (yy-thunks yy) (yy-thunkpos yy) (yy-thunkslen yy))
    (let ((thunk (+ (yy-thunks yy) (yy-thunkpos yy))))
      (set (yy-thunk-func  thunk) func)
      (set (yy-thunk-begin thunk) begin)
      (set (yy-thunk-end   thunk) end))
    (incr (yy-thunkpos yy) (yy-thunk_sizeof))
    1))

(define yyDone
  (lambda (yy)
    (debug (printf "yyDone %p %d\n" yy (yy-thunkpos yy)))
    (for (pos 0 (yy-thunk_sizeof) (- (yy-thunkpos yy) (yy-thunk_sizeof)))
      (let ((thunk  (+ (yy-thunks yy) pos))
	    (yyleng (if (yy-thunk-end thunk)
			(yy-makeText yy (yy-thunk-begin thunk) (yy-thunk-end thunk))
			(yy-thunk-begin thunk))))
	(debug (printf "  => %p %p %d %p <- %d %d\n" (yy-thunk-func thunk) (yy-text yy) yyleng yy (yy-thunk-begin thunk) (yy-thunk-end thunk)))
	((yy-thunk-func thunk) (yy-text yy) yyleng yy)))
    (set (yy-thunkpos yy) 0)))

(define yyCommit
  (lambda (yy)
    (if (incr (yy-limit yy) (- (yy-pos yy)))
	(memmove (yy-buf yy) (+ (yy-buf yy) (yy-pos yy)) (yy-limit yy)))
    (incr (yy-begin yy) (- (yy-pos yy)))
    (incr (yy-end   yy) (- (yy-pos yy)))
    (set (yy-pos yy) 0)
    (set (yy-thunkpos yy) 0)))

(define yyMatchDot
  (lambda (yy)
    (debug (printf "yyMatchDot %d\n") (char@ (yy-buf yy) (yy-pos yy)))
    (if (or (< (yy-pos yy) (yy-limit yy)) ((yy-refill yy) yy))
	(incr (yy-pos yy))
	0)))

(define yyMatchChar
  (lambda (yy char)
    (debug (printf "  yyMatchChar %d %p %p %d\n" char yy (yy-buf yy) (yy-pos yy)))
    (if (and (or (< (yy-pos yy) (yy-limit yy)) ((yy-refill yy) yy))
	     (== (char@ (yy-buf yy) (yy-pos yy)) char))
	(let () (debug (printf "+ yyMatchChar\n")) (incr (yy-pos yy)))
	(let () (debug (printf "- yyMatchChar\n")) 0))))

(define yyCharEscapes
  (let ((tab     (malloc 256)))
    (for (i 0 1 255) (set (char@ tab i) i))
    (set (char@ tab $a) $\a)
    (set (char@ tab $b) $\b)
    (set (char@ tab $e) $\e)
    (set (char@ tab $f) $\f)
    (set (char@ tab $n) $\n)
    (set (char@ tab $r) $\r)
    (set (char@ tab $t) $\t)
    (set (char@ tab $v) $\v)
    tab))

(define yyEncodeClass
  (lambda (string)
    (let ((char   0)
	  (prev  -1)
	  (span   0)
	  (on     1)
	  (off    0)
	  (class  (malloc 257)))
      (if (== $^ (char@ string))
	  (let ()
	    (incr string)
	    (set on 0)
	    (set off 1)))
      (memset class off 256)
      (set (char@ class 256) 0)
      (while (set char (char@ string))
	(incr string)
	(set span (and (== $- char) (>= prev 0) (char@ string)
		       (set char (char@ string))
		       (incr string)))
	(if (and (== $\\ char) (char@ string))
	    (let ()
	      (set char (char@ yyCharEscapes (char@ string)))
	      (incr string)))
	(if span
	    (let ()
	      (while (<= (incr prev) char)
		(set (char@ class prev) on))
	      (set prev -1))
	    (set (char@ class (set prev char)) on)))
      class)))

(syntax yyMakeClass
  (lambda (node compiler)
    [String size: '256 value_: (yyEncodeClass [[node second] _stringValue])]))

(define yyMatchClass
  (lambda (yy class)
    (debug (let ()
	     (printf "yyMatchClass <")
	     (for (i 0 1 255) (if (char@ class i) (printf "%c" i)))
	     (printf "> %d\n" (char@ (yy-buf yy) (yy-pos yy)))))
    (and (or (< (yy-pos yy) (yy-limit yy)) ((yy-refill yy) yy))
	 (char@ class (char@ (yy-buf yy) (yy-pos yy)))
	 (incr (yy-pos yy)))))

(define yyMatchString
  (lambda (yy string)
    (debug (printf "yyMatchString <%s> %c\n" string (char@ (yy-buf yy) (yy-pos yy))))
    (let ((yypos0 (yy-pos yy)))
      (while (char@ string)
	(or (< (yy-pos yy) (yy-limit yy))
	    ((yy-refill yy) yy)
	    (let ()
	      (set (yy-pos yy) yypos0)
	      (if 1 (return 0))))
	(or (== (char@ string)
		(char@ (yy-buf yy) (yy-pos yy)))
	    (let ()
	      (set (yy-pos yy) yypos0)
	      (if 1 (return 0))))
	(incr string)
	(incr (yy-pos yy)))
      1)))

;;----------------------------------------------------------------

(define yy-push
  (lambda (yy obj)
    (dprintf "yy-push %p\n" obj)
    (buffer-full-check (yy-stack yy) (yy-stackpos yy) (yy-stacklen yy))
    (dprintf "yy-push go %p %d\n" (yy-stack yy) (yy-stackpos yy))
    (set (long@ (+ (yy-stack yy) (yy-stackpos yy))) obj)
    (dprintf "PUSH %d %s\n" (yy-stackpos yy) [[obj printString] _stringValue])
    (dprintf "yy-push ok\n")
    (incr (yy-stackpos yy) 4)))

(define yy-top
  (lambda (yy)
    (dprintf "yy-top\n")
    (and (== (yy-stackpos yy) 0) (error "stack undeflow"))
    (long@ (+ (yy-stack yy) (- (yy-stackpos yy) 4)))))

(define yy-pop
  (lambda (yy)
    (dprintf "yy-pop\n")
    (and (== (yy-stackpos yy) 0) (error "stack undeflow"))
    (let ((obj (long@ (+ (yy-stack yy) (incr (yy-stackpos yy) -4)))))
      (dprintf "POP  %d %s\n" (yy-stackpos yy) [[obj printString] _stringValue])
      obj)))

;;----------------------------------------------------------------

(syntax car	(lambda (node comp) `(long@ ,[node second]  )))
(syntax cdr	(lambda (node comp) `(long@ ,[node second] 1)))

(syntax caar	(lambda (node comp) `(car (car ,[node second]))))
(syntax cadr	(lambda (node comp) `(car (cdr ,[node second]))))
(syntax cdar	(lambda (node comp) `(cdr (car ,[node second]))))
(syntax cddr	(lambda (node comp) `(cdr (cdr ,[node second]))))

(define cons
  (lambda (a d)
    (dprintf "cons %p %p\n" a d)
    (let ((cell (GC_malloc 8)))
      (set (car cell) a)
      (set (cdr cell) d)
      cell)))

(define sassoc
  (lambda (key list)
    (dprintf "sassoc %s %p\n" key list)
    (while (and list (strcmp key (caar list)))
      (set list (cdr list)))
    (if list (car list) 0)))

(define length
  (lambda (list)
    (let ((count 0))
      (while list
	(incr count)
	(set list (cdr list)))
      count)))

(define yy-makeRule
  (lambda (yy name)
    (dprintf "makeRule %s\n" name)
    (let ((rule [yyRule withName: name]))
      (set (yy-rules yy) (cons (cons (strdup name) rule) (yy-rules yy))))))

(define yy-findRule
  (lambda (yy name)
    (dprintf "findRule %s\n" name)
    (let ((rule (sassoc name (yy-rules yy))))
      (if rule
	  (cdr rule)
	  (cdar (yy-makeRule yy name))))))

;;----------------------------------------------------------------

(define yy-addHeader
  (lambda (yy string)
    (debug (printf "HEADER %%{%s%%}\n" string))
    (or (yy-headers yy)
	(set (yy-headers yy) [OrderedCollection new]))
    [(yy-headers yy) add: [String value_: (strdup string)]]))

(define yy-addFooter
  (lambda (yy string)
    (debug (printf "FOOTER %%%s\n" string))
    (set (yy-footer yy) (strdup string))))

;;----------------------------------------------------------------

(define yyPush
  (lambda (yytext yyleng yy)
    (debug (printf "yyPush %d + %d\n" (yy-svalpos yy) yyleng))
    (buffer-full-check (yy-svals yy) (+ (yy-svalpos yy) yyleng) (yy-svalslen yy))
    (incr (yy-svalpos yy) yyleng)))

(define yySet 
  (lambda (yytext yyleng yy)
    (debug (printf "yySet %d\n" yyleng))
    (set (long@ (+ (yy-svals yy) (yy-svalpos yy)) yyleng) (yy-result yy))))
