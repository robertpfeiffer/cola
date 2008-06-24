" XXX compute and store the optimum fitness class at each breakpoint and eliminate the other three break nodes "
" XXX simplify the inner loop for lines beyond easyLine (j > j0)"
" XXX simplify the inner loop for lines with no looseness (q == 0)"
" XXX fix the search for the break node corresponding to a non-zero looseness "
" XXX pretolerance should be slightly higher than 1 -- sqrt(3) for example "
" XXX add hyphenation "
" XXX provide canned glue regimes for raggeg right, ragged left, ragged centered "

{ import: Layout }

INFINITY := [ 1000 ]
MINFINITY := [ INFINITY negated ]

"----------------------------------------------------------------"

CBox : Object ( character width stretch shrink penalty flagged )

CBox character	[ ^character ]
CBox width	[ ^width ]
CBox stretch	[ ^stretch ]
CBox shrink	[ ^shrink ]

CBox isBox		[ ^true ]
CBox isGlue		[ ^false ]
CBox isPenalty		[ ^false ]
CBox isForcedBreak	[ ^false ]

CBox withCharacter: characterInteger width: widthNumber
[
    self := self new.
    character := characterInteger.
    width := widthNumber.
    stretch := 0.
    shrink := 0.
    penalty := 0.
    flagged := false.
]

CBox printOn: aStream
[
    super printOn: aStream.
    aStream
	print: width;
	nextPut: $(;
	print: character;
	nextPut: $)
]

"----------------------------------------------------------------"

Glue : Object ( width stretch shrink )

Glue width	[ ^width ]
Glue stretch	[ ^stretch ]
Glue shrink	[ ^shrink ]

Glue isBox		[ ^false ]
Glue isGlue		[ ^true ]
Glue isPenalty		[ ^false ]
Glue isForcedBreak	[ ^false ]

Glue withWidth: widthNumber stretch: stretchNumber shrink: shrinkNumber
[
    self := self new.
    width := widthNumber.
    stretch := stretchNumber.
    shrink := shrinkNumber.
]

Glue computeWidth: ratio
[
    ^width + (ratio * (ratio < 0 ifTrue: [shrink] ifFalse: [stretch]))
]
        
"----------------------------------------------------------------"

Penalty : Object ( width penalty flagged stretch shrink )

Penalty width	[ ^width ]
Penalty penalty	[ ^penalty ]
Penalty flagged	[ ^flagged ]
Penalty stretch	[ ^stretch ]
Penalty shrink	[ ^shrink ]

Penalty isBox		[ ^false ]
Penalty isGlue		[ ^false ]
Penalty isPenalty	[ ^true ]
Penalty isForcedBreak	[ ^penalty == MINFINITY ]
    
Penalty withWidth: widthNumber penalty: penaltyInteger flagged: flag
[
    self := self new.
    width := widthNumber.
    penalty := penaltyInteger.
    flagged := flag.
    stretch := 0.
    shrink := 0.
]

"----------------------------------------------------------------"

BreakNode : Link ( position line fitnessClass totalWidth totalStretch totalShrink demerits previous )
    
BreakNode position	[ ^position ]
BreakNode line		[ ^line ]
BreakNode fitnessClass	[ ^fitnessClass ]
BreakNode demerits	[ ^demerits ]
BreakNode previous	[ ^previous ]

BreakNode withPosition: p line: l fitnessClass: fc totalWidth: tw totalStretch: tst totalShrink: tsh demerits: d
[
    ^self withPosition: p line: l fitnessClass: fc totalWidth: tw totalStretch: tst totalShrink: tsh demerits: d previous: nil
]

BreakNode withPosition: p line: l fitnessClass: fc totalWidth: tw totalStretch: tst totalShrink: tsh demerits: d previous: prev
[
    self := self new.
    position := p.
    line := l.
    fitnessClass := fc.
    totalWidth := tw.
    totalStretch := tst.
    totalShrink := tsh.
    demerits := d.
    previous := prev.
]

