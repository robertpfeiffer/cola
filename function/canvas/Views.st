" Views.st -- the basic View hierarchy

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

  Last edited: 2007-09-18 20:12:44 by piumarta on emilia
"

{ import: Object }
{ import: Colour }
{ import: Shape }

"----------------------------------------------------------------"

" A CompositeView is a logical grouping of an arbitray number of
  sibling views.  The group as a whole can provide content for an
  arbitrary number of parent containers. "

CompositeView : LinkedList (
    containers	"OrderedCollection of all Views for which I hold the contents"
    properties	"IdentityDictionary of properties"
)

CompositeView new
[
    self := super new.
    containers := OrderedCollection new.
]

CompositeView withContainer: aView
[
    self := self new.
    containers add: aView.
]

CompositeView addContainer: aView
[
    containers add: aView.
]

CompositeView addFirst: aView		[ aView container: self.  ^super addFirst: aView ]
CompositeView addLast: aView		[ aView container: self.  ^super addLast: aView ]
CompositeView add: aView		[ aView container: self.  ^super addLast: aView ]
CompositeView add: aView before: bView	[ aView container: self.  ^super add: aView before: bView ]
CompositeView add: aView after: bView	[ aView container: self.  ^super add: aView after: bView ]

CompositeView remove: aView
[
    super remove: aView.
    aView container: nil.
    ^aView
]

CompositeView printContentsOn: aStream	[]

_object asOop	{ _return((oop)((long)self << 1 | 1)); }

CompositeView printOn: aStream
[
    super printOn: aStream.
    aStream nextPut: $-; print: self asOop
]

"----------------------------------------------------------------"

" A ComposableView can be combined with other views in a hierarchical
  fashion.  (The structure is actually be a bipartite graph, somewhat
  more general than a simple tree-like hierarchy.) "

ComposableView : Link (
    container	"CompositeView of which I am a member and for which I provide content"
    contents	"CompositeView of other views that provide my content"
    properties	"IdentityDictionary of properties"
)

ComposableView withContents: contentsCollection
[
    self := super new.
    contents := contentsCollection addContainer: self.
]

ComposableView new
[
    ^self withContents: CompositeView new.
]

ComposableView contents		[ ^contents ]
ComposableView container	[ ^container ]

ComposableView container: aView
[
    (aView and: [container]) ifTrue: [self error: 'this view already has a container'].
    container := aView.
]

ComposableView add: aView		[ ^contents addLast: aView ]
ComposableView addFirst: aView		[ ^contents addFirst: aView ]
ComposableView addLast: aView		[ ^contents addLast: aView ]
ComposableView add: aView before: bView	[ ^contents add: aView before: bView ]
ComposableView add: aView after: bView	[ ^contents add: aView after: bView ]

ComposableView removeFirst		[ ^contents removeFirst ]
ComposableView removeLast		[ ^contents removeLast ]
ComposableView remove: aView		[ ^contents remove: aView ]

ComposableView removeFrom: firstView to: lastView
[
    | next |
    [next := firstView nextLink.
     self remove: firstView.
     firstView ~~ lastView and: [firstView := next]]
	whileTrue
]

ComposableView isEmpty		[ ^contents isEmpty ]
ComposableView notEmpty		[ ^contents notEmpty ]
ComposableView first		[ ^contents first ]
ComposableView last		[ ^contents last ]

ComposableView printOn: aStream
[
    super printOn: aStream.
    aStream nextPut: $-; print: self asOop
]

"----------------------------------------------------------------"

{ import: Transform }

" A TransformView modifies the coordinate system of its contents. "

TransformView : ComposableView (
    transform	"Transform2D -- transforms my coordinate system into that of my inferior views"
    inverse	"Transform2D -- the inverse of my transform (cached for speed)"
)

TransformView withContents: aCompositeView
[
    self := super withContents: aCompositeView.
    inverse := transform := Transform2D withIdentity.
]

TransformView isTransformView	[ ^self ]
Object isTransformView		[ ^nil ]

TransformView translation: aPair	[  inverse := (transform := Transform2D withTranslation: aPair) inverted ]
TransformView rotation: aNumber		[  inverse := (transform := Transform2D withRotation: aNumber) inverted ]
TransformView scaling: aPair		[  inverse := (transform := Transform2D withScaling: aPair) inverted ]

TransformView translateBy: aPair	[  inverse := (transform translateBy: aPair) inverted ]
TransformView rotateBy: aNumber		[  inverse := (transform rotateBy: aNumber) inverted ]
TransformView scaleBy: aPair		[  inverse := (transform scaleBy: aPair) inverted ]

ComposableView transformView	[ ^TransformView new add: self; yourself ]
CompositeView  transformView	[ ^TransformView withContents: self ]

ComposableView translateBy: aPair	[ ^self transformView translateBy: aPair ]
ComposableView rotateBy: aPair		[ ^self transformView rotateBy: aPair ]
ComposableView scaleBy: aPair		[ ^self transformView scaleBy: aPair ]

CompositeView  translateBy: aPair	[ ^self transformView translateBy: aPair ]
CompositeView  rotateBy: aPair		[ ^self transformView rotateBy: aPair ]
CompositeView  scaleBy: aPair		[ ^self transformView scaleBy: aPair ]

"----------------------------------------------------------------"

" A View is an abstract ComposableView having a shape that can be
  displayed and/or interacted with.  Concrete Subtypes must implement
  #pathOn: and #bounds. "

View : ComposableView (
    fillColour		"Colour that will fill my associated shape"
    strokeColour	"Colour that will outline my associated shape"
    strokeWidth		"Number measuring the width of my stroked outline"
)

View fillColour: aColour	[  fillColour := aColour ]
View fillColour			[ ^fillColour ]
View strokeColour: aColour	[  strokeColour := aColour ]
View strokeColour		[ ^strokeColour ]
View strokeWidth: aNumber	[  strokeWidth := aNumber ]
View strokeWidth		[ ^strokeWidth ]

"----------------------------------------------------------------"

" A ShapedView provides its displayable path via a Shape. "

ShapedView : View (
    shape	"Shape of my displayable path"
)

ShapedView isShapedView	[ ^self ]
Object isShapedView	[ ^nil ]

ShapedView withShape: aShape
[
    self := super new.
    shape := aShape.
]

ShapedView shape		[ ^shape ]
ShapedView shape: aShape	[  shape := aShape ]

Shape shapedView
[
    ^ShapedView withShape: self
]

ShapedView printOn: aStream
[
    super printOn: aStream.
    aStream
	nextPut: $(;
	print: shape;
	nextPut: $)
]
