{ import: Object }
{ import: Colour }
{ import: Font }
{ import: Views }

String asCompositeView
[
    ^self asCompositeViewWithFont: Font default
]

String asCompositeViewWithFont: aFont
[
    | text |
    text := CompositeView new.
    self inject: 0 into: [:x :codePoint |
	| glyph |
	text addLast: (((glyph := aFont glyphAt: codePoint) shapedView fillColour: Colour black)
			   transformView translate: x @ 0).
	x + glyph metrics hAdvance].
    ^text
]

CompositeView asString
[
    | stream |
    stream := WriteStream on: (String new: 32).
    self do: [:view |
	| glyph |
	(view isTransformView
		and: [view notEmpty
		and: [(glyph := view first) isShapedView
		and: [(glyph := glyph shape) isGlyph]]])
	    ifTrue: [stream nextPut: glyph codePoint & 255]].
    ^stream contents
]