BreakNode unlink		"do not clear nextLink -- iteration must be stable under removal"
[
    prevLink nextLink: nextLink.
    nextLink prevLink: prevLink.
]

BreakNode unlinked	[]	"do not clear nextLink -- iteration must be stable under removal"

BreakNode = aBreakNode
[
    ^line == aBreakNode line and: [position == aBreakNode position and: [fitnessClass == aBreakNode fitnessClass]]
]

BreakNode printOn: aStream
[
    aStream
	nextPut: $<; print: line;
	nextPut: $,; print: position;
	nextPut: $,; print: fitnessClass;
	nextPut: $,; print: demerits;
	nextPut: $>
]

"----------------------------------------------------------------"

BreakNodeList : LinkedList ()

BreakNodeList insert: aBreakNode
[
    | nodeLine curLink |
    nodeLine := aBreakNode line.
    curLink := lastLink.
    [curLink and: [curLink line > nodeLine]] whileTrue: [curLink := curLink prevLink].
    [curLink and: [curLink line == nodeLine]]
	whileTrue:
	    [curLink = aBreakNode
		 ifTrue:
		     [curLink demerits < aBreakNode demerits ifTrue: [^curLink].
		      super add: aBreakNode before: curLink.
		      super remove: curLink.
		      ^aBreakNode].
	     curLink := curLink prevLink].
    ^curLink
	ifTrue:  [super add: aBreakNode after: curLink]
	ifFalse: [super addFirst: aBreakNode]
]

"----------------------------------------------------------------"

ObjectList : OrderedCollection ( debug sumWidth sumStretch sumShrink )

ObjectList new: size
[
    self := super new: size.
    debug := false.
]

ObjectList addClosingPenalty
[
    self
	add: (Penalty withWidth: 0 penalty:  INFINITY flagged: false);
	add: (Glue    withWidth: 0 stretch:  INFINITY shrink:  0);
	add: (Penalty withWidth: 0 penalty: MINFINITY flagged: true)
]

ObjectList isFeasibleBreakpoint: index
[
    | box |
    box := self at: index.
    (box isPenalty and: [box penalty < INFINITY]) ifTrue: [^true].
    (index > 0 and: [box isGlue and: [(self at: index - 1) isBox]]) ifTrue: [^true].
    ^false
]

ObjectList isForcedBreak: index
[
    | box |
    box := self at: index.
    ^box isPenalty and: [box penalty == MINFINITY]
]

ObjectList measureWidthFrom:   pos1 to: pos2	[ ^(sumWidth   at: pos2) - (sumWidth   at: pos1) ]
ObjectList measureStretchFrom: pos1 to: pos2	[ ^(sumStretch at: pos2) - (sumStretch at: pos1) ]
ObjectList measureShrinkFrom:  pos1 to: pos2	[ ^(sumShrink  at: pos2) - (sumShrink  at: pos1) ]

ObjectList computeAdjustmentRatioFrom: pos1 to: pos2 line: line lineLengths: lineLengths
[
    | length availableLength s |
    length := self measureWidthFrom: pos1 to: pos2.
    (self at: pos2) isPenalty ifTrue: [length := length + (self at: pos2) width].
    debug ifTrue: [StdOut nextPutAll: '\tline length='; println: length].
    availableLength := line < lineLengths size ifTrue: [lineLengths at: line] ifFalse: [lineLengths last].
    debug ifTrue: [StdOut
		       nextPutAll: 'adj from ';	print: pos1;   nextPutAll: ' to '; print: pos2;
		       nextPutAll: ' len ';	print: length; nextPutAll: ' in '; print: availableLength;
		       nextPutAll: ' --> '].
    length < availableLength
	ifTrue:
	   [s := self measureStretchFrom: pos1 to: pos2.
	    debug ifTrue: [StdOut
			       nextPutAll: '\tLine too short: shortfall=';
			       print:      availableLength - length;
			       nextPutAll: ', stretch=';
			       println:    s].
	    ^(s > 0 ifTrue: [(availableLength - length) / s] ifFalse: [INFINITY])].
    length > availableLength
	ifTrue:
	   [s := self measureShrinkFrom: pos1 to: pos2.
	    debug ifTrue: [StdOut
			       nextPutAll: '\tLine too long: extra=';
			       print:	   availableLength - length;
			       nextPutAll: ', shrink=';
			       println:	   s].
	    ^(s > 0 ifTrue: [(availableLength - length) / s] ifFalse: [INFINITY])].
    ^0
]

