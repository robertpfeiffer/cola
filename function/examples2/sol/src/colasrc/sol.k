
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;											     ;;;
;;;  SOL Language Interpreter                       					     ;;;
;;;                                                               			     ;;;
;;;  COLA Version: running directly on COLA objects					     ;;;
;;;                                                               			     ;;;
;;; Author:        Hesam Samimi                                   			     ;;;
;;;                                                               			     ;;;
;;; Revision:      # 1.74                                       			     ;;;
;;; Last Update:   07-29-2008								     ;;; 
;;;                                                               			     ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;											     ;;;
;;; Instructions:								 	     ;;;
;;;   1. Start your program with line:							     ;;;
;;;         { sol-program }								     ;;;
;;;   2. Run the interpreter, replacing <program filename> to the full name of your program: ;;;
;;;   	 (the dash at the end needed for interactive interpreter upon loading of your file)  ;;;
;;;   	    idst/function/jolt2/main idst/function/jolt2/boot.k sol.k <program filename> -   ;;;
;;;   3. To start interactive after running the file, in cola interpreter type:              ;;;
;;;   	    { sol-program }    	    	    		 				     ;;;
;;;   	     		 					       			     ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; importing define-type into jolt2 from jolt ;; fixme
(load "define-type.k")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Some low level constructs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define IdentityDictionary (import "IdentityDictionary"))
(define LinkedList (import "LinkedList"))
(define Random (import "Random"))
(define Integer (import "Integer"))
(define Float (import "Float"))
(define Symbol (import "Symbol"))

