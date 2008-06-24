{ import: Objects }

Color : Object ( r g b a )

Color asColor	[]

Color withR: red withG: green withB: blue	[ ^self withR: red withG: green withB: blue withA: 255 ]

Color withR: red withG: green withB: blue withA: alpha
[
    self := self new.
    r := red   asInteger.
    g := green asInteger.
    b := blue  asInteger.
    a := alpha asInteger.
]

Color gray: percent
[
    | fraction lum |
    fraction := ((percent max: 0) min: 100) / 100.0.
    lum := (255 * fraction) rounded.
    ^self withR: lum withG: lum withB: lum withA: 255
]

Color r	[ ^r ]
Color g	[ ^g ]
Color b	[ ^b ]
Color a	[ ^a ]

ColorGray25	:= [ Color withR:  64 withG:  64 withB:  64 ]
ColorGray50	:= [ Color withR: 128 withG: 128 withB: 128 ]
ColorGray75	:= [ Color withR: 196 withG: 196 withB: 196 ]
ColorBlack	:= [ Color withR:   0 withG:   0 withB:   0 ]
ColorRed	:= [ Color withR: 255 withG:   0 withB:   0 ]
ColorGreen	:= [ Color withR:   0 withG: 255 withB:   0 ]
ColorYellow	:= [ Color withR: 255 withG: 255 withB:   0 ]
ColorBlue	:= [ Color withR:   0 withG:   0 withB: 255 ]
ColorMagenta	:= [ Color withR: 255 withG:   0 withB: 255 ]
ColorCyan	:= [ Color withR:   0 withG: 255 withB: 255 ]
ColorWhite	:= [ Color withR: 255 withG: 255 withB: 255 ]
ColorNone	:= [ Color withR:   0 withG:   0 withB:   0 withA:   0 ]

Color printOn: aStream
[
    aStream
	nextPut: $(; print: self r;
	nextPut: $,; print: self g;
	nextPut: $,; print: self b;
	nextPut: $,; print: self a;
	nextPut: $)
]
