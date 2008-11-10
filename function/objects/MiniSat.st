
"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;											     ;;;
;;;  MiniSat - implements MiniSAT satisfiablity solver for COLA   			     ;;;
;;;            ( by Niklas Eén, Niklas Sörensson - http://minisat.se/ )                      ;;;
;;;  					                                                     ;;;
;;;                                                               			     ;;;
;;; Author:        Hesam Samimi                                   			     ;;;
;;;                                                               			     ;;;
;;; Revision:      # 1.0                                      			             ;;;
;;; Last Update:   11-08-2008								     ;;; 
;;;                                                               			     ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;
;;;  Input: a satisfiability problem in CNF (OrderedCollection of 'clauses')
;;;
;;;           each clause is expressed as an Array of 'literals'
;;;	      each literal is expressed as a 'variable' or its negation
;;;	      each variable is expressed as just a natural number
;;; 
;;; Output: -if UNSATISFIABLE: nil
;;;               SATISFIABLE: true. 
;;;                            [ MiniSat model ] will contain a model (a satisfiable assignment) 
;;;			       [ MiniSat printModel ] will print the model
;;;
;;;
;;; Module: MiniSat
;;;
;;; Methods: [ MiniSat new ]                   <---- constructor
;;;          [ MiniSat addClause: clause ]     <---- adds clauses (and simplifies when possible)
;;;          [ MiniSat solve ]                 <---- solve the satisfiability problem
;;;          [ MiniSat simplify ]              <---- reduce the problem given current assignments
;;;          [ MiniSat model ]                 <---- will contain a model (solution) if exists
;;;          [ MiniSat printModel ]            <---- print the above 
;;;
;;; e.g.:
;;;
;;;    ~X1 V X3 V ~X5                                 [ [ -1,  3, -5 ], 
;;;    ~X2 V ~X4 V X5                                   [ -2, -4,  5 ],
;;;    ~X1 V X2 V ~X4          ======>                  [ -1,  2, -4 ],
;;;    ~X3 V X4 V ~X5                                   [ -3,  4, -5 ],
;;;    X2 V X3 V ~X4 V X5                               [  2,  3, -4, 5 ],
;;;    ~X2 V ~X3                                        [ -2, -3 ],
;;;    X2                                               [  2 ] ]
;;;
;;;                              out: [ nil, _object, nil, _object, _object ] 
;;;                                   which means one solution is:
;;;                                   X1 = false, X2 = True, X3 = False, X4 = True, X5 = True
;;;

"

{ import: Objects }
{ import: Random }

MiniSat : Object ( ok model conflict clauses learnts clauseIncr activity varIncr watches assigns polarity decisionVar trail trailLim reason level qHead simpDBAssigns orderHeap randomSeed progressEstimate removeSatisfied seen varDecay clauseDecay randomVarFreq restartFirst restartIncr learntSizeFactor learntSizeIncr simpDBProps learntsLiterals clausesLiterals analyzeToClear )
SatClause : Object ( literals learnt activity abstraction )
SatLiteral : Object ( var sign index watchIndex )


" Globals "
vUndef := [ -1 ]
litError := [ 0 ]
lTrue := [ true ]
lFalse := [ false ]
lUndef := [ -1 ]
randomGen := [ Random new ]
polarityFalse := [ 1 ]

" Parameters "
polarityMode := [ polarityFalse ]
expensiveCCMin := [ true ]

"fixme: assumptions not yet "
MiniSat solve
[
   | numConflicts numLearnts status |
   '---------------------------------------------------' putln. 'solving...' putln.
   model := OrderedCollection new.
   conflict := OrderedCollection new.
   ok ifFalse: [ '<- ok is false... unsat ' putln. ^false ].
   numConflicts := restartFirst.
   numLearnts := self nClauses * learntSizeFactor.
   status := lUndef.
   " search... "
   [ status == lUndef ] whileTrue:
     [ status := self search: ( Array with: numConflicts with: numLearnts ).
       numConflicts := numConflicts * restartIncr.
       numLearnts := numLearnts * learntSizeIncr
     ].
   ( status == lTrue )
      ifTrue: [ " extend & copy model " 
		"fixme"
		'copying model: ' put. assigns println.
		model := assigns copy.
		self verifyModel
              ]
     ifFalse: [ ( status == lFalse ) ifFalse: [ ^self error: 0 ].
		conflict size == 0 ifTrue: [ ok := false ]
              ].
    self cancelUntil: 0.
   '<- ...done solving (status=' put. status print. ')' putln. 
    ^status == lTrue
]

"/*_________________________________________________________________________________________________
|
|  search : (nof_conflicts : int) (nof_learnts : int) (params : const SearchParams&)  ->  [lbool]
|  
|  Description:
|    Search for a model the specified number of conflicts, keeping the number of learnt clauses
|    below the provided limit. NOTE! Use negative value for 'nof_conflicts' or 'nof_learnts' to
|    indicate infinity.
|  
|  Output:
|    'l_True' if a partial assigment that is consistent with respect to the clauseset is found. If
|    all variables are decision variables, this means that the clause set is satisfiable. 'l_False'
|    if the clause set is unsatisfiable. 'l_Undef' if the bound on number of conflicts is reached.
|________________________________________________________________________________________________"
MiniSat search: opts
[   | numConflicts numLearnts backTrackLevel conflCtr theFirst learntClause analyzeRes next c |
   '---------------------------------------------------' putln. 'searching...' putln.
    numConflicts := opts at: 0.
    numLearnts := opts at: 1.
    conflCtr := 0.
    ok ifFalse: [ ^self error: 1 ].
    theFirst := true.
    [ true ] whileTrue:
      [ | confl |
	confl := self propagate.
	confl == nil 
          ifFalse: [ " conflict "
		     'in search - propagate returned a conflict!' putln.
		     conflCtr := conflCtr + 1.
		     self decisionLevel == 0 ifTrue: [ '<- conflict at level=0, unsat! false' putln. ^lFalse ].
		     theFirst := false.
		     analyzeRes := self analyze: confl.
		     learntClause := analyzeRes at: 0.
		     backTrackLevel := analyzeRes at: 1.
		     self cancelUntil: backTrackLevel.
		     ( self isLitUndef: ( learntClause literals first ) ) ifFalse: [ ^self error: 2 ].
		     ( learntClause literals size == 1 )
		       ifTrue: [ self uncheckedEnqueue: learntClause literals first ]
		      ifFalse: [ c := SatClause literals: learntClause literals learnt: true.
                                 learnts add: c.
                                 self attachClause: c.
				 self clauseBumpActivity: c.
				 'reason is ' put. c printlnMe.
				 self uncheckedEnqueue: ( learntClause literals first ) reason: c
		               ].
		      self varDecayActivity.
		      self clauseDecayActivity
	           ]
	   ifTrue: [ " no conflict "
		     'in search - propagate returned no conflicts' putln.
		     ( numConflicts >= 0 and: [ conflCtr >= numConflicts ] ) 
		       ifTrue: [ progressEstimate := self progressEstimate.
				 self cancelUntil: 0.
				 '<- no conflict: undef' putln.
				 ^lUndef
                               ].
		     " simplify the set of problem clauses "
		     ( self decisionLevel == 0 and: [ ( self simplify ) not ] ) ifTrue: [ '<- :false' putln. ^lFalse ].
		     " reduce the set of learnt clauses "
		     ( numLearnts >= 0 and: [ ( learnts size - self nAssigns ) >= numLearnts ] ) 
		       ifTrue: [ self reduceDB ].
		     next := lUndef.
		     "fixme: assumptions not supported yet "
		     ( next == lUndef ) ifTrue:
		       [ next := self pickBranchLit: polarityMode rndVarFreq: randomVarFreq.
			 ( next == lUndef ) ifTrue: [ " model found " '<- model found: true' putln. ^lTrue ]
		       ].
		     "  Increase decision level and enqueue 'next' "
		     ( self isLitUndef: next ) ifFalse: [ ^self error: 3 ].
		     self newDecisionLevel.
		     self uncheckedEnqueue: next
	           ]
      ]
]

" _________________________________________________________________________________________________
|
|  propagate : [void]  ->  [Clause*]
|  
|  Description:
|    Propagates all enqueued facts. If a conflict arises, the conflicting clause is returned,
|    otherwise NULL.
|  
|    Post-conditions:
|      * the propagation queue is empty, even if there was a conflict.
|________________________________________________________________________________________________ "
MiniSat propagate
[ 
    | lit ws notLit clLits confl cntr watchNotFound clsCntr watchesToRemove numProps noConfl clause | 
    " wacthed are arrays of array of clauses (one clause array for each literal) 
      ws : clauses watching the literal "
    noConfl := true.
    confl := nil.
    numProps := 0.
    '---------------------------------------------------' putln.
    'propagating... (trail=' put. trail printMe. ')' putln.
    self printDecisionQueue.	
    [ qHead < trail size ] whileTrue:
      [ lit := trail at: qHead.
	qHead := qHead + 1.
        ws := self watchesOfLit: lit.
        'literal ' put. lit printMe. ' has watches: ' putln. ws printlnMe.
	numProps := numProps + 1.
	clsCntr := 0.
	"keeps track of indeces of unit/sat clauses which should be removed from watch list:"
        watchesToRemove := OrderedCollection new. 
	[ noConfl and: [ clsCntr < ws size ] ] whileTrue:     
          [ clause := ws at: clsCntr.
            " make sure false literal is 2nd "
	    'now looking at clause ' put. clause printlnMe.
	    notLit := lit negated.
	    clLits := clause literals.
	    ( ( clLits at: 0 ) eq: notLit ) ifTrue:
              [ 'oops: negated literal ( ' put. notLit printMe. ' ) is first. switching it with 2nd...' putln.
	        clLits at: 0 put: (clLits at: 1).
                clLits at: 1 put: notLit 
	      ].
	    " If 0th watch is true, then clause is already satisfied "
            'checking if 0th watch ( ' put. ( clLits at: 0 ) printMe. ' ) is true...' putln.
            ( self isLitTrue: ( clLits at: 0 ) ) 
	       ifTrue: [ "fixme" '0th watch is true, clause (#' put. clsCntr print. ') is satisfied... removing' putln. 
			watchesToRemove add: clsCntr 
		       ]
	      ifFalse: [ "look for new watch" 
			 'looking for a new watch...' putln.
		         cntr := 2.
			 watchNotFound := true.
			 [ cntr < clLits size and: [ watchNotFound ] ] whileTrue:
			   [ ( self isLitFalse: ( clLits at: cntr ) ) ifFalse:
			     [ clLits at: 1 put: (clLits at: cntr ).
			       clLits at: cntr put: notLit. 
			       ( self watchesOfLit: ( (clLits at: 1) negated ) ) add: clause.
			       ' found one: ' put. (clLits at: 1) printlnMe. 
			       watchNotFound := false
			     ].
			   cntr := cntr + 1  
		         ].
			 watchNotFound ifTrue:
			   [ "did not find watch: clause is unit under assignment "
			     'did not find one: clause is unit under assignment... removing' putln.
			     watchesToRemove add: clsCntr.
			     ( self isLitFalse: ( clLits at: 0 ) ) 
			       ifTrue: [ confl := clause.
				         qHead := trail size.
			                 noConfl := false.
					 '0th literal is false, we have a conflict: we should copy remining watches and go. conflict:' put. confl printlnMe.
				       ]
			       ifFalse: [ self uncheckedEnqueue: ( clLits at: 0 ) reason: clause ].
			    ]
		       ].
		  clsCntr := clsCntr + 1
          ].
	  ws removeAtIndeces: watchesToRemove.
    ].
    simpDBProps := simpDBProps - numProps.
    '<- ...done propagating' put. 
    confl ifTrue: [ '(conflict=' put. confl printMe. ')' putln ] ifFalse: [ '(no conflict)' putln ].
    self printDecisionQueue.
    ^confl
]


"_________________________________________________________________________________________________
|
|  simplify : [void]  ->  [bool]
|  
|  Description:
|    Simplify the clause database according to the current top-level assigment. Currently, the only
|    thing done here is the removal of satisfied clauses, but more things can be put here.
|________________________________________________________________________________________________"
MiniSat simplify
[
    '---------------------------------------------------' putln.
    'simplifying... (ok=' put. ok print. ')' putln.
    self decisionLevel == 0 ifFalse: [ ^self error: 4 ].
    " if already in a conflict, return false "
    ( ok and: [ self propagate == nil ] ) ifFalse: 
      [ ok := false. 
	'<- already in a conflict... ok = false' putln.
        ^ok ].
    ( self nAssigns == simpDBAssigns or: [ simpDBProps > 0 ] ) ifTrue:
      [ '<- true' putln. ^true ].
    " remove satisfied clauses "
    self removeSatisfied: learnts.
    self removeSatisfied: clauses.
    " remove fixed variables from the variable heap "
    "fixme"
    simpDBAssigns := self nAssigns. 
    'simpDBAssigns=' put. simpDBAssigns println.
    simpDBProps := clausesLiterals + learntsLiterals.  " (shouldn't depend on stats really, but it will do for now)"
    '<- ...done simplifying: true ' putln.
    ^true
]

"_________________________________________________________________________________________________
|
|  reduceDB : ()  ->  [void]
|  
|  Description:
|    Remove half of the learnt clauses, minus the clauses locked by the current assignment. Locked
|    clauses are clauses that are reason to some assignment. Binary clauses are never removed.
|________________________________________________________________________________________________"
MiniSat reduceDB
[
    | extraLim removeIdxs i |
    removeIdxs := OrderedCollection new.
    extraLim := clauseIncr / learnts size.
    learnts sortContents.
    i := 0.
    [ i < ( learnts size / 2 ) ] whileTrue: 
      [ | cls |
	cls := learnts at: i.
	( cls literals size > 2 and: [ ( self isClauseLocked: cls ) not ] ) 
	  ifTrue: [ self removeClause: cls.
		    removeIdxs add: i
	          ].
        i := i + 1 
      ].
    [ i < learnts size ] whileTrue:
      [ | cls |
	cls := learnts at: i.
	( cls literals size > 2 and: [ ( ( self isClauseLocked: cls ) not ) and: 
	                               [ cls activity < extraLim ] ] )
	  ifTrue: [ self removeClause: cls.
	            removeIdxs add: i 
	          ].
	i := i + 1  
      ].
   learnts removeAtIndeces: removeIdxs 
]

"_________________________________________________________________________________________________
|
|  analyze : (confl : Clause*) (out_btlevel : int&)  ->  [void]
|  
|  Description:
|    Analyze conflict and produce a reason clause.
|  
|    Pre-conditions:
|      * 'out_learnt' is assumed to be cleared.
|      * Current decision level must be greater than root level.
|  
|    Post-conditions:
|      * 'out_learnt[0]' is the asserting literal at level 'out_btlevel'.
|  
|  Effect:
|    Will undo part of the trail, upto but not beyond the assumption of the current decision level.
|________________________________________________________________________________________________"
MiniSat analyze: confl
[
    | pathC p index backTrackLevel newLoop learntClause removeIdxs abstLevel idx 
      varIdx var cls pVarIdx max i litp |
    '---------------------------------------------------' putln.
    'analyzing conflict... (conflict=' put. confl printMe. ')' putln.
    self printDecisionQueue.
    learntClause := SatClause literals: ( OrderedCollection new ) learnt: true.
    newLoop := true.
    pathC := 0.
    p := lUndef.
    " generate conflict clause "
    index := trail size - 1.
    backTrackLevel := 0.
    [ newLoop or: [ pathC > 0 ] ] whileTrue: 
      [ newLoop := false.
        " otherwise should be UIP "
	( confl == nil ) ifTrue: [ ^self error: 5 ].
        cls := confl.
	( cls learnt ) ifTrue: [ self clauseBumpActivity: cls ].
	( cls literals copyFrom: ( ( p == lUndef ) ifTrue: [ 0 ] ifFalse: [ 1 ] ) ) do: 
	  [:lit |
	    var := lit var.
	    varIdx := self varIndex: var.
	    ( ( seen at: varIdx ) or: [ ( level at: varIdx ) <= 0 ] ) ifFalse:
	      [ self varBumpActivity: var.
		seen at: varIdx put: true.
		( ( level at: varIdx ) >= self decisionLevel ) 
		  ifTrue: [ pathC := pathC + 1 ]
		  ifFalse: [ ( learntClause literals ) add: lit. 
			     ( ( level at: varIdx ) > backTrackLevel ) ifTrue:  
			       [ backTrackLevel := ( level at: varIdx ) ]
		           ].
	      ].
          ].
	" select next clause to look at "
	[ seen at: ( self varIndex: ( trail at: index ) var ) ] whileFalse:
	  [ index := index - 1 ].
	index := index - 1.
        p := trail at: ( index + 1 ).
        pVarIdx := self varIndex: ( p var ).
	confl := reason at: pVarIdx.
	'setting conflict to ->' put. confl ifTrue: [ confl printlnMe ] ifFalse: [ '' putln ].
	seen at: pVarIdx put: false.
	pathC := pathC - 1.
	'pathC=' put. pathC println.
    ]. 
        'hi' putln.
    'learned now: ' put. learntClause printlnMe.
    " 0th lit is the asserting literal at backtracklevel: "
    ( learntClause literals size == 0 )
      ifTrue: [ ( learntClause literals ) add: ( p negated ) ] 
      ifFalse: [ ( learntClause literals ) at: 0 put: ( p negated ) ].
    " simplify conflict clause "
    removeIdxs := OrderedCollection new.
    expensiveCCMin
       ifTrue: [ abstLevel := 0. 
		 " maintain an abstraction of levels involved in conflict "
		 ( learntClause literals copyFrom: 1 ) do: 
		   [:lit | abstLevel == 0 ifTrue: [ abstLevel := self abstractLevelOfVar: (lit var) ] ].
		   analyzeToClear := learntClause.
		   idx := 1.
		   ( learntClause literals copyFrom: 1 ) do: 
		     [:lit |
		       varIdx := self varIndex: ( lit var ).
		       ( ( reason at: varIdx ) == nil or: 
		         [ self litRedundant: lit abstractionLevels: abstLevel ] ) ifFalse:
		           [ removeIdxs add: idx ].
		       idx := idx + 1.	 
		     ]
	       ]
      ifFalse: [ analyzeToClear := learntClause.
		 ( learntClause literals copyFrom: 1 ) do: 
		   [:lit |
		     varIdx := self varIndex: ( lit var ).
		     cls := reason at: varIdx.
		     idx := 1.	 
		     ( cls literals copyFrom: 1 ) do:
		       [:lp | 
			 ( ( seen at: ( self varIndex: ( lp var ) ) ) or: 
			     [ level at: ( self varIndex: ( lp var ) ) <= 0 ] ) ifTrue:
			  [ removeIdxs add: idx ]. "fixme"
			  idx := idx + 1.
		       ]
		   ]
               ].
    learntClause literals removeAtIndeces: removeIdxs.
    " find correct backtrack level "
    ( learntClause literals size == 1 )
       ifTrue: [ backTrackLevel := 0 ]
      ifFalse: [ max := 1.
		 i := 2.
		 ( learntClause literals copyFrom: 2 ) do:
		   [:lit | 
		     ( ( level at: ( self varIndex: ( lit var ) ) ) > 
		       ( level at: ( self varIndex: ( ( learntClause literals at: max ) var ) ) ) )
		       ifTrue: [ max := i ].
		     i := i + 1.
		   ].
		 litp := learntClause literals at: max.
		 learntClause literals at: max put: ( learntClause literals at: 1 ).
		 learntClause literals at: 1 put: litp.
		 backTrackLevel := level at: ( self varIndex: ( litp var ) )
               ].
    analyzeToClear literals do: [:lit | seen at: ( self varIndex: ( lit var ) ) put: false ].
    " seen array is now cleared "
    '<- ...done analyzing. learnt clause: ' put. learntClause printMe. ' btlevel: ' put. backTrackLevel println.
    ^Array with: learntClause with: backTrackLevel.
]

MiniSat verifyModel
[
    "fixme"
    ^true
]

MiniSat error: num
[
    'ERROR from ' put. num println.	
    ^(-1)
]

MiniSat new
[
    varDecay := 1 / 0.95.
    clauseDecay := 1 / 0.999.
    randomVarFreq := 2. "2%"
    restartFirst := 100.
    restartIncr := 1.5.
    learntSizeFactor := 1 / 3.
    learntSizeIncr := 1.1.
    ok := true.
    clauseIncr := 1.
    varIncr := 1.
    qHead := 0.
    simpDBAssigns := -1.
    simpDBProps := 0.
    orderHeap := IdentityDictionary new. "fixme : Heap"
    randomSeed := 91648253.
    progressEstimate := 0.
    removeSatisfied := true.
    clausesLiterals := 0. 
    learntsLiterals := 0.
    clauses := OrderedCollection new.
    learnts := OrderedCollection new.
    activity := OrderedCollection new.
    watches := OrderedCollection new.
    assigns := OrderedCollection new.
    polarity := OrderedCollection new.
    decisionVar := OrderedCollection new.
    trail := OrderedCollection new.
    trailLim := OrderedCollection new.
    reason := OrderedCollection new.
    level := OrderedCollection new.
    seen := OrderedCollection new.
]

MiniSat newVar
[
    | vIdx |
    vIdx := self nVars.
    watches add: ( OrderedCollection new ).
    watches add: ( OrderedCollection new ).
    reason add: 0.
    assigns add: lUndef.
    level add: -1.
    activity add: 0.
    seen add: false.
    polarity add: true.
    decisionVar add: true.
    self insertVarOrder: vIdx.
    ^vIdx
]

MiniSat insertVarOrder: varIdx
[
    ( ( ( orderHeap includesKey: varIdx ) not ) and: [ decisionVar at: varIdx ] )
        ifTrue: [ orderHeap at: varIdx put: varIdx ] "fixme"
]

MiniSat watchesOfLit: lit
[
    ^watches at: ( lit watchIndex )
]

MiniSat attachClause: cl
[
    'attaching clause: ' put. cl printlnMe.
    cl size > 1 ifFalse: [ ^self error: 6 ].
    ( self watchesOfLit: ( ( cl literals at: 0 ) negated ) ) add: cl.
    ( self watchesOfLit: ( ( cl literals at: 1 ) negated ) ) add: cl.
    cl learnt ifTrue: [ learntsLiterals := learntsLiterals + cl size ]
             ifFalse: [ clausesLiterals := clausesLiterals + cl size ]
]
   
MiniSat detachClause: cl
[
    cl size > 1 ifFalse: [ ^self error: 7 ].
    "fixme"
    ( self watchesOfLit: ( ( cl literals at: 0 ) negated ) ) remove: cl ifAbsent: [ nil ].
    ( self watchesOfLit: ( ( cl literals at: 1 ) negated ) ) remove: cl ifAbsent: [ nil ].
    cl learnt ifTrue: [ learntsLiterals := learntsLiterals - cl size ]
             ifFalse: [ clausesLiterals := clausesLiterals - cl size ]
] 

MiniSat readClause: ints
[
    | var lit literals |
    literals := OrderedCollection new.
    ints do: [:int | var := int abs - 1.
                     [ var >= self nVars ] whileTrue: [ self newVar ].
                     lit := SatLiteral int: int.
                     literals add: lit ].
    ^literals
]

" ints is a collection of variables "
MiniSat addClause: ints
[
    | literals c i j litPrev |
    literals := self readClause: ints.
	
    self decisionLevel == 0 ifFalse: [ ^self error: 8 ].
    ok ifFalse: [ ^false ].
    " Check if clause is satisfied and remove false/duplicate literals: " 
    'adding : ' put.
    literals sortContents.
    i := 0.
    j := 0.
    litPrev := lUndef.
    literals printlnMe.
    " normalize cluase "
    literals do: [:lit |   " clause is true if any literal is true, or
                             there are any negation pairs of literals " 

		           ( ( self isLitTrue: lit ) or: 
		           [ litPrev ~= lUndef ifTrue: [ self isLit: lit NegationOfLit: litPrev ]
				              ifFalse: [ false ] ] )
			     ifTrue: [^true]
		            ifFalse: 
			       [ " remove false and duplicate literals "
				 ( self isLitUndef: lit ) ifTrue: 
				   [ litPrev == lUndef 
					ifTrue: [ litPrev := lit.
				                  literals at: j put: ( literals at: i ).
				                  j := j + 1.  ]
				       ifFalse: [ ( lit eq: litPrev ) ifFalse: 
						    [ litPrev := lit.
						     literals at: j put: ( literals at: i ).
			                             j := j + 1 ] ] ] ].
	                 i := i + 1 ].
    literals removeLastN: ( i - j ).
    literals isEmpty ifTrue: [ ok := false. 
			       '! conflict: this clause is unsat' putln.   
	                       ^false ].
    literals size == 1 ifTrue: [ 'this is a unit clause, will just propagate it (unit resolution)' putln.
				 self uncheckedEnqueue: ( literals at: 0 ). 
                                 ok := ( self propagate == nil ).
                                 ^ok ]
                      ifFalse: [ c := SatClause literals: literals learnt: false.
                                 clauses add: c.
                                 self attachClause: c ].
    'added clause: ' put.
    c printlnMe.
    ^true
]

MiniSat removeClause: clause
[
   self detachClause: clause
]

MiniSat printDecisionQueue
[
    'decision queue: [ ' put. trail printMe. '] ( level=' put.
    self decisionLevel print. ' )' putln
]

MiniSat printClauses
[
    'clauses: [ ' put. clauses printMe. ']' putln
]

MiniSat printSummary
[
    self printDecisionQueue.
    self printClauses.
    '' putln
]

MiniSat printWatches
[
    | i | 
    i := 1.
    watches do: [:wc | 'watches of ' put. i println. wc printlnMe. 
                       i := i * -1. i > 0 ifTrue: [ i := i + 1 ]. ]
]

MiniSat printModel
[ | i |
   model size == 0 
      ifTrue: [ 'UNSAT' putln ]
     ifFalse: [ 'SAT' putln.
		'[ ' put.
                i := 1.
		model do: [:val | val ifTrue: [ i print ] ifFalse: [ '-' put. i print ]. ' ' put.
		            i := i + 1 
                          ].
                ']' putln 
              ]
]

" "
MiniSat analyzeFinal
[

]

" backtrack to the state at given level (keeping all assignment at 'level' but not beyond) "
MiniSat cancelUntil: toLevel
[ ( self decisionLevel > toLevel ) ifTrue:
    [ | c vIdx |
      c := trail size - 1.
      [ c >= ( trailLim at: toLevel ) ] whileTrue:
	[ vIdx := self varIndex: ( ( trail at: c ) var ).
	  assigns at: vIdx  put: lUndef.
          self insertVarOrder: vIdx.
	  c := c - 1.
	].

      qHead := trailLim at: toLevel.
      trail removeLastN: ( trail size - ( trailLim at: toLevel ) ).
      trailLim removeLastN: ( trailLim size - toLevel )
    ]
]

MiniSat progressEstimate
[
    | progress f i |
    progress := 0.
    f := 1.0 / self nVars.
    i := 0.
    [ i <= self decisionLevel ] whileTrue:
      [ | beg end |
	beg := ( i == 0 ) ifTrue: [ 0 ] ifFalse: [ trailLim at: ( i - 1 ) ].
	end := ( i == self decisionLevel ) ifTrue: [ trail size ] ifFalse: [ trailLim at: i ].
	progress := progress + ( f exp: i ) * ( end - beg ).
	i := i + 1  
      ].
    ^progress / self nVars
]

" Check if 'p' can be removed. 'abstract_levels' is used to abort early if the algorithm is
  visiting literals at levels that cannot be removed later "
MiniSat litRedundant: litp abstractionLevels: abstLevels
[
    | stk top varIdx |
    stk := OrderedCollection new.
    stk add: litp.
    top := analyzeToClear literals size.
    [ stk size > 0 ] whileTrue: 
      [ | cls |
	( reason at: ( self varIndex: stk last var ) ) == nil ifTrue: [ ^self error: 9 ].
        cls := reason at: ( self varIndex: stk last var ).
	stk removeLast.
	( cls literals copyFrom: 1 ) do:
	  [:lit |
	     varIdx := self varIndex: ( lit var ).
	     ( ( seen at: varIdx ) or: [ ( level at: varIdx ) <= 0 ] ) ifFalse: 
	         [ ( ( ( reason at: varIdx ) == nil ) and: [ ( ( self abstractLevelOfVar: ( lit var ) ) bitAnd: abstLevels ) == 0 ] ) "fixme"
		    ifTrue: [ ( ( analyzeToClear literals ) copyFrom: top ) do: 
				[:p | seen at: ( self varIndex: ( p var ) ) put: false ].
			      ( analyzeToClear literals ) removeLastN: ( analyzeToClear literals size - top ).
			      ^false
		            ] 
		   ifFalse: [ seen at: ( self varIndex: ( lit var ) ) put: true.
		              stk add: lit.
			      ( analyzeToClear literals ) add: lit
		            ]. 
	         ]
	  ]
      ].
    ^true
]

" increase a clause with the current 'bump' value "
MiniSat clauseBumpActivity: clause
[
    clause setActivity: ( clause activity + clauseIncr ).
    "fixme: 1e20 instead?"
    clause activity > 100 ifTrue: 
      [ "rescale"
	"fixme: 1e-20 instead?"
	learnts do: [:lrnt | lrnt setActivity : ( lrnt activity * 0.01 ) ].
        clauseIncr := clauseIncr * ( 0.01 ).
      ]
]

" decay all clauses with the specified factor. Implemented by increasing the 'bump' value instead "
MiniSat clauseDecayActivity
[
    clauseIncr := clauseIncr * clauseDecay
]

" increase a variable with the current 'bump' value "
MiniSat varBumpActivity: var
[
    | varIdx i |
    i := 0.
    varIdx := self varIndex: var.
    activity at: varIdx put: ( ( activity at: varIdx ) + varIncr ). 
    "fixme: 1e20 instead?"
    ( activity at: varIdx ) > 100 ifTrue:
      [ "rescale"
	"fixme: 1e-20 instead?"
	[ i < self nVars ] whileTrue: 
	  [ activity at: i put: ( ( activity at: i ) * ( 0.01 ) ). 
	    i := i + 1
	  ].
        varIncr := varIncr * ( 0.01 ).
      ].
    " update orderHeap with respect to new activity "
    ( orderHeap includesKey: varIdx ) ifTrue: [ orderHeap decrease: varIdx ]
]

" decay all variables with the specified factor. Implemented by increasing the 'bump' value instead" 
MiniSat varDecayActivity
[
    varIncr := varIncr * varDecay
]

MiniSat randomIntLessThan: n
[
    randomGen next.
    ^randomGen nextInt: n
]

" picks a value for an unassigned literal "
MiniSat pickBranchLit: thePolarityMode rndVarFreq: rndFrq
[
    | next sign isRnd modelNotFound |
    '---------------------------------------------------' putln.
    'picking a value for a literal...' putln.
    next := vUndef.
    sign := true.
    isRnd := false.
    modelNotFound := true.
    " random decision "
    ( ( self randomIntLessThan: 100 ) < randomVarFreq and: [ orderHeap isEmpty not ] ) ifTrue:
      [ 
          isRnd := true.
	  'random decision' putln.
	  next := orderHeap at: ( orderHeap keys at: ( self randomIntLessThan: ( orderHeap keys size ) ) )
      ].
    " activity-based decision "
    isRnd ifFalse: [ 'activity-based decision: removing min out of order heap' putln ].
    [ ( ( next == vUndef or: [ ( assigns at: next ) ~= lUndef ] ) 
      or: [ ( decisionVar at: next ) not ] ) and: [ modelNotFound ] ] whileTrue:
        [ orderHeap isEmpty 
	    ifTrue: [ next := vUndef. modelNotFound := false ]
	    ifFalse: [ next := orderHeap removeMin ]
        ].
	'picked var: ' put. ( self indexVar: next ) println.
    ^next == vUndef ifTrue: [ lUndef ] ifFalse: [ SatLiteral var: ( self indexVar: next ) sign: sign ]

]

" removes satisfied clauses "
MiniSat removeSatisfied: cs
[ 
    | removeIdxs i |
    removeIdxs := OrderedCollection new.
    i := 0.
    cs do: [:clause | ( clause satisfied: self ) ifTrue: [ removeIdxs add: i. 
							   self removeClause: clause ].
	              i := i + 1 ].
    'clause:' putln.
    cs printlnMe.
    'sat lits:' putln.
    removeIdxs println.
    cs removeAtIndeces: removeIdxs
]

MiniSat isLitUndef: lit
[
    ^( self valueOfLit: lit ) == lUndef 
]

MiniSat isLitTrue: lit
[
    ^( self valueOfLit: lit ) == lTrue
]

MiniSat isLitFalse: lit
[
    ^( self valueOfLit: lit ) == lFalse
]

MiniSat isVarUndef: var
[
    ^( self valueOfVar: var ) == lUndef 
]

MiniSat isLit: lit1 NegationOfLit: lit2
[
    ^( lit1 var == lit2 var ) and: [ ( lit1 sign and: [ lit2 sign not ] ) or: 
                                   [ lit2 sign and: [ lit1 sign not ] ] ]
]

"Enqueue a literal. Assumes value of literal is undefined."
MiniSat uncheckedEnqueue: lit reason: from
[
    | idx negated |
    ( self valueOfLit: lit ) == lUndef ifFalse: [ ^self error: 10 ]. 
    '|-> assigning <true> to literal: ' put.
    lit printMe.  ' ( decision level=' put.
    self decisionLevel print. ' )' putln.
    idx := lit index.
    negated := lit sign.
    assigns at: idx put: negated not.
    level at: idx put: self decisionLevel.
    reason at: idx put: from.
    trail add: lit
]

MiniSat uncheckedEnqueue: lit
[
    ^self uncheckedEnqueue: lit reason: nil
]

MiniSat clauses
[
    ^clauses
]

MiniSat conflict
[
    ^conflict
]

MiniSat model
[
    ^model
]

MiniSat decisionLevel
[
    ^trailLim size
]

MiniSat newDecisionLevel
[
    trailLim add: ( trail size )
]

MiniSat isClauseLocked: clause
[
    | varIdx lit |
    lit := clause literals first.	
    varIdx := self varIndex: ( lit var ).
    ^( ( ( reason at: varIdx ) == clause ) and: [ self isLitTrue: lit ] )
]

" an abstraction of sets of decision levels " 
MiniSat abstractLevelOfVar: var
[
    "fixme"
    ^self levelOfVar: var
]

MiniSat nAssigns
[
    ^trail size
]

MiniSat nClauses
[
    ^clauses size
]

MiniSat nVars
[
    ^assigns size
]

"returns--> lUndef: if unassigned, true: if true, false: if false "
MiniSat valueOfLit: lit
[
    | idx negated val |
    idx := lit index.
    val := assigns at: idx.
    val == lUndef ifTrue: [ ^lUndef ] ifFalse: [ negated := lit sign.
					         negated ifTrue: [ ^val not ] 
                                                        ifFalse: [ ^val ] ]
]

MiniSat varIndex: var
[
    ^var - 1
]

MiniSat indexVar: idx
[
    ^idx + 1
]


MiniSat valueOfVar: var
[
    ^assigns at: ( self varIndex: var )
]

MiniSat levelOfVar: var
[
    ^level at: ( self varIndex: var )
]

SatClause literals: lits learnt: isLearnt
[
    self := super new.
    literals := lits.
    learnt := isLearnt.
    isLearnt ifTrue: [ activity := 0 ] ifFalse: [ self calcAbstraction ]. 
    ^self
]

SatClause satisfied: solver
[
   self literals do: [:lit | ( solver isLitTrue: lit ) ifTrue: [ ^true ] ].
   ^false
]

SatClause calcAbstraction
[
    abstraction := 0.
    literals do: [:lit | abstraction == 0 ifTrue: [ abstraction := 1 ]  ]. "fixme"
]

SatClause learnt
[
    ^learnt
]

SatClause activity
[
    ^activity
]

SatClause setActivity: act
[
    activity := act
]


SatClause literals
[
    ^literals
]

SatClause size
[
    ^literals size
]

Object printlnMe
[
    self printMe.
    '' putln
]

SatClause printMe
[
    '[ ' put. literals printMe. ']' put.
]

SatLiteral signedVar
[
   ^sign ifTrue: [ -1 * var ] ifFalse: [ var ]
]

SatLiteral printMe
[
   self signedVar print.
   
]

OrderedCollection printMe
[
    self do: [:elm | elm printMe. 
                     String space put ]
]

" removes given indeces (assumed odered) from collection " 
OrderedCollection removeAtIndeces: idxs
[
     | idxFix |
     idxFix := 0.
     idxs do: [:idx | self removeAtIndex: (idx - idxFix). idxFix := idxFix + 1 ]
]

OrderedCollection removeLastN: n
[
    [ n > 0 ] whileTrue: [ self removeLast. 
                           n := n - 1 ]
]

SatLiteral int: int
[
    | v |
    self := super new.
    ^self var: ( int abs ) sign: ( int < 0 )
]

SatLiteral var: v sign: s
[
    self := super new.
    sign := s.
    var := v.
    index := var - 1.
    watchIndex := ( var - 1 ) * 2.
    s ifTrue: [ watchIndex := watchIndex + 1 ].
    ^self
]

SatLiteral negated
[
    ^self int: ( -1 * self signedVar )
]

SatLiteral var
[
    ^var
]

SatLiteral index
[
    ^index
]


SatLiteral watchIndex
[
    ^watchIndex
]

SatLiteral sign
[
    ^sign
]

SatLiteral eq: sl
[
    ^( var == sl var ) and:
     [ sign == sl sign ]
]

SatLiteral < sl
[
    ^var == sl var ifTrue: [ sign not ] ifFalse: [ var < sl var ]
]

SatClause < sc
[
    ^( self literals size > 2 ) and: [ ( sc literals size == 2 ) or: [ activity < sc activity ] ]
]

"fixme: should be heap"
IdentityDictionary isEmpty
[
    ^self keys isEmpty
]

"fixme"
IdentityDictionary decrease: var
[
    ^0
]

IdentityDictionary removeMin
[
    | item key min minKey |
    minKey := self keys first.
    min := self at: minKey.
    ( self keys copyFrom: 1 ) do: [:k | ( ( self at: k ) < min ) ifTrue: [ minKey := k. 
	                                                                   min := self at: k ] ].
    item := self at: minKey.
    self removeKey: minKey ifAbsent: [ ].
    ^item
]


OrderedCollection sortContents
[
    self isEmpty ifFalse: [self sortFrom: 0 to: self size - 1].
]

OrderedCollection sortFrom: index to: limit
[
    | element next |
    element := self at: index.
    index < limit ifFalse: [^element].
    next := self sortFrom: index + 1 to: limit.
    element < next ifTrue: [^element].
    self at: index put: next.
    self at: index + 1 put: element.
    self sortFrom: index + 1 to: limit.
    ^next
]
