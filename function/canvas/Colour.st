{ import: Object }

SmallInteger floor	[ ^self ]

Colour : Object ( rChannel gChannel bChannel aChannel )

Colour withR: r G: g B: b	[ ^self withR: r G: g B: b A: 1.0 ]

Colour withR: r G: g B: b A: a
[
    self := self new.
    rChannel := r.
    gChannel := g.
    bChannel := b.
    aChannel := a.
]

Colour copy		[ ^self withR: rChannel G: gChannel B: bChannel A: aChannel ]

Colour copyWithAlpha: a	[ ^self withR: rChannel G: gChannel B: bChannel A: a ]

Colour r [ ^rChannel ]
Colour g [ ^gChannel ]
Colour b [ ^bChannel ]
Colour a [ ^aChannel ]

Colour _a8r8g8b8
[
    | _a8 _r8 _g8 _b8 _a8r8g8b8 |
    _a8 := (aChannel            * 255.0) asInteger _integerValue.
    _r8 := (aChannel * rChannel * 255.0) asInteger _integerValue.
    _g8 := (aChannel * gChannel * 255.0) asInteger _integerValue.
    _b8 := (aChannel * bChannel * 255.0) asInteger _integerValue.
    {
        v__a8r8g8b8= (oop)(((int) v__a8 << 24) | ((int) v__r8 << 16) | ((int) v__g8 <<  8) |  (int) v__b8);
    }.
    ^_a8r8g8b8
]

Colour withH: h S: s V: b	[ ^self  withH: h S: s V: b A: 1.0 ]

Colour withH: h S: s V: b A: a
[
    | h60 i f p q t |
    s <= 0.0001 ifTrue: [^self withR: b G: b B: b A: 1.0].
    h   := h rounded \\ 360.
    h60 := h asFloat / 60.
    i   := h60 truncated.
    f   := h60 - i.
    p   := (1.0 - s) * b.
    q   := (1.0 - (s * f)) * b.
    t   := (1.0 - (s * (1.0 - f))) * b.
    i == 0 ifTrue: [^Colour withR: b G: t B: p A: a].
    i == 1 ifTrue: [^Colour withR: q G: b B: p A: a].
    i == 2 ifTrue: [^Colour withR: p G: b B: t A: a].
    i == 3 ifTrue: [^Colour withR: p G: q B: b A: a].
    i == 4 ifTrue: [^Colour withR: t G: p B: b A: a].
    i == 5 ifTrue: [^Colour withR: b G: p B: q A: a].
    ^Colour withR: 0 G: 0 B: 0 A: a
]

Colour h
[
    | max min span h |
    max := ((rChannel max: gChannel) max: bChannel).
    min := ((rChannel min: gChannel) min: bChannel).
    span := max - min.
    span = 0.0 ifTrue: [^0.0].
    h := rChannel = max
	ifTrue: [((gChannel - bChannel) asFloat / span) * 60.0]
	ifFalse:
	   [gChannel = max
		ifTrue:  [120.0 + (((bChannel - rChannel) asFloat / span) * 60.0)]
		ifFalse: [240.0 + (((rChannel - gChannel) asFloat / span) * 60.0)]].
    ^h < 0.0 ifTrue: [h + 360.0] ifFalse: [h]
]

Colour s
[
    | max min |
    max := min := rChannel.
    gChannel > max ifTrue: [max := gChannel].
    bChannel > max ifTrue: [max := bChannel].
    gChannel < min ifTrue: [min := gChannel].
    bChannel < min ifTrue: [min := bChannel].
    ^max = 0
	ifTrue:  [0.0]
	ifFalse: [(max - min) / max]
]

Colour v
[
    ^rChannel max: (gChannel max: bChannel)
]

ColourBlack	:= [ Colour withR: 0.0 G: 0.0 B: 0.0 A: 1.0 ]	Colour black	 [ ^ColourBlack	  ]
ColourRed	:= [ Colour withR: 1.0 G: 0.0 B: 0.0 A: 1.0 ]	Colour red	 [ ^ColourRed	  ]
ColourGreen	:= [ Colour withR: 0.0 G: 1.0 B: 0.0 A: 1.0 ]	Colour green	 [ ^ColourGreen	  ]
ColourBlue	:= [ Colour withR: 0.0 G: 0.0 B: 1.0 A: 1.0 ]	Colour blue	 [ ^ColourBlue	  ]
ColourYellow	:= [ Colour withR: 1.0 G: 1.0 B: 0.0 A: 1.0 ]	Colour yellow	 [ ^ColourYellow  ]
ColourMagenta	:= [ Colour withR: 1.0 G: 0.0 B: 1.0 A: 1.0 ]	Colour magenta	 [ ^ColourMagenta ]
ColourCyan	:= [ Colour withR: 0.0 G: 1.0 B: 1.0 A: 1.0 ]	Colour cyan	 [ ^ColourCyan	  ]
ColourWhite	:= [ Colour withR: 1.0 G: 1.0 B: 1.0 A: 1.0 ]	Colour white	 [ ^ColourWhite	  ]

ColourDarkGrey	:= [ Colour withR: 0.2 G: 0.2 B: 0.2 A: 1.0 ]	Colour darkGrey	 [ ^ColourDarkGrey  ]
ColourGrey	:= [ Colour withR: 0.5 G: 0.5 B: 0.5 A: 1.0 ]	Colour grey	 [ ^ColourGrey	    ]
ColourLightGrey	:= [ Colour withR: 0.8 G: 0.8 B: 0.8 A: 1.0 ]	Colour lightGrey [ ^ColourLightGrey ]

Colour lighter			[ ^self lighter: 0.5 ]
Colour darker			[ ^self darker: 0.5 ]

Colour lighter: fraction	[ ^self mixedWith: ColourWhite ratio: 1.0 - fraction ]
Colour darker: fraction		[ ^self mixedWith: ColourBlack ratio: 1.0 - fraction ]

Colour mixedWith: aColour	[ ^self mixedWith: aColour ratio: 0.5 ]

Colour mixedWith: aColour ratio: m
[
    | n |
    n := 1.0 - m.
    ^self withR: (rChannel * m) + (aColour r * n)
	  G:     (gChannel * m) + (aColour g * n)
	  B:     (bChannel * m) + (aColour b * n)
	  A:     (aChannel)
]

Colour inverted	[ ^self withR: 1.0 - rChannel G: 1.0 - gChannel B: 1.0 - bChannel A: aChannel ]

Colour printOn: aStream
[
    super printOn: aStream.
    aStream
	nextPut: $(;
	print: rChannel; space; print: gChannel; space; print: bChannel; space; print: aChannel;
	nextPut: $)
]


ColourWheelCache := [ IdentityDictionary new ]


Colour wheel: n
[
    ^ColourWheelCache
	at: n
	ifAbsent: [ColourWheelCache at: n put: (self wheel: n h: 0.0 s: 0.9 b: 0.7)]
]

Colour wheel: n h: h s: s b: b
[
    | a step |
    a := Array new: n.
    step := 360.0 / (n max: 1).
    0 to: n - 1 do: [:i | a at: i put: (self withH: h + i * step S: s V: b)].
    ^a
]
