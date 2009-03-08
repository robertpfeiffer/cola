" Colour.st -- simple colours (no alpha)

  Copyright (c) 2009 Ian Piumarta
  All rights reserved.

  Permission is hereby granted, free of charge, to any person obtaining a
  copy of this software and associated documentation files (the 'Software'),
  to deal in the Software without restriction, including without limitation
  the rights to use, copy, modify, merge, publish, distribute, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, provided that the above copyright notice(s) and this
  permission notice appear in all copies of the Software and that both the
  above copyright notice(s) and this permission notice appear in supporting
  documentation.

  THE SOFTWARE IS PROVIDED 'AS IS'.  USE ENTIRELY AT YOUR OWN RISK.

  Last edited: 2009-03-07 20:21:10 by piumarta on emilia
"

{ import: Objects }

Colour : Object ( red green blue )

Colour withR: r G: g B: b
[
    self := self new.
    red   := r.
    green := g.
    blue  := b.
]

Colour grey: g	[ ^self withR: g G: g B: g ]

Colour fromHex: hex
[
    ^self withR: hex >> 16 & 255 / 255 G: hex >> 8 & 255 / 255 B: hex & 255 / 255
]

Colour r	[ ^red ]
Colour g	[ ^green ]
Colour b	[ ^blue ]

Colour lighter			[ ^self lighter: 0.5 ]
Colour darker			[ ^self darker: 0.5 ]

Colour lighter: fraction	[ ^self mixedWith: ColourWhite ratio: 1.0 - fraction ]
Colour darker: fraction		[ ^self mixedWith: ColourBlack ratio: 1.0 - fraction ]

Colour mixedWith: aColour	[ ^self mixedWith: aColour ratio: 0.5 ]

Colour mixedWith: aColour ratio: m
[
    | n |
    n := 1.0 - m.
    ^self withR: (red   * m) + (aColour r * n)
	      G: (green * m) + (aColour g * n)
	      B: (blue  * m) + (aColour b * n)
]

Colour inverted	[ ^self withR: 1.0 - red G: 1.0 - green B: 1.0 - blue ]

ColourBlack	:= [ Colour withR: 0.0 G: 0.0 B: 0.0 ]
ColourBlue	:= [ Colour withR: 0.0 G: 0.0 B: 1.0 ]
ColourGreen	:= [ Colour withR: 0.0 G: 1.0 B: 0.0 ]
ColourCyan	:= [ Colour withR: 0.0 G: 1.0 B: 1.0 ]
ColourRed	:= [ Colour withR: 1.0 G: 0.0 B: 0.0 ]
ColourMagenta	:= [ Colour withR: 1.0 G: 0.0 B: 1.0 ]
ColourYellow	:= [ Colour withR: 1.0 G: 1.0 B: 0.0 ]
ColourWhite	:= [ Colour withR: 1.0 G: 1.0 B: 1.0 ]
