{ import: Object }
{ import: Layout }
{ import: LinkedList }
{ import: Link }

{ import: debug }

BGP : Link ( width character )

BGP isBox	[ ^nil ]
BGP isGlue	[ ^nil ]
BGP isPenalty	[ ^nil ]

BGP width	[ ^width ]
BGP character	[ ^character ]

"----------------"

Box : BGP ()

Box isBox	[]

Box withWidth: w character: c
[
    self := self new.
    width := w.
    character := c.
]

Box printOn: aStream
[
    super printOn: aStream.
    aStream nextPut: $(; nextPut: character; nextPut: $)
]

"----------------"

Penalty : BGP ( penalty flag )

Penalty isPenalty	[]

Penalty penalty		[ ^penalty ]
Penalty flag		[ ^flag ]

Penalty withWidth: w penalty: p flag: f
[
    self := self new.
    width := w.
    penalty := p.
    flag := f.
]

"----------------"

Glue : BGP ( stretch shrink )

Glue isGlue	[]

Glue stretch	[ ^stretch ]
Glue shrink	[ ^shrink ]
Glue penalty	[ ^0 ]
Glue flag	[ ^nil ]

Glue withWidth: w stretch: y shrink: z
[
    self := self new.
    width := w.
    stretch := y.
    shrink := z.
]

"----------------"

BGP for: aCharacter
[
    aCharacter <= $  ifTrue: [^Glue withWidth: 1 stretch: 2 shrink: 0].
    ^Box withWidth: 1 character: aCharacter.
]

"----------------------------------------------------------------"

Node : Object (
    position		"index of box for which this is a feasible break"
    line		"line number that this node would break"
    fitness		"0 tight, 1 good, 2 loose, 3 pigeonholed"
    totalwidth		"natural width between this node and previous"
    totalstretch	"stretch between this node and previous"
    totalshrink		"shrink between this node and previous"
    totaldemerits	"total demerits from this node to start of text"
    ratio		"adjustment ratio for line ending at this node"
    previous		"previous break if this one ends a line"
    link		"next Node in a list of Nodes"
)

Node position		[ ^position ]
Node line		[ ^line ]
Node fitness		[ ^fitness ]
Node totalwidth		[ ^totalwidth ]
Node totalstretch	[ ^totalstretch ]
Node totalshrink	[ ^totalshrink ]
Node totaldemerits	[ ^totaldemerits ]
Node ratio		[ ^ratio ]
Node previous		[ ^previous ]
Node link		[ ^link ]

Node link: aNode	[ link := aNode ]

NodeCount := [ 0 ]

Node withPosition: p line: l fitness: f totalwidth: w totalstretch: y totalshrink: z totaldemerits: d ratio: r previous: prev link: next
[
    self := self new.
    position		:= p.
    line		:= l.
    fitness		:= f.
    totalwidth		:= w.
    totalstretch	:= y.
    totalshrink		:= z.
    totaldemerits	:= d.
    ratio		:= r.
    previous		:= prev.
    link		:= link.
    NodeCount := NodeCount + 1.
]

Node printOn: aStream
[
    super printOn: aStream.
    aStream
	nextPut: $(;
	print: position; space;
	print: line; space;
	print: fitness; space;
	print: totalwidth; space;
	print: totalstretch; space;
	print: totalshrink; space;
	print: totaldemerits; space;
	print: ratio;
	nextPut: $).
]

 INFINITY := [ 100000 ]
MINFINITY := [ INFINITY negated ]

TextLayout : Object (
    A		"Node - active node list"
    P		"Node - passive node list"
    SW		"Float - sum of widths so far"
    SY		"Float - sum of stretch so far"
    SZ		"Float - sum of shrink so far"
    a		"Node - current active node during iteration"
    b		"index of current input box/glue/penalty"
    preva	"Node - previous active node during iteration"
    nexta	"Node - next active node during iteration"
    q		"Integer - looseness"
    rho		"Float - tolerance"
    alpha	"Integer - flagged demerit"
    gamma	"Integer - fitness demerit"
    j0		"index of first easy line"
    l		"line length"
    j		"index of a line"
    r		"adjustment ratio"
    d		"demerits"
    c		"fitness class"
    text	"list of boxes/glue/penalties"
    D		"minimum demerit"
    Dc		"Array of demerits by fitness class"
    Ac		"Array of nodes by fitness class"
    Rc		"Array of adjustment ratios by fitness class"
    tw		"total width"
    ty		"total stretch"
    tz		"total shrink"
    k		"line number of best break"
    breaks	"final set of breakpoints"
)

