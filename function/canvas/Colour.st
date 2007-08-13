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

Colour withH: h S: s B: b	[ ^self  withH: h S: s B: b A: 1.0 ]

Colour withH: h S: s B: b A: a
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
    i == 0 ifTrue: [^Colour withR: b G: t B: p].
    i == 1 ifTrue: [^Colour withR: q G: b B: p].
    i == 2 ifTrue: [^Colour withR: p G: b B: t].
    i == 3 ifTrue: [^Colour withR: p G: q B: b].
    i == 4 ifTrue: [^Colour withR: t G: p B: b].
    i == 5 ifTrue: [^Colour withR: b G: p B: q].
    ^ColourBlack
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

Colour lighter			[ ^self mixedWith: ColourWhite ratio: 0.5 ]
Colour darker			[ ^self mixedWith: ColourBlack ratio: 0.5 ]

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
    0 to: n - 1 do: [:i | a at: i put: (self withH: h + i * step S: s B: b)].
    ^a
]