COUNT := [ 0 ]

ObjectList addActiveNode: node to: activeNodes
[
    activeNodes insert: node
]

ObjectList computeBreakpointsLengths: lineLengths
	   looseness: looseness			"0"
	   tolerance: tolerance			"1"
	   fitnessDemerit: fitnessDemerit	"100"
	   flaggedDemerit: flaggedDemerit	"100"
[
    | m p f widthSum stretchSum shrinkSum activeNodes minBox best d b breaks |
    m := self size.
    m == 0 ifTrue: [^Array new: 0].
    p := Array new: m withAll: 0.
    f := Array new: m withAll: 0.
    self doWithIndex: [:box :i |
	box isGlue
	    ifFalse:
		[box isPenalty
		     ifTrue:
			[p at: i put: box penalty.
			 f at: i put: (box flagged ifTrue: [1] ifFalse: [0])]]].
    sumWidth   := Array new: m.
    sumStretch := Array new: m.
    sumShrink  := Array new: m.
    widthSum := stretchSum := shrinkSum := 0.
    self doWithIndex: [:box : i |
        sumWidth   at: i put: widthSum.    widthSum   := widthSum   + box width.
        sumStretch at: i put: stretchSum.  stretchSum := stretchSum + box stretch.
        sumShrink  at: i put: shrinkSum.   shrinkSum  := shrinkSum  + box shrink].
    activeNodes := BreakNodeList new.
    activeNodes add: (BreakNode withPosition: 0 line: 0 fitnessClass: 1 totalWidth: 0 totalStretch: 0 totalShrink: 0 demerits: 0).
    debug ifTrue: [StdOut nextPutAll: 'looping over '; print: m; nextPutAll: ' box objects\n'].
    breaks := BreakNodeList new.
    self doWithIndex: [:boxB :i |
        (self isFeasibleBreakpoint: i)
	    ifTrue:
	       [debug ifTrue: [StdOut
				   nextPutAll: 'feasible breakpoint at '; println: i;
				   nextPutAll: '\tcurrent active node list: '; println: activeNodes].
		debug ifTrue: [StdOut
				   nextPutAll: 'FEASIBLE BREAK: ';	print: boxB;
				   space;				print: (sumWidth at: i);
				   space;				println: activeNodes].
		activeNodes do: [:boxA || r |
		    debug ifTrue: [StdOut tab; print: boxA; tab].
		    r := self computeAdjustmentRatioFrom: boxA position to: i line: boxA line lineLengths: lineLengths.
		    debug ifTrue: [StdOut println: r; nextPutAll: '\tr='; println: r; nextPutAll: '\tline='; println: boxA line].
		    (r < -1 or: [boxB isForcedBreak])
			ifTrue: "Deactivate node A"
			   [activeNodes size == 1
				ifFalse:
				    [debug ifTrue: [StdOut
							nextPutAll: '\tremoving node '; println: boxA;
							nextPutAll: '\tfrom ';		println: activeNodes].
				     activeNodes remove: boxA]].
		    (-1 <= r and: [r <= tolerance])
			ifTrue:
			   ["Compute demerits and fitness class"
			    | demerits fitnessClass |
			    demerits := (p at: i) >= 0 ifTrue:		   [(1 + (100 * r abs cubed) + (p at: i)) cubed]
				ifFalse: [(self isForcedBreak: i) ifTrue:  [(1 + (100 * r abs cubed)) squared - (p at:i) squared]
								  ifFalse: [(1 + (100 * r abs cubed)) squared]].
			    demerits := demerits + (flaggedDemerit * (f at: i) * (f at: boxA position)).
			    "Figure out the fitness class of this line (tight, loose, very tight or very loose)."
			    fitnessClass := r < -0.5 ifTrue: [0] ifFalse: [r <= 0.5 ifTrue: [1] ifFalse: [r <= 1 ifTrue: [2] ifFalse: [3]]].
			    "If two consecutive lines are in very different fitness classes, add to the demerit score for this break."
			    (fitnessClass - boxA fitnessClass) abs > 1 ifTrue: [demerits := demerits + fitnessDemerit].
			    debug ifTrue: [StdOut nextPutAll: '\tdemerits='; println: demerits; nextPutAll: '\tfitness class='; println: fitnessClass].
			    breaks add: (BreakNode
					     withPosition: i
					     line:	   boxA line + 1
					     fitnessClass: fitnessClass
					     totalWidth:   (sumWidth   at: i)
					     totalStretch: (sumStretch at: i)
					     totalShrink:  (sumShrink  at: i)
					     demerits:     demerits
					     previous:     boxA).
			    debug ifTrue: [StdOut
					       nextPutAll: '\trecording feasible break: '; println: boxB;
					       nextPutAll: '\t\tdemerits='; println: demerits;
					       nextPutAll: '\t\tfitness class='; println: fitnessClass].
			    ]. "-1 <= adjustmentRatio <= tolerance"
			]. "activeNodes do:"
		debug ifTrue: [StdOut nextPutAll: 'list of breaks at '; print: i; nextPutAll: ': '; println: breaks].
		[breaks notEmpty] whileTrue: [self addActiveNode: breaks removeFirst to: activeNodes].
		]. "isFeasibleBreakpoint"
	]. "self do:"
    debug ifTrue: [StdOut nextPutAll: 'main loop completed\nactive nodes='; println: activeNodes].
    minBox := activeNodes minimum: [:box | box demerits].
    debug ifTrue: [StdOut nextPutAll: 'lowest demerits='; println: minBox].
    looseness ~~ 0
	ifTrue:
	   [best := 0.
            d := INFINITY.
            activeNodes do: [:br || delta |
                delta := br line - minBox line.
                ((looseness <= delta and: [delta < best]) or: [best < delta and: [delta < looseness]])
		    ifTrue: [d := br demerits.  b := br]
		    ifFalse:
			[(delta == best and: [br demerits < d])
			     ifTrue:
				[d := br demerits.
				 b := br]]].
            minBox := b].
    breaks := OrderedCollection new.
    [minBox] whileTrue:
	[debug ifTrue: [StdOut nextPutAll: 'add prev break '; println: minBox].
	 breaks addFirst: minBox position.
	 minBox := minBox previous].
    ^(breaks notEmpty and: [self size - 1 == breaks last]) ifTrue: [breaks]
]

