{ import: Views }
{ import: Font }

ComposableView layout	[ self perform: (self propertyAt: #layout ifAbsent: [#yourself]) ]

ComposableView pageLayout
[
    | bounds l y w h left right |
    bounds := self bounds.
    l := bounds left + 2.
    y := bounds top - 2.
    w := bounds width - 4.
    left := self first.
    [left]
	whileTrue:
	   [right := left firstBeyondWidth: w.
	    h := left upTo: right inject: left layoutHeight into: [:maxH :v | maxH max: v layoutHeight].
	    y := y - h.
	    left upTo: right inject: l into: [:x :v | v translation: x , y.  x + v layoutWidth].
	    ((left := right) and: [left isLineBreak])
		ifTrue: [left := left nextLink]].
]

ComposableView firstBeyondWidth: width
[
    | link |
    link := self.
    [link and: [link notLineBreak and: [(width := width - link layoutWidth) > 0]]]
	whileTrue: [link := link nextLink].
    ^link
]

ComposableView verticalLayout
[
    | y |
    y := 0.
    contents reverseDo: [:v |
	v bottom: y.
	y := y + v bounds height].
]

ComposableView horizontalLayout
[
    | x |
    x := 0.
    contents do: [:v |
	v left: x.
	x := x + v bounds width].
]

ComposableView	bottom: aNumber	[ contents bottom: aNumber ]
CompositeView	bottom: aNumber	[ self do: [:v | v bottom: aNumber] ]
ShapedView	bottom: aNumber	[ shape := shape translatedBy: 0, (aNumber - shape bounds bottom) ]
TransformView	bottom: aNumber	[ self translation: 0, aNumber ]

ComposableView	left: aNumber	[ contents left: aNumber ]
CompositeView	left: aNumber	[ self do: [:v | v left: aNumber] ]
ShapedView	left: aNumber	[ shape := shape translatedBy: (aNumber - shape bounds left), 0 ]
TransformView	left: aNumber	[ self translation: aNumber, 0 ]

ComposableView layoutChanged: source	[ container layoutChanged: self ]
CompositeView layoutChanged: source	[ containers do: [:container | container layoutChanged: self] ]

ComposableView layoutWidth	[ ^self bounds width ]
ComposableView layoutHeight	[ ^self bounds height ]
ComposableView layoutBounds	[ ^self bounds ]

ComposableView isLineBreak	[ ^false ]
ComposableView notLineBreak	[ ^self isLineBreak not ]

TransformView layoutWidth	[ ^contents layoutWidth ]
TransformView layoutHeight	[ ^contents layoutHeight ]
TransformView layoutBounds	[ ^contents layoutBounds boundsTransformedBy: transform ]

TransformView isLineBreak	[ ^contents isLineBreak ]

CompositeView layoutWidth	[ ^self inject: 0 into: [:w :v | w + v layoutWidth] ]
CompositeView layoutHeight	[ ^self inject: 0 into: [:h :v | h max: v layoutHeight] ]
CompositeView layoutBounds	[ ^self inject: (self isEmpty ifTrue: [Rectangle zero] ifFalse: [self first layoutBounds]) into: [:r :v | r union: v layoutBounds] ]

CompositeView isLineBreak	[ ^self detect: [:v | v isLineBreak] ]

ShapedView layoutWidth		[ ^shape layoutWidth ]
ShapedView layoutHeight		[ ^shape layoutHeight ]
ShapedView layoutBounds		[ ^shape layoutBounds ]

ShapedView isLineBreak		[ ^shape isLineBreak ]

Shape layoutWidth		[ ^self width ]
Shape layoutHeight		[ ^self height ]
Shape layoutBounds		[ ^self bounds ]

Shape isLineBreak		[ ^false ]

Glyph layoutWidth		[ ^metrics hAdvance ]
Glyph layoutHeight		[ ^font metrics unitsPerEm ceiling max: metrics height ]
Glyph layoutBounds		[ ^0, font metrics bbMinY corner: metrics hAdvance, self layoutHeight ]

Glyph isLineBreak		[ ^codePoint == 10 or: [codePoint == 13] ]
