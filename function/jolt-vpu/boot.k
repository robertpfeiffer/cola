;;; -*- coke -*-
;;; 
;;; Handy definitions for all coke programs.

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

(define herald
  (lambda (path)
    [StdErr nextPutAll: '"; loading: '"]
    [StdErr nextPutAll: [String value_: path]]
    [StdErr cr]))

(herald "boot.k")

;; read and evaluate a stream of s-expressions

(define read
  (lambda (fileOrString)
    (let ((scanner [CokeScanner on: [fileOrString readStream]])
	  (expr    0))
      (while (set expr [scanner next])
	[expr eval]))))

;; read the contents of a file

(define load
  (lambda (path)
    (let ((file [File open: [String value_: path]]))
      (if file
	  (let ()
	    (herald path)
	    (read file))
          (let ()
	    (printf "%s: No such file or directory\n" path)
	    (exit 1))))))

(load "quasiquote.k")	; enable backquote (`) syntax for quasiquotation
(load "syntax.k")	; syntactic sugar for common constructs
(load "debug.k")	; debugging
(load "object.k")	; object manipulation
