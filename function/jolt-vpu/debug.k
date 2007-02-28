(define error		(lambda (message)	(printf "%s\n" message) (exit 1)))
(define syntax-error	(lambda (form message)	(printf "syntax error: expected %s\n" message) (exit 1)))

(define _param		(dlsym "_libid_param"))

(define %main		(long@ (_param 1)))
(define %sysarch	(_param 5))
(define %sysos		(_param 6))

(define pc-map-size	0)
(define pc-map-capacity 4192)
(define pc-map		(malloc (* 4 pc-map-capacity)))

(syntax pc-map-start	 (lambda (node) `(long@ ,[node second] 0)))
(syntax pc-map-end	 (lambda (node) `(long@ ,[node second] 1)))
(syntax pc-map-name	 (lambda (node) `(long@ ,[node second] 2)))
(syntax set-pc-map-start (lambda (node) `(set-long@ ,[node second] 0 ,[node third])))
(syntax set-pc-map-end	 (lambda (node) `(set-long@ ,[node second] 1 ,[node third])))
(syntax set-pc-map-name	 (lambda (node) `(set-long@ ,[node second] 2 ,[node third])))

(define pc-map-append
  (lambda (entry)
    (if (== pc-map-size pc-map-capacity)
	(begin
	  (set pc-map-capacity (* pc-map-capacity 2))
	  (set pc-map (realloc pc-map (* 4 pc-map-capacity)))))
    (set (long@ pc-map pc-map-size) entry)
    (set pc-map-size (+ 1 pc-map-size))))

(define pc-map-add
  (lambda (start end name)
    ;;(printf "pc-map-add %08x %08x %s\n" start end name)
    (let ((entry (malloc 12)))
      (set (pc-map-start entry) start)
      (set (pc-map-end   entry) end  )
      (set (pc-map-name  entry) name )
      (pc-map-append entry)
      start)))

[Compiler registerLambdasWith: pc-map-add]

(syntax get-current-fp
  (lambda (form compiler)
    [[compiler vpu] ldFP]
    0))
    
(define get-caller-fp
  (lambda (fp)
    (long@ fp)))

(define get-frame-ip
  (cond
   ((== 0 (strcmp %sysarch "i386"))	(lambda (fp) (long@ fp 1)))
   ((== 0 (strcmp %sysarch "ppc"))	(lambda (fp) (long@ (get-caller-fp) 2)))
   (1					(error "architecture not supported"))))

(define get-function-name
  (lambda (ip)
    (for (i 0 1 (- pc-map-size 1))
      (let ((entry (long@ pc-map i)))
	(if (and (<= (pc-map-start entry) ip) (< ip (pc-map-end entry)))
	    (return (pc-map-name entry)))))
    ""))

(define %top-level-fp (get-current-fp))

(while (get-caller-fp (get-caller-fp %top-level-fp))
  (set %top-level-fp (get-caller-fp %top-level-fp)))

(define backtrace
  (lambda (result)
    (let ((fp   (get-current-fp))
	  (prev (- fp 1)))
      (while (and fp (< prev fp) (<= fp %top-level-fp))
	(let ((ip (get-frame-ip fp))
	      (fn (get-function-name ip)))
	  (printf "%08x %08x %s\n" fp ip fn))
	(set prev fp)
	(set fp (get-caller-fp fp))))
    result))

(let ((main   (long@ ((dlsym "_libid_param") 1)))
      (symbols (malloc 8192)))
  (sprintf symbols "%s.sym" main)
  (load symbols)
  (free symbols))

(define sigtab
  (let ((names (malloc (* 4 32))))
    (for (i 0 1 31) (set (long@ names i) "unknown"))
    (set (long@ names  1) "hangup")
    (set (long@ names  2) "interrupt")
    (set (long@ names  3) "quit")
    (set (long@ names  4) "illegal instruction")
    (set (long@ names 10) "bus error")
    (set (long@ names 11) "segmentation violation")
    (set (long@ names 15) "software termination from kill")
    names))

(define signal-handler
  (lambda (signum)
    (let ((diag (malloc 64)))
      (sprintf diag "signal %d (%s)" signum (long@ sigtab signum))
      (error diag))))

(define signal (dlsym "signal"))

(define init-signals
  (lambda (handler)
    (signal  1 handler)		; hangup
    (signal  2 handler)		; interrupt
    (signal  3 handler)		; quit
    (signal  4 handler)		; illegal instruction
    (signal 10 handler)		; bus error
    (signal 11 handler)		; segmentation violation
    (signal 15 handler)))	; software termination signal from kill

(init-signals signal-handler)

(define error
  (lambda (message)
    (init-signals 0)
    (printf "\n; error: %s\n" message)
    (backtrace)
    (exit 1)))

(define VPU (import "VPU"))

(begin
  [VPU malloc:	(lambda (lbs) (let ((mem (malloc (+ 8 lbs)))) (set (long@ mem) lbs) ( + mem 8)))]
  [VPU free:	(lambda (ptr) (free (- ptr 8)))])

(define lambda-end (lambda (l) (+ l (long@ l -2))))

(syntax named-lambda	; (named-lambda (args) "name" body...)
  (lambda (form)
    (or [[form size] >= '3]
	(syntax-error form "(named-lambda (args...) \"name\" body...)"))
    (let ((args [form second])
	  (name [form third])
	  (expr [form copyFrom: '1]))
      (or [name isString]
	  (syntax-error form "(named-lamba (args...) \"name\" body...)"))
      [expr first: 'lambda]
      [expr second: args]
      `(let ((l ,expr))
	 (pc-map-add l (lambda-end l) ,name)))))
