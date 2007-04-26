;;; boot.k -- construct default compilation and evaluation environment

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

;;; Last edited: 2007-04-26 13:14:47 by piumarta on emilia

(define __dlsym _dlsym)

(define printf			(__dlsym _RTLD_DEFAULT "printf"))
(define exit			(__dlsym _RTLD_DEFAULT "exit"))

(define _dlsym
  (lambda (lib name)
    (let ((addr (__dlsym lib name)))
      (or addr
	  (let ()
	    (printf "%s: symbol lookup failed\n" name)
	    (exit 1)))
      addr)))

(define dlsym
  (lambda (name)
    (_dlsym _RTLD_DEFAULT name)))

(define sprintf			(dlsym "sprintf"))
(define malloc			(dlsym "malloc"))
(define realloc			(dlsym "realloc"))
(define free			(dlsym "free"))
(define strcmp			(dlsym "strcmp"))
(define usleep			(dlsym "usleep"))

(define _dlopen			(dlsym "dlopen"))
(define dlclose			(dlsym "dlclose"))

(define %%dlopen
  (lambda (dir lib ext)
    (let ((buf (malloc 1024)))
      (sprintf buf "%s%s%s" dir lib ext)
      (let ((handle (_dlopen buf (| _RTLD_NOW _RTLD_GLOBAL))))
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
      (or handle (let ()
		   (printf "%s: cannot load library\n" lib)
		   (exit 1)))
      handle)))

;; import/export to/from the object namespace

(define import			(dlsym	"_libid_import"))
(define export			(dlsym	"_libid_export"))

(define Object			(import "Object"))
(define OS			(import "OS"))
(define Options			(import "Options"))
(define CokeScanner		(import "CokeScanner"))
(define OrderedCollection	(import "OrderedCollection"))
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
(define Array__new_		(long@ (_bind 'new:		Array)))
(define Array__copyWithFirst_	(long@ (_bind 'copyWithFirst:	Array)))
(define Array__withParameters_	(long@ (_bind 'withParameters:	Array)))
(define Array__at_		(long@ (_bind 'at:		Array)))
(define Array__at_put_		(long@ (_bind 'at:put:		Array)))

(syntax send ; (send selector receiver args...)
  (lambda (form compiler)
    (let ((call   (Array__copyWithFirst_ 0 form form 0))
	  (params (Array__new_           0 Array Array '3)))
      (Array__at_put_ 0 call call   '0 '(long@ __c))
      (Array__at_put_ 0 call call   '1 '__c)
      (Array__at_put_ 0 call call   '2 '__r)
      (Array__at_put_ 0 call call   '3 '__r)
      (Array__at_put_ 0 params params '0 (Array__at_ 0 form form '1))
      (Array__at_put_ 0 params params '1 (Array__at_ 0 form form '2))
      (Array__at_put_ 0 params params '2 call)
      (let ((send '(let ((__s : 0) (__r : 1))
		     (let ((__c (_bind __s __r)))
		       : 2))))
	(Array__withParameters_ 0 send send params)))))

(define CokeScanner		(import "CokeScanner"))

(define open-bracket-reader
  (lambda (_closure _self self stream)
    (send 'next stream)
    (let ((node (send 'read:list:delimited: self stream Expression '93))
	  (list (send 'withAll: OrderedCollection node)))
      (if (< (send 'size list) '2)
	  (send 'syntaxError: self node)
	  (let ((receiver  (send 'removeFirst list))
		(selector  (send 'removeFirst list))
		(arguments (send 'new OrderedCollection)))
	    (or (send 'isSymbol selector)
		(send 'syntaxError: self node))
	    (and (send 'notEmpty list)
		 (send 'addLast: arguments (send 'removeFirst list)))
	    (while (and (>= (send 'size list) 2)
			(send 'isKeyword selector)
			(send 'isKeyword (send 'first list)))
	      (set selector (send ', selector (send 'removeFirst list)))
	      (send 'addLast: arguments (send 'removeFirst list)))
	    (send 'addAllLast: arguments list)
	    (let ((message (send 'on: WriteStream (send 'new: Expression '4))))
	      (send 'nextPut: message 'send)
	      (send 'nextPut: message (send 'with:with: Expression 'quote selector))
	      (send 'nextPut: message receiver)
	      (send 'nextPutAll: message arguments)
	      ;(send 'print: StdOut (send 'contents message))
	      ;(send 'cr StdOut)
	      (send 'contents message)))))))

(define close-bracket-reader
  (lambda (_closure _self self stream)
    (send 'error:unexpected: self stream '93)))

(send 'readerAt:put: CokeScanner '91 open-bracket-reader)
(send 'readerAt:put: CokeScanner '93 close-bracket-reader)

(define herald
  (lambda (path)
    [StdErr nextPutAll: '"; loading: "]
    [StdErr nextPutAll: [String value_: path]]
    [StdErr cr]))

(herald "boot.k")

;; read and evaluate a stream of s-expressions

(define read
  (lambda (fileOrString)
    (let ((stream [fileOrString readStream])
	  (expr    0))
      (while (set expr [CokeScanner read: stream])
	(if [Options verbose] (let () [StdOut print: expr][StdOut cr]))
	(set expr [expr eval])
	(if [Options verbose] (let () [StdOut nextPutAll: '"  => "][StdOut print: expr][StdOut cr]))))))

;; read the contents of a file

(define load-if-present
  (lambda (path)
    (let ((file [File openIfPresent: [String value_: path]]))
      (if file
	  (let ()
	    (herald path)
	    (read file)
	    1)
	  0))))

(define load
  (lambda (path)
    (or (load-if-present path)
	(let ()
	  (printf "%s: No such file or directory\n" path)
	  (exit 1)))))

(define load
  (lambda (path)
    (let ((file [File openIfPresent: [String value_: path]]))
      (or file (set file [File openIfPresent: [[[Options libdir] , '"/"] , [String value_: path]]]))
      (if file
	  (let ()
	    (herald path)
	    (read file))
          (let ()
	    (printf "%s: No such file or directory\n" path)
	    (exit 1))))))

(load "quasiquote.k")	; enable backquote (`) syntax for quasiquotation
(load "syntax.k")	; syntactic sugar for common constructs
(load "number.k")	; numeric syntax
(load "debug.k")	; debugging
(load "object.k")	; object manipulation
