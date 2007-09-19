{ import: View }
{ import: Views-button }
{ import: Text }

"----------------------------------------------------------------"

World : WorldView ( launcher )

EchoSelector : Object ()
EchoSelector select: aKey	[ StdOut println: aKey ]

World select: aKey	[ self perform: aKey ]

IdentityDictionary selectionView: target
[
    | group selectionView inset |
    group := ButtonGroup new.
    (selectionView := TransformView new) propertyAt: #layout put: #verticalLayout.
    inset := Font metrics height - Font metrics unitsPerEm.
    self do: [:assoc |
	| key value button buttonView |
	key := assoc key.
	value := assoc value.
	group add: (button := Button new).
	button onBlock: [:b | target select: value].
	button offBlock: [:b | target select: nil].
	buttonView := (Rectangle zero corner: 100, Font metrics height ceiling) buttonView: button.
	buttonView add: (key asString stringView transformView translation: inset,inset).
	buttonView propertyAt: #pointerMotionEvent put: [:v :e | e handler beginButton: v].
	selectionView add: buttonView transformView].
    selectionView layout.
    ^selectionView
]

IdentityDictionary menuView: target
[
    | group selectionView inset |
    group := ButtonGroup new.
    (selectionView := TransformView new) propertyAt: #layout put: #verticalLayout.
    inset := Font metrics height - Font metrics unitsPerEm.
    self do: [:assoc |
	| key value button buttonView |
	key := assoc key.
	value := assoc value.
	group add: (button := Button new).
	button onBlock: [:b | target select: value.  b off].
	buttonView := (Rectangle zero corner: 100, Font metrics height ceiling) buttonView: button.
	buttonView add: (key asString stringView transformView translation: inset,inset).
	buttonView propertyAt: #pointerMotionEvent put: [:v :e | e handler beginButton: v].
	selectionView add: buttonView transformView].
    selectionView layout.
    ^selectionView
]

"----------------------------------------------------------------"

GravityVector := [ 0.03 , -0.5 ]

Recycling := [ false ]

Polygons := [ nil ]
Particles := [ nil ]

Particle : ShapedView ()

Particle new
[
    self := super withShape: (Polygon newStar: 5 innerRadius: Random next * 8.0 outerRadius: Random next * 16.0).
    self fillColour: Colour red.
]

ParticleView : TransformView ( velocityVector rotationSpeed locked )

ParticleView initialise
[
    self translation: 500,20.
    velocityVector := (Random next - 0.5 * 4.0) , (2.0 + Random next * 8.0).
    rotationSpeed := velocityVector x / -20.
]

ParticleView step
[
    (Pair zero transformedBy: transform) y < 0
	ifTrue:
	   [| fillColour |
	    fillColour := contents first fillColour.
	    self initialise.
	    contents first fillColour: (Colour withR: fillColour g G: fillColour b B: fillColour r).
	    Recycling := true].
    self rotateBy: rotationSpeed.
    locked ifTrue: [^self].
    self damaged.
    self translateBy: velocityVector.
    self damaged.
    velocityVector := velocityVector + GravityVector.
]

World step
[
    Recycling
	ifFalse:
	   [| pv |
	    pv := ParticleView new initialise.
	    pv add: Particle new.
	    self addFirst: pv.
	    Particles add: pv].
    Particles do: [:pv | pv step].
    Polygons do: [:polygon |
	polygon damaged.
	polygon rotateBy: 0.01745329251994329576.
	polygon damaged].
]

World setup0
[
    | polygon |
    self fillColour: (Colour withR: 0.4 G: 0.6 B: 0.8).
    Polygons := OrderedCollection new.
    Particles := OrderedCollection new.
    1 timesRepeat:
       [polygon := ShapedView withShape: (Polygon newStar: 24 innerRadius: 10 outerRadius: 100).
	polygon fillColour: Colour yellow.
	polygon := ParticleView new add: polygon; yourself.
	polygon translation: 430,430.
	self add: (Polygons add: polygon)].
    "self add: (((0,0 corner: 300,400) shapedView fillColour: Colour blue lighter) transformView translation: 200,200)."
    stepper := [self step].
]

"----------------------------------------------------------------"

Fonts := [ nil ]
FontIndex := [ nil ]
Glyphs := [ nil ]
Rotating := [ nil ]
Scale := [ nil ]