"----------------------------------------------------------------"

SequenceableCollection tokenized: delimiters
[
    | in out tokens |
    in := self readStream.
    out := WriteStream on: (self new: self size).
    tokens := OrderedCollection new.
    [in atEnd not and: [delimiters includes: in peek]] whileTrue: [in next].
    [in atEnd]
	whileFalse:
	   [[in atEnd or: [delimiters includes: in peek]] whileFalse: [out nextPut: in next].
	    [in atEnd not and: [delimiters includes: in peek]] whileTrue: [in next].
	    tokens add: out contents.
	    out reset].
    ^tokens
]

"----------------------------------------------------------------"

TextGlue  := [ 5 ]	"6/18 em"
TextPlus  := [ 3 ]
TextMinus := [ 1 ]
TextLoose := [ 0 ]

LayoutTarget := [ nil ]

TextLayout : Layout ()

TextLayout incrGlue	[ StdOut nextPutAll: 'glue is now ';  println: (TextGlue  := TextGlue  + 1).  self doLayouts ]
TextLayout decrGlue	[ StdOut nextPutAll: 'glue is now ';  println: (TextGlue  := TextGlue  - 1).  self doLayouts ]
TextLayout incrPlus	[ StdOut nextPutAll: 'plus is now ';  println: (TextPlus  := TextPlus  + 1).  self doLayouts ]
TextLayout decrPlus	[ StdOut nextPutAll: 'plus is now ';  println: (TextPlus  := TextPlus  - 1).  self doLayouts ]
TextLayout incrMinus	[ StdOut nextPutAll: 'minus is now '; println: (TextMinus := TextMinus + 1).  self doLayouts ]
TextLayout decrMinus	[ StdOut nextPutAll: 'minus is now '; println: (TextMinus := TextMinus - 1).  self doLayouts ]
TextLayout incrLoose	[ StdOut nextPutAll: 'loose is now '; println: (TextLoose := TextLoose + 1).  self doLayouts ]
TextLayout decrLoose	[ StdOut nextPutAll: 'loose is now '; println: (TextLoose := TextLoose - 1).  self doLayouts ]

