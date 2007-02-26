{ import: Integer }
{ import: LargePositiveInteger }
{ import: LargeNegativeInteger }

Integer new: length neg: neg
[
    ^(neg ifTrue: [LargeNegativeInteger] ifFalse: [LargePositiveInteger]) new: length
]

Integer lastDigit
[
    ^self digitAt: self digitLength
]

Integer growTo: n
[
    ^self copyTo: (self new: n)
]

Integer copyTo: x
[
    | stop |
    stop := self digitLength min: x digitLength.
    ^x replaceFrom: 1 to: stop with: self startingAt: 1
]

Integer + aNumber
[
    aNumber isInteger
	ifTrue:
	   [^self negative == aNumber negative
		ifTrue:  [(self digitAdd: aNumber) normalize]
		ifFalse: [self digitSubtract: aNumber]].
    ^aNumber adaptToInteger: self andSend: #+
]

Integer digitAdd: arg 
[
    | len arglen accum sum |
    accum := 0.
    (len := self digitLength) < (arglen := arg digitLength) ifTrue: [len := arglen].
    sum := Integer new: len neg: self negative.
    1 to: len do: [:i |
	accum := (accum bitShift: -8) + (self digitAt: i) + (arg digitAt: i).
	sum digitAt: i put: (accum bitAnd: 255)].
    accum > 255
	ifTrue: 
	   [sum := sum growby: 1.
	    sum at: sum digitLength put: (accum bitShift: -8)].
    ^sum
]

Integer - aNumber
[
    aNumber isInteger
	ifTrue:
	   [^self negative == aNumber negative
		ifTrue:  [self digitSubtract: aNumber]
		ifFalse: [(self digitAdd: aNumber) normalize]].
    ^aNumber adaptToInteger: self andSend: #-
]