World setup1
[
    | hRes vRes size font w h |
    size := 24.
    hRes := 355 "window widthInMillimetres".
    vRes := 568 "window heightInMillimetres".
    StdOut print: hRes; tab; print: vRes; tab; println: (25.4 / hRes asFloat * 1000"self width")"window dpi".
    Fonts := OrderedCollection new
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
    font := Fonts first.
    FontIndex := 0.
    w := font metrics unitsPerEm.
    h := font metrics unitsPerEm.
    "StdOut println: font metrics width; println: font metrics height; println: font metrics bounds."
    Glyphs := OrderedCollection new.
    Rotating := OrderedCollection new.
    fillColour := Colour white "Colour withR: 0.4 G: 0.6 B: 0.8".
    0 to: 255 do: [:i | self addRotating: i font: font at: (i \\ 16 * w + 64) , (800"window height" - 96 - (i // 16 * h))].
    Scale := 1.0.
    stepper := nil.
]

World addRotating: index font: font at: position
[
    | gv tv |
    "gv := ShapedView withShape: ((OldFont named: 'arial-iso15' pointSize: 32) glyphAt: index)."
    gv := ShapedView withShape: (font glyphAt: index).
    Glyphs add: gv.
    gv fillColour: Colour black.
    tv := gv transformView.
    tv add: (gv bounds expanded			shapedView strokeColour: (Colour withR: 1 G: 0 B: 0 A: 0.2)).
    "tv add: (font metrics bounds		shapedView strokeColour: (Colour withR: 0 G: 1 B: 0 A: 0.5))."
    tv add: ((-0.5 , -0.5 corner: 0.5 , 0.5)	shapedView strokeColour: (Colour withR: 1 G: 0 B: 0 A: 0.5)).
"
    tv translation: gv bounds extent negated / (2,2).
    tv := tv transformView.
"
    Rotating add: tv.
    tv := tv transformView.
    tv add: ((0 , 0 corner: font metrics unitsPerEm , font metrics unitsPerEm)
						shapedView strokeColour: (Colour withR: 0 G: 1 B: 0 A: 0.5)).
    tv translation: position.
    self add: tv.
]

"----------------------------------------------------------------"

World setup2
[
    | text editor button y dy group buttons list menu |
    self fillColour: (Colour withR: 0.4 G: 0.6 B: 0.8).

    text := (Rectangle zero corner: 300,200) scrollingView fillColour: Colour white.
    editor := text textEditor.
    1 to: 20 do: [:i | editor inputString: 'hello ', i printString, '\n'].
    text layout; scrollTo: editor caret bounds.
    text := self add: ((text withVerticalScrollBar withTitle: 'Workspace') translation: 100,100).

""
    self add: (((TransformView withContents: text contents) translateBy: -20,-200; rotateBy: 1.0; scaleBy: 0.5,0.5) withTitle: 'Workspace copy').
""

    y := 200.
    dy := Font metrics height.

    self
	addButton: 'One'	to: self at: 500,(y := y - dy);
	addButton: 'Two'	to: self at: 500,(y := y - dy);
	addButton: 'Three'	to: self at: 500,(y := y - dy);
	addButton: 'Four'	to: self at: 500,(y := y - dy).

    group := ButtonGroup new.
    y := 500.
    dy := Font metrics height.

    (buttons := TransformView new) propertyAt: #layout put: #verticalLayout.
    group
	add: (self addButton: 'one'	to: buttons at: Pair zero);
	add: (self addButton: 'two'	to: buttons at: Pair zero);
	add: (self addButton: 'three'	to: buttons at: Pair zero);
	add: (self addButton: 'four'	to: buttons at: Pair zero).
    self add: buttons.
    buttons layout; translation: 700,200.

    list := IdentityDictionary new.
    #(zero one two three four five six seven eight nine ten) doWithIndex: [:n :i | list at: n put: i].
    list := list selectionView: EchoSelector.
    list propertyAt: #layout put: #verticalLayout.
    list layout.

    self add: ((((Pair zero corner: 100,50) scrollingView fillColour: Colour white)
		    add: list;
		    yourself)
		   withVerticalScrollBar translation: 500,500).
]

"----------------------------------------------------------------"

World setup
[
    | text editor button y dy group buttons list menu |
    self fillColour: (Colour withR: 0.4 G: 0.6 B: 0.8).

    text := (Rectangle zero corner: 300,200) scrollingView fillColour: Colour white.
    editor := text textEditor.
    1 to: 20 do: [:i | editor inputString: 'hello ', i printString, '\n'].
    text layout; scrollTo: editor caret bounds.
    text := self add: ((text withVerticalScrollBar withTitle: 'Workspace') translation: 100,100).

    self add: (((TransformView withContents: text contents) translateBy: -20,-200; rotateBy: 1.0; scaleBy: 0.5,0.5)
		   withTitle: 'Workspace copy').

    y := 200.
    dy := Font metrics height.

    self
	addButton: 'One'	to: self at: 500,(y := y - dy);
	addButton: 'Two'	to: self at: 500,(y := y - dy);
	addButton: 'Three'	to: self at: 500,(y := y - dy);
	addButton: 'Four'	to: self at: 500,(y := y - dy).

    group := ButtonGroup new.
    y := 500.
    dy := Font metrics height.

    (buttons := TransformView new) propertyAt: #layout put: #verticalLayout.
    group
	add: (self addButton: 'one'	to: buttons at: Pair zero);
	add: (self addButton: 'two'	to: buttons at: Pair zero);
	add: (self addButton: 'three'	to: buttons at: Pair zero);
	add: (self addButton: 'four'	to: buttons at: Pair zero).
    self add: buttons.
    buttons layout; translation: 700,200.

    list := IdentityDictionary new.
    #(zero one two three four five six seven eight nine ten) doWithIndex: [:n :i | list at: n put: i].
    list := list selectionView: EchoSelector.
    list propertyAt: #layout put: #verticalLayout.
    list layout.

    self add: ((((Pair zero corner: 100,50) scrollingView fillColour: Colour white)
		    add: list;
		    yourself)
		   withVerticalScrollBar translation: 500,500).
]

"----------------------------------------------------------------"

{ input: systemWorkspace }

World pointerDownEvent :event
[
    | list |
    (contents detect: [:v | v bounds containsPoint: event position]) ifTrue: [^event handled: self].
    launcher
	ifFalse:
	   [list := (('system workspace' -> #systemWorkspace),
		     ('workspace' -> #thumbnail),
		     ('thumbnail' -> #thumbnail),
		     ('quit'	  -> #quit)) menuView: self.
	    list propertyAt: #layout put: #verticalLayout.
	    list layout.
	    launcher := (((list bounds shapedView fillColour: Colour white) add: list; yourself) withTitle: 'Launcher')].
    launcher container
	ifFalse:
	   [launcher translation: event position - (0,launcher bounds height).
	    (self addFirst: launcher) damaged].
]

ThumbnailNesting := [ nil ]

ThumbnailView : View ( view bounds )

ThumbnailView withView: aView
[
    self := self new.
    view := aView.
    bounds := view bounds / (10.0,10.0).
]

ThumbnailView drawOn: aCanvas in: clipRectangle
[
    ThumbnailNesting ifTrue: [^self].
    ThumbnailNesting := true.
    aCanvas save; setClipRectangle: bounds; scale: 0.1, 0.1.
    view drawOn: aCanvas in: bounds * (10,10).
    aCanvas restore.
    ThumbnailNesting := false.
]

ThumbnailView handleEvent: anEvent at: aPoint
[
    | result |
    ThumbnailNesting ifTrue: [^nil].
    ThumbnailNesting := true.
    result := super handleEvent: anEvent at: aPoint.
    ThumbnailNesting := false.
    ^result
]

View thumbnailView
[
    ^ThumbnailView withView: self
]

ThumbnailView bounds
[
    ^bounds
]

World systemWorkspace	[ (self addFirst: ((self systemString workspace: 'Workspace') translation: 10,10)) damaged ]
World workspace		[ (self addFirst: (('' workspace: 'Workspace') translation: 10,10)) damaged ]
World thumbnail		[ (self addFirst: ((self thumbnailView transformView translation: 10,10) withTitle: 'World')) damaged ]
World quit		[ OS exit: 0 ]

Association , anAssociation		[ ^self asIdentityDictionary, anAssociation ]
Association asIdentityDictionary	[ ^IdentityDictionary new at: key put: value; yourself ]
IdentityDictionary , anAssociation	[  self at: anAssociation key put: anAssociation value ]
IdentityDictionary asIdentityDictionary	[ ^self ]

World addButton: label to: outer at: position
[
    | button buttonView |
    button := Button new.
    button onBlock: [:b | StdOut println: label, ' ON!'].
    button offBlock: [:b | StdOut println: label, ' off'].
    buttonView := (Rectangle zero corner: 200, Font metrics height ceiling) buttonView: button.
    buttonView add: (label stringView transformView translation: 5,5).
    buttonView propertyAt: #pointerMotionEvent put: [:v :e | e handler beginButton: v.  e handled: v].
    outer add: (buttonView transformView translation: position).
    ^button
]

""
Object error: reason			[ StdOut cr; nextPutAll: reason.
					  World openDebugger: reason ]

Object doesNotUnderstand: aSelector	[ StdOut cr; nextPutAll: (self printString, ' does not understand ', aSelector).
					  World openDebugger: self printString, ' does not understand ', aSelector ]
""

String backtrace	[ ^self value_: self _backtrace ]
String _backtrace	{ return (oop)_backtrace(); }

World openDebugger: aString
[
    | debugger |
    debugger := String backtrace workspace: aString.
    self
	addFirst: (debugger translation: window bounds topLeft + (100, debugger bounds height negated));
	forceToScreen;
	restart
]

World adopt: aWorld from: anEvent in: aView
[
    (World := aWorld) damaged.
]

World current	[ ^World ]

"

    | world0 world1 world2 thumb |
    world0 := World := World new setup0 open.
    world1 := World new setup1 window: World window.
    world2 := World new setup2 window: World window.
    (world0 add: ((world1 thumbnailView propertyAt: #pointerUpEvent put: [:v :e | World adopt: world1 from: e in: v]; yourself) transformView translation: 900,10)).
    (world1 add: ((world2 thumbnailView propertyAt: #pointerUpEvent put: [:v :e | World adopt: world2 from: e in: v]; yourself) transformView translation: 900,10)).
    (world2 add: ((world0 thumbnailView propertyAt: #pointerUpEvent put: [:v :e | World adopt: world0 from: e in: v]; yourself) transformView translation: 900,10)).
    World forceToScreen; run.
]
"
[
    (World := World new) setup; open; forceToScreen; run.
]
""
