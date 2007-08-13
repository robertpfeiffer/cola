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

CompositeView addFirst: aView	[ aView container: self.  ^super addFirst: aView ]
CompositeView addLast: aView	[ aView container: self.  ^super addLast: aView ]
CompositeView add: aView	[ aView container: self.  ^super addLast: aView ]

CompositeView printContentsOn: aStream	[]

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
    self := super new.
    contents := CompositeView withContainer: self.
]

ComposableView contents	[ ^contents ]

ComposableView container
[
    ^container
]

ComposableView container: aView
[
    container ifTrue: [self error: 'this view already has a container'].
    container := aView.
]

ComposableView add: aView	[ ^contents addLast: aView ]
ComposableView addFirst: aView	[ ^contents addFirst: aView ]
ComposableView addLast: aView	[ ^contents addLast: aView ]

ComposableView isEmpty		[ ^contents isEmpty ]
ComposableView notEmpty		[ ^contents notEmpty ]
ComposableView first		[ ^contents first ]

"----------------------------------------------------------------"

" A TransformView modifies the coordinate system of its contents. "

TransformView : ComposableView (
    translation	"Point vector by which I translate the coordinate system's origin"
    rotation	"Number giving the angle in radians by which rotate the coordinate system about the (possibly translated) origin"
)

TransformView isTransformView	[ ^self ]
Object isTransformView		[ ^nil ]

TransformView translate: aPoint	[  translation := aPoint ]
TransformView translation	[ ^translation ifNil: [0@0] ]
TransformView rotate: aNumber	[  rotation := aNumber ]
TransformView rotation		[ ^rotation ifNil: [0] ]

ComposableView transformView
[
    ^TransformView new
	add: self;
	yourself
]

CompositeView transformView
[
    ^TransformView withContents: self
]

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