Integer digitSubtract: arg 
[
    | smaller larger z sum sl al ng |
    sl := self digitLength.
    al := arg digitLength.
    (sl = al ifTrue:  [[(self digitAt: sl) = (arg digitAt: sl) and: [sl > 1]]
			   whileTrue: [sl := sl - 1].
		       al := sl.
		       (self digitAt: sl) < (arg digitAt: sl)]
	     ifFalse: [sl < al])
	ifTrue:
	   [larger := arg.
	    smaller := self.
	    ng := self negative == false.
	    sl := al]
	ifFalse: 
	   [larger := self.
	    smaller := arg.
	    ng := self negative].
    sum := Integer new: sl neg: ng.
    z := 0.
    "Loop invariant is -1<=z<=1"
    1 to: sl do: [:i |
	z := z + (larger digitAt: i) - (smaller digitAt: i).
	sum digitAt: i put: z - (z // 256 * 256).
	"sign-tolerant form of (z bitAnd: 255)"
	z := z // 256].
    ^sum normalize
]

Integer * aNumber
[
    aNumber isInteger
	ifTrue:
	   [^self digitMultiply: aNumber neg: self negative ~~ aNumber negative].
    ^aNumber adaptToInteger: self andSend: #*
]

Integer digitMultiply: arg neg: ng
[
    | prod prodLen carry digit k ab |
    (arg digitLength = 1 and: [(arg digitAt: 1) = 0]) ifTrue: [^0].
    (self digitLength = 1 and: [(self digitAt: 1) = 0]) ifTrue: [^ 0].
    prodLen := self digitLength + arg digitLength.
    prod := Integer new: prodLen neg: ng.
    "prod starts out all zero"
    1 to: self digitLength do: [:i |
	(digit := self digitAt: i) ~= 0
	    ifTrue: 
	       [k := i.
		carry := 0.
		"Loop invariant: 0<=carry<=0377, k=i+j-1"
		1 to: arg digitLength do: [:j |
		    ab := (arg digitAt: j) * digit + carry + (prod digitAt: k).
		    carry := ab bitShift: -8.
		    prod digitAt: k put: (ab bitAnd: 255).
		    k := k + 1].
		prod digitAt: k put: carry]].
    ^prod normalize
]

Integer // aNumber
[
    | q |
    aNumber = 0 ifTrue: [^self error: 'division by 0'].
    self = 0 ifTrue: [^0].
    q := self quo: aNumber.
    ^(q negative ifTrue: [q * aNumber ~= self] ifFalse: [q = 0 and: [self negative ~= aNumber negative]])
	ifTrue:  [q - 1]
	ifFalse: [q]
]

Integer quo: aNumber
[
    | ng quo |
    aNumber isInteger
	ifTrue:
	   [ng := self negative == aNumber negative == false.
	    quo := (self digitDiv: (aNumber isSmallInteger ifTrue: [aNumber abs] ifFalse: [aNumber]) neg: ng)
		at: 1.
	    ^quo normalize].
    ^aNumber adaptToInteger: self andSend: #quo:
]

Integer / aNumber
[
    | quoRem |
    aNumber isInteger
	ifTrue:
	    [quoRem := self digitDiv: aNumber abs neg: self negative ~~ aNumber negative.
	     ^(quoRem at: 2) = 0
		 ifTrue:  [(quoRem at: 1) normalize]
		 ifFalse: [self asFloat / aNumber asFloat]].	"xxx Fractional arithmetic elided"
    ^ aNumber adaptToInteger: self andSend: #/
]

Integer digitDiv: arg neg: ng
[
    | quo rem ql d div dh dnh dl qhi qlo j l hi lo r3 a t |
    arg = 0 ifTrue: [^self errorZeroDivide].
    l := self digitLength - arg digitLength + 1.
    l <= 0 ifTrue: [^Array with: 0 with: self].
    d := 8 - arg lastDigit highBitOfPositiveReceiver.
    div := arg digitLshift: d.
    div := div growTo: div digitLength + 1.
    "shifts so high order word is >=128"
    rem := self digitLshift: d.
    rem digitLength = self digitLength ifTrue: [rem := rem growTo: self digitLength + 1].
    "makes a copy and shifts"
    quo := Integer new: l neg: ng.
    dl := div digitLength - 1.
    "Last actual byte of data"
    ql := l.
    dh := div digitAt: dl.
    dnh := dl = 1 ifTrue: [0] ifFalse: [div digitAt: dl - 1].
    1 to: ql do: [:k |
	"maintain quo*arg+rem=self"
	"Estimate rem/div by dividing the leading to bytes of rem by dh."
	"The estimate is q = qhi*16+qlo, where qhi and qlo are nibbles."
	j := rem digitLength + 1 - k.
	"r1 _ rem digitAt: j."
	(rem digitAt: j) = dh
	    ifTrue: [qhi := qlo := 15 "i.e. q=255"]
	    ifFalse: 
	       ["Compute q = (r1,r2)//dh, t = (r1,r2)\\dh.
		Note that r1,r2 are bytes, not nibbles.  
		Be careful not to generate intermediate results exceeding 13  
		bits."
		"r2 _ (rem digitAt: j - 1)."
		t := ((rem digitAt: j) bitShift: 4) + ((rem digitAt: j - 1) bitShift: -4).
		qhi := t // dh.
		t := (t \\ dh bitShift: 4) + ((rem digitAt: j - 1) bitAnd: 15).
		qlo := t // dh.
		t := t \\ dh.
		"Next compute (hi,lo) _ q*dnh"
		hi := qhi * dnh.
		lo := qlo * dnh + ((hi bitAnd: 15) bitShift: 4).
		hi := (hi bitShift: -4) + (lo bitShift: -8).
		lo := lo bitAnd: 255.
		"Correct overestimate of q.  Max of 2 iterations through loop -- see Knuth vol. 2"
		r3 := j < 3 ifTrue: [0] ifFalse: [rem digitAt: j - 2].
		[(t < hi or: [t = hi and: [r3 < lo]])
		     and: ["i.e. (t,r3) < (hi,lo)"
			   qlo := qlo - 1.
			   lo := lo - dnh.
			   lo < 0
			       ifTrue: 
				   [hi := hi - 1.
				    lo := lo + 256].
			   hi >= dh]]
		    whileTrue:
			[hi := hi - dh].
		qlo < 0
		    ifTrue: 
			[qhi := qhi - 1.
			 qlo := qlo + 16]].
	"Subtract q*div from rem"
	l := j - dl.
	a := 0.
	1 to: div digitLength do: [:i |
	    hi := (div digitAt: i) * qhi.
	    lo := a + (rem digitAt: l) - ((hi bitAnd: 15) bitShift: 4) - ((div digitAt: i) * qlo).
	    rem digitAt: l put: lo - (lo // 256 * 256).
	    "sign-tolerant form of (lo bitAnd: 255)"
	    a := lo // 256 - (hi bitShift: -4).
	    l := l + 1].
	a < 0
	    ifTrue: 
	       ["Add div back into rem, decrease q by 1"
		qlo := qlo - 1.
		l := j - dl.
		a := 0.
		1 to: div digitLength do: [:i |
		    a := (a bitShift: -8) + (rem digitAt: l) + (div digitAt: i).
		    rem digitAt: l put: (a bitAnd: 255).
		    l := l + 1]].
	quo digitAt: quo digitLength + 1 - k put: (qhi bitShift: 4) + qlo].
    rem := rem digitRshift: d bytes: 0 lookfirst: dl.
    ^Array with: quo with: rem
]

Integer bitAnd: n 
[
    | norm |
    norm := n normalize.
    ^self
	digitLogic: norm
	op: #bitAnd:
	length: (self digitLength max: norm digitLength)
]

Integer digitLogic: arg op: op length: len
[
    | result neg1 neg2 rneg z1 z2 rz b1 b2 b |
    neg1 := self negative.
    neg2 := arg negative.
    rneg := ((neg1 ifTrue: [-1] ifFalse: [0])
		 perform: op 
		 with: (neg2 ifTrue: [-1] ifFalse: [0])) < 0.
    result := Integer new: len neg: rneg.
    rz := z1 := z2 := true.
    1 to: result digitLength do: [:i | 
	b1 := self digitAt: i.
	neg1 ifTrue: [b1 := z1
			  ifTrue: [b1 = 0
				       ifTrue: [0]
				       ifFalse: 
					  [z1 := false.
					   256 - b1]]
			  ifFalse: [255 - b1]].
	b2 := arg digitAt: i.
	neg2 ifTrue: [b2 := z2
			  ifTrue: [b2 = 0
				       ifTrue: [0]
				       ifFalse: 
					   [z2 := false.
					    256 - b2]]
			  ifFalse: [255 - b2]].
	b := b1 perform: op with: b2.
	result 
	    digitAt: i 
	    put: (rneg ifTrue: [rz ifTrue: [b = 0
						ifTrue: [0]
						ifFalse:
						    [rz := false.
						     256 - b]]
				   ifFalse: [255 - b]]
		       ifFalse: [b])].
    ^result normalize
]

Integer << displacement
[
    displacement < 0 ifTrue: [self error: 'negative displacement'].
    ^self bitShift: displacement
]

Integer >> displacement
[
    displacement < 0 ifTrue: [self error: 'negative displacement'].
    ^self bitShift: displacement negated
]

Integer bitShift: displacement
[
    | magnitudeShift |
    magnitudeShift := self bitShiftMagnitude: displacement.
    ^((self negative and: [displacement negative]) and: [self anyBitOfMagnitudeFrom: 1 to: displacement negated])
	ifTrue:  [magnitudeShift - 1]
	ifFalse: [magnitudeShift]
]

Integer bitShiftMagnitude: displacement
[
    | rShift |
    displacement >= 0 ifTrue: [^self digitLshift: displacement].
    rShift := 0 - displacement.
    ^(self
	  digitRshift: (rShift bitAnd: 7)
	  bytes: (rShift bitShift: -3)
	  lookfirst: self digitLength) normalize
]

Integer digitLshift: shiftCount 
[
    | carry rShift mask len result byteShift bitShift highBit |
    (highBit := self highBitOfMagnitude) = 0 ifTrue: [^0].
    len := highBit + shiftCount + 7 // 8.
    result := Integer new: len neg: self negative.
    byteShift := shiftCount // 8.
    bitShift  := shiftCount \\ 8.
    bitShift = 0		"Fast version for byte-aligned shifts"
	ifTrue: [^result replaceFrom: byteShift + 1 to: len with: self startingAt: 1].
    carry := 0.
    rShift := bitShift - 8.
    mask := 255 bitShift: 0 - bitShift.
    1 to: byteShift do: [:i | result digitAt: i put: 0].
    1 to: len - byteShift do: [:i |
	| digit |
	digit := self digitAt: i.
	result digitAt: i + byteShift put: (((digit bitAnd: mask) bitShift: bitShift) bitOr: carry).
	carry := digit bitShift: rShift].
    ^result
]

Integer digitRshift: anInteger bytes: b lookfirst: a
[
    "Shift right 8*b+anInteger bits, 0 <= n < 8.  Discard all digits beyond a, and all zeroes at or below a."
    | n x r f m digit count i |
    n := 0 - anInteger.
    x := 0.
    f := n + 8.
    i := a.
    m := 255 bitShift: 0 - f.
    digit := self digitAt: i.
    [((digit bitShift: n) bitOr: x) = 0 and: [i ~= 1]]
	whileTrue:
	   [x := digit bitShift: f "Can't exceed 8 bits".
	    i := i - 1.
	    digit := self digitAt: i].
    i <= b ifTrue: [^Integer new: 0 neg: self negative].  "All bits lost"
    r := Integer new: i - b neg: self negative.
    count := i.
    x := (self digitAt: b + 1) bitShift: n.
    b + 1 to: count do: [:j |
	digit := self digitAt: j + 1.
	r digitAt: j - b put: (((digit bitAnd: m) bitShift: f) bitOr: x). 	"Avoid values > 8 bits"
	x := digit bitShift: n].
    ^r
]

Integer < aNumber
[
    aNumber isInteger
	ifTrue:
	   [self negative == aNumber negative
		ifTrue: [self negative
			     ifTrue:  [^(self digitCompare: aNumber) > 0]
			     ifFalse: [^(self digitCompare: aNumber) < 0]]
		ifFalse: [^self negative]].
    ^aNumber adaptToInteger: self andSend: #<
]

Integer digitCompare: anInteger 
[
    | length argLength digit argDigit |
    length := self digitLength.
    (argLength := anInteger digitLength) ~= length
	ifTrue:
	   [^argLength > length
		ifTrue:  [-1]
		ifFalse: [ 1]].
    [length > 0]
	whileTrue: 
	   [(argDigit := anInteger digitAt: length) ~= (digit := self digitAt: length)
		ifTrue: [^argDigit < digit
			     ifTrue:  [ 1]
			     ifFalse: [-1]].
	    length := length - 1].
    ^0
]

Integer gcd: anInteger
[
    "See Knuth, Vol 2, 4.5.2, Algorithm L"
    | higher u v k uHat vHat a b c d vPrime vPrimePrime q t |
    higher := SmallInteger maxVal highBit.
    u := self abs max: (v := anInteger abs).
    v := self abs min: v.
    [v isSmallInteger]
	whileFalse: 
	   [(uHat := u bitShift: (k := higher - u highBit)) isSmallInteger
		ifFalse: 
		   [k := k - 1.
		    uHat := uHat bitShift: -1].
	    vHat := v bitShift: k.
	    a := 1.
	    b := 0.
	    c := 0.
	    d := 1.
	    "Test quotient"
	    [(vPrime := vHat + d) ~= 0 and: [(vPrimePrime := vHat + c) ~= 0 and: [(q := uHat + a // vPrimePrime) = (uHat + b // vPrime)]]]
		whileTrue:
		   ["Emulate Euclid"
		    c := a - (q * (a := c)).
		    d := b - (q * (b := d)).
		    vHat := uHat - (q * (uHat := vHat))].
	    "Multiprecision step"
	    b = 0
		ifTrue:  [v := u rem: (u := v)]
		ifFalse:
		    [t := u * a + (v * b).
		     v := u * c + (v * d).
		     u := t]].
    ^v gcd: u
]
