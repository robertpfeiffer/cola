;;; bunnu.k -- mock JS running directly on COLA objects

;;; Copyright (c) 2008 Ian Piumarta
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

;;; Last edited: 2008-04-10 12:20:00 by piumarta on emilia.local

(printf "; defining semantics\n")

(syntax bs-integer	; integer
  (lambda (node compiler)
    `',[node second]))

(syntax bs-array	; values...
  (lambda (node compiler)
    `',[node second]))

(syntax bs-name		; symbol
  (lambda (node compiler)
    [node second]))

(syntax bs-string	; string
  (lambda (node compiler)
    `',[node second]))

(syntax bs-char		; char
  (lambda (node compiler)
    `',[node second]))

(syntax bs-import	; symbol
  (lambda (node compiler)
    `(define ,[node second] (import ,[[node second] asString]))))

(syntax bs-define	; symbol value
  (lambda (node compiler)
    `(define ,[node second] ,[node third])))

(syntax bs-define-method ; type selector params body
  (lambda (node compiler)
    `(add-method ,[node second] ',[node third] (lambda (_closure _self self ,@[node fourth]) ,[node fifth]))))

(syntax bs-lambda	; parameters body
  (lambda (node compiler)
    `(lambda ,[node second] ,[node third])))

(syntax bs-call		; function arguments
  (lambda (node compiler)
    `(,[node second] ,@[node third])))

(syntax bs-send		; receiver selector arguments
  (lambda (node compiler)
    `(send ',[node third] ,[node second] ,@[node fourth])))

(syntax bs-add		(lambda (node compiler) `[,[node second] +  ,[node third]]))
(syntax bs-subtract	(lambda (node compiler) `[,[node second] -  ,[node third]]))
(syntax bs-multiply	(lambda (node compiler) `[,[node second] *  ,[node third]]))
(syntax bs-divide	(lambda (node compiler) `[,[node second] /  ,[node third]]))
(syntax bs-modulus	(lambda (node compiler) `[,[node second] %  ,[node third]]))

(syntax bs-less		(lambda (node compiler) `[,[node second] <  ,[node third]]))
(syntax bs-lessEqual	(lambda (node compiler) `[,[node second] <= ,[node third]]))
(syntax bs-equal	(lambda (node compiler) `[,[node second] =  ,[node third]]))
(syntax bs-notEqual	(lambda (node compiler) `[,[node second] ~= ,[node third]]))
(syntax bs-greaterEqual	(lambda (node compiler) `[,[node second] >= ,[node third]]))
(syntax bs-greater	(lambda (node compiler) `[,[node second] >  ,[node third]]))

(syntax bs-assign	; symbol value
  (lambda (node compiler)
    `(define ,[node second] ,[node third])))

(syntax bs-while
  (lambda (node compiler)
    `(while ,[node second] ,[node third])))

(syntax bs-for
  (lambda (node compiler)
    `(let ()
       ,[node second]
       (while ,[node third]
	 ,[node fifth]
	 ,[node fourth]))))

(syntax bs-if
  (lambda (node compiler)
    `(if ,[node second] ,[node third] ,[node fourth])))

(syntax bs-type		; base fields
  (lambda (node compiler)
    (let ((base   [node second])
	  (name   [base asString])
	  (fields [node third]))
      `(let ((proto  [(import ,name) _delegated]))	; this is the new type
	 ;;[[proto _vtable] methodAt: '_sizeof    put: (lambda (_closure _self self) ,[SmallInteger value_: protoSize]) with: 0]
	 [[proto _vtable] methodAt: '_debugName put: (lambda (_closure _self self) ,name) with: 0]
	 ;;(export ,[protoName asString] proto)	; export new type to Pepsi global namespace
	 ;;,@(make-accessors baseSize slotNames)
	 proto))))

(syntax bs-print
  (lambda (node compiler)
    (let ((arg [node second]))
      (if arg `[[,arg asString] put] '['"\t" put]))))

(syntax bs-println
  (lambda (node compiler)
    (let ((arg [node second]))
      (if arg `[[,arg asString] putln] '['"\n" put]))))

(printf "; defining syntax\n")

(define Integer (import "Integer"))
(define Float (import "Float"))

['{
  error		= <- [self error: '"bunnu syntax error"]
  eof		= !.
  eol		= '\r' '\n'* | '\n' '\r'*
  space		= [ \t] | eol
  comment	= '//' (!eol .)* eol
  _		= (space | comment)*

  alnum		= [a-zA-Z_0-9]

  magnitude	= ([0-9]+) $->0 !'.' _				<- [Integer fromString: [self @ '0]]
		| (([0-9]+) '.' ([0-9]+)) $->0 _		<- [Float fromString: [self @ '0]]

  number	= '-' magnitude 				<- [result negated]
		|     magnitude

  name		= ([a-zA-Z_][a-zA-Z_0-9]*) $->0 _		<- [[self @ '0] asSymbol]

  // literals

  escapeChar	= 'a' <-  '7 | 'b' <-  '8 | 'e' <- '27 | 'f' <- '12 | 'n' <- '10 | 'r' <- '13 | 't' <-  '9 | 'v' <- '11
  char		= ( '\\' escapeChar ->0 | . ->0 )		<- [self @ '0]
  string	= ( "'" ( !"'" char )* ->0 "'"
		  | '"' ( !'"' char )* ->0 '"' )		<- [[self @ '0] asString]

  comma		= ',' _

  lbrack	= '[' _
  rbrack	= ']' _

  literals	= number ->0 ( comma number )* ->1		<- [Array with: [self @ '0] withAll: [self @ '1]]
		|						<- [Array new: '0]

  array		= lbrack literals ->0 rbrack			<- [self @ '0]

  parameters	= name ->0 ( comma name )* ->1			<- [Array with: [self @ '0] withAll: [self @ '1]]
		|						<- [Array new: '0]

  lparen	= '(' _
  rparen	= ')' _
  dollar	= '$' _

  function	= 'function' !alnum _

  funDefn	= function lparen parameters ->0 rparen
		    statement ->1				<- `(bs-lambda  ,[self @ '0] ,[self @ '1])

  semicolon	= ';' _
  lbrace	= '{' _
  rbrace	= '}' _

  fields	= ( name ->1 semicolon <- [self @ '1] )* ->0	<- [self @ '0]

  type		= 'type' !alnum _

  typeDefn	= type name ->0 lbrace fields ->1 rbrace	<- `(bs-type  ,[self @ '0] ,[self @ '1] "_object") ->0
		    ( plus name ->1				<- [[self @ '0] at: '3 put: [self @ '1]]
		    )?						<- [self @ '0]

  primary	= ( funDefn
		  | typeDefn
		  | name					<- `(bs-name    ,result)
	          | number					<- `(bs-integer ,result)
	          | array					<- `(bs-array   ,result)
	          | string					<- `(bs-string  ,result)
	          | dollar char					<- `(bs-char    ,result)
		  | lparen expression ->0 rparen		<- [self @ '0]
		  )

  dot		= '.' _

  arguments	= expression ->0 ( comma expression )* ->1	<- [Array with: [self @ '0] withAll: [self @ '1]]
		|						<- [Array new: '0]

  funCall	= primary ->0
		    ( lparen arguments ->1 rparen		<- `(bs-call ,[self @ '0] ,[self @ '1]) ->0
		    | dot name ->1 lparen arguments ->2 rparen	<- `(bs-send ,[self @ '0] ,[self @ '1] ,[self @ '2]) ->0
		    )*						<- [self @ '0]

  star		= '*' _
  slash		= '/' !'/' _
  percent	= '%' _

  product	= funCall ->0 ( ( star    funCall ->1		<- `(bs-multiply ,[self @ '0] ,[self @ '1]) ->0 )
		              | ( slash   funCall ->1		<- `(bs-divide   ,[self @ '0] ,[self @ '1]) ->0 )
			      | ( percent funCall ->1		<- `(bs-modulus  ,[self @ '0] ,[self @ '1]) ->0 )
			      )*				<- [self @ '0]
  plus		= '+' _
  minus		= '-' _

  sum		= product ->0 ( ( plus    product ->1		<- `(bs-add	 ,[self @ '0] ,[self @ '1]) ->0 )
			      | ( minus   product ->1		<- `(bs-subtract ,[self @ '0] ,[self @ '1]) ->0 )
			      )*				<- [self @ '0]

  less		= '<' !'<' _
  lessEqual	= '<=' _
  equal		= '==' _
  notEqual	= '!=' _
  greaterEqual	= '>=' _
  greater	= '>' !'>' _

  relation	= sum -> 0 ( ( less   	    sum ->1		<- `(bs-less         ,[self @ '0] ,[self @ '1]) ->0 )
			   | ( lessEqual    sum ->1		<- `(bs-lessEqual    ,[self @ '0] ,[self @ '1]) ->0 )
			   | ( equal  	    sum ->1		<- `(bs-equal        ,[self @ '0] ,[self @ '1]) ->0 )
			   | ( notEqual     sum ->1		<- `(bs-notEqual     ,[self @ '0] ,[self @ '1]) ->0 )
			   | ( greaterEqual sum ->1		<- `(bs-greaterEqual ,[self @ '0] ,[self @ '1]) ->0 )
			   | ( greater      sum ->1		<- `(bs-greater      ,[self @ '0] ,[self @ '1]) ->0 )
			   )*					<- [self @ '0]

  assign	= '=' !'=' _
  cola		= '#' _

  expression	= name ->0 assign relation ->1			<- `(bs-assign ,[self @ '0] ,[self @ '1])
		| relation
		| cola COLA-expression

  var		= 'var' !alnum _

  varDecl	= var name					<- `(bs-define ,[result asSymbol] 0) ->0
		    ( assign expression ->1			<- [[self @ '0] at: '2 put: [self @ '1]]
		    )?						<- [self @ '0]
		| name ->0 dot name ->1 assign
		    function lparen parameters ->2 rparen
		    statement ->3				<- `(bs-define-method ,[self @ '0] ,[self @ '1] ,[self @ '2] ,[self @ '3])

  while		= 'while' !alnum _

  whileStmt	= while lparen expression ->0 rparen
		    statement ->1				<- `(bs-while ,[self @ '0] ,[self @ '1])

  for		= 'for' !alnum _

  forStmt	= for lparen statement  ->0
			     statement  ->1
			     expression ->2 rparen
		    statement ->3				<- `(bs-for ,[self @ '0] ,[self @ '1] ,[self @ '2] ,[self @ '3])

  if		= 'if' !alnum _
  else		= 'else' !alnum _

  ifStmt	= if lparen expression  ->0 rparen
		    statement ->1				<- `(bs-if ,[self @ '0] ,[self @ '1] 0) ->0
		    ( else statement ->1			<- [[self @ '0] at: '3 put: [self @ '1]]
		    )?						<- [self @ '0]

  print		= 'print' !alnum _
  println	= 'println' !alnum _

  printStmt	= ( print					<- `(bs-print 0) ->0
                  | println					<- `(bs-println 0) ->0
		  ) ( expression ->1				<- [[self @ '0] at: '1 put: [self @ '1]]
		    )?						<- [self @ '0]

  compoundStmt	= lbrace topStmt* -> 0 rbrace			<- `(let () ,@[self @ '0])

  statement	= printStmt semicolon
                | whileStmt
                | forStmt
                | ifStmt
                | compoundStmt
		| expression semicolon

  import	= 'import' !alnum _

  importDecl	= import name					<- `(bs-import ,result)

  funDecl	= function name->0
		    lparen parameters ->1 rparen
		    statement ->2				<- `(bs-define ,[self @ '0] (bs-lambda ,[self @ '1] ,[self @ '2]))

  topStmt	= ( varDecl semicolon ->0
		  | importDecl semicolon ->0
		  | funDecl ->0
		  | statement ->0 ) <- [self @ '0]

  program	= _ ( topStmt					<- (let ()
								     ;[result println]
								     (let ((value [result eval]))
								       ;(printf "  => ") [value println]
								       value))
		    | !eof error
                    )*						<- '0
} name: 'bunnu]
