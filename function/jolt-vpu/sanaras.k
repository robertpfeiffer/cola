;;; Sana sanita colita de rana
;;; Si no sanas hoy sanarás mañana

(define fail
  (lambda (expr)
    [StdErr nextPutAll: '"FAIL "]
    [StdErr print: expr]
    [StdErr cr]
    [OS exit: 0]))

(syntax assert
  (lambda (form)
    `(or ,[form second] (fail ',[form second]))))

(syntax refute
  (lambda (form)
    `(and ,[form second] (fail ',[form second]))))

(printf "bool...\n")

(refute	0)
(assert	1)

(assert	-2)
(assert	-1)
(assert	1)
(assert	2)
(assert	16r100)
(assert	16r10000)
(assert	16r1000000)
(assert	16r8000000)

(assert (not 0))
(refute	(not 1))

(refute	(not -2))
(refute	(not -1))
(refute	(not 1))
(refute	(not 2))
(refute	(not 0x100))
(refute	(not 0x10000))
(refute	(not 0x1000000))
(refute	(not 0x8000000))

(assert	(== -1 -1))	(refute	(== -1  0))	(refute	(== -1  1))
(refute	(==  0 -1))	(assert	(==  0  0))	(refute	(==  0  1))
(refute	(==  1 -1))	(refute	(==  1  0))	(assert	(==  1  1))

(refute	(!= -1 -1))	(assert	(!= -1  0))	(assert	(!= -1  1))
(assert	(!=  0 -1))	(refute	(!=  0  0))	(assert	(!=  0  1))
(assert	(!=  1 -1))	(assert	(!=  1  0))	(refute	(!=  1  1))

(refute	(< -1 -1))	(assert	(< -1  0))	(assert	(< -1  1))
(refute	(<  0 -1))	(refute	(<  0  0))	(assert	(<  0  1))
(refute	(<  1 -1))	(refute	(<  1  0))	(refute	(<  1  1))

(assert	(<= -1 -1))	(assert	(<= -1  0))	(assert	(<= -1  1))
(refute	(<=  0 -1))	(assert	(<=  0  0))	(assert	(<=  0  1))
(refute	(<=  1 -1))	(refute	(<=  1  0))	(assert	(<=  1  1))

(assert	(>= -1 -1))	(refute	(>= -1  0))	(refute	(>= -1  1))
(assert	(>=  0 -1))	(assert	(>=  0  0))	(refute	(>=  0  1))
(assert	(>=  1 -1))	(assert	(>=  1  0))	(assert	(>=  1  1))

(refute	(> -1 -1))	(refute	(> -1  0))	(refute	(> -1  1))
(assert	(>  0 -1))	(refute	(>  0  0))	(refute	(>  0  1))
(assert	(>  1 -1))	(assert	(>  1  0))	(refute	(>  1  1))

(refute	(or 0 0))	(assert	(or 0 1))	(assert	(or 1 0))	(assert	(or 1 1))
(refute	(or 0 0 0))	(assert	(or 0 0 1))	(assert	(or 0 1 0))	(assert	(or 0 1 1))
(assert	(or 1 0 0))	(assert	(or 1 0 1))	(assert	(or 1 1 0))	(assert	(or 1 1 1))

(refute	(and 0 0))	(refute	(and 0 1))	(refute	(and 1 0))	(assert	(and 1 1))
(refute	(and 0 0 0))	(refute	(and 0 0 1))	(refute	(and 0 1 0))	(refute	(and 0 1 1))
(refute	(and 1 0 0))	(refute	(and 1 0 1))	(refute	(and 1 1 0))	(assert	(and 1 1 1))

(printf "arithmetic...\n")

(assert	(== 0 (+ 0 0)))	(assert	(== 1 (+ 0 1)))	(assert	(== 1 (+ 1 0)))	(assert	(== 2 (+ 1 1)))

(assert	(== 1 (+ 0 0 1)))	(assert	(== 1 (+ 0 1 0)))
(assert	(== 1 (+ 0 1 0)))	(assert	(== 2 (+ 0 1 1)))
(assert	(== 2 (+ 1 0 1)))	(assert	(== 3 (+ 1 1 1)))

(assert	(== 3 (+ 1 2 0)))
(assert	(== 4 (+ 1 0 3)))
(assert	(== 5 (+ 0 2 3)))

(assert	(==  8 (+ 10 -2)))	(assert	(== 8 (+ -2 10)))
(assert	(== -8 (+ -10 2)))	(assert	(== -8 (+ 2 -10)))

(assert	(== 55 (+ 1 2 3 4 5 6 7 8 9 10)))

(assert	(== -1 (- 1)))
(assert	(==  0 (- 1 1)))
(assert	(== -2 (- -1 1)))
(assert	(==  0 (- -1 -1)))
(assert	(==  4 (- 10 1 2 3)))
(assert	(== 16 (- 10 -1 -2 -3)))

(assert	(== 0 (* 0 0 1)))	(assert	(== 0 (* 0 1 0)))
(assert	(== 0 (* 0 1 0)))	(assert	(== 0 (* 0 1 1)))
(assert	(== 0 (* 1 0 1)))	(assert	(== 1 (* 1 1 1)))

(assert	(== 12 (* 4 3)))
(assert	(== 60 (* 5 4 3)))

(assert	(== -20 (*  10 -2)))	(assert	(== -20 (* -2  10)))
(assert	(== -20 (* -10  2)))	(assert	(== -20 (*  2 -10)))
(assert	(==  20 (*  10  2)))	(assert	(==  20 (* -2 -10)))

(assert	(== 120 (* 1 2 3 4 5)))

(assert	(==  22 (/ 22  1)))
(assert	(==   0 (/  1 22)))
(assert	(==   0 (/  0 22)))
(assert	(==   3 (/ 22  7)))
(assert	(==   3 (/ 666 7 6 5)))

(assert	(==   0 (% 22  1)))
(assert	(==   1 (%  1 22)))
(assert	(==   0 (%  0 22)))
(assert	(==   1 (% 22  7)))
(assert	(==   2 (% 666 10 4)))

(assert	(== 42 (+ 22 20)))
(assert	(==  2 (- 22 20)))
(assert	(== 42 (* 6 7)))
(assert	(==  6 (/ 666 111)))
(assert	(== 66 (% 666 100)))

(printf "bitwise operations and large constants...\n")

(assert	(== 0x00000100 (<< 0x00000001 8)))
(assert	(== 0x00000001 (>> 0x00000100 8)))
(assert	(== 0x78000000 (<< 0x12345678 24)))
(assert	(== 0x00000012 (>> 0x12345678 24)))

(assert	(== 0x40000000 (<< 0x00000001 30)))
(assert	(== 0x80000000 (<< 0x00000001 31)))
(assert	(== 0xfffffffe (>> 0x80000000 30)))
(assert	(== 0xffffffff (>> 0x80000000 31)))

(define a 0b1101001000100001000001)
(define b 0b1000001000010001001011)

(assert	(== 0b1000001000000001000001 (& a b)))
(assert	(== 0b1101001000110001001011 (| a b)))
(assert	(== 0b0101000000110000001010 (^ a b)))	;; VPU-3.x barfs on this!

(set a 0x12345678)
(set b 0x87654321)

(assert (== 0x99999999 (+ a b)))

(assert	(== 0x12345678 a))
(assert	(== 0x87654321 b))

(assert	(== 0x00123456 (>> a  8)))	(assert	(== 0xff876543 (>> b  8)))
(assert	(== 0x00001234 (>> a 16)))	(assert	(== 0xffff8765 (>> b 16)))
(assert	(== 0x00000012 (>> a 24)))	(assert	(== 0xffffff87 (>> b 24)))
(assert	(== 0x00000000 (>> a 31)))	(assert	(== 0xffffffff (>> b 31)))
(assert	(== 0x34567800 (<< a  8)))	(assert	(== 0x65432100 (<< b  8)))
(assert	(== 0x56780000 (<< a 16)))	(assert	(== 0x43210000 (<< b 16)))
(assert	(== 0x78000000 (<< a 24)))	(assert	(== 0x21000000 (<< b 24)))
(assert	(== 0x00000000 (<< a 31)))	(assert	(== 0x80000000 (<< b 31)))

(printf "local scope...\n")

(assert	(==   0 (let ((x 0) (y 42) (z 666)) x)))
(assert	(==  42 (let ((x 0) (y 42) (z 666)) y)))
(assert	(== 666 (let ((x 0) (y 42) (z 666)) z)))
(assert	(==   0 (let ((x 0)) (let ((y 42) (z 666)) x))))
(assert	(==  42 (let ((x 0)) (let ((y 42) (z 666)) y))))
(assert	(== 666 (let ((x 0)) (let ((y 42) (z 666)) z))))
(assert	(==   0 (let ((x 0)) (let ((y 42)) (let ((z 666)) x)))))
(assert	(==  42 (let ((x 0)) (let ((y 42)) (let ((z 666)) y)))))
(assert	(== 666 (let ((x 0)) (let ((y 42)) (let ((z 666)) z)))))
(assert	(==   0 (let ((x 0) (y 42)) (let ((z 666)) x))))
(assert	(==  42 (let ((x 0) (y 42)) (let ((z 666)) y))))
(assert	(== 666 (let ((x 0) (y 42)) (let ((z 666)) z))))

(printf "conditional and loop...\n")

(assert	(if 1 1 0))	(refute	(if 0 1 0))
(refute	(if 1 0 1))	(assert	(if 0 0 1))

(assert	(== 42  (if -1 42 666)))
(assert	(== 42  (if  1 42 666)))
(assert	(== 666 (if  0 42 666)))
(assert	(== 42  (if  2 42 666)))
(assert	(== 42  (if  3 42 666)))

(define a   (lambda () 42))
(define b   (lambda () 666))
(define c   (lambda () 999))
(define yes (lambda () 1))
(define no  (lambda () 0))

(assert	(== 42 (let ((var 0))
		(if (yes)
		    (if (== 0 var)
			(a)
			(b))
		    (c)))))

(assert	(== 666 (let ((var 1))
		 (if (yes)
		     (if (== 0 var)
			 (a)
			 (b))
		     (c)))))

(assert	(== 999 (let ((var 1))
		 (if (no)
		     (if (== 0 var)
			 (a)
			 (b))
		     (c)))))

(assert	(== 54 (let ((x 1) (y 0))
		(while (< x 10)
		  (set y (+ y (set x (+ x 1)))))
		y)))

(printf "arguments and nested calls...\n")

(define iii (lambda (a b) (+ a b)))

(assert	(==  3 (iii 1 2)))
(assert (== 10 (iii (iii 1 2) (iii 3 4))))
(assert (== 10 (iii (iii 1 2 3 4 5 6 7  8  9 10 11 12 13 14 15 16)
		   (iii 3 4 5 6 7 8 9 10 11 12 13 14 15 16))))

(define iv (lambda (a b c d e) (+ a b c d e)))
(define iv (lambda (a b c d e) (+ a e)))

;(compileFlags 1)
(assert	(==  6 (iv 1 2 3 4 5)))
;(compileFlags 0)
(assert	(==  6 (iv 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16)))
(assert	(== 20 (iv (iv 1 2 3 4 5)
		  (iv 2 3 4 5 6  7  8  9 10 11 12 13 14)
		  (iv 3 4 5 6 7  8  9 10 11 12 13 14)
		  (iv 4 5 6 7 8  9 10 11 12 13 14)
		  (iv 5 6 7 8 9 10 11 12 13 14))))

(define ix (lambda (a b c d e f g h i j k l) (+ a j)))

(ix 1 2 3 4 5 6 7 8 9 10)
(ix 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19)

(assert	(== 11 (ix  1  2  3  4  5  6  7  8  9 10)))
(assert	(== 31 (ix 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25)))

(assert	(== 42 (ix (ix  1  2  3  4  5  6  7  8  9 10)
		  0
		  0
		  0
		  0
		  0
		  0
		  0
		  0
		  (ix 11 12 13 14 15 16 17 18 19 20))))

(assert	(== 42 (ix (ix  1  2  3  4  5  6  7  8  9 10)
		  (ix  2  3  4  5  6  7  8  9 10 11)
		  (ix  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18)
		  (ix  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18)
		  (ix  5  6  7  8  9 10 11 12 13 14 15 16 17 18)
		  (ix  6  7  8  9 10 11 12 13 14 15 16 17 18)
		  (ix  7  8  9 10 11 12 13 14 15 16 17 18)
		  (ix  8  9 10 11 12 13 14 15 16 17 18)
		  (ix  9 10 11 12 13 14 15 16 17 18)
		  (ix 11 12 13 14 15 16 17 18 19 20))))

(printf "memory access...\n")

(define x 42)
(assert	(== 42 x))

(set x 666)
(assert	(== 666 x))

(define malloc (dlsym "malloc"))
(define x (malloc 4))
(set x (malloc 16))

(set (long@ x  ) 1)	(assert	(== 1 (long@ x)))		(assert	(== 1 (long@ x 0)))
(set (long@ x 1) 2)	(assert	(== 2 (long@ x 1)))	(assert	(== 2 (long@ (+ x  4))))
(set (long@ x 2) 3)	(assert	(== 3 (long@ x 2)))	(assert	(== 3 (long@ (+ x  8))))
(set (long@ x 3) 4)	(assert	(== 4 (long@ x 3)))	(assert	(== 4 (long@ (+ x 12))))

(if (char@ x)
    (begin
      (printf "(your machine is LITTLE endian)\n")
      (assert (== 1 (char@ (+ x  0))))	(assert (== 0 (char@ (+ x  3))))
      (assert (== 2 (char@ (+ x  4))))	(assert (== 0 (char@ (+ x  7))))
      (assert (== 3 (char@ (+ x  8))))	(assert (== 0 (char@ (+ x 11))))
      (assert (== 4 (char@ (+ x 12))))	(assert (== 0 (char@ (+ x 15))))
      (set (long@ x) 0x12345678)
      (assert (== 0x12 (char@ x 3)))
      (assert (== 0x34 (char@ x 2)))
      (assert (== 0x56 (char@ x 1)))
      (assert (== 0x78 (char@ x 0)))
      (assert (== 0x1234 (short@ x 1)))
      (assert (== 0x5678 (short@ x 0)))
      (set (short@ x 1) 0xabcd)
      (assert (== 0xabcd5678 (long@ x))))
    (begin
      (printf "(your machine is BIG endian)\n")
      (assert (== 0 (char@ (+ x  0))))	(assert (== 1 (char@ (+ x  3))))
      (assert (== 0 (char@ (+ x  0))))	(assert (== 2 (char@ (+ x  7))))
      (assert (== 0(char@ (+ x  0))))	(assert (== 3 (char@ (+ x 11))))
      (assert (== 0 (char@ (+ x  0))))	(assert (== 4 (char@ (+ x 15))))
      (set (long@ x) 0x12345678)
      (assert (== 0x12 (char@ x 0)))
      (assert (== 0x34 (char@ x 1)))
      (assert (== 0x56 (char@ x 2)))
      (assert (== 0x78 (char@ x 3)))
      (assert (== 0x1234 (short@ x 0)))
      (assert (== 0x5678 (short@ x 1)))
      (set (short@ x 1) 0xabcd)
      (assert (== 0x1234abcd (long@ x)))))

(printf "local variable overload...\n")

(define func
  (lambda (a)
    (let ((b (+ a a))
	  (c (+ b b))
	  (d (+ c c))
	  (e (+ d d))
	  (f (+ e e))
	  (g (+ f f))
	  (h (+ g g))
	  (i (+ h h))
	  (j (+ i i))
	  (k (+ j j))
	  (l (+ k k))
	  (m (+ l l))
	  (n (+ m m))
	  (o (+ n n))
	  (p (+ o o))
	  (q (+ p p))
	  (r (+ q q))
	  (s (+ r r))
	  (t (+ s s))
	  (u (+ t t))
	  (v (+ u u))
	  (w (+ v v))
	  (x (+ w w))
	  (y (+ x x))
	  (z (+ y y)))
      (+ a b c d e f g h i j k l m n o p q r s t u v w x y z))))

(assert (== (- (<< 1 26) 1) (func 1)))

(printf "pathological cases...\n")

; aliased output used in call arguments
(define malloc  (dlsym "malloc"))
(define sprintf (dlsym "sprintf"))
(define buf (malloc 32))
(assert (== 11 (sprintf buf "%d %d %d\n" 1 (if 0 22 333) 4444)))
(assert (== 10 (sprintf buf "%d %d %d\n" 1 (if 1 22 333) 4444)))

; aliased binary outputs
(define x 0)
(assert (== 7 (if 0 (+ 1 2) (+ 3 4))))
(assert (== 3 (if 1 (+ 1 2) (+ 3 4))))

; call to label address
(define sfib (lambda (n) (if (< n 2) 1 (* n (sfib (- n 1))))))
(assert (== 120 (sfib 5)))

; call to variable address
(define sg 0)
(define sg (lambda (n) (if (< n 2) 1 (* n ((begin sg) (- n 1))))))
(assert (== 120 (sg 5)))

; local functions and funargs
(assert (== 42 (let ((f1 (lambda (x) (+ x x)))
		    (f2 (lambda (x) (* x 3)))
		    (f3 (lambda (x) (- x 1))))
		(f1 (f2 (f3 8))))))

(assert (== 42 (let ((f1 (lambda (f2 x) (f2 x)))
		    (f3 (lambda (x) (* 2 x))))
		(f1 f3 21))))

; reload of aliased registers (requires small # of regs (read: i386))

(define a 0)
(define b 1)

(assert (== 3 (if 0 (+ a (+ a (+ a (+ a (+ b (+ b a))))))
		 (if 1 3 4))))

(assert (== 2 (if 1 (+ a (+ a (+ a (+ a (+ a (+ a (+ b (+ b (+ a (+ a a))))))))))
		 (if 1 3 4))))

(assert (== 3 (if 0 1
		 (if 1 3 4))))

(assert (== 3 (if 0 (+ a (+ a (+ a (+ a (+ a (+ a (+ b (+ b (+ a (+ a a))))))))))
		 (if 1 3 4))))

(assert (== 4 (if 0 1
		 (if 0 3 4))))

(assert (== 4 (if 0 (+ a (+ a (+ a (+ a (+ a (+ a (+ b (+ b (+ a (+ a a))))))))))
		 (if 0 3 4))))

(define a 1)
(define b 2)

(define vec (malloc 8))
(set (long@ vec 0) 3)
(set (long@ vec 1) 4)

(define p (lambda (a b c) (printf "%d %d %d\n" a b c)))

(let ((c 4))
  (printf "%d\n" (+ a (* 4 (+ c (long@ vec 0))))))

(let ((c 4))
  (printf "%d\n"
		 (+ a (* 4 (long@ vec 1)))))

(let ((c 4))
  (printf "%d\n"
		 (* 4 c)))

;(set-compiler-flags (set-debug-flags -1))

(let ((c 4))
  (printf "%d %d %d\n"
		 (+ a (* 4 (+ c (long@ vec 0))))
		 (+ a (* 4 (long@ vec 1)))
		 (* 4 c)))

(let ((x 2))
  (+ x x x x x))

(define strdup  (dlsym "strdup"))
(define strcmp  (dlsym "strcmp"))
(define isalpha (dlsym "isalpha"))

(define capitalise
  (lambda (s)
    (let ((t (strdup s)) (p t) (c 0))
      (while (set c (char@ p))
	(if (isalpha c) (set (char@ p) (& c 0xdf)))
	(set p (+ p 1)))
      t)))

(assert (strcmp "Hoopla! oink! oink!" (capitalise "Hoopla! oink! oink!")))
(refute (strcmp "HOOPLA! OINK! OINK!" (capitalise "Hoopla! oink! oink!")))

(printf "objects...\n")

(define-type X Object (foo))

(printf "done\n")
(printf "congratulations -- your code generator (%s) passes a bunch of simple tests\n\n" [[(import "VPU") versionString] _elements])
