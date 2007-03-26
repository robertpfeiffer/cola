" jolt.st -- jolt library shell

  Copyright (c) 2006, 2007 Ian Piumarta
  All rights reserved.

  Permission is hereby granted, free of charge, to any person obtaining a
  copy of this software and associated documentation files (the 'Software'),
  to deal in the Software without restriction, including without limitation
  the rights to use, copy, modify, merge, publish, distribute, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, provided that the above copyright notice(s) and this
  permission notice appear in all copies of the Software and that both the
  above copyright notice(s) and this permission notice appear in supporting
  documentation.

  THE SOFTWARE IS PROVIDED 'AS IS'.  USE ENTIRELY AT YOUR OWN RISK.

  Last edited: 2007-03-26 08:54:27 by piumarta on emilia
"

{ import: Object }
{ import: Scanner }
{ import: Compiler }
{ import: CodeGenerator-local }

Initialisation := ['
(define printf			(_dlsym _RTLD_DEFAULT "printf"))
(define exit			(_dlsym _RTLD_DEFAULT "exit"))

(define dlsym
  (lambda (name)
    (let ((addr (_dlsym _RTLD_DEFAULT name)))
      (if addr
	  addr
	  (let ()
	    (printf "%s: symbol lookup failed\n" name)
	    (exit 1))))))

(define sprintf			(dlsym "sprintf"))
(define malloc			(dlsym "malloc"))
(define realloc			(dlsym "realloc"))
(define free			(dlsym "free"))
(define strcmp			(dlsym "strcmp"))
(define usleep			(dlsym "usleep"))

(define _dlopen			(dlsym "dlopen"))

(define %%dlopen
  (lambda (dir lib ext)
    (let ((buf (malloc 1024)))
      (sprintf buf "%s%s%s" dir lib ext)
      (let ((handle (_dlopen buf _RTLD_NOW)))
	(free buf)
	handle))))

(define %dlopen
  (lambda (dir lib)
    (let ((handle 0))
      (or handle (set handle (%%dlopen dir lib "")))
      (or handle (set handle (%%dlopen dir lib ".so")))
      (or handle (set handle (%%dlopen dir lib ".dylib")))
      handle)))

(define dlopen
  (lambda (lib)
    (printf "; loading: %s\n" lib)
    (let ((handle 0))
      (or handle (set handle (%dlopen "./"              lib)))
      (or handle (set handle (%dlopen ""                lib)))
      (or handle (set handle (%dlopen "/usr/local/lib/" lib)))
      (or handle (set handle (%dlopen "/usr/X11R6/lib/" lib)))
      (if handle
	  handle
	  (let ()
	    (printf "%s: cannot load library\n" lib)
	    (exit 1))))))

;; import/export to/from the object namespace

(define import			(dlsym	"_libid_import"))
(define export			(dlsym	"_libid_export"))

(define Object			(import "Object"))
(define OS			(import "OS"))
(define CokeScanner		(import "CokeScanner"))
(define Expression		(import "Expression"))
(define Compiler		(import "Compiler"))
(define File			(import "File"))
(define ReadStream		(import "ReadStream"))
(define WriteStream		(import "WriteStream"))
(define String			(import "String"))
(define StdIn			(import "StdIn"))
(define StdOut			(import "StdOut"))
(define StdErr			(import "StdErr"))

;; message send syntax

(define _bind	(dlsym "_libid_bind"))

(define Array			(import "Array"))
(define Array__new_		(long@ (_bind \'new:		Array)))
(define Array__copyWithFirst_	(long@ (_bind \'copyWithFirst:	Array)))
(define Array__withParameters_	(long@ (_bind \'withParameters:	Array)))
(define Array__at_		(long@ (_bind \'at:		Array)))
(define Array__at_put_		(long@ (_bind \'at:put:		Array)))

(syntax send ; (send selector receiver args...)
  (lambda (form compiler)
    (let ((call   (Array__copyWithFirst_ 0 form form 0))
	  (params (Array__new_           0 Array Array \'3)))
      (Array__at_put_ 0 call call   \'0 \'(long@ __c))
      (Array__at_put_ 0 call call   \'1 \'__c)
      (Array__at_put_ 0 call call   \'2 \'__r)
      (Array__at_put_ 0 call call   \'3 \'__r)
      (Array__at_put_ 0 params params \'0 (Array__at_ 0 form form \'1))
      (Array__at_put_ 0 params params \'1 (Array__at_ 0 form form \'2))
      (Array__at_put_ 0 params params \'2 call)
      (let ((send \'(let ((__s : 0) (__r : 1))
		     (let ((__c (_bind __s __r)))
		       : 2))))
	(Array__withParameters_ 0 send send params)))))

(define herald
  (lambda (path)
    [StdErr nextPutAll: \'"; "]
    [StdErr nextPutAll: [String value_: path]]
    [StdErr cr]))

;; read and evaluate a sequence of ASTs

(lambda (cString)
  (let ((string  [String value_: cString])
        (scanner [CokeScanner on: [string readStream]])
        (expr    0)
        (result  0))
    (while (set expr [scanner next])
      ;;[StdOut print: expr][StdOut cr]
      (set result [expr _eval]))
    result))
']

Jolt : Object ()

Jolt initialise
[
    | scanner expr result |
    scanner := CokeScanner on: Initialisation readStream.
    [(expr := scanner next) isNil]
	whileFalse:
	   ["StdErr print: expr; cr."
	    result := expr _eval.
	    "StdErr nextPutAll: ' => '; print: expr; cr"].
    ^result
]
