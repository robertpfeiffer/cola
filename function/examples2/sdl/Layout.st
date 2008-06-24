{ import: Objects }

Layout : Object ()

"----------------------------------------------------------------"

SimpleLayout : Layout ()

SimpleLayout layout: aBox
[
    | x y w h |
    x := y := 0.
    w := aBox extent x.
    h := 0.
    aBox do: [:box || xx |
	xx := box extent x.
	(x > 0 and: [x + xx >= w])
	    ifTrue:
	       [y := y + h.
		x := h := 0].
	box position: x,y.
	x := x + xx.
	h := h max: box extent y]
]

"----------------------------------------------------------------"

KerningLayout : Layout ()

KerningLayout layout: aBox
[
    | x y w h prev |
    x := y := 2.
    w := aBox extent x - 4.
    h := 2.
    aBox do: [:box || glyph xx |
	glyph := box glyph.
	xx := glyph advance x.
	(x > 0 and: [x + xx >= w])
	    ifTrue:
	       [y := y + h + 2.
		x := h := 2.
		prev := nil].
	prev ifTrue: [x := x + (prev kerningFor: glyph) x].
	prev := glyph.
	box position: x,y.
	x := x + xx.
	h := h max: box extent y]
]