TextLayout on: aString
[
    q		:=	0.	"looseness"
    rho 	:= 1.7321.	"tolerance"
    alpha	:=     50.	"flagged demerit"
    gamma	:=    100.	"fitness demerit"
    text	:= LinkedList new.
    l		:=  #(80).	"line length(s)"
    j0		:= q == 0 ifTrue: [l size] ifFalse: [INFINITY].	"last non-easy line number"
    Ac		:= Array new: 4.
    Dc		:= Array new: 4.
    Rc		:= Array new: 4.
    aString do: [:ch | text add: (BGP for: ch)].
    text
	add: (Penalty withWidth: 0 penalty:  INFINITY flag:   nil);
	add: (Glue    withWidth: 0 stretch:  INFINITY shrink: 0);
	add: (Penalty withWidth: 0 penalty: MINFINITY flag:   nil).
]

TextLayout lineLengths: lens
[
    l  := lens.
    j0 := q == 0 ifTrue: [l size] ifFalse: [INFINITY].
]

TextLayout run
[
    self createAnActiveNodeRepresentingTheStartingPoint.
    SW := SY := SZ := 0.0.
    b := text first.
    [b]
	whileTrue:
	   [b isBox
		ifTrue: [SW := SW + b width]
		ifFalse:
		   [b isGlue
			ifTrue:
			   [b prevLink isBox ifTrue: [self mainLoop].
			    SW := SW + b width.
			    SY := SY + b stretch.
			    SZ := SZ + b shrink]
			ifFalse:
			   [b penalty ~~ INFINITY ifTrue: [self mainLoop]]].
	    b := b nextLink].
    self chooseTheActiveNodeWithTheFewestTotalDemerits.
    q ~~ 0 ifTrue: [self chooseTheAppropriateActiveNode].
    self useTheChosenNodeToDetermineTheOptimumBreakpoints.
    ^breaks
]

TextLayout createAnActiveNodeRepresentingTheStartingPoint
[
   A := Node withPosition: nil line: 0 fitness: 1 totalwidth: 0 totalstretch: 0 totalshrink: 0 totaldemerits: 0 ratio: 0 previous: nil link: nil.
   P := nil.
]

TextLayout computeJAndTheAdjustmentRatioRFromAToB
[
    | J L Y Z |
    L := SW - a totalwidth.
    b isPenalty ifTrue: [L := L + b width].
    j := a line + 1.
    J := j > j0 ifTrue: [l last] ifFalse: [l at: j - 1].
    r :=	      L < J ifTrue: [(Y := SY - a totalstretch) > 0 ifTrue: [(J - L) / Y] ifFalse: [INFINITY]]
	    ifFalse: [L > J ifTrue: [(Z := SZ - a totalshrink ) > 0 ifTrue: [(J - L) / Z] ifFalse: [INFINITY]]
	    ifFalse: [0]].
]

TextLayout mainLoop
[
    a := A.
    preva := nil.
    [a]	whileTrue:
	[Dc atAllPut: (D := INFINITY).
	 [   nexta := a link.
	     self computeJAndTheAdjustmentRatioRFromAToB.
	     (r < -1 or: [b penalty == MINFINITY])
		 ifTrue:  [self deactivateNodeA]
		 ifFalse: [preva := a].
	     (-1 <= r and: [r <= rho])
		 ifTrue:
		     [self computeDemeritsDAndFitnessClassC.
		      d < (Dc at: c)
			  ifTrue:
			      [Dc at: c put: d.
			       Ac at: c put: a.
			       Rc at: c put: r.
			       d < D ifTrue: [D := d]]].
	     (a := nexta) and: [a line < j or: [j >= j0]]] whileTrue.
	 D < INFINITY ifTrue: [self insertNewActiveNodesForBreaksFromAcToB]].
    A ifFalse: [self doSomethingDrasticSinceThereIsNoFeasibleSolution].
]

