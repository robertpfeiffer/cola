;;; yy-compile.k -- PEG parser generator
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
;;; Last edited: 2007-05-21 00:32:17 by piumarta on emilia

(define fopen	(dlsym "fopen"))
(define fdopen	(dlsym "fdopen"))
(define fclose	(dlsym "fclose"))
(define fprintf (dlsym "fprintf"))

(define indent 0)

(syntax gen=
  (lambda (node)
    `(let ()
       (for (i 1 1 (yy-indent ,[node second])) (fprintf (yy-output ,[node second]) " "))
       (fprintf (yy-output ,[node second]) ,@[node copyFrom: '2]))))

(syntax gen
  (lambda (node)
    `(let ()
       (for (i 1 1 (yy-indent ,[node second])) (fprintf (yy-output ,[node second]) " "))
       (fprintf (yy-output ,[node second]) ,@[node copyFrom: '2])
       (fprintf (yy-output ,[node second]) "\n"))))

(syntax gen+
  (lambda (node)
    `(let ()
       (gen ,@[node copyFrom: '1])
       (incr (yy-indent ,[node second]) 2))))

(syntax gen-
  (lambda (node)
    `(let ()
       (incr (yy-indent ,[node second]) -2)
       (gen ,@[node copyFrom: '1]))))

(syntax yy-label	(lambda (node) `(incr (yy-labels ,[node second]))))

(syntax yyLabel		(lambda (node) `(let()	     (gen  ,[node second] "(label %d)" ,[node third])
					    (yydebug (gen  ,[node second] "(printf \"label %d\\n\")" ,[node third]))
					    )))
(syntax yyJump		(lambda (node) `(gen  ,[node second] "(goto %d)" ,[node third])))
(syntax yySave		(lambda (node) `(gen+ ,[node second] "(let ((yypos%d (yy-pos yy)) (yythunkpos%d (yy-thunkpos yy)))" ,[node third] ,[node third])))
(syntax yyRestore	(lambda (node) `(gen  ,[node second] "(set (yy-pos yy) yypos%d) (set (yy-thunkpos yy) yythunkpos%d)" ,[node third] ,[node third])))
(syntax yyEnd		(lambda (node) `(gen- ,[node second] ")")))


(define [yyNode compile: yy]
  (let ()
    (error "%s should have overridden 'compile:'" [self _debugName])))

(define [yyRule declare: yy]
  (let ()
    (gen yy "(define yy__%s 0)" [self name])
    ;;    (for (index '0 2 [[[self actions] size] - '1])
    ;;      (gen yy "(define yy%s 0)" [[[self actions] at: index] name]))
    ))

(define [yyRule compile: yy]
  (let ()
    (or [self expression] (printf "rule '%s' used but not defined\n" [self name]))
    (or [self used] (== self (yy-start yy)) (printf "rule '%s' defined but not used\n" [self name]))
    (let ((ko   (yy-label yy))
	  (safe (or [[self expression] isQuery] [[self expression] isStar])))
      (gen  yy "\n;; %s" [self name])
      (for (index '0 2 [[[self actions] size] - '1])
	(let ((action [[self actions] at: index]))
	  (gen+ yy "(define yy%s" [action name])
	  (gen+ yy "(lambda (yytext yyleng yy)")
	  (let ((var [[action rule] variables]))
	    (while var
	      (gen yy "(active %s yy_%d_rval yy_%d_lval)" [var name] [var offset] [var offset])
	      (set var [var next])))
	  (yydebug (gen  yy "(printf \"  yy%s\\n\")" [action name]))
	  (gen  yy "(set (yy-result yy) (let () %s))" [action text])
	  (yydebug (gen  yy "(printf \"+ yy%s\\n\")" [action name]))
	  (gen- yy ")")
	  (gen- yy ")")))
      (gen+ yy "(define yy__%s" [self name])
      (gen+ yy "(lambda (yy)")
      (yydebug (gen  yy "(printf \"  %s\\n\")" [self name]))
      (or safe (yySave yy 0))
      (and [self variables] (gen yy "(yyDo yy yyPush %d 0)" (* 4 [[self variables] offset])))
      ;;fprintf(output, "\n  yyprintf((stderr, \"%%s\\n\", \"%s\"));", node->rule.name);
      [[self expression] compile: yy with: ko]
      ;;fprintf(output, "\n  yyprintf((stderr, \"  ok   %%s @ %%s\\n\", \"%s\", yybuf+yypos));", node->rule.name);
      (and [self variables] (gen yy "(yyDo yy yyPush -%d 0)" (* 4 [[self variables] offset])))
      (yydebug (gen yy "(printf \"+ %s\\n\")" [self name]))
      (gen yy "(return 1)")
      (or safe
	  (let ()
	    (yyLabel yy ko)
	    (yyRestore yy 0)
	    ;;fprintf(output, "\n  yyprintf((stderr, \"  fail %%s @ %%s\\n\", \"%s\", yybuf+yypos));", node->rule.name);
	    (and [self variables] (gen yy "(yyDo yy yyPush -%d 0)" (* 4 [[self variables] offset])))
	    (yydebug (gen yy "(printf \"- %s\\n\")" [self name]))
	    (gen yy "(return 0)")
	    (yyEnd yy)))
      (gen- yy ")")
      (gen- yy ")")
      (and (yy-indent yy) (error "bad nesting %d" (yy-indent yy))))
    (and [self next] [[self next] compile: yy])))

(define [yyNode compile: yy with: ko]
  (let ()
    (error "%s should have overridden 'compile:with:'" [self _debugName])))

(define [yyVariable compile: yy with: ko]
  (let ()
    (error "%s should have overridden 'compile:with:" [self _debugName])))

(define [yyAction compile: yy with: ko]
  (let ()
    (gen yy "(yyDo yy yy%s (yy-begin yy) (yy-end yy))" [self name])))

(define [yyName compile: yy with: ko]
  (let ()
    (gen yy "(if (not (yy__%s yy)) (goto %d))" [[self rule] name] ko)
    (if [self variable] (gen yy "(yyDo yy yySet -%d 0)"  [[self variable] offset]))))

(define [yyDot compile: yy with: ko]
  (let ()
    (gen yy "(if (not (yyMatchDot yy)) (goto %d))" ko)))

(define [yyString compile: yy with: ko]
  (let ((string [self string])
	(length (strlen string)))
    (if (or (== 1 length) (and (== 2 length) (== $\\ (char@ string))))
	(gen yy "(if (not (yyMatchChar yy $%s)) (goto %d))"      string ko)
	(gen yy "(if (not (yyMatchString yy \"%s\")) (goto %d))" string ko))))

(define yyClassString
  (lambda (class)
    (let ((string [WriteStream on: [String new: '512]]))
      (for (i 0 1 255)
	[string nextPut: '$\\]
	[string nextPut: (if (char@ class i) '$1 '$0)])
      [[string contents] _stringValue])))

(define [yyClass compile: yy with: ko]
  (let ()
    (gen yy "(if (not (yyMatchClass yy \"%s\")) (goto %d))" (yyClassString (yyEncodeClass [self string])) ko)))

(define [yyPredicate compile: yy with: ko]
  (let ()
    (gen yy "(if (not (let ((yyleng (yy-makeText yy (yy-begin yy) (yy-end yy))) (yytext (yy-text yy))) %s)) (goto %d))" [self text] ko)))

(define [yySequence compile: yy with: ko]
  (let ((node [self first]))
    (while node
      [node compile: yy with: ko]
      (set node [node next]))))

(define [yyAlternate compile: yy with: ko]
  (let ((ok (yy-label yy)))
    (yySave yy ok)
    (let ((node [self first]))
      (while node
	(if [node next]
	    (let ((next (yy-label yy)))
	      [node compile: yy with: next]
	      (yyJump yy ok)
	      (yyLabel yy next)
	      (yyRestore yy ok))
	    (let ()
	      [node compile: yy with: ko]))
	(set node [node next])))
    (yyEnd yy)
    (yyLabel yy ok)))

(define [yyQuery compile: yy with: ko]
  (let ((qko (yy-label yy))
	(qok (yy-label yy)))
    (yySave yy qko)
    [[self element] compile: yy with: qko]
    (yyJump yy qok)
    (yyLabel yy qko)
    (yyRestore yy qko)
    (yyEnd yy)
    (yyLabel yy qok)))

(define [yyStar compile: yy with: ko]
  (let ((again (yy-label yy))
	(out   (yy-label yy)))
    (yyLabel yy again)
    (yySave yy out)
    [[self element] compile: yy with: out]
    (yyJump yy again)
    (yyLabel yy out)
    (yyRestore yy out)
    (yyEnd yy)))

(define [yyPlus compile: yy with: ko]
  (let ((again (yy-label yy))
	(out   (yy-label yy)))
    [[self element] compile: yy with: ko]
    (yyLabel yy again)
    (yySave yy out)
    [[self element] compile: yy with: out]
    (yyJump yy again)
    (yyLabel yy out)
    (yyRestore yy out)
    (yyEnd yy)))

(define [yyPeekFor compile: yy with: ko]
  (let ((ok (yy-label yy)))
    (yySave yy ok)
    [[self element] compile: yy with: ko]
    (yyRestore yy ok)
    (yyEnd yy)))

(define [yyPeekNot compile: yy with: ko]
  (let ((ok (yy-label yy)))
    (yySave yy ok)
    [[self element] compile: yy with: ok]
    (yyJump yy ko)
    (yyLabel yy ok)
    (yyRestore yy ok)
    (yyEnd yy)))

;;; ----------------------------------------------------------------

(define yy-compile
  (lambda (yy output)
    (or (set (yy-output yy)
	     (if output
		 (fopen output "w")
		 (fdopen 1 "w")))
	(error "cannot open output"))
    (gen yy ";;; this file was generated automatically -- EDIT AT YOUR OWN RISK")
    (gen yy ";;; ")
    (gen yy ";;; from yy-compile.k, last edited: 2007-05-20 12:00:52 by piumarta on emilia
"   )
    (if (yy-headers yy)
	(let ((headers (yy-headers yy)))
	  (while [headers notEmpty]
	    (let ((header [headers removeFirst]))
	      (gen yy "%s" [header _stringValue])))
	      (gen yy "")))
    (gen yy "(require 'yy)\n")
    (let ((rules   (yy-rules yy))
	  (maxVars 0))
      (while rules
	(let ((rule (cdar rules)))
	  (debug [StdOut println: rule])
	  [rule declare: yy]
	  (if (and [rule variables] (> [[rule variables] offset] maxVars))
	      (set maxVars [[rule variables] offset]))
	  (set rules (cdr rules yy))))
      (while (> maxVars 0)
	(gen yy "(define yy_%d_lval (lambda () '(- (+ (yy-svals yy) (yy-svalpos yy)) %d)))"      maxVars (* maxVars 4))
	(gen yy "(define yy_%d_rval (lambda () '(long@ (+ (yy-svals yy) (yy-svalpos yy)) -%d)))" maxVars    maxVars   )
	(incr maxVars -1)))
    (let ((rules (yy-rules yy)))
      (while rules
	(let ((rule (cdar rules)))
	  (debug [StdOut println: rule])
	  [rule compile: yy]
	  (set rules (cdr rules yy)))))
    (gen yy "\n(define yy-parse-from")
    (gen yy "  (lambda (yy rule)")
    (gen yy "    (yy-reset yy)")
    (gen yy "    (let ((yyok (rule yy)))")
    (gen yy "      (and yyok (yyDone yy))")
    (gen yy "      (yyCommit yy)")
    (gen yy "      yyok)))")
    (gen yy "\n(define yy-parse")
    (gen yy "  (lambda (yy)")
    (gen yy "    (yy-parse-from yy yy__%s)))" [(yy-start yy) name])
    (and (yy-footer yy)
	 (gen yy "\n%s" (yy-footer yy)))
    (fclose (yy-output yy))))
