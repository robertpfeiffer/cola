" Views-scrolling.st -- clipping + transformation = scrolling

  Copyright (c) 2007 Ian Piumarta
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

  Last edited: 2007-09-18 20:13:42 by piumarta on emilia
"

{ import: Views }

ClippingView : ShapedView ()

ClippingView drawOn: aCanvas in: clipRectangle
[
    | clip |
    clip := clipRectangle intersect: self bounds.
    aCanvas save; setClipRectangle: clip.
    super drawOn: aCanvas in: clip.
    aCanvas restore.
]

Shape clippingView	[ ^ClippingView withShape: self ]

"----------------------------------------------------------------"

ScrollingView : ClippingView (
    translation
    scrollerView
)

ScrollingView withShape: aShape
[
    self := super withShape: aShape.
    translation := Pair zero.
]

Shape scrollingView	[ ^ScrollingView withShape: self ]

ScrollingView scrollerView: aView
[
    scrollerView := aView.
    scrollerView scrollRegion: (self bounds proportionsIn: (contents layoutBounds translatedBy: translation)).
]

ScrollingView drawContentsOn: aCanvas in: clipRectangle
[
    aCanvas save; translate: translation.
    super drawContentsOn: aCanvas in: (clipRectangle translatedBy: translation negated).
    aCanvas restore.
]

ScrollingView damaged: damageRect
[
    | bounds |
    bounds := self bounds.
    scrollerView scrollRegion: (bounds proportionsIn: (contents layoutBounds translatedBy: translation)).
    super damaged: ((damageRect translatedBy: translation) intersect: bounds).
    scrollerView damaged.
]

ScrollingView scrollProportionally: aPoint
[
    aPoint := aPoint * contents layoutBounds extent.
    translation := translation - aPoint.
    self damaged.
]

ScrollingView scrollTo: targetRectangle
[
    (shape bounds contains: (targetRectangle translatedBy: translation))
	ifFalse: [self centreOn: targetRectangle].
]

ScrollingView centreOn: targetRectangle
[
    | bounds layout x y |
    bounds := shape bounds.
    layout := contents layoutBounds.
    x := (0 max: targetRectangle right - bounds right).
    y := (0 max: bounds centre y - targetRectangle centre y) min: (bounds bottom - contents layoutBounds bottom).
    translation := x , y.
]

ScrollingView applyTransform: aPointOrShape
[
    ^aPointOrShape translatedBy: translation negated
]

ScrollingView globalToLocal: aPointOrShape
[
    ^(super globalToLocal: aPointOrShape) translatedBy: translation negated
]

"----------------"

ScrollerView : ShapedView ( scrollBar scrollingView )

ScrollerView handleEvent: anEvent at: aPoint
[
    ^super handleEvent: anEvent at: aPoint
]

ScrollerView scrollBar: aView
[
    self add: (scrollBar := aView).
]

ScrollerView scrollingView: aView
[
    scrollingView := aView.
    aView scrollerView: self.
]

ScrollerView scrollRegion: aRectangle
[
    | e |
    e := self bounds extent.
    scrollBar shape: (aRectangle origin * e corner: aRectangle corner * e).
]

ScrollerView translateBy: aPoint
[
    | innerBounds outerBounds range |
    innerBounds := scrollBar bounds.
    outerBounds := self bounds.
    range := outerBounds extent - innerBounds extent.
    aPoint := aPoint max: outerBounds origin - innerBounds origin.
    aPoint := aPoint min: outerBounds corner - innerBounds corner.
    aPoint := aPoint / outerBounds extent.
    scrollingView scrollProportionally: aPoint.
]

ComposableView scrollerView
[
    ^(ScrollerView withShape: self bounds)
	scrollBar: self;
	fillColour: Colour grey lighter
]

"----------------------------------------------------------------"

ComposableView withVerticalScrollBar
[
    | scroller view |
    scroller := ((Rectangle zero corner: 10, self bounds height) shapedView fillColour: Colour grey lighter lighter) scrollerView.
    scroller scrollingView: self.
    scroller propertyAt: #pointerDownEvent put: [:v :event | event handler beginDragging: v from: event].
    view := self transformView.
    view add: (scroller transformView translation: self bounds bottomRight).
    ^view
]
