{ import: HostWindow }
{ import: View }
{ import: Text }

"----------------------------------------------------------------"

World : View ( window fonts fontIndex glyphs rotating scale stepping )

World bounds
[
    ^Rectangle origin: 0,0 corner: window extent
]

World pathOn: aCanvas
[
    ^aCanvas rectangle: (0,0 corner: window extent)
]

World addRotating: index font: font at: position
[
    | gv tv |
    "gv := ShapedView withShape: ((OldFont named: 'arial-iso15' pointSize: 32) glyphAt: index)."
    gv := ShapedView withShape: (font glyphAt: index).
    glyphs add: gv.
    gv fillColour: Colour black.
    tv := gv transformView.
    tv add: (gv bounds expanded			shapedView strokeColour: (Colour withR: 1 G: 0 B: 0 A: 0.2)).
    "tv add: (font metrics bounds		shapedView strokeColour: (Colour withR: 0 G: 1 B: 0 A: 0.5))."
    tv add: ((-0.5 , -0.5 corner: 0.5 , 0.5)	shapedView strokeColour: (Colour withR: 1 G: 0 B: 0 A: 0.5)).
"
    tv translation: gv bounds extent negated / (2,2).
    tv := tv transformView.
"
    rotating add: tv.
    tv := tv transformView.
    tv add: ((0 , 0 corner: font metrics unitsPerEm , font metrics unitsPerEm)
						shapedView strokeColour: (Colour withR: 0 G: 1 B: 0 A: 0.5)).
    tv translation: position.
    self add: tv.
]

World setup
[
    | size font w h |
    size := 24.
    fonts := OrderedCollection new
	add: (Font serif medium roman  	pointSize: size);
	add: (Font serif medium italic 	pointSize: size);
	add: (Font serif bold   roman  	pointSize: size);
	add: (Font serif bold   italic 	pointSize: size);
	add: (Font sans	 medium roman  	pointSize: size);
	add: (Font sans	 medium italic  pointSize: size);
	add: (Font sans	 bold   roman  	pointSize: size);
	add: (Font sans	 bold   italic	pointSize: size);
	add: (Font mono	 medium roman  	pointSize: size);
	add: (Font mono	 medium italic	pointSize: size);
	add: (Font mono	 bold   roman  	pointSize: size);
	add: (Font mono	 bold   italic	pointSize: size);
	yourself.
    font := fonts first.
    fontIndex := 0.
    w := font metrics unitsPerEm.
    h := font metrics unitsPerEm.
    "StdOut println: font metrics width; println: font metrics height; println: font metrics bounds."
    glyphs := OrderedCollection new.
    rotating := OrderedCollection new.
    fillColour := Colour white "Colour withR: 0.4 G: 0.6 B: 0.8".
    0 to: 255 do: [:i | self addRotating: i font: font at: (i \\ 16 * w + 64) , (window height - 96 - (i // 16 * h))].
    scale := 1.0.
    stepping := false.
    w := 720.
    h := 500.
    self add: (('controls:' asCompositeViewWithFont: (Font mono bold pointSize: 12)) translateBy: w, h).
    #('     +  grow heading'     '     -  shrink heading'    '     0  reset heading'
      '     1  next family'      '     2  next series'       '     3  next shape'
      '    up  next typeface'    '  down  previous typeface'
      '  left  rotate left'      ' right  rotate right'
      ' space  autorotate'       'escape  bye bye')
	do: [:s | self add: ((s asCompositeViewWithFont: (Font mono pointSize: 10)) translateBy: w, (h := h - 20))].
]

World step
[
    self rotateBy: Float pi / 100.0
]

World rotateBy: angle
[
    rotating do: [:v | v rotateBy: angle].
]

World fontBy: offset
[
    | font |
    fontIndex := fontIndex + offset + fonts size \\ fonts size.
    font := fonts at: fontIndex.
    glyphs do: [:g | g shape: (g shape font: font)].
]

World fontFlip: mask
[
    | font |
    fontIndex := fontIndex ^ mask \\ fonts size.
    font := fonts at: fontIndex.
    glyphs do: [:g | g shape: (g shape font: font)].
]

World scaleBy: factor
[
    scale := scale * factor.
]

World scaleTo: factor
[
    scale := factor.
]

World stepToggle
[
    stepping := stepping not.
]

World drawIn: clipRectangle
[
    | ctx view font |
    clipRectangle
	ifTrue:
	   [ctx := window newPainter.
	    (clipRectangle contains: window bounds)
		ifFalse:
		   [ctx setSource: Colour black; rectangle: (clipRectangle outsetBy: 1.0) expanded; stroke.
		    ctx setClipRectangle: (clipRectangle outsetBy: 1.0) expanded].
	    self drawOn: ctx in: clipRectangle.
	    ""
	    font := (fonts at: fontIndex) pointSize: 28.
	    ctx	translate: (256.0 / (scale max: 1.0)) , (window height - 20 - (22 * scale)); scale: scale,scale.
	    ctx save; setSource: Colour blue; string: (font typeface name) font: font; fill; restore.
	    (scale between: 0.9 and: 1.1)
		ifFalse: [ctx setSource: Colour red.
			 (fonts at: fontIndex) typeface name do: [:c | ctx glyphPoints: (font glyphAt: c); translate: (font glyphAt: c) metrics hAdvance , 0].
			 ctx stroke].
	    ""
	    ctx destroy.
	    window swapBuffers"; sync".
	    {
#	      if 0
		static int count= 0;
		if ((count++ % 100) == 0) printf("%7ld %7ld %7ld\n", GC_get_heap_size(), GC_get_free_bytes(), GC_get_bytes_since_gc());
#	      endif
	    }]
]

World draw
[
    self drawIn: window bounds.
]

World run
[
    | evt |
    window := HostWindow withExtent: 1024,768"1600,1000".
    self setup.
    self draw.
    [stepping
	 ifTrue:  [self dispatchEvent: window pollEvent; step; draw]
	 ifFalse: [self dispatchEvent: window waitEvent]]
      repeat.
]

World dispatchEvent: anEvent
[
    | view |
    anEvent ifFalse: [^self].
    anEvent handler: self.
    self handleEvent: anEvent.
]

World keyDownEvent :anEvent
[
    | ucs4 state |
    window purge.
    ucs4 := anEvent ucs4.
    ucs4 == 0x11 ifTrue: [^self rotateBy: (Float pi / 20.00)        ; draw].
    ucs4 == 0x12 ifTrue: [^self fontBy:    1                        ; draw].
    ucs4 == 0x13 ifTrue: [^self rotateBy: (Float pi / 20.00) negated; draw].
    ucs4 == 0x14 ifTrue: [^self fontBy:   -1                        ; draw].
    ucs4 == $+ 	 ifTrue: [^self scaleBy:   2.0                      ; draw].
    ucs4 == $= 	 ifTrue: [^self scaleBy:   2.0                      ; draw].
    ucs4 == $- 	 ifTrue: [^self scaleBy:   0.5                      ; draw].
    ucs4 == $_ 	 ifTrue: [^self scaleBy:   0.5                      ; draw].
    ucs4 == $0   ifTrue: [^self scaleTo:   1.0                      ; draw].
    ucs4 == $1   ifTrue: [^self fontBy:    4                        ; draw].
    ucs4 == $2   ifTrue: [^self fontFlip:  2                        ; draw].
    ucs4 == $3   ifTrue: [^self fontFlip:  1                        ; draw].
    ucs4 == $    ifTrue: [^self stepToggle			    ; draw].
    ucs4 == 27   ifTrue: [^OS exit: 0].
    StdOut println: ucs4.
]

[ World new run ]