;; find out name of program file if it is given on the cmdline
(define programFileName (let ((args [OS arguments])) 
			     (if (and [[args size] > '2]
			     	      (!= [[[OS arguments] at: '2] asSymbol] '-))
				 [[[OS arguments] at: '2] _eval]
				 0)))

;; parameters
(define sol-opts [IdentityDictionary new])
[sol-opts at: 'max-time-ahead put: '3] ;; max search tree depth to go

;; constants
(define braces [Array with: '"{" with: '"}"])
(define brackets [Array with: '"[" with: '"]"])
(define parens [Array with: '"(" with: '")"])

(define sol-true 'yes)
(define sol-false 'no)
(define sol-unknown 'unknown)
(define sol-null 0)
(define sol-ok 'ok.)
(define sol-error '"violation!")

;; replaceKeywords: 
;; it or its will be replaced with name of class in question, of is replaced
;; with the element in question from the set.
(define sol-it 'sol-it)
(define sol-of 'sol-of)
(define sol-each 'sol-each)
(define sol-now 'sol-now)
(define sol-all 'sol-all)
(define sol-every 'sol-every)
(define sol-any 'sol-any)
(define sol-hypothetical 'sol-hypothetical)
(define sol-actual 'sol-actual)
(define sol-size 'sol-size)
(define sol-minimize 'minimize)
(define sol-maximize 'maximize)

(define solRandomGen [Random new])

;; x ^ y
(define math-exp
	(lambda (x y)
		(let ((ans '1))
		     (while [y > '0]
		     	    (set ans [ans * x])
			    (set y [y - '1]))
		     ans)))

;; returns a new collection with a subset of elements in original collection which 
;; satisfy a predicate 
;; if msg: send each element the msg before applying the pred on it
(define filter1
	(lambda (pred collection msg args)
	       (let ((index '0) (res [OrderedCollection new]))
	       	    (while [index < [collection size]]
		    	   (let ((item (if msg [[collection at: index] perform: msg]
			   	       	       [collection at: index])))
		    	         (if (pred item args) [res add: [collection at: index]])
		    	   (set index [index + '1])))
		    res)))

;; runs the same predicate (predicateToRun) once for each of the elements in the collection:
;; replaces keyword "of" with each of the elements in that predicate
(define filter2
	(lambda (pred predicateToRun collection args)
	       (let ((index '0) (res [OrderedCollection new]))
	       	    (while [index < [collection size]]
		    	   (let ((item [collection at: index])
			   	 (varVals [Array with: [Array with: sol-of withAll: [args at: '0]]
				 	  	 with: [Array with: item withAll: [args at: '1]]]))
		    	         (if (pred predicateToRun varVals) [res add: [collection at: index]])
		    	   (set index [index + '1])))
		    res)))

;; runs procedure on each element of collection
;; if msg: send each element the msg before applying the proc on it
(define for-each
	(lambda (proc collection msg args)
	       (let ((index '0))
	       	    (while [index < [collection size]]
		    	   (let ((item (if msg [[collection at: index] perform: msg]
			   	       	       [collection at: index])))
		    	    	(proc item args))
		    	   (set index [index + '1])))))

;; [[a]] --> [[a]]
;; [[a b]] --> [[a] [b]]
;; [[a b] [c d]] --> [[a c] [a d] [b c] [b d]]
;; [[1 2] [3 4] [5 6]] --> [[1 3 5] [1 3 6] [1 4 5] [1 4 6] [2 3 5] [2 3 6] [2 4 5] [2 4 6]]
(define cross-product 
       (lambda (lits)    
       	  (let ((res [OrderedCollection new]) (litsCp [lits copy]))
       	       (if [lits isEmpty]
	           lits
		   (let ((one [lits at: '0]) (oneCp [one copy]))
		   	(if (and [one isSequenceableCollection] [one isEmpty])
			    one
		   	    (if (== [lits size] '1)
			    	(let ((this [OrderedCollection with: [OrderedCollection with: [one at: '0]]])
				      (rest (if (== [one size] '1) 
				      	    	[OrderedCollection new]
				      	    	(cross-product [OrderedCollection with: [OrderedCollection with: [one at: '1]]]))))
				      [res addAll: this addAll: rest]
				      res)
			    	(let ((two [lits at: '1]) (x [litsCp removeFirst]) (butOne litsCp))
				     (if [two isEmpty]
				     	 two
				     	 (if [one isSequenceableCollection]
				     	     (let ((oneButOne [one copy]) (y [oneButOne removeFirst])
					       	  (this (cross-product [OrderedCollection with: [one at: '0] withAll: butOne]))
					       	  (rest (cross-product [OrderedCollection with: oneButOne withAll: butOne])))
				              	  [res addAll: this addAll: rest]
				              	  res)
				      	     (let ((twoButOne [two copy]) (z [twoButOne removeFirst]))
				      	     	   (if (== [lits size] '2)
					       	       (let ((this [OrderedCollection with: [OrderedCollection with: one with: [two at: '0]]])
						             (rest (cross-product [OrderedCollection with: one with: twoButOne])))
					      	     	     [res addAll: this addAll: rest]
						     	     res)
				                       (let ((rest (cross-product butOne)))
					       	       	    [res addAll: rest]
					       	       	    (let ((res2 [res consAll: one]))
						    	    	 res2))))))))))))))


(define plug-in-bindings-values-full-cross-product-h 
	(lambda (vars vals-cross-p exp)
		(let ((res [OrderedCollection new]) (i '0))
		     (while [i < [vals-cross-p size]]
		     	    (let ((this [exp replaceAll: vars withAll: [vals-cross-p at: i]]))
			    	 [res add: this]
			    	 (set i [i + '1])))
		     res)))

;; [x y] [[1 2] [3 4]] [make x y] -> [[make 1 3] [make 1 4] [make 2 3] [make 2 4]]
(define plug-in-bindings-values-full-cross-product
	(lambda (vars val-lists exp)
		(let ((possVals (cross-product val-lists)))
		      (plug-in-bindings-values-full-cross-product-h vars possVals exp))))

(define exp-at-time
	(lambda (exp time)
		(if (== time sol-now) 
		    exp
		    [exp replaceAll: [Array with: sol-now] withAll: [Array with: `(sol-number ,time)]])))

;; plugs in vals for vars in an expression and then evaluates it
(define eval-sol-expr
	(lambda (expression vars vals)
;	        ['"before:" putln] [expression println]
	        (let ((expressionTranslated (if vars
		     			    	[expression replaceAll: vars withAll: vals]
						expression)))
;	              ['"after:" putln] [expressionTranslated println]
		      [expressionTranslated solEval])))

;; plugs in vals for vars in an expression and then evaluates it
;; arg = [Array with: vars with: vals]
(define eval-sol-expr2
	(lambda (expression args)
	      (let ((vars [args first]) (vals [args second]))
	      	   (eval-sol-expr expression vars vals))))

(define soracle 0) ;; workaround for mutual def of fns

;; makes the given world the current world, so that the world is reflected in all values of "now" time.
(define set-current-world
	(lambda (world)
		(let ()
		      [[soracle currently] currentWorld: world]
		      )))

;; used to go back to current world as we had before doing a "set-current-world"
(define restore-current-world
	(lambda (origWorld)
		 ;; restore the current world and the property-to-world map
	    	 [[soracle currently] currentWorld: origWorld]
	         ))

;; evaluates the expr in given world by temporarily setting current world to it,
;; then restores the current world to the original
(define eval-sol-expr-in-world
	(lambda (expression vars vals world)
		(let ((currWorld [[soracle currently] currentWorld]))
		      ;; temporarily set current world to this one
		      (set-current-world world)
		      (let ((exprEvald (eval-sol-expr expression vars vals)))
		           ;; restore current world
		           (restore-current-world currWorld)
			   exprEvald))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sol code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-type Dummy Object (value))

(define [Dummy withValue: value]
	(let ((dum [self new]))
	     [dum value: value]
	     dum))

(define sol-nil [Dummy withValue: 0])

(define-type SetOrList LinkedList ())
(define-type Set SetOrList (elements))
(define-type List SetOrList (myElement))
(define-type ListElement Link (element))

(define [Object isSet] 0)
(define [Object isList] 0)
(define [Object isSetOrList] 0)
(define [Object isSolObject] 0)

(define [Set isSet] 1)
(define [List isList] 1)
(define [SetOrList isSetOrList] 1)

(define [Object isIdentityDictionary] 0)
(define [IdentityDictionary isIdentityDictionary] 1)

(define [Object printMe]
	(if (== self 0) 
	    [sol-false printMe]
	    (if (== self sol-error)
	    	[sol-error put]
	   	 (if [self isSolObject]
	    	     [self print]
	    	     [[self asString] put]))))

(define [Object printlnMe]
	(if (== self 0) 
	    [sol-false printlnMe]
	    (if (== self sol-error)
	    	[sol-error putln]
	    	(if [self isSolObject]
	    	    [self println]
	    	    [[self asString] putln]))))

(define [Symbol + sym]
	[self , sym])

(define [Integer ** num]
	(math-exp self num))

(define [OrderedCollection addAll: collection]
     (let ((index '0))
     	  (while (< index [collection size])
	      	 [self add: [collection at: index]]    	      	     
	      	 (set index [index + '1]))))

(define [OrderedCollection addAll: c1 addAll: c2]
	(let ()
	     [self addAll: c1]
	     [self addAll: c2]))

(define [OrderedCollection add: elm addAll: c1]
	(let ()
	     [self add: elm]
	     [self addAll: c1]
	     self))

(define [OrderedCollection addIfAbsent: elm]
     (let ((index '0))
     	  (while (< index [self size])
	  	 (if [[self at: index] = elm] (return '0))
		 (set index [index + '1]))
          [self add: elm]))

(define [OrderedCollection addAnyAbsent: collection]
     (let ((index '0))
     	  (while (< index [collection size])
	      	 [self addIfAbsent: [collection at: index]]
	      	 (set index [index + '1]))))
           

;; a [[b c] [e f]] --> [[a b c] [a e f]]
(define [OrderedCollection consAll: elm]
     (let ((index '0) (res [self new]))
     	  (while (< index [self size])
	      	 [res add: [OrderedCollection with: elm withAll: [self at: index]]]
		 (set index [index + '1]))
           res))

(define [OrderedCollection toString]
     (let ((index '0) (res '""))
     	  (while (< index [self size])
	  	 (if (!= '0 index) (set res [res , '" "]))
	      	 (set res [res , [self at: index]])
	      	 (set index [index + '1]))
           res))

(define [OrderedCollection printMe_h: newline]
	 (let ((index '0))
	      [[brackets at: '0] put]
	      (while (< index [self size])
	      	     (let ((elm [self at: index]))
	      	     	  [elm printMe])
	      	     (if (!= index [[self size] - '1]) ['", " put])
	      	     (set index [index + '1]))
	      (if newline [[brackets at: '1] putln] [[brackets at: '1] put])))

(define [OrderedCollection printMe]
	[self printMe_h: 0])

(define [OrderedCollection printlnMe]
	[self printMe_h: 1])

(define [Array printMe_h: newline]
	 (let ((index '0))
	      [[brackets at: '0] put]
	      (while (< index [self size])
	      	     (let ((elm [self at: index]))
	      	     	  [elm printMe])
	      	     (if (!= index [[self size] - '1]) ['", " put])
	      	     (set index [index + '1]))
	      (if newline [[brackets at: '1] putln] [[brackets at: '1] put])))

(define [Array printMe]
	[self printMe_h: 0])

(define [Array printlnMe]
	[self printMe_h: 1])

(define [SetOrList printMe]
	[self printMe_h: 0])

(define [SetOrList printlnMe]
	[self printMe_h: 1])

(define [Set printMe_h: newline]
	 (let ((index '0))
	      [[braces at: '0] put]
	      (while (< index [[self elements] size])
	      	     (let ((elm [[self elements] at: index]))
	      	     	  [elm printMe])
	      	     (if (!= index [[[self elements] size] - '1]) ['", " put])
	      	     (set index [index + '1]))
	      (if newline [[braces at: '1] putln] [[braces at: '1] put])))

(define [List printMe_h: newline]
	 (let ((llElm [self first]))
	      [[brackets at: '0] put]
	      (while llElm
	      	     (let ((elm [llElm element]))
	      	     	  [elm printMe])
	      	     (if [llElm nextLink] ['", " put])
	      	     (set llElm [llElm nextLink]))
	      (if newline [[brackets at: '1] putln] [[brackets at: '1] put])))

(define [Set withElements: elms]
	(let ((s [self new]))
	     [s elements: elms]
	     s))

(define [Set withElement: elm]
	(let ((s [self newEmpty]))
	     [s addElement: elm]
	     s))

(define [ListElement with: elm]
	(let ((e [self new]))	     	     
	     [e element: elm]
	     e))

(define [List withElement: elm]
	(let ((l [self new])
	      (e [ListElement with: elm]))
	      [l add: e]	     	     
	      l))

(define [List withElements: elms]
	(let ((l [self new]) (i '0))
	      (while [i < [elms size]]
	      	     (let ((e [ListElement with: [elms at: i]]))
		     	  [l add: e])
	      	     (set i [i + '1]))
	      l))

(define [Set includes: elm]
	(let ((index '0))
     	     (while (< index [[self elements] size])
		    (if [[[self elements] at: index] = elm] (return 1))
	   	    (set index [index + '1]))
	     (return 0)))

(define [List includes: anElm]
	 (let ((llElm [self first]))
	      (while llElm
	      	     (let ((elm [llElm element]))
	      	     	  (if [elm = anElm] (return 1)))
	      	     (set llElm [llElm nextLink]))
	      (return 0)))

(define [Set = s]
	(and [s isSet]
	     (let ((elms [self elements]))
	     	  (and (== [[s elements] size] [elms size])
	     	       (let ((i '0))
	     	       	    (while [i < [elms size]]
		  	    	   (if (not [s includes: [elms at: i]]) (return 0))
	                 	   (set i [i + '1]))
		   	    1)))))

(define [List = aL]
	(and [aL isList]
	     [[self size] = [aL size]]
	     (let ((myllElm [self first]) (aLllElm [aL first]))
	      	  (while myllElm
	      	     	 (let ((myElm [myllElm element]) (aLElm [aLllElm element]))
	      	     	      (if [myElm ~= aLElm] (return 0)))
	      	     	 (set myllElm [myllElm nextLink]) 
			 (set aLllElm [aLllElm nextLink]))
	          1)))

(define [Set size]
	[[self elements] size])

(define [Set at: index]
	[[self elements] at: index])

(define [List at: index]
	(let ((myllElm [self first]) (i '0))
	     (while (and myllElm [i < index])
	     	    (set i [i + '1])
	      	    (set myllElm [myllElm nextLink]))
	     [myllElm element]))

(define [Set copy]
     	[[self newEmpty] withElements: [[self elements] copy]])

(define [List copy]
	(let ((l [self new]) (llElm [self first]))
	      (while llElm
	      	     (let ((elm [llElm element])
	      	     	   (e [ListElement with: [elm copy]]))
		     	   [l add: e])
	      	     (set llElm [llElm nextLink]))
	      l))

(define [List elements]
	(let ((l [OrderedCollection new]) (llElm [self first]))
	      (while llElm
	      	     (let ((elm [llElm element]))
		     	   [l add: elm])
	      	     (set llElm [llElm nextLink]))
	      l))

(define [SetOrList newEmpty]
	[self withElements: [OrderedCollection new]])
	     
(define [Set removeElement: elm]
	[[self elements] remove: elm ifAbsent: sol-nil])

(define [List removeElement: anElm]
	(let ((llElm [self first]))
	      (while llElm
	      	     (let ((elm [llElm element]))
	      	     	  (if [elm = anElm] (let ()
			      	     	    	 [self remove: llElm]
			      	     	    	 (return 1))))
	      	     (set llElm [llElm nextLink]))
	      sol-nil))

(define [SetOrList removeElements: elms]
	(let ((index '0))
     	     (while (< index [elms size])
		    [self removeElement: [elms at: index]] 	    
	   	    (set index [index + '1]))))
	     
(define [Set addElement: elm]
	(let ()
	     (if (not [self includes: elm]) [[self elements] add: elm])))

(define [List addElement: elm]
	(let ((e [ListElement with: elm]))
	      [self add: e]))

(define [SetOrList addElements: elms]
	(let ((index '0))
     	     (while (< index [elms size])
		    [self addElement: [elms at: index]] 	    
	   	    (set index [index + '1]))))

(define [Set + set2]
	(let ((sum [self copy])
	      (opr2 (if [set2 isSet] 
	      		set2 
			[[self new] withElement: set2])))
	     [sum addElements: [opr2 elements]]
	     sum))

(define [List append: list2]
	(let ((llElm [list2 first]))
	      (while llElm
	      	     (let ((elm [llElm element]))
	      	     	  [self addElement: elm])
	      	     (set llElm [llElm nextLink]))))

(define [List + list2]
	(let ((sum [self copy])
	      (opr2 (if [list2 isList] 
	      		list2 
			[[self new] withElement: list2])))
	     [sum append: opr2]
	     sum))

(define [Set - set2]
	(let ((sub [self newEmpty]) (index '0)
	      (opr2 (if [set2 isSet] 
	      		set2 
			[[self new] withElement: set2])))
     	     (while (< index [[self elements] size])
		    (if (not [opr2 includes: [[self elements] at: index]]) 
		    	[sub addElement: [[self elements] at: index]])
	   	    (set index [index + '1]))
	     sub))

(define [List minusList: list2]
	(let ((llElm [list2 first]))
	      (while llElm
	      	     (let ((elm [llElm element]))
	      	     	  [self removeElement: elm])
	      	     (set llElm [llElm nextLink]))))

(define [List - list2]
	(let ((sub [self copy])
	      (opr2 (if [list2 isList] 
	      		list2 
			[[self new] withElement: list2])))
	     [sub minusList: opr2]
	     sub))

;; returns a new set with elements of cross product of this and that set
(define [Set * set2]
	(let ((res [self newEmpty]) (index '0)
	      (cpElms (cross-product [OrderedCollection with: [self elements]
	     	      		     			with: [set2 elements]])))
	     (while [index < [cpElms size]]
	     	    [res addElement: [Set withElements: [cpElms at: index]]]
	     	    (set index [index + '1]))
	     res))	


;; returns a new list with elements of cross product of this and that list
(define [List * list2]
	(let ((res [self newEmpty]) (index '0)
	      (cpElms (cross-product [OrderedCollection with: [self elements]
	     	      		     			with: [list2 elements]])))
	     (while [index < [cpElms size]]
	     	    [res addElement: [List withElements: [cpElms at: index]]]
	     	    (set index [index + '1]))
	     res))	

;; returns a new set with a subset of elements in the original set which satisfy a predicate
(define [Set selectBy: predicate]
	(let ((res [self copy]) (elms [res elements]) 
	      (vars [Array with: 'foo]) (vals [Array with: 'bar])) ;; fixme
		   (let ((filteredElms (filter2 eval-sol-expr2 predicate elms [Array with: vars with: vals])))
	     	   	[res elements: filteredElms]
	     	  	res)))

(define [List selectBy: predicate]
	(let ((elms [self elements])
	      (vars [Array with: 'foo]) (vals [Array with: 'bar])) ;; fixme
		   (let ((filteredElms (filter2 eval-sol-expr2 predicate elms [Array with: vars with: vals])))
	     	   	[self withElements: filteredElms])))

;; runs a collection of messages (msgs) recursively on each element in the collection
(define [OrderedCollection doMsgs: msgs]
	(let ((i '0) (j '1))
	     (while (< i [self size])
	     	    (let ((res [[self at: i] perform: [msgs at: '0]]))
	     	    	 (while (< j [msgs size])
		    	   	(set res [res perform: [msgs at: j]])
				(set j [j + '1]))
		         [res println])
	   	    (set i [i + '1]))))

;; returns a new collection resulted from running a collection of messages (msgs) 
;; recursively on each element in the original collection
(define [OrderedCollection mapMsgs: msgs]
	(let ((i '0) (j '1) (newCollection [self copy]))
	     (while (< i [self size])
	     	    (let ((res [[newCollection at: i] perform: [msgs at: '0]]))
	     	    	 (while (< j [msgs size])
		    	   	(set res [res perform: [msgs at: j]])
				(set j [j + '1]))
			 [newCollection at: i put: res])
	   	    (set i [i + '1]))
	     newCollection))

;; get a random element out of collection
(define [OrderedCollection randomOne] ;; fixme
	(let ((n [solRandomGen nextInt: [self size]]))
	     (if (== [self size] '0)
	     	 0
		 [self at: n])))

;; get a num size random subset out of collection
(define [OrderedCollection random: num] ;; fixme
	(let ((i '0) (x [Random next]) (mySize [self size])
	      (n [Random nextInt: mySize]) (subset [Set newEmpty]))
	     (if [num > mySize]
	     	 sol-error
		 (let ((mem [IdentityDictionary new]))
	   	      (while [[[subset elements] size] < num]
		      	     (while [mem includesKey: n]
		     	     	    (set n [Random nextInt: mySize]))
		             [mem at: n put: '1]
		     	     [subset addElement: [self at: n]])
		           subset))))

(define [OrderedCollection isEmpty]
	(== [self size] '0))

(define [Array copy]
	(let ((newArray [[self new] with: [[self at: '0] copy]]) (i '1))
     	     (while (< i [self size])
		    (set newArray [newArray withAll: newArray with: [[self at: i] copy]])
	            (set i [i + '1]))
	     newArray))

(define [OrderedCollection copy]
	(let ((newOrderedCollection [self new]) (i '0))
     	     (while (< i [self size])
	     	    (let ((itemOrig [self at: i]) (item (if itemOrig [itemOrig copy] itemOrig)))
		    	 [newOrderedCollection add: item])
	            (set i [i + '1]))
	     newOrderedCollection))

(define [OrderedCollection = c]
	(and [c isSequenceableCollection]
	     (== [c size] [self size])
	     (let ((i '0))
	     	  (while [i < [self size]]
		  	 (if (not (== [self at: i] [c at: i])) (return 0))
	                 (set i [i + '1]))
		   1)))	  
          
(define [OrderedCollection toIdentityDictionary]
	(let ((res [IdentityDictionary new]) (i '0))
     	     (while (< i [self size])
	     	    (let ((this [IdentityDictionary new]) (valOrig [[self at: i] second])
		    	  (key [[[self at: i] first] copy])
		    	  (val (if valOrig [valOrig copy] valOrig))
		    	  (itm (if (and [val isSequenceableCollection] (not [val isExpression]))
			       	   [val toIdentityDictionary]
				   val)))
		    [res at: key put: itm])
	            (set i [i + '1]))
	     res))


(define [IdentityDictionary toOrderedCollection]
	(let ((res [OrderedCollection new]) (myKeys [self keys]) (i '0))	     
	     (while (< i [myKeys size])
	     	    (let ((this [OrderedCollection new]) (elmOrig [self at: [myKeys at: i]])
		    	  (elm (if elmOrig [elmOrig copy] elmOrig))
		    	  (itm (if [elm isIdentityDictionary]
			       	   [elm toOrderedCollection]
				   elm)))
			 [this add: [myKeys at: i]]
			 [this add: itm]
			 [res add: this])
		    (set i [i + '1]))
	     res))

;; returns the key in dictionary with min or max value
;; isMaxMin should be set to 'min for min case, 'max for max case
(define [IdentityDictionary keyWithExtremum: isMaxMin]
	(let ((myKeys [self keys]) (i '0) (extremum 0) (ansKey 0) (isMin (== isMaxMin 'min)))     
	     (while (< i [myKeys size])
	     	    (if (or (not extremum) (or (and isMin [[self at: i] < extremum])
		    	    	 	       [[self at: i] > extremum]))
			(let ()
			     (set ansKey i)
			     (set extremum [self at: i])))	     	    
		    (set i [i + '1]))
	     ansKey))


(define [IdentityDictionary printlnMe]
	[[self toOrderedCollection] printlnMe])

(define [IdentityDictionary = dic]
	(and [dic isIdentityDictionary]
	     (== [[self keys] size] [[dic keys] size])
	     (let ((dicKeys [dic keys]) (myKeys [self keys]) (i '0))
	     	   (while (< i [myKeys size])
		   	  (if (or (not [dic includesKey: [myKeys at: i]])
			      	  (not [[self at: [myKeys at: i]] = [dic at: [myKeys at: i]]]))
					(return 0))
		          (set i [i + '1]))
	            1)))

(define [Object copy]
	(let ((res [self new]))
	     (set res self)
	     res))

(define [Object = o]
	(== self o))

;; goes through items in a collection and items in olds collection replaced by items in news collection
;; [hi [hello sup hi]] , [hi sup] , [hola boludo] --> [hola [hello boludo hola]]
(define [Array replaceAll: olds withAll: news]
	(let ((i '0) (res [self copy]))
	     (while (< i [olds size])
		    [res replace: [olds at: i] with: [news at: i]]
	            (set i [i + '1]))
	     res))

(define [OrderedCollection replaceAll: olds withAll: news]
	(let ((i '0) (res [self copy]))
	     (while (< i [olds size])
		    [res replace: [olds at: i] with: [news at: i]]
	            (set i [i + '1]))
	     res))

;; olds: [x y] news: [[1 2] [3 4]] self: [make x y] 
;; -> [[make 1 3] [make 1 4] [make 2 3] [make 2 4]]
(define [Array replaceAll: olds withAnyCombinationOfAll: news]
	(let ()
	     (plug-in-bindings-values-full-cross-product olds news self)))

;; deep replaces in place all occurances of a word with another in a collection
(define [Array replace: old with: new]
	(let ((i '0))
     	     (while (< i [self size])
	     	    (let ((elm [self at: i]))
		     	 (if [elm isSequenceableCollection]
			     [elm replace: old with: new]
 			     (if (== [self at: i] old)
			     	 [self at: i put: new])))
	             (set i [i + '1]))))

(define [OrderedCollection replace: old with: new]
	(let ((i '0))
     	     (while (< i [self size])
	     	    (let ((elm [self at: i]))
		     	 (if [elm isSequenceableCollection]
			     [elm replace: old with: new]
 			     (if (== [self at: i] old)
			     	 [self at: i put: new])))
	             (set i [i + '1]))))

;; create array consisting of "element" repeated "times" times
(define [Array nOf: element n: times]
	(let ((i '1) (res [self with: element]))
	     (while (< i times)
	     	    (set res [Array withAll: res with: element])
	            (set i [i + '1]))
	     res))

;; [1 2 3 4] --> [[[1 2] 3] 4]
(define [Array unflatten]
	(let ((res [Array with: [self first] with: [self second]]) 
	      (s [self size]) (i '2))
	     (while (< i s)
	     	    (set res [Array with: res with: [self at: i]])
	            (set i [i + '1]))
	     res))

(define [Object solEval]
	[self _eval])

(define [Object replaceAll: olds withAll: news]
	(let ((i '0))
     	     (while (< i [olds size])
	     	    (if (== [olds at: i] self) (return [news at: i]))
		    (set i [i + '1]))
	     self))

(define [Object toSolName]	; symbol
    	`',self)

(define [Object toSolValue]	; symbol
    	`(sol-value ,self))

;; Sol code - helpers

;; collection: (a b), collection: (1 2) ---> dict: a->1, b->2 
(define make-dictionary-from-keys-vals 
	(lambda (keys vals)
		(let ((index '0) (dict [IdentityDictionary new]))
		     (while (< index [keys size])
		     	    [dict at: [keys at: index] put: [vals at: index]]
		     	    (set index [index + '1]))
		     dict)))

;; Sol code - main

;; internal classes

;; whole knowledge base: containing all micro worlds plus a working memory called currently
;; which remembers the worlds (situation) of the current micro world (the dynamic stuff)
(define-type KnowledgeBase Object (name microWorlds currently))

;; a micro world: containing all classes in it
(define-type MicroWorld Object (name classes instances relQualifications))

;; a class in some micro world: containing property names and all instances
(define-type MicroWorldClass Object (name propertyNames qualifications actions goals instances))

;; an instance of a class: containing a name and property values
(define-type ClassInstance Object (name class))

;; a world (situation) at time t is a dictionary that maps an instance name to a dictionary
;; that maps a property name to a property value
;; possibleWorldInfo is a dictionary of information about possible world. keys are 'id and 'path.

;; the possibleWorldInfo at: 'id  is used to distinguish between the possible worlds having the same time
;; the possibleWorldInfo at: 'cause is the action taken that resulted in reaching this world
;; the possibleWorldInfo at: 'parent is the world prior to this world
(define-type World Object (time possibleWorldInfo instancePropertyValues)) 

;; this stores anything about current, including the current micro world in context, etc.
;; instancePropertyWorlds is a dictionary InstanceName x ( PropertyName x World ) to tell
;; which world (time) has the most up-to-date value of a property of an instance
;; calculatedPWs tells which future time's possible worlds are already in cache
(define-type WorkingMemory Object (name currentMicroWorld currentWorld calculatedPWs worlds))

;; a qualification (dynamic property) of a class in the micro world
;; a qualification has the value of one or none of its "values" collection depending which or none
;; of "predicates" collection is true.
(define-type Qualification Object (name class values predicates))

;; a relative (binary) qualification (dynamic property) between two objects in the micro world
(define-type RelativeQualification Object (name object1 object2 predicate))

;; a goal of a class in the micro world
;; heuristics are used to decide between worlds when goal is not satisfied
(define-type Goal Object (name class variables predicate heuristics))

;; an action of a class in the micro world
(define-type Action Object (name class variables consequence rules))

;; a rule for an action of a class in the micro world
(define-type ActionConsequence Object (assignments))

;; a heuristic for a goal of a class in the micro world
(define-type GoalHeuristic Object (goal type expression))

;; a rule for an action of a class in the micro world
(define-type Assignment Object (assignment predicate))

;; methods for internal classes

(define [Expression isSolObject] 1)
(define [SetOrList isSolObject] 1)
(define [KnowledgeBase isSolObject] 1)
(define [MicroWorld isSolObject] 1)
(define [MicroWorldClass isSolObject] 1)
(define [ClassInstance isSolObject] 1)
(define [World isSolObject] 1)
(define [WorkingMemory isSolObject] 1)
(define [Qualification isSolObject] 1)
(define [RelativeQualification isSolObject] 1)
(define [Goal isSolObject] 1)
(define [Action isSolObject] 1)
(define [ActionConsequence isSolObject] 1)
(define [Assignment isSolObject] 1)

(define [Object isWorld] 0)
(define [World isWorld] 1)

(define [World copy]
	(let ((res [World new]) 
	      (instPropValsCp [[[self instancePropertyValues] toOrderedCollection] copy]))
              [res time: [[self time] copy]]
              [res possibleWorldInfo: [[self possibleWorldInfo] copy]]
	      [res instancePropertyValues: [instPropValsCp toIdentityDictionary]]
	     res))

(define [World = w]
	(and [w isWorld]
	     (== [self time] [w time])
	     [[self instancePropertyValues] = [w instancePropertyValues]]))

(define [WorkingMemory withName: name]
	(let ((cm [self new]) (s0 [World withTime: '0]) (wlds [IdentityDictionary new])
	      (s0pws [IdentityDictionary new]))
	     [s0pws at: '0 put: s0]	     
	     [wlds at: '0 put: s0pws]
	     [cm name: name]
	     [cm currentWorld: s0]
	     [cm calculatedPWs: [IdentityDictionary new]]
	     [cm worlds: wlds]
	     cm))

;; creates a new world to move one unit in time forward, updates the CurrentWorld
;; in the new world, records which action resulted in this new world.
;; a new world is created everytime an action is about to happen
(define [WorkingMemory newAtTimePlusOne: actionDescr isHyp: isHypothetical]
	(let ((newTime [[[self currentWorld] time] + '1])
	      (newCurrWorld [World withTime: newTime]))
	      [[newCurrWorld possibleWorldInfo] at: 'cause put: actionDescr]
	      [[newCurrWorld possibleWorldInfo] at: 'parent put: [self currentWorld]]
	      (if (and isHypothetical [[self worlds] includesKey: newTime])
	      	  (let ((possibleWorlds [[self worlds] at: newTime]) (p '0))
		       (while [possibleWorlds includesKey: p]
		       	      (set p [p + '1]))
			[[newCurrWorld possibleWorldInfo] at: 'id put: p]			
			[possibleWorlds at: p put: newCurrWorld])
                  (let ((possibleWorlds [IdentityDictionary new]))
		       [possibleWorlds at: '0 put: newCurrWorld]
	     	       [[self worlds] at: newTime put: possibleWorlds]))
		       
             ;; clear calculated possible worlds cache if this is a real action
	     (if (not isHypothetical)
	     	[[soracle currently] calculatedPWs: [IdentityDictionary new]])

	     [self currentWorld: newCurrWorld]
	     '0))
	     	   
(define [World withTime: time]
	(let ((w [self new]))
	     [w time: time]
	     [w possibleWorldInfo: [IdentityDictionary new]]
	     [[w  possibleWorldInfo] at: 'id put: '0]
	     [[w  possibleWorldInfo] at: 'parent put: 0]
	     [w instancePropertyValues: [IdentityDictionary new]]
	     w))

(define [KnowledgeBase withName: name]
	(let ((kb [self new]))
	     [kb name: name]
	     [kb currently: [WorkingMemory withName: 'currently]]
	     [kb microWorlds: [IdentityDictionary new]]
	     kb))

(define [KnowledgeBase addMicroWorld: newMicroWorldName]	
	(let ((newMicroWorld [MicroWorld new]))
	     ;; instantiate a new MicroWorld
	     [newMicroWorld name: newMicroWorldName]
	     [newMicroWorld classes: [IdentityDictionary new]]
	     [newMicroWorld instances: [IdentityDictionary new]]
	     [newMicroWorld relQualifications: [IdentityDictionary new]]
	     [[self microWorlds] at: newMicroWorldName put: newMicroWorld]
	     ;; make the current micro world this new one
	     [[self currently] currentMicroWorld: newMicroWorld]))


;; soracle: whole knowlegebase
(define soracle [KnowledgeBase withName: 'soracle])

;; get a qualification of a class
(define [MicroWorldClass getQualification: name]
	[[self qualifications] at: name])

;; get an action of a class
(define [MicroWorldClass getAction: name]
	[[self actions] at: name])

;; get a goal of a class
(define [MicroWorldClass getGoal: name]
	[[self goals] at: name])

;; get the first goal of a class
(define [MicroWorldClass getAGoal]
	(let ((goals [self goals]) (goalNames [goals keys]))
	     [goals at: [goalNames first]]))

(define kb-get-microworld
	(lambda (name) 
		[[soracle microWorlds] at: name]))

(define mw-get-class
	(lambda (name) 
		(let ((mw [[soracle currently] currentMicroWorld]))
		     [[mw classes] at: name])))

;; given instance name returns its class
(define instance-get-class
	(lambda (instanceName)
		(let ((mw [[soracle currently] currentMicroWorld]))
		     [[[mw instances] at: instanceName] class])))

;; takes instance name and world where the most recent info for the particular property 
;; should be found -- returns propertyName X propertyValue dictionary  
(define mw-get-instance
	(lambda (name worldWithThisPropertyValue)
		(let ((instPropNameValDict 
		          [worldWithThisPropertyValue instancePropertyValues]))
		      (let ((inst [instPropNameValDict at: name ifAbsentPut: [IdentityDictionary new]]))
			       [instPropNameValDict at: name]))))

;; [x y] [[1 2] [3 4]] [make x y] -> [[make 1 3] [make 1 4] [make 2 3] [make 2 4]]
;; [direction,speed] --> [[up,dn,lf,rt],[1,2]]
(define class-collection-to-possible-instances
	(lambda (classNames)
	        (let ((res [OrderedCollection new]) (i '0))
		     (while [i < [classNames size]]
		     	    (let ((class (mw-get-class [classNames at: i])))
		     	    	 [res add: [[class instances] keys]])
		     	    (set i [i + '1]))
		     res)))

;; takes an Action object, returns possible executions of it (iterating thru all its valid instances
;; and valid action params)
(define action-possible-runs
	(lambda (action)
		;; [robot do move direction] --> 
		;; [[ldg do move up], [ldg do move down], [ldg do move left], [ldg do move right]]
		(let ((class [action class]) (actionVars [action variables])
		      (actionCmd `(sol-action-run ,[class name] ,[action name] ,[actionVars mapMsgs: [Array with: 'toSolValue]] ,sol-hypothetical))
		      (possInstances [[class instances] keys])
		      (possParams (class-collection-to-possible-instances actionVars))
		      ;; [robot, direction]
		      (allVars [Array with: [class name] withAll: actionVars])
		      ;; [[ldg], [down, right, up, left]]
		      (allVals (let () [possParams insert: possInstances atIndex: '0] possParams)))
		      [actionCmd replaceAll: allVars withAnyCombinationOfAll: allVals]
		      )))

;; find possible world values 1 unit of time from now
;; go through all possible valid actions of all instances and generate a set of possible values
;; for the instance property in question
(define next-possible-value-worlds
	(lambda (instanceName)
		(let ((possibleWorlds [OrderedCollection new]) 
		      (class (instance-get-class instanceName))
		      (actions [class actions]) 
		      (possibleActions [actions keys])
		      (currWorld [[soracle currently] currentWorld])
		      (currTime [currWorld time]) 
		      (nextTime [currTime + '1]) 
		      ;; find the right pwId index to store the new possible world
		      (pwId (if [[[soracle currently] worlds] includesKey: nextTime]
		      	    	(let ((p '0) (possWorlds [[[soracle currently] worlds] at: nextTime]))
			       	     (while [possWorlds includesKey: [p + '1]]
		       	       	      	    (set p [p + '1]))
		      	       	      	    p)
			        '0))
		      (i '0))

		      ;; check if we have calculated the possible worlds at currTime + 1 already:
		      (if [[[soracle currently] calculatedPWs] includesKey: nextTime]
		      	  (let ((pws [[[soracle currently] calculatedPWs] at: nextTime]))
;			       ['"cached" putln]
		               (return pws)))

		      ;; iterate thru actions, find out all instances that can run them,
		      ;; with all possible pararms
		      (while [i < [possibleActions size]]
		      	     (let ((actionPossRuns 
			               (action-possible-runs [actions at: [possibleActions at: i]]))
				   (j '0))
				   (while [j < [actionPossRuns size]]
				  	 (let ()
				  	      (let ((thisRun [[actionPossRuns at: j] solEval]))
						   ;; if this action run was successful add the hypothetical world
					      	   (if [thisRun ~= sol-error] 
						       (let ()
						       	    [possibleWorlds addIfAbsent: [[soracle currently] currentWorld]]
							    (set pwId [pwId + '1])))))
					 ;; restore the current world and the property-to-world map
					 [[soracle currently] currentWorld: currWorld]
					 (set j [j + '1])))
			     (set i [i + '1]))
		      possibleWorlds
		      )))

(define possible-value-worlds-h
	(lambda (instanceName timeAhead)
		(let ((possibleWorlds [OrderedCollection new]) 
		      (currWorld [[soracle currently] currentWorld])		      
		      (currTime [currWorld time]) 
		      (targetTime [currTime + timeAhead]) 
		      )

		      ;; find possible worlds one unit time ahead
		      (let ((nextPWs (next-possible-value-worlds instanceName)))
			   (if [timeAhead > '1]
			       ;; temporarily set curr world to each nextPWs, and repeat proc
		      	       (let ((i '0))
				     (while [i < [nextPWs size]]
				       	    (let () 
					      	 (set-current-world [nextPWs at: i])
						 (let ((fartherPWs (possible-value-worlds-h instanceName [timeAhead - '1])))
						      [possibleWorlds addAnyAbsent: fartherPWs]
						      ;; restore current world
						      (restore-current-world currWorld)))
				       	    (set i [i + '1])))
				[possibleWorlds addAll: nextPWs])
		       	    possibleWorlds))))


;; find possible world values timeAhead unit of time into the future:
;; go through all possible valid actions of all instances and generate a set of possible values
;; for the instance property in question
(define possible-value-worlds
	(lambda (instanceName timeAhead)
		(let ((possibleWorlds [OrderedCollection new]) 
		      (currWorld [[soracle currently] currentWorld])
		      (currTime [currWorld time]) 
		      (targetTime [currTime + timeAhead]) 
		      )

		      ;; check if we have calculated the possible worlds at currTime + 1 already:
		      (if [[[soracle currently] calculatedPWs] includesKey: targetTime]
		      	  (let ((pws [[[soracle currently] calculatedPWs] at: targetTime]))
;			       ['"cached" putln]
		               (return pws)))

		      ;; calculate them
		      (let ((pws (possible-value-worlds-h instanceName timeAhead)))
		            ;; mark cache
		      	    [possibleWorlds addAll: pws]
			    [[[soracle currently] calculatedPWs] at: targetTime put: possibleWorlds]
			    possibleWorlds))))

;; updates property value for an instance (in a new world, by moving the time one unit forward)
(define instance-update-property
	(lambda (instanceName propertyName propertyValue isHypothetical)
		(let ((propertyNamesValuesDict 
		         (mw-get-instance instanceName [[soracle currently] currentWorld])))
		         [propertyNamesValuesDict at: propertyName put: [propertyValue solEval]]
		         )))

;; find out which world has the most recent value for this property
;; if specifc time given (not now), then get value at that particular time
(define instance-property-get-world
	(lambda (instanceName propertyName time)
		(let ((currWorld [[soracle currently] currentWorld])
		      (currTime [currWorld time])
		      (timeToUse (if (and [time isNumber] [time < currTime]) time currTime)))
		      ;; if time is given and is in future we return a collection of possible worlds
		      (if (and [time isNumber] [time > currTime])
		      	  (let ((possibleWorlds (possible-value-worlds instanceName [time - currTime])))
			       possibleWorlds)
			       
		      	  ;; if not (past/present) we have an exact world, start looking in current,
			  ;; if past, go to the parent and parent of parent, so on, until we're at
			  ;; desired time world
			  ;; if not in past (its parents) until property found (dynamic scope of worlds)
			  (let ((worldToUse currWorld))
			       (while [timeToUse < [worldToUse time]]
			       	      (set worldToUse [[worldToUse possibleWorldInfo] at: 'parent]))
			       worldToUse)))))

;; returns property value of an instance once the correct world storing this info is known
;; if dynamicScope flag is set, it keeps lookup in ancestors for the property...
(define instance-get-property-given-world 
	(lambda (instanceName propertyName worldWithThisPropertyValue dynamicScope)
		;; we're looking for the world that has this property starting from given 
	  	;; world. if not there, go to the parent and parent of parent, so on,
	  	;; until we go enough back to find the world that has the most uptodate
	  	;; value of this property
	  	(let ((worldToUse worldWithThisPropertyValue)
	             (propertyNamesValuesDict (mw-get-instance instanceName worldToUse)))
		     (while (and dynamicScope
		     	    	 (not [propertyNamesValuesDict includesKey: propertyName])
		     	    	 [[worldToUse possibleWorldInfo] at: 'parent])
			    (set worldToUse [[worldToUse possibleWorldInfo] at: 'parent])
		            (set propertyNamesValuesDict 
        	      	       	 (mw-get-instance instanceName worldToUse)))
		     (if [propertyNamesValuesDict includesKey: propertyName]
		     	 [propertyNamesValuesDict at: propertyName]
			 sol-error))))

;; given an instance and its property name, returns its current property value
;; if the property name and value isnt in the current world, we should look into past times
;; (the current world stores only deltas w/ respect to prev world)
(define instance-get-property
	(lambda (instanceName propertyName time)
		(let ((class (instance-get-class instanceName))		      
		      (worldWithThisPropertyValue 
		               (instance-property-get-world instanceName propertyName time)))
		     ;; first see this is a property or qualification:
		     (if [[class qualifications] includesKey: propertyName]

		     	 ;; qualification case:
			 ;; see if it is already cached in this world:
			 (let ((qualCachedLookup (instance-get-property-given-world instanceName propertyName worldWithThisPropertyValue 0)))
			      (if [qualCachedLookup ~= sol-error]
			      	  ;; it is cached, just return it:
			    	  qualCachedLookup
			     	  ;; not cached for this world: calcualte + cache it.
			     	  (let ((qualification [[class qualifications] at: propertyName]) (i '0))
			       	       ;; find first qual value with satisfied predicate and return it
			       	       (while [i < [[qualification values] size]]
			       	      	      (let ((qualValue [[qualification values] at: i])
				      	      	    (qualPred [[qualification predicates] at: i]))
					      	    (if (eval-sol-expr qualPred [Array with: sol-it] [Array with: instanceName])
					    	    	(let ((qualValueEvald (eval-sol-expr qualValue [Array with: sol-it] [Array with: instanceName])))
						       	     ;; cache and return it
						       	     (instance-update-property instanceName propertyName `',qualValueEvald 0)
					               	     (return qualValueEvald))))
				              (set i [i + '1]))
			                 ;; no qualification value has a satisfiable predicate: value = no
				         0)))

		     	 ;; property case:
		     	 ;; find out which world has the most recent (or whatever version
			 ;; requested) value for this property
		     	 (let ((currWorld [[soracle currently] currentWorld])
			       (currTime [currWorld time]))
			       ;; if worldWithThisPropertyValue is a collection, it means 
			       ;; the requested time was in the future and we have a set
			       ;; of possible world values:
			       (if [worldWithThisPropertyValue isSequenceableCollection]
			       	   ;; future case: we have a set of possible world values
				   (let ((possibleWorldPropertyValues [Set newEmpty]) (i '0))
				   	(while [i < [worldWithThisPropertyValue size]]
					       (let ((propertyValue 
					                (instance-get-property-given-world 
							    instanceName propertyName
							     [worldWithThisPropertyValue at: i] 1)))
						    [possibleWorldPropertyValues addElement: propertyValue])						    
					       (set i [i + '1]))
			       		['"Possible World values (" put]
			       		[[time - currTime] print]
			       		['" time unit from now):" putln]
;					[worldWithThisPropertyValue doMsgs: [Array with: 'time]]
;					[worldWithThisPropertyValue doMsgs: [Array with: 'possibleWorldInfo]]
					possibleWorldPropertyValues)
				   ;; present/past case: we have one certain value
				   (instance-get-property-given-world instanceName propertyName worldWithThisPropertyValue 1)))))))

;; if we have a set of instances to lookup property, result is new set 
;; else we're just looking up property of a single instance
(define get-property-of-one-or-set-of-instances
	(lambda (instanceNameOrSet propertyName time)
		(if [instanceNameOrSet isSetOrList]
		    (let ((i '0) (elms [instanceNameOrSet elements]) (res [Set newEmpty]))
		      	   (while [i < [elms size]]
		      	  	  (let ((propVal (instance-get-property [elms at: i] propertyName time)))
		      	       	       [res addElement: propVal])
			   	  (set i [i + '1]))
			   res)
		    (instance-get-property instanceNameOrSet propertyName time))))

;; given an instance name and a collection of cascaded properties, gets the property value
;; e.g. [[mychair, location], x-coord] --> means [[mychair location] x-coord]
(define instance-get-cascaded-properties
	(lambda (instancePropertiesList time microWorld)
		(let ((the1st [instancePropertiesList at: '0]) 
		      (the2nd [instancePropertiesList at: '1]))
		     	     ;; if this is cascaded property list...
			 (if [the1st isArray]
		     	     (let ((val (instance-get-cascaded-properties the1st time microWorld)))
			      	  (get-property-of-one-or-set-of-instances val the2nd time))
			     ;; this is just a simple <isntance> <property> case...     
			     ;; first check if this instance exists
		     	     (if [[microWorld instances] includesKey: the1st]
			     	 (get-property-of-one-or-set-of-instances the1st the2nd time)
				 sol-error)))))

(define apply-assignment 
	(lambda (assignment args)
	      (let ((actionVars [args first]) (actionParams [args second])
	      	    (isHypothetical [args third])
		    (vars (if isHypothetical [Array with: sol-actual withAll: actionVars] actionVars))
		    (vals (if isHypothetical [Array with: sol-hypothetical withAll: actionParams] actionParams)))
		    (let ((assignmentTranslated [assignment replaceAll: vars withAll: vals]))
	     	    	 [assignmentTranslated solEval]))))

;; adds a new microworld to the knowledge-base
(define kb-add-microworld 
	(lambda (name)
		[soracle addMicroWorld: name]
		sol-ok))

;; adds a new class to a microworld
(define mw-add-class
	(lambda (name propertyNames) 
		(let ((mw [[soracle currently] currentMicroWorld])
		      (newMicroWorldClass [MicroWorldClass new]))		     
	     	     ;; instantiate a new MicroWorldClass for this micro world
	     	     [newMicroWorldClass name: name]
	     	     [newMicroWorldClass propertyNames: propertyNames]
		     [newMicroWorldClass qualifications: [IdentityDictionary new]]
		     [newMicroWorldClass actions: [IdentityDictionary new]]
		     [newMicroWorldClass goals: [IdentityDictionary new]]
		     [newMicroWorldClass instances: [IdentityDictionary new]]
		     [[mw classes] at: name put: newMicroWorldClass]
		     sol-ok
		     )))

;; adds a new instance of a class
(define class-add-instance
	(lambda (className instanceName propertyValues)
		(let ((mw [[soracle currently] currentMicroWorld]) 
		      (class (mw-get-class className))
		      (newClassInstance [ClassInstance new])
		      (instPropNameValDict 
		          [[[soracle currently] currentWorld] instancePropertyValues])
		      (propNameToValDict 
		          (make-dictionary-from-keys-vals [class propertyNames] [propertyValues mapMsgs: [Array with: 'solEval]]))		      
		      )			  
	     	     ;; instantiate a new MicroWorldClass for this micro world
	     	     [newClassInstance name: instanceName]
	     	     [newClassInstance class: class]
		     ;; add this instance to the current world (situation) dictionary
		     [instPropNameValDict at: instanceName put: propNameToValDict]
		     [[mw instances] at: instanceName put: newClassInstance]
		     [[class instances] at: instanceName put: newClassInstance]
		     sol-ok
		     )))

;; adds a new qualification for a class
(define class-add-qualification
	(lambda (className qualificationName qualificationValue qualificationPred)
		(let ((class (mw-get-class className)))
		     ;; see if this qualification already has a definition or not
		     (if [[class qualifications] includesKey: qualificationName]
		     	 ;; qualification is defined before, we're just adding a new value/predicate
			 (let ((qualification [[class qualifications] at: qualificationName]))
			       [[qualification values] add: qualificationValue]
			       [[qualification predicates] add: qualificationPred]
			       sol-ok)
			 ;; qualification is new
		      	 (let ((newClassQualification [Qualification new])
			       (qualValues [OrderedCollection new]) (qualPredicates [OrderedCollection new]))
	     	     	      ;; instantiate a new Qualification for this class
			      [qualValues add: qualificationValue]
			      [qualPredicates add: qualificationPred]
	     	     	      [newClassQualification name: qualificationName]
	     	     	      [newClassQualification class: class]
	     	     	      [newClassQualification values: qualValues]
	     	     	      [newClassQualification predicates: qualPredicates]
		     	      ;; add this qualification to the class		     
		     	      [[class qualifications] at: qualificationName put: newClassQualification]
			      sol-ok
		     	      )))))

;; adds a new relative qualification for a microworld
(define mw-add-rel-qualification
	(lambda (relQualificationName var1Name var2Name pred)
		(let ((mw [[soracle currently] currentMicroWorld])
		      (newMWRelQualification [RelativeQualification new]))
		     [newMWRelQualification name: relQualificationName]
		     [newMWRelQualification object1: var1Name]
		     [newMWRelQualification object2: var2Name]
		     [newMWRelQualification predicate: pred]
		     [[mw relQualifications] at: relQualificationName put: newMWRelQualification]
	      	     sol-ok)))

;; adds a new action for a class
(define class-add-action-or-goal
	(lambda (type className actionOrGoalName actionOrGoalVars actionConseqOrGoalPred)
		(let ((isAction (== type 'action))
		      (class (mw-get-class className))
		      (newClassActionOrGoal (if isAction [Action new] [Goal new]))
		      (classActionsOrGoals (if isAction [class actions] [class goals]))
		      (newActionConseq [ActionConsequence new])
		      (index '0))
		      (if isAction
		      	  (let ((assigns [OrderedCollection new]))
		     		;; iterate through actionOrGoal assignments to create ActionConsequence
				;; object and finally add the new actionOrGoal to the class
		     		(while (< index [actionConseqOrGoalPred size])
		     	       	       (let ((newAssignment [Assignment new])
			       	       	     (assignmentAndPred [actionConseqOrGoalPred at: index])
					     (assignment [assignmentAndPred at: '0])
					     (predicate [assignmentAndPred at: '1]))
					     		[newAssignment assignment: `(sol-assignment ,[assignment at: '0] ,[assignment at: '1] ,sol-actual)]
					  		[newAssignment predicate: predicate]
					  		[assigns add: newAssignment])
	    		               (set index [index + '1]))
		     		       [newActionConseq assignments: assigns]))
	     	     ;; instantiate a new ActionOrGoal for this class
	     	     [newClassActionOrGoal name: actionOrGoalName]
	     	     [newClassActionOrGoal class: class]
	     	     [newClassActionOrGoal variables: actionOrGoalVars]
	     	     (if isAction 
		     	 ;; action def
		     	 (let ()
		     	       [newClassActionOrGoal rules: [OrderedCollection new]]
	     		       [newClassActionOrGoal consequence: newActionConseq])
			 ;; goal def
			 (let ()
			      [newClassActionOrGoal heuristics: [OrderedCollection new]]
			      [newClassActionOrGoal predicate: actionConseqOrGoalPred]))
		     ;; add this actionOrGoal to the class		     
		     [classActionsOrGoals at: actionOrGoalName put: newClassActionOrGoal]
		     sol-ok
		     )))

;; adds a new rule for an action of a class
(define action-add-rule
	(lambda (className actionName rulePredicate)
		(let ((class (mw-get-class className)))
		     (let ((action [class getAction: actionName]))
		     	  [[action rules] add: rulePredicate]
			  sol-ok
			  ))))

;; adds a new heuristic def for a goal of a class
(define goal-add-heuristic
	(lambda (className goalName minOrMax heuristicExpr)
		(let ((class (mw-get-class className)))
		     (let ((goal [class getGoal: goalName])
		     	   (heuristic [GoalHeuristic new]))
			   [heuristic goal: goal]
			   [heuristic type: minOrMax]
			   [heuristic expression: heuristicExpr]
		     	   [[goal heuristics] add: heuristic]
			   sol-ok
			   ))))
		     
;; if action var (actionVars) is a class name, its value (actionParam) should be instance of that
(define validate-action-parameters 
	(lambda (actionVars actionParams)
		(let ((mw [[soracle currently] currentMicroWorld]) (i '0))
		     (while [i < [actionVars size]]
		     	    (if (and [[mw classes] includesKey: [actionVars at: i]]
			    	     (not (and [[mw instances] includesKey: [actionParams at: i]]
				     	       (== [[[[mw instances] at: [actionParams at: i]] class] name]
					       	   [actionVars at: i]))))
				(return 0))
			    (set i [i + '1]))
                     (return 1))))
			
;; run action rules to see if this action run is valid
(define validate-action
	(lambda (actionVars actionParams actionRules instanceName)
		;; first automatic rule: if action var is a class name, the var val
		;; (parameter) must be an instance of that class
		(and (validate-action-parameters actionVars actionParams)
		     ;; now check action for each rule associate with it
		     (let ((i '0))
		          (while [i < [actionRules size]]			  	 
			       	 (if (not (eval-sol-expr 
				     	      [actionRules at: i] 
			   	              [Array with: sol-it withAll: actionVars] 
					      [Array with: instanceName withAll: actionParams]))
				     (return 0))
				 (set i [i + '1]))
			 1))))

;; given a world (of time t) returns a set of all actions taken (in string form) form time t = 0
;; that resulted in getting to this world
;; inString is a flag to tell whether report each action as a nice plane string or as an actual
;; collection (for later processing)
(define world-get-path
	(lambda (world inString)
		(let ((w world) (currTime [[[soracle currently] currentWorld] time]) 
		      (path [OrderedCollection new]))
		     (while (!= [w time] currTime)
		     	    	 ;; if inString we should eval params, otherwise store them unevald
				 ;; for later action running
		     	    (let ((action [[w possibleWorldInfo] at: 'cause])
			    	  (actionCp [action copy])
				  (actionParamsEvald (let () [actionCp removeFirst]
				  		     	     [actionCp removeFirst]
							     [actionCp mapMsgs: [Array with: 'solEval]]))
				  (actionFinal [OrderedCollection with: [action first] 
				  	       			  with: [action second]
								  withAll: actionParamsEvald])
			    	  (elm (if inString [actionFinal toString] action)))
		     	    	  [path addFirst: elm])
		     	    (set w [[w possibleWorldInfo] at: 'parent]))
		     [List withElements: path])))

;; given a collection of possible worlds, uses any defined heuristics to pick one,
;; if none, just pick a random one!
(define pick-from-possible-worlds-by-heuristics
	(lambda (instanceName goalName possibleWorlds)
		(let ((class (instance-get-class instanceName))
		      (goal [class getGoal: goalName])
		      (heuristics [goal heuristics]))
		      (if (== [heuristics size] '0)
		      	  ;; no heuristics defined... random picking:
		      	  [possibleWorlds randomOne]
			  ;; we have heuristics... pick the possible world best matching heuristics
			  ;; sum the score from all heuristics for each possible world and pick the
			  ;; world with the highest score sum (for minimize heuristics we negate)
			  (let ((h '0) (pickIndex '0) (pwScores [IdentityDictionary new]))
		       	       ['"consulting heuristics..." putln]
		               (while [h < [heuristics size]]			       	      
			       	      (let ((i '0) (scoresSum '0) (tempScores [IdentityDictionary new])
			              	    (j '0) (theHeuristic [heuristics at: h])
				      	    (isMinimize (== [theHeuristic type] sol-minimize))
				      	    (isMaximize (== [theHeuristic type] sol-maximize)))
			              	    (while [i < [possibleWorlds size]]
			       	       	    	   (let ((rawPWScore
							    (eval-sol-expr-in-world 
				      	    	    	        [theHeuristic expression] 
		  	              	    	    		[Array with: sol-it]
				      	    	    		[Array with: instanceName]
						    		[possibleWorlds at: i])))
						        [tempScores at: i put: rawPWScore]
							(set scoresSum [scoresSum + rawPWScore]))
					   	    (set i [i + '1]))
			       	      	    ;; in order to make the weight of all heuristics the same 
				            ;; have to calc scores as fraction of heuristic expression
				            ;; value of the whole sum
					    (while [j < [possibleWorlds size]]
							 ;; fixme: only 'minimize'/'maximize' supported
					    	   (let ((pwScore (if isMinimize 
							 	      [[tempScores at: j] * '-1]
								      [tempScores at: j])))
						   	(if [pwScores includesKey: j]
						       	    [pwScores at: j put: [[pwScores at: j] + [pwScore / scoresSum]]]
						       	    [pwScores at: j put: [pwScore / scoresSum]]))
						   (set j [j + '1])))
					(set h [h + '1]))
				;; now we have sumed up the score from all heuristics for each pw,
				;; return the highest scoring one...
			       	[possibleWorlds at: [pwScores keyWithExtremum: 'max]])))))

;; checks if goal is satisfied at given world
(define instance-goal-satisfied
	(lambda (instanceName goalName goalParams world)
		(let ((class (instance-get-class instanceName)) (goal [class getGoal: goalName])
		      (currWorld [[soracle currently] currentWorld])
		      (currTime [currWorld time])		      
		      (goalPred [goal predicate]) (time [world time])		     
		      (origGoalVars [goal variables])
		      (origGoalParams [goalParams mapMsgs: [Array with: 'solEval]])
		      (goalVars [Array with: sol-it withAll: origGoalVars])
	       	      (goalParams [Array with: instanceName withAll: origGoalParams]))
		      ;; temporarily set current world to this one
		      (set-current-world world)
		      (let ((predEvald (eval-sol-expr goalPred goalVars goalParams)))
				       ;; restore current world
				       (restore-current-world currWorld)
				       predEvald))))

;; looks ahead in time, generating more and more worlds by trying all actions possible
;; until the given goal is satisfied
;; returns the future world for which goal is satisfied
;; nth tells which solution to report (nth = 0 returns the first solved path)
;; stopOnOnlyChild is a flag to tell it to stop solving if there is only one next possible world
;; (used when we just want to find next best action)
(define instance-solve-path-to-goal
	(lambda (instanceName goalName goalParams nth stopOnOnlyChild)
		(let ((timeAhead '1) (currWorld [[soracle currently] currentWorld])
		      (allSeenWorlds [OrderedCollection new]))
		      ;; is it already satisfied?
		      (if (instance-goal-satisfied instanceName goalName goalParams currWorld)
		          currWorld
			  ;; look ahead in time until satisfied
			  (let ()
			       (while [timeAhead <= [sol-opts at: 'max-time-ahead]]
		      	  	      (let ((possibleWorlds (possible-value-worlds instanceName timeAhead))
				      	    (OneChildCase (and stopOnOnlyChild
					    		       (== [possibleWorlds size] '1)))
			              	    (i '0))
					    [allSeenWorlds addAll: possibleWorlds]
			       		    ['"looking " put] [timeAhead print] ['" time unit ahead (" put] [[possibleWorlds size] print] ['" possible worlds)" putln]
			       	      	    (while [i < [possibleWorlds size]]
			       	      	     	   (let ((world [possibleWorlds at: i]))
				      	     	   	(if (or OneChildCase
							    	(instance-goal-satisfied instanceName goalName goalParams world))
							    (if (== nth '0)
							    	;; we're using this solution
							    	(let ()
							    	     (return world))
								 ;; we have to skip this solution...
								(set nth [nth - '1]))
							))
			       	             	   (set i [i + '1])))
			              (set timeAhead [timeAhead + '1]))
			       ;; we are too deep in the tree, 
			       ;; use any heuristics to pick a world instead
			       ['"ok I hear the cpu fan... giving up!" putln]
			       (if (or (== [allSeenWorlds size] '0) (not stopOnOnlyChild))
			       	   sol-error
			       	   (pick-from-possible-worlds-by-heuristics instanceName goalName allSeenWorlds))
			       )))))

(define instance-run-action 0) ;; workaround for mutual definition of fns

;; given a path (list of actions that lead to a goal), runs the first n ones.
(define run-n-actions-in-path 
	(lambda (instanceName path n)
		(let ((i '0))
		     (while [n > i]
		     	    (let ((nextAction [[path elements] at: i])
	   	      	    	 (actionInstName [nextAction first])
		      		 (actionName [nextAction second])
		      		 (actionParams (let () [nextAction removeFirst]
				  	       	       [nextAction removeFirst]
				            	       nextAction))
	                         (actionParamsEvald [actionParams mapMsgs: [Array with: 'solEval]])
		      		 (actionInString (let ((c [OrderedCollection with: actionInstName
						    	    	  	     with: 'did
				  		  	    	  	     with: actionName]))
					              [c addAll: actionParamsEvald]
					   	      [c toString])))
		                 ;; if this instance isnt the actor of this action discard...
		       		 (if (not (== actionInstName instanceName))
			   	     sol-error
		 	   	     ;; run the picked action
			   	     (let ((actionRunRes (instance-run-action actionInstName actionName actionParams sol-actual)))
			       	     	  [actionInString println]
			       	 	  (if (== actionRunRes sol-error) (return sol-error)))))
			     (set i [i + '1]))
		sol-ok)))

;; finds and prints the solved path to goal.
;; if runActually flag, it will run the actions to reach the goal
(define instance-run-goal
	(lambda (instanceName goalName goalParams runActually)
		(let ((class (instance-get-class instanceName)))
		     ;; validate goal name
		     (if (not [[class goals] includesKey: goalName])
		     	 (return sol-error))
		     ;; fixme: only finds the 0th solution: (nth = 0) 
		     (let ((world (instance-solve-path-to-goal instanceName goalName goalParams '0 0)))
		     	  (if (== world sol-error)
		     	      ['"not satisfiable!" putln]
		     	      (if (== [world time] [[[soracle currently] currentWorld] time])
		     	      	  ['"already satisfied." putln]
		      	     	  (let ((pathInStr (world-get-path world 1)))
		    	      	       ['"satisfied at time: " put]
	 	              	       [[world time] println]
		      	      	       ['"satisfied by: " put]
			      	       [pathInStr printlnMe]
				       (if runActually
				       	   (let ((path (world-get-path world 0)))
				      	   	(run-n-actions-in-path instanceName path [[path elements] size]))
				           ))))
		          sol-ok))))

;; finds the path to goal, run the next action in this path.
(define instance-find-next-action-to-goal
	(lambda (instanceName goalName goalParams)
		;; fixme: only finds the 0th solution: (nth = 0) 
		(let ((class (instance-get-class instanceName)) 
		      (goal [class getAGoal]) (goalName [goal name])
		      (world (instance-solve-path-to-goal instanceName goalName [OrderedCollection new] '0 1)))
		      (if (== world sol-error)
		      	  sol-error
		      	  (let ((path (world-get-path world 0)))
			       (let ((run (run-n-actions-in-path instanceName path '1)))
			       	    run))))))
	
(define instance-run-action
	(lambda (instanceName actionName origActionParams hypotheticalOrActual)
		(let ((isHypothetical (== hypotheticalOrActual sol-hypothetical))
		      (class (instance-get-class instanceName)))
		      ;; validate action name
		      (if (not [[class actions] includesKey: actionName])
			  (return sol-error))
		      (let ((action [class getAction: actionName])
			   (origActionVars [action variables])
		           (origActionParamsEvald [origActionParams mapMsgs: [Array with: 'solEval]])
			   (actionVars [Array with: sol-it withAll: origActionVars])
			   (actionParams [Array with: instanceName withAll: origActionParamsEvald])
			   (actionDescr [OrderedCollection with: instanceName with: actionName withAll: origActionParams])
			   (actionRules [action rules])
		           (actionConseq [[action consequence] assignments]))


			   ;; if action has defined vars but is called without params, it means
			   ;; its being asked to take the action that is in the path to satisfy
			   ;; the instance goal (used for e.g. in 2-player game against computer)
			   (if (and (!= [origActionVars size] '0) (== [origActionParams size] '0))
			       ;; fixme: assumes there is only 1 goal defined for instance and takes no params
			       (return (instance-find-next-action-to-goal instanceName)))

		           ;; first check if action obeys its rules
			   (if (validate-action origActionVars 
		                         	origActionParamsEvald actionRules instanceName)
			       ;; rule check passed.
			       ;; filter out assignments which dont meet their predicate:
			       (let ((assignments 
				           (filter1 eval-sol-expr2 actionConseq 'predicate
			     	       		    [Array with: actionVars with: actionParams])))
				     ;; increment time if action sucessful:
			             (if (!= [assignments size] '0) [[soracle currently] newAtTimePlusOne: actionDescr isHyp: isHypothetical])
				     	 ;; run each assignment:
				     	 (for-each apply-assignment assignments 'assignment
				     	       	  	[Array with: actionVars with: actionParams
							       with: isHypothetical])
					 sol-ok)
				sol-error)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Semantics
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(printf "; defining semantics\n")

(syntax sol-boolean
 	(lambda (node compiler)
		(let ((arg [node second]))		     
		     arg)))

(syntax sol-number	; integer
 	(lambda (node compiler)
    	       `',[node second]))

(syntax sol-set	; set notation
 	(lambda (node compiler)
		(let ()
    	       `',[Set withElements: [[node second] mapMsgs: [Array with: 'solEval]]]))) ;; fixme

(syntax sol-list ; list notation
 	(lambda (node compiler)
		(let ()
    	       `',[List withElements: [[node second] mapMsgs: [Array with: 'solEval]]]))) ;; fixme

(syntax sol-name	; symbol
 	(lambda (node compiler)
    	       `',[node second]))

(syntax sol-value	; symbol
 	(lambda (node compiler)
    	       `',[node second]))

(syntax sol-string	; symbol
 	(lambda (node compiler)
    	       `',[node second]))

(syntax sol-word	; word
 	(lambda (node compiler)
    	       `',[node second]))

(syntax sol-rel-qualify-clause
	(lambda (node compiler)
		(let ((relQualName [node second]) (obj1 [node third]) 
		      (obj2 [node fourth]))
		      `(let ((mw [[soracle currently] currentMicroWorld]))
		      	    (if [[mw relQualifications] includesKey: ,relQualName]
			    	(let ((relQual [[mw relQualifications] at: ,relQualName])
				      (relQualPred [relQual predicate])
				      (relQualVar1 [relQual object1])
				      (relQualVar2 [relQual object2]))				      
				      (eval-sol-expr relQualPred 
				      		     [Array with: relQualVar1 with: relQualVar2]
						     [Array with: ,obj1 with: ,obj2]))
				sol-error)))))

(syntax sol-log
	(lambda (node compiler)
		(let ((op [node second]))
		     `(,op ,[node third] ,[node fourth]))))

(syntax sol-negate
 	(lambda (node compiler)
		(let ((arg [node second]))
			 `(if ,arg 0 1))))

(syntax sol-predicate
 	(lambda (node compiler)
		(let ((pred [node second]) (time [node third]))
		      `(let ((predAtTime (exp-at-time ,pred ,time)))
			    (if predAtTime sol-true sol-false)))))
			     
(syntax sol-for ;; fixme
 	(lambda (node compiler)
		(let ((quantifier [node second]) 
		      (set [node third])
		      (cmd [node fourth]))
		      `(let ((res sol-ok) (setTrue '1)
		             (isAll (== ',quantifier sol-all))
		      	     (isEvery (== ',quantifier sol-every))
			     (isAny (== ',quantifier sol-any)))
		      	    ;; < for all > <for any> or <for every> ...
		      	    (if (or isAll isEvery isAny)
		            	(let ((index '0) (setElms [,set elements]))
     			       	     (while (< index [setElms size])
				      	    (let ((elm [setElms at: index])
					    	  ;; hack fixme: cannot add already evald set, 
						  ;; need to quote it, also all elements within it!
					    	  (elmToUse (if [elm isSet]
						  	    	`(sol-set (,'unquote 
									  [[elm elements] mapMsgs: [Array with: 'toSolValue]]))
								(if [elm isList]
								    `(sol-list (,'unquote 
									  [[elm elements] mapMsgs: [Array with: 'toSolValue]]))
								    elm)))
					    	  (thisCmd [',cmd replaceAll: [Array with: sol-each] withAll: [Array with: elmToUse]]))	
					   	 ;; run each command here
						 (let ((thisCmdRes [thisCmd solEval]))
						      ;; fixme: dont know how to return early!
						      (if (and isEvery (not thisCmdRes))
						      	       (set setTrue 0))
						      (if (and isAny thisCmdRes) (set setTrue 0))
					   	      (if isAll (let () [thisCmd println]
						      	  	     	[thisCmdRes printlnMe])))
						 )
	    			            (set index [index + '1]))
			        	    (if isEvery (if setTrue (set res '1) (set res sol-null)))
					    (if isAny (if (not setTrue) (set res '1) (set res sol-null)))
					    res)
				sol-error)))))

;; e.g.
;; all square
;; all green color tall size lego
(syntax sol-setToBe-all-instances
	(lambda (node compiler)
		(let ((className [node second]) (propertyValNamePairs [node third])
		      (mw [[soracle currently] currentMicroWorld]))
		     ;; validate class name
		     (if [[mw classes] includesKey: className]
		      	 (let ((class (mw-get-class className))
		      	       (instances [[class instances] keys])
			       (initSet `(sol-set ,[instances mapMsgs: [Array with: 'toSolValue]])))
		      	    (if (== [propertyValNamePairs size] '0)
			    	initSet
				;; generate the select expression to get the qualified elements of set:
				(let ((setSelectExp 0) (setToUse initSet) (i '0))
				     (while [i < [propertyValNamePairs size]]
				     	    (set setSelectExp `(send '= (sol-instance-property-lookup (sol-of ,[[propertyValNamePairs at: i] second]) sol-now) ,[[propertyValNamePairs at: i] first]))
				     	    (set setToUse `(sol-select-from-set ,setToUse ,setSelectExp))
				     	    (set i [i + '1]))			 
				      setToUse)))
			  `',sol-error))))

		
(syntax sol-random-instances-from-all-instances
	(lambda (node compiler)
		(let ((num [node second]) (className [node third]) 
		      (propertyValNamePairs [node fourth]) 
		      (mw [[soracle currently] currentMicroWorld]))
		      ;; validate class name first:
		     (if [[mw classes] includesKey: className]
		      	 (let ((class (mw-get-class className)))
		      	      `(let ((set (sol-setToBe-all-instances ,className ,propertyValNamePairs)))
		      	      	    (if (== ,num '1)
		      	     	    	[[set elements] randomOne]
					[[set elements] random: ,num])))
			`',sol-error))))

(syntax sol-random-elements-from-set
	(lambda (node compiler)
		`(let ((num ,[node second]) (s ,[node third]))
		      (if (== num '1)
		      	  [[s elements] randomOne]
		      	  [[s elements] random: num]))))

;; used to send various messages to a set/list, 
;; including element reference by index, size query, ...
(syntax sol-send-msg-to-set-or-list
	(lambda (node compiler)
		`(let ((msg ,[node second]) (s ,[node third]))
		      (if [msg isNumber]
		      	  ;; this is an element reference by index:
		      	  [s at: msg]
			  (if (== msg sol-size)
			      ;; this is asking the size of the set
			      [s size]
			      sol-error)))))

(syntax sol-select-from-set
	(lambda (node compiler)
		(let ((set [node second]) (predicate `',[node third]))
		     `[,set selectBy: ,predicate])))

(syntax sol-instance-property-lookup
	(lambda (node compiler)
		(let ((exp [node second]) (time [node third]))
		      `(let ((mw [[soracle currently] currentMicroWorld])
		      	     (propVal (instance-get-cascaded-properties ',exp ,time mw)))
		      	     propVal))))

;; E.g. { A1 A3 B2 } row number --> { 1 3 2 }
(syntax sol-set-instance-property-lookup
	(lambda (node compiler)
		`(let ((set ,[node second]) (mw [[soracle currently] currentMicroWorld])
		       (cascadedPropList ',[node third]) (time ',[node fourth]))
		      (let ((i '0) (j '0) (elms [set elements]) (res [Set newEmpty]) (validInsts 1))
		      	   ;; first make sure all instances exists
			   (while [i < [elms size]]
			   	  (if (not [[mw instances] includesKey: [elms at: i]])
				      	   (set validInsts 0))
			   	  (set i [i + '1]))
		           (if validInsts
			       ;; now lookup properties
		      	       (let ()
			       	    (while [j < [elms size]]
			   	      	   ;; fixme: the unflatten should happen at parse time
		      	   	      	   (let ((exp [[Array with: [elms at: j] withAll: cascadedPropList] unflatten]))
		      	  	       	   	(let ((propVal (instance-get-cascaded-properties exp time mw)))
		      	       		    	     [res addElement: propVal]))
			   	  		     (set j [j + '1]))
				     res)
			       sol-error)))))

(syntax sol-assignment
	(lambda (node compiler)
		`(let ((leftSide ',[node second]) (rightSide ',[node third]) 
		       (isHypothetical (== ,[node fourth] sol-hypothetical))
		       ;; hack fixme: have to take out last prop name out of cascaded names as
		       ;; the property to be updated...
		       (propertyName ',[[[node second] second] second]))
		       [leftSide at: '1 put: [[leftSide second] first]] ;; hack fixme
		       (let ((instanceName (if [[leftSide second] isSequenceableCollection] 
			  	       	       [leftSide solEval]
					       [leftSide second]))
			     (propertyNewVal rightSide))
			     (instance-update-property instanceName propertyName propertyNewVal 
			     			       isHypothetical)
		       	     '0))))

(syntax sol-time
	(lambda (node compiler)
		`',[[[soracle currently] currentWorld] time]))

(syntax sol-set-opt
	(lambda (node compiler)
		`(let ()
		     [sol-opts at: ',[node second] put: ,[node third]]
		     sol-ok)))

(syntax sol-start-world
	(lambda (node compiler)
		`(kb-add-microworld ',[node second])))

(syntax sol-cont-world
	(lambda (node compiler)
		`(let ((theMicroWorld (kb-get-microworld ',[node second])))
		      [[soracle currently] currentMicroWorld: theMicroWorld]
		      sol-ok)))

(syntax sol-create-obj
	(lambda (node compiler)
		`(mw-add-class ',[node second] ',[node third])))

(syntax sol-make-obj
	(lambda (node compiler)
		`(let ((instanceName (if [',[node third] isExpression] 
		      		     	 [',[node third] solEval]
					 ',[node third]))) ;; hack fixme: doing this for instance names
					 	 	   ;; derived from word concats (sol-word-add)
		      (class-add-instance ',[node second] instanceName ',[node fourth]))))

(syntax sol-qualify-obj
	(lambda (node compiler)
		`(class-add-qualification ',[node second] ',[node third] ',[node fourth] ',[node fifth])))

(syntax sol-rel-qualify-objs
	(lambda (node compiler)
		`(mw-add-rel-qualification ',[node second] ',[node third] ',[node fourth] ',[node fifth])))

(syntax sol-action-def 
	(lambda (node compiler)
		`(class-add-action-or-goal 'action ',[node second] ',[node third] ',[node fourth] ',[node fifth])))

(syntax sol-goal-def 
	(lambda (node compiler)
		`(class-add-action-or-goal 'goal ',[node second] ',[node third] ',[node fourth] ',[node fifth])))

(syntax sol-action-rule
	(lambda (node compiler)
		`(action-add-rule ',[node second] ',[node third] ',[node fourth])))

(syntax sol-goal-heuristic
	(lambda (node compiler)
		`(goal-add-heuristic ',[node second] ',[node third] ',[node fourth] ',[node fifth])))

(syntax sol-action-run
	(lambda (node compiler)
		(let ()
		     `(instance-run-action ',[node second] ',[node third] ',[node fourth] ',[node fifth]))))

(syntax sol-goal-check
	(lambda (node compiler)
		(let ()
		     `(instance-run-goal ',[node second] ',[node third] ',[node fourth] 0))))

(syntax sol-goal-run
	(lambda (node compiler)
		(let ()
		     `(instance-run-goal ',[node second] ',[node third] ',[node fourth] 1))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Syntax
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(printf "; defining syntax\n")

['{

error		   = <- [self error: '"syntax error"]
eol		   = '\r' '\n'* | '\n' '\r'*
space		   = [ \t] | eol | comment
spaces		   = space*
dot		   = '.'
end	           = !.
theEnd	           = 'end-file' spaces dot* | end
mySpace	           = space | end
nonSpace	   = !(space | dot | rparen)
endWord		   = !nonSpace spaces
comment		   = ';' (!eol .)* eol | '/*' (!'*/' .)* '*/'

lparen		   = '(' spaces
rparen		   = ')' spaces
lbraces		   = '{' spaces
rbraces		   = '}' spaces
lbrackets	   = '[' spaces
rbrackets	   = ']' spaces
equals		   = '=' spaces

specialKeyword	   = '*' | 'x' | '/' | '+' | '-' | 'means' | 'consequence' | 'end-file'
keywords	   = 'is' | 'if' | 'not' | 'and' | 'or' | 'in' | '*' | 'x' | '/' | '+' | '-'  
		   | 'by' | 'for' | 'all' | 'every' | 'any' | 'do' | 'satisfy' | 'satisfiable' 
		   | 'its' | 'it' | 'of' | 'each'
		   | 'select' | 'first' | 'second' | 'third' | 'fourth' | 'fifth' | 'size'
		   | 'start-world' | 'random' | 'continue-word' | 'create' | 'make' | 'qualify' 
		   | 'rel-qualify' | 'action' | 'goal' | 'try' | 'consequence' | 'rule' | 'heuristic'
		   | 'english' | 'means' | 'respond' | 'time' | 'end-file'
keyword		   = keywords (space | dot | rparen)
time		   = 'time'->0 endWord <- [self @ '0]
it		   = ('its'|'it') endWord <- sol-it
each		   = 'each'->0 endWord <- sol-each
of		   = 'of'->0 endWord <- sol-of
at		   = 'at'->0 endWord <- [self @ '0]
do		   = 'do'->0 endWord <- [self @ '0]
satisfy		   = 'satisfy'->0 endWord <- [self @ '0]
satisfiable	   = 'satisfiable'->0 endWord <- [self @ '0]
in		   = 'in'->0 endWord <- [self @ '0]
for		   = 'for'->0 endWord <- [self @ '0]
all		   = 'all'->0 endWord <- sol-all
every		   = 'every'->0 endWord <- sol-every
any		   = 'any'->0 endWord <- sol-any
respondBy	   = 'respond'->0 endWord 'by' spaces <- [self @ '0]
consequence	   = 'consequence'->0 endWord <- [self @ '0]
try	   	   = 'try'->0 endWord <- [self @ '0]
means		   = 'means'->0 endWord <- [self @ '0]
by		   = 'by'->0 endWord <- [self @ '0]
select		   = 'select'->0 endWord <- [self @ '0]
random		   = 'random'->0 endWord <- [self @ '0]
english		   = 'english'->0 endWord <- [self @ '0]
rule		   = 'rule'->0 endWord <- [self @ '0]
heuristic	   = 'heuristic'->0 endWord <- [self @ '0]
minimize	   = 'minimize'->0 spaces <- [self @ '0]
maximize	   = 'maximize'->0 spaces <- [self @ '0]
phrase		   = 'phrase'->0 endWord <- [self @ '0]
is		   = ('is'|'if')$->0 endWord <- 'is
not		   = 'not'->0 endWord <- [self @ '0]
and		   = 'and'
or		   = 'or'
first		   = 'first' endWord <- `(sol-number 0) 
second		   = 'second' endWord <- `(sol-number 1) 
third		   = 'third' endWord <- `(sol-number 2) 
fourth		   = 'fourth' endWord <- `(sol-number 3) 
fifth		   = 'fifth' endWord <- `(sol-number 4)
size		   = 'size' endWord <- sol-size
replaceKeywords    = it | of | each
articleA	   = ('an' | 'a') $->0 endWord
		     	  <- [self @ '0]
articleThe	   = ('the') $->0 endWord
		     	  <- [self @ '0]
article		   = articleA | articleThe
true	     	   = 'yes' endWord
		     	  <- '1
false	     	   = 'no' endWord
		     	  <- '0
boolean 	   = true | false
logicAndOp         = spaces (and) $->0 endWord
		     	  <- [[self @ '0] asSymbol]
logicOrOp          = spaces (or) $->0 endWord
		     	  <- [[self @ '0] asSymbol]
logicOp		   = logicAndOp | logicOrOp
mathAddOp          = spaces ('+' | '-') $->0 spaces
		     	  <- [[self @ '0] asSymbol]
mathMultOp         = spaces ('**' | '*' | '/') $->0 spaces
		     	  <- [[self @ '0] asSymbol]
mathOp		   = mathAddOp | mathMultOp
mathCompOp	   = spaces ('=' | '<=' | '>=' | '<' | '>' | 'in') $->0 spaces
		      	  <- [[self @ '0] asSymbol]
higherOrderCKeys   = every | any
char		   = ( . ->0 )		
		          <- [self @ '0]
string	 	   = '"' ( !'"' char )* ->0 '"' spaces		
		          <- `(sol-string ,[[[self @ '0] asString] asSymbol])
name		   = replaceKeywords
		   | !keyword ([a-zA-Z_-][a-zA-Z_0-9-]*) $->0 spaces
		          <- [result asSymbol]
		   | lparen expr->0 rparen
		     	  <- [self @ '0]
magnitude	   = ([0-9]+) $->0 spaces				
		          <- [Integer fromString: [self @ '0]]
		   | (([0-9]+) '.' ([0-9]+)) $->0 spaces		
		          <- [Float fromString: [self @ '0]]
number	           = '-' magnitude 				
		          <- `(sol-number ,[result negated])
		   | magnitude
		          <- `(sol-number ,result)
value		   = lparen expr->0 rparen
  		          <- [self @ '0] 
		   | boolean
		   | number
  		   | name->0
			  <- `(sol-value ,[self @ '0])
		   | string		  
		   | listOrSetToBe
alphaNum	   = first | second | third | fourth | fifth
listMsg	   	   = alphaNum | size
word		   = !specialKeyword ([a-zA-Z_?0-9-]+) $->0 spaces
		          <- [result asSymbol]
timeQuery	   = 'time' spaces
			  <- `(sol-time)
instanceName       = name
names              = name->0 name*->1
		          <-  [Array with: [self @ '0] withAll: [self @ '1]]
values             = value->0 value*->1
		          <-  [Array with: [self @ '0] withAll: [self @ '1]]
cascadedNames      = (instanceName->0 
		          <- [self @ '0])->1
		          (name->3 
			        <- [Array with: [self @ '1] with: [self @ '3]] -> 1)+
				       <- [self @ '1]
cascadedValueName = value->0 name->1
		    	  <- [Array with: [self @ '0] with: [self @ '1]]
propertyReference  = cascadedNames
  		          <- `(sol-instance-property-lookup ,result sol-now)
atTimePropertyReference = propertyReference
			| at time number->0 spaces cascadedNames->1
  		          <- `(sol-instance-property-lookup ,[self @ '1] ,[self @ '0])
words              = word->0 word*->1
		          <-  [Array with: [self @ '0] withAll: [self @ '1]]

higherOrderClause  = for higherOrderCKeys->2 genListOrSetToBe->0 do clauses->1
                          <- `(sol-for ,[self @ '2] ,[self @ '0] ,[self @ '1])
clause	     	   = boolean->0
			  <- `(sol-boolean ,[self @ '0])
                   | higherOrderClause
		   | not clause->0
		          <- `(sol-negate ,[self @ '0])
  		   | listOrSetToBe->0 mathCompOp->1 listOrSetToBe->2
		          <- `(send ',[self @ '1] ,[self @ '0] ,[self @ '2])
  		   | expr->0 in->1 expr->2
		          <- `[,[self @ '2] includes: ,[self @ '0]]
  		   | expr->0 mathCompOp->1 expr->2
		          <- `(send ',[self @ '1] ,[self @ '0] ,[self @ '2])
	           | values->0
		          <- `(sol-rel-qualify-clause ,[[self @ '0] at: '1] 
			     			      ,[[self @ '0] at: '0] ,[[self @ '0] at: '2])
  		   | lparen clauses->0 rparen
  		          <- [self @ '0]
clauses	     	   = (clause->0 
		          <- [self @ '0])->1
		          (logicOp->2 clause->3 
				<- `(sol-log ,[self @ '2] ,[self @ '1] ,[self @ '3]) -> 1)*
  		          	       <- [self @ '1]
singleClausePred   = is clause->0
  		          <- [self @ '0]
optSingleClausePred = singleClausePred
  		   | ''
		          <- `(sol-boolean 1)
predicate	   = is clauses->0
  		          <- `(sol-predicate ,[self @ '0] sol-now)
atTimePredicate    = predicate
	           | at time number->0 spaces is clauses->1
  		          <- `(sol-predicate ,[self @ '1] ,[self @ '0])
optPredicate       = is clauses->0
  		          <- [self @ '0]		     
  		   | ''
		          <- `(sol-boolean 1)
selectExpr	   = select genListOrSetToBe->0 by clauses->1
  		          <- `(sol-select-from-set ,[self @ '0] ,[self @ '1])
		   | article->0 genListOrSetToBe->1
  		          <- `(sol-random-elements-from-set '1 ,[self @ '1])
	           | number->0 spaces random genListOrSetToBe->1
		     	  <- `(sol-random-elements-from-set ,[self @ '0] ,[self @ '1])
pickFromSetExpr    = article->0 cascadedValueName*->1 name->2
		          <- `(sol-random-instances-from-all-instances '1 ,[self @ '2] ,[self @ '1])
 		   | number->0 spaces random cascadedValueName*->1 name->2
		          <- `(sol-random-instances-from-all-instances ,[self @ '0] ,[self @ '2] ,[self @ '1])
	           | (genListOrSetToBe | replaceKeywords)->1 spaces listMsg->0
		     	  <- `(sol-send-msg-to-set-or-list ,[self @ '0] ,[self @ '1])
setPropertyReference = listOrSetToBe->0 spaces name+->1
		     	  <- `(sol-set-instance-property-lookup ,[self @ '0] ,[self @ '1] sol-now)
atTimeSetPropertyReference = setPropertyReference
			   | at time number->2 spaces listOrSetToBe->0 spaces name+->1
		     	         <- `(sol-set-instance-property-lookup ,[self @ '0] ,[self @ '1] ,[self @ '2])
genPropertyReference = atTimePropertyReference | atTimeSetPropertyReference
primitive	   = lparen listOrSetToBe->0 rparen listMsg->1
  		          <- `(sol-send-msg-to-set-or-list ,[self @ '1] ,[self @ '0])
		   | lparen expr->0 rparen
  		          <- [self @ '0]	     
		   | pickFromSetExpr
                   | selectExpr
		   | atTimeSetPropertyReference
	           | number
		   | listOrSetToBe
		   | atTimePropertyReference
		   | timeQuery
		   | value
multExpr	   = (primitive->0 
		          <- [self @ '0])->1
		          (mathMultOp->2 primitive->3 
			        <- `(send ',[self @ '2] ,[self @ '1] ,[self @ '3]) -> 1)*
  		          	       <- [self @ '1]
expr	 	   = (multExpr->0 
		          <- [self @ '0])->1
		          (mathAddOp->2 multExpr->3 
			        <- `(send ',[self @ '2] ,[self @ '1] ,[self @ '3]) -> 1)*
  		          	       <- [self @ '1]		  
exprs		   = expr+
primitiveWord      = lparen exprWord->0 rparen
  		          <- [self @ '0]
  		   | words->0
		          <- `(sol-word-expression ,[self @ '0])
exprWord	   = primitiveWord
		   | exprWord->0 mathOp->1 primitiveWord->2
  		          <- `(,[self @ '1] ,[self @ '0] ,[self @ '2])
exprWords	   = exprWord+
allInstances	   = all cascadedValueName*->1 name->0
		          <- `(sol-setToBe-all-instances ,[self @ '0]  ,[self @ '1])
list		   = spaces lbrackets value*->0 rbrackets
                          <- `(sol-list ,[self @ '0])
set		   = spaces lbraces value*->0 rbraces
                          <- `(sol-set ,[self @ '0])
setOrList          = set | list
listOrSetToBe      = (allInstances->1 | setOrList->1) mathOp->2 primitive->3
		     	  <- `(send ',[self @ '2] ,[self @ '1] ,[self @ '3])
		   | set
		   | list
		   | allInstances
		   | selectExpr->0
		          <- [self @ '0]
genListOrSetToBe   = listOrSetToBe | genPropertyReference
exprsConjs	   = exprs
		   | exprsConjs->0 and exprs->1
  		          <- `(,[self @ '0] ,[self @ '1])
exprWordsConjs	   = exprWords
		   | exprWordsConjs->0 and exprWords->1
  		          <- `(,[self @ '0], [self @ '1])
assignment	   = propertyReference->0 equals expr->1 optSingleClausePred->2
  		          <- [Array with: [Array with: [self @ '0] with: [self @ '1]] with: [self @ '2]]
assignments	   = (assignment->0 
		          <- [Array with: [self @ '0]])->1
		          (logicAndOp->2 assignment->3 
				<- [Array withAll: [self @ '1] with: [self @ '3]] -> 1)*
  		          	       <- [self @ '1]
conseqClause       = consequence assignments->0
   		          <- [self @ '0]
conseqClauseOpt    = conseqClause
		   | ''
englishConseqClause = consequence exprWordsConjs->0
   		          <- [self @ '0]
englishConseqClauseOpt = englishConseqClause
		       | ''
query		   = !'end-file' (atTimePredicate | expr)

startWorld         = 'start-world' endWord name->0
                          <- `(sol-start-world ,[self @ '0])
contWorld          = 'continue-world' endWord name->0
                          <- `(sol-cont-world ,[self @ '0])
createObj          = 'create' endWord name->0 name*->1
                          <- `(sol-create-obj ,[self @ '0] ,[self @ '1])
groupObjs          = 'group' endWord name->0 names->1
                          <- `(sol-group-objs ,[self @ '0] ,[self @ '1])
makeObj            = 'make' endWord name->0 instanceName->1 value*->2
                          <- `(sol-make-obj ,[self @ '0] ,[self @ '1] ,[self @ '2])
qualify            = 'qualify' endWord name->0 name->1 expr->2 optPredicate->3
                          <- `(sol-qualify-obj ,[self @ '0] ,[self @ '1] ,[self @ '2] ,[self @ '3])
relQualify         = 'rel-qualify' endWord name->0 name->1 name->2 is clauses->3
                          <- `(sol-rel-qualify-objs ,[self @ '1] ,[self @ '0] ,[self @ '2] ,[self @ '3])
actionDef          = 'action' endWord name->0 name->1 name*->2 conseqClause->3
                          <- `(sol-action-def ,[self @ '0] ,[self @ '1] ,[self @ '2] ,[self @ '3])
actionRuleDef      = rule name->0 name->1 is clauses->2
                          <- `(sol-action-rule ,[self @ '0] ,[self @ '1] ,[self @ '2])
goalDef            = 'goal' endWord name->0 name->1 name*->2 try clauses->3
                          <- `(sol-goal-def ,[self @ '0] ,[self @ '1] ,[self @ '2] ,[self @ '3])
goalHeuristicDef   = heuristic name->0 name->1 name->2 expr->3
                          <- `(sol-goal-heuristic ,[self @ '0] ,[self @ '1] ,[self @ '2] ,[self @ '3])
englishDef         = englishAction | englishRule | englishPhrase
englishAction      = english 'action' endWord name->0 name->1 name*->2 means exprWords->3 englishConseqClauseOpt->4
                          <- `(sol-english-action-def ,[self @ '0] ,[self @ '1] ,[self @ '2] ,[self @ '3] ,[self @ '4])
englishRule        = english rule name->0 name->1 is exprWordsConjs->2
                          <- `(sol-english-rule ,[self @ '0] ,[self @ '1] ,[self @ '2])
englishPhrase      = english phrase exprWords->0 means query->1 respondBy exprWords->2 
                          <- `(sol-english-phrase ,[self @ '0] ,[self @ '1] ,[self @ '2])
actionRun          = name->0 do name->1 value*->2
		          <- `(sol-action-run ,[self @ '0] ,[self @ '1] ,[self @ '2] ,sol-actual) 
goalCheck          = is name->0 name->1 value*->2 satisfiable
		          <- `(sol-goal-check ,[self @ '0] ,[self @ '1] ,[self @ '2]) 
goalRun            = name->0 satisfy name->1 value*->2
		          <- `(sol-goal-run ,[self @ '0] ,[self @ '1] ,[self @ '2]) 
setOpt             = 'set-opt' endWord name->0 value->1
		          <- `(sol-set-opt ,[self @ '0] ,[self @ '1]) 

higherOrderCmd     = for genListOrSetToBe->0 do (createObj | makeObj | query)->1
                          <- `(sol-for ,sol-all ,[self @ '0] ,[self @ '1])

sentence           = startWorld | contWorld | createObj | groupObjs | makeObj | qualify 
  		   | relQualify | actionDef | actionRuleDef | goalDef | goalHeuristicDef 
		   | englishDef | actionRun | goalCheck | goalRun | higherOrderCmd
		   | setOpt | query 
program            = spaces ( sentence 
		     	    	  <- (let () [result println]
				     	     (let ((value [result solEval]))
					  [value printlnMe])) dot spaces 
						  | !theEnd error )* 
				  spaces theEnd
                          <- '0

} name: 'sol]

;; load user program
(if programFileName
    (load programFileName)
    '0)