TextLayout target: aBox	[ ^LayoutTarget := aBox ]
TextLayout doLayouts	[  LayoutTarget ifTrue: [LayoutTarget layoutContents] ]

TextLayout layout: aBox
[
    | glue plus minus looseness tolerance fitnessDemerit flaggedDemerit
      wordwise text lineWidth line lineLengths lineNo justify breaks lineStart
      inset x y w h |
    inset := 6.
    glue  := TextGlue.  plus  := TextPlus.  minus := TextMinus.
    looseness := TextLoose.  tolerance := 1.
    fitnessDemerit := 100.  flaggedDemerit := 100.
    lineWidth := aBox extent x - (inset * 2).
    justify := true.
    text := aBox contents.
    line := ObjectList new.
    wordwise ifTrue: [
	(text tokenized: ' \n\r')
	    do: [:word |
		line add: (word = '@'
			       ifTrue:  [Penalty withWidth: 0 penalty: MINFINITY flagged: false]	"forced line break"
			       ifFalse: [CBox withCharacter: word width: word size])]
	    separatedBy: [line add: (Glue withWidth: glue stretch: plus shrink: minus)].		"interword space: 2 plus 1 minus 1"
    ] ifFalse: [
	text do: [:char |
	    line add: (char glyph ucs4 = 32
			   ifTrue: [Glue withWidth: glue stretch: plus shrink: minus]
			   ifFalse:
			       [char glyph ucs4 = -1
				    ifTrue:  [Penalty withWidth: 0 penalty: MINFINITY flagged: false]	"forced line break"
				    ifFalse: [CBox withCharacter: char width: char glyph advance x]])]
    ].
    "closing penalty and glue"
    line addClosingPenalty.
    "compute the breakpoints"
    lineLengths := Array with: lineWidth.
    [breaks := line computeBreakpointsLengths: lineLengths
		   looseness: looseness
		   tolerance: tolerance
		   fitnessDemerit: fitnessDemerit
		   flaggedDemerit: flaggedDemerit]
	whileFalse:
	    [(tolerance := tolerance + 1) > 10
		 ifTrue:  [StdErr nextPutAll: 'cannot break paragraph with given parameters\n'.  ^nil]
		 ifFalse: [StdErr nextPutAll: 'tolerance increased to '; println: tolerance]].
    "StdOut print: breaks; space; println: line size; println: breaks size."
    breaks first == 0 ifFalse: [breaks error: 'first break is not at offset 0'].
    lineStart := 0.
    lineNo := 0.
    y := inset.
    breaks from: 1 do: [:breakpoint || r |
        r := line computeAdjustmentRatioFrom: lineStart to: breakpoint line: lineNo lineLengths: lineLengths.
        lineNo := lineNo + 1.
	x := inset.
	h := 0.
	line from: lineStart to: breakpoint do: [:box |
            box isGlue
		ifTrue:  [x := x + (box computeWidth: r)]
		ifFalse:
		    [box isBox
			 ifTrue:
			    [box character position: x,y.
			     x := x + box character glyph advance x.
			     h := h max: box character extent y]]].
        lineStart := breakpoint + 1.
	y := y + h]
]
