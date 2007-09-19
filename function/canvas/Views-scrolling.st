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