TextLayout computeDemeritsDAndFitnessClassC
[
    | Pb |
    Pb := b penalty.
    d := 	    Pb >= 0	    ifTrue: [(1 + (100 * r abs cubed) + Pb) squared]
	  ifFalse: [Pb >  MINFINITY ifTrue: [(1 + (100 * r abs cubed)     ) squared - Pb squared]
	  ifFalse:			    [(1 + (100 * r abs cubed)     ) squared]].
    (b flag and: [a flag]) ifTrue: [d := d + alpha].
    c :=	  (r < -0.5) ifTrue: [0]
    	ifFalse: [(r <= 0.5) ifTrue: [1]
    	ifFalse: [(r <= 1.0) ifTrue: [2]
    	ifFalse:                     [3]]].
    (c - a fitness) abs > 1 ifTrue: [d := d + gamma].
    d := d + a totaldemerits.
]

TextLayout insertNewActiveNodesForBreaksFromAcToB
[
    self computeTwTyTz.
    0 to: 3 do: [:n |
	(Dc at: n) <= (D + gamma)
	    ifTrue:
	       [| s |
		s := Node withPosition: b line: (Ac at: n) line + 1 fitness: c
			  totalwidth: tw totalstretch: ty totalshrink: tz totaldemerits: (Dc at: n)
			  ratio: (Rc at: n) previous: (Ac at: n) link: a.
		preva ifTrue: [preva link: s] ifFalse: [A := s].
		preva := s]].
]

TextLayout computeTwTyTz
[
    | i |
    tw := SW.
    ty := SY.
    tz := SZ.
    i  := b.
    [i and: [i isGlue or: [i isPenalty and: [i == b or: [i penalty ~~ MINFINITY]]]]]
	whileTrue:
	   [i isGlue
		ifTrue:
		   [tw := tw + i width.
		    ty := ty + i stretch.
		    tz := tz + i shrink].
	    i := i nextLink].
]

TextLayout deactivateNodeA
[
    preva ifTrue: [preva link: nexta] ifFalse: [A := nexta].
    a link: P.
    P := a.
]

TextLayout chooseTheActiveNodeWithTheFewestTotalDemerits
[
    a := b := A.
    d := a totaldemerits.
    [a := a link] whileTrue: [a totaldemerits < d ifTrue: [d := (b := a) totaldemerits]].
    k := b line.
]

TextLayout chooseTheAppropriateActiveNode
[
    | s delta |
    a := A.
    s := 0.
    [ delta := a line - k.
      ((q <= delta and: [delta < s]) or: [s < delta and: [delta <= q]])
	  ifTrue:
	      [s := delta.
	       d := a totaldemerits.
	       b := a].
      a := a link]
	whileTrue.
    k := b line.
]

TextLayout useTheChosenNodeToDetermineTheOptimumBreakpoints
[
    breaks := Array new: k.
    k - 1 downTo: 0 do: [:kk |
	breaks at: kk put: b.
	b := b previous].
]

SampleText := [ 'The worship of money is the lowest of all human emotions, but it is shared not only by the bourgeoisie but also by the great majority of us: Little people, humble people, even those who are practically penniless. And I, with all my indignation, all my passion for destruction, I, too, am not free of it. I who am oppressed by wealth, who realise it to be the source of all misery, all my vices and hatred, all the bitterest humiliations that I have to suffer, all my impossible dreams and all the endless torment of my existence, still, all the time, as soon as I find myself in the presence of a rich person, I cannot help looking up to him, as some exceptional and splendid being, a kind of marvelous divinity, and in spite of myself, stronger than either my will or my reason, I feel rising from the very depths of my being, a sort of incense of admiration for this wealthy creature, who is all too often as stupid as he is pitiless. Isn''t it crazy? And why... why? - Octave Mirbeau' ]

TextLayout test
[
    | len br bgp |
    self := self on: SampleText.
    self lineLengths: #(32 32 32 32 70 70 70 50).
    br := self run.
    bgp := text first.
    len := l last.
    br do: [ :node || break w y z ratio |
	break := node position.
	w := y := z := 0.0.
	ratio := node ratio.
	ratio > 0.0 ifTrue: [y := ratio].
	ratio < 0.0 ifTrue: [z := ratio].
	[bgp == break]
	    whileFalse:
	       [bgp isGlue
		    ifTrue:
		       [w := w + bgp width + (y * bgp stretch) + (z * bgp shrink).
			[w > 0.5] whileTrue: [' ' put.  w := w - 1.0]].
		bgp isBox ifTrue: [bgp character put].
		bgp := bgp nextLink].
	StdOut cr.
	bgp := bgp nextLink].
]

[
    TextLayout test.
    OS exit: 0.
]
