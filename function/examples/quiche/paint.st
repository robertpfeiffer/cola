" paint.st -- Quick User Interface Clumsily Hacked for Editing

  Copyright (c) 2009 Ian Piumarta, Takashi Yamamiya
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

  Last edited: 2009-03-16 18:57:30 by piumarta on emilia
"

{ import: TextEditor }

{ include <SDL/SDL.h> }
{ include "SDL_prims.h" }

Surface withExtent: aPoint
[
    | _w _h |
    self := super new.
    _w := aPoint x _integerValue.
    _h := aPoint y _integerValue.
  {
    SDL_Surface *surface;
    surface= SDL_CreateRGBSurface(SDL_SWSURFACE, (long)v__w, (long)v__h, 32, 255U << 24, 255U << 16, 255U << 8, 255U);

    if (!surface) {
      fprintf(stderr, "could not create surface\n");
      abort();
    }
    /*SDL_SetAlpha(surface, SDL_SRCALPHA, 128);*/
    self->v__surface= (oop)surface;
  }.
]

Surface fillCircle: aPoint radius: radius withColour: aColour
[
    | _x _y _radius _r _g _b |
    _x := aPoint x             _integerValue.
    _y := aPoint y             _integerValue.
    _radius := radius               _integerValue.
    _r := (aColour r * 255.9)  _integerValue.
    _g := (aColour g * 255.9)  _integerValue.
    _b := (aColour b * 255.9)  _integerValue.
  {
    SDL_FillCircle((SDL_Surface *)self->v__surface, (int)v__x, (int)v__y, (int)v__radius, 
SDL_MapRGB(((SDL_Surface *)self->v__surface)->format, (long)v__r, (long)v__g, (long)v__b));
  }.
]


DisplaySurface withExtent: aPoint
[
    | _w _h |
    self := super new.
    _w := aPoint x _integerValue.
    _h := aPoint y _integerValue.
  {
    SDL_Surface *surface;
    SDL_EnableKeyRepeat(300, 30);
    SDL_EnableUNICODE(1);
    surface= SDL_SetVideoMode((long)v__w, (long)v__h, 32, SDL_SWSURFACE | SDL_DOUBLEBUF /*| SDL_NOFRAME*/);
    if (!surface) {
      fprintf(stderr, "could not create surface\n");
      abort();
    }
    self->v__surface= (oop)surface;
#ifndef _WIN32
    if ((fcntl(fileno(stdin), F_SETFL, O_NONBLOCK)) == -1) { perror("error"); exit(1); }
#endif
  }.
    xPos := yPos := mState := 0.
]

"----------------------------------------------------------------"

Box dispatchEvent: anEvent at: aPoint
[
    | handler |
    (self includesPoint: aPoint) ifFalse: [^nil].
    aPoint := aPoint - origin.
    self do: [:box | (box dispatchEvent: anEvent at: aPoint) ifTrue: [^self]]. "Kids first"
    (handler := self eventHandlersAt: anEvent type) ifFalse: [^nil].
    ^handler handle: anEvent for: self at: aPoint.
]

Box paletteForExtent: aPoint
[
    | sf |
    sf := Surface withExtent: aPoint.
    0 to: aPoint x - 1 do: [ :x |
	0 to: aPoint y - 1 do: [ :y |
	    sf fillRectangle: (x, y extent: 1,1)
		    withColour: (self paletteColorAt: x, y inExtent: aPoint)]].
    ^sf asBox bePalette
]

Box paletteColorAt: aPoint inExtent: extent
[
    ^Colour hue: 360 * aPoint x / extent x
	    saturation: (2 * aPoint y / extent y min: 1)
	    brightness: (-2 * aPoint y + (extent y * 2) / extent y min: 1)
]

Box saveAllSurfacesAsBmp
[
    | name |
    (surface and: [name := self propertiesAt: #bmpName])
	ifTrue: [surface toFile: name.
		 StdOut nextPutAll: 'saved: '; nextPutAll: name; cr.].
    self do: [:box | box saveAllSurfacesAsBmp].
]

Box buildTextBox: aString bounds: bounds on: frame
[
    | box |
    ^ (box := Box withBounds: bounds)
	addLast: (aString asText beEditable: box);
	backgroundColour: ColourWhite;
	borderColour: (Colour grey: 0.5);
	borderWidth: 1.
]

"----------------------------------------------------------------"

Colour hue: hue saturation: saturation brightness: brightness
[
    "Copied from Squeak"

    | s v hf i f p q t | 
    s := (saturation asFloat max: 0.0) min: 1.0.
    v := (brightness asFloat max: 0.0) min: 1.0.

    "zero saturation yields gray with the given brightness"
    s = 0.0 ifTrue: [ ^ self withR: v G: v B: v ].
    
    hf := hue asFloat.
    (hf < 0.0 or: [hf >= 360.0])
	ifTrue: [hf := hf - ((hf quo: 360.0) asFloat * 360.0)].
    hf := hf / 60.0.
    i := hf asInteger.  "integer part of hue"
    f := hf fractionPart.         "fractional part of hue"
    p := (1.0 - s) * v.
    q := (1.0 - (s * f)) * v.
    t := (1.0 - (s * (1.0 - f))) * v.
    
    0 = i ifTrue: [ ^ self withR: v G: t B: p ].
    1 = i ifTrue: [ ^ self withR: q G: v B: p ].
    2 = i ifTrue: [ ^ self withR: p G: v B: t ].
    3 = i ifTrue: [ ^ self withR: p G: q B: v ].
    4 = i ifTrue: [ ^ self withR: t G: p B: v ].
    5 = i ifTrue: [ ^ self withR: v G: p B: q ].
    
    self error: 'implementation error'.
]

Number sign [ ^self = 0 ifTrue: [ 0 ] ifFalse: [ self > 0 ifTrue: [ 1 ] ifFalse: [ -1 ]]]

Surface drawLoopFrom: start to: stop put: aSurface
[
    | destX destY xDelta yDelta dx dy px py P |
    "This algorithm is based on BitBlt>>drawLoopX:Y: in Squeak."

    xDelta := stop x - start x.
    yDelta := stop y - start y.
    dx := xDelta sign.
    dy := yDelta sign.
    px := yDelta abs.
    py := xDelta abs.
    destX := start x.
    destY := start y.

    py > px
	ifTrue: 
	    ["more horizontal"
	     P := py - (px // 2). "px // 2 is used to round the error"
	     1 to: py do: 
	       [:i |
		   aSurface drawOn: self at: destX, destY.
		   destX := destX + dx.
		   (P := P - px) <= 0 ifTrue: 
		       [destY := destY + dy.
			P := P + py]]]
	ifFalse: 
	    ["more vertical"
	     P := px - (py // 2).
	     1 to: px do:
	       [:i |
		   aSurface drawOn: self at: destX, destY.
		   destY := destY + dy.
		   (P := P - py) <= 0 ifTrue: 
		       [destX := destX + dx.
			P := P + px]]].
]

Surface toFile: fileName
[
    | _file |
    _file := fileName _stringValue.
    {
      /* We need to convert to 24 bit format explicitly because SDL_SaveBMP
         does not keep the bitpattern if it is 32 bit (bug?) */
      SDL_Surface *src= (SDL_Surface *) self->v__surface;
      SDL_Surface *dst= SDL_CreateRGBSurface(SDL_SWSURFACE,
        src->w, src->h, 32, 255U << 16, 255U << 8, 255U << 0, 0);
      SDL_BlitSurface(src, NULL, dst, NULL);
      int result= SDL_SaveBMP(dst, (char*) v__file);
      SDL_FreeSurface(dst);

      if (result != 0) {
        printf("SDL error: %s.\n", SDL_GetError());
        _return(0);
      }
    }.
]

"----------------------------------------------------------------"
"The global paint configuration"

PaintTool : Object ( nibSize nibColour nib )

PaintTool new
[
    self := super new.
    nibSize := 3.
    nibColour := ColourBlack.
]

PaintTool nibColour: aColour	[  nibColour := aColour.  self destroyNib ]
PaintTool nibColour		[^ nibColour]
PaintTool nibSize: aNumber	[  nibSize := aNumber.	  self destroyNib ]
PaintTool nibSize		[^ nibSize]

PaintTool destroyNib		[  nib ifTrue: [nib surface destroy].  nib := nil ]

PaintTool nib			[ ^nib ifNil: [nib := Box makeNib: nibSize colour: nibColour] ]

[ PaintTool := PaintTool new ]

"----------------------------------------------------------------"
"Paint tool"

PaintHandler : EventHandler (prev)

PaintHandler new
[
    self := super new.
]

PaintHandler motionEvent :event :box :point
[
    | offset nib |
    prev ifFalse: [^self].
    nib := PaintTool nib.
    offset := (nib width // 2), (nib height // 2).
    box surface drawLoopFrom: prev - offset to: point - offset put: nib surface.
    prev := point.
]

PaintHandler buttonDownEvent :event :box :point [ prev := point ]
PaintHandler buttonUpEvent :event :box :point   [ prev := nil ]

Box bePaintable
[
    | handler |
    handler := PaintHandler new.
    self eventHandlersAt: #motionEvent put: handler.
    self eventHandlersAt: #buttonDownEvent put: handler.
    self eventHandlersAt: #buttonUpEvent put: handler.
]

Box makeNib: size [ ^self makeNib: size colour: ColourBlack ]

Box makeNib: size colour: aColour
[
    | sf |
    sf := Surface withExtent: 20, 20.
    sf fillCircle: 10, 10 radius: size withColour: aColour.
    ^sf asBox
]

DoqReadStream g
[
    | name sfc |
    name := self nextArgument.
    name println.
    sfc := Surface fromFile: name.
    ^sfc ifTrue: [sfc asBox bePaintable propertiesAt: #bmpName put: name; yourself]
]

"----------------------------------------------------------------"

TextEditor loadBMP: text as: name
[
    | surface |
    name := name asString.
    ((name endsWith: '.bmp') or: [name endsWith: '.BMP']) ifFalse: [name := name , '.bmp'].
    surface := Surface fromFile: name.
    surface ifFalse: [^nil].
    (surface asBox bePaintable propertiesAt: #bmpName put: name; yourself) linkBefore: dot.
    dot container layoutChanged.
]

TextEditor save: text as: name
[
    name := name asString.
    (name endsWith: '.doq') ifFalse: [name := name , '.doq'].
    (File create: name) write: text asDoqString; close.
    StdOut nextPutAll: 'saved: '; nextPutAll: name; cr.
    text saveAllSurfacesAsBmp
]

"Insert a new image. The argument 'window' is used to locate the dialog box"
TextEditor insertNewImage: text window: window
[
    | box |
    box := self buildNewImageDialog: [ :fileName :w :h |
	| newImage extent surface |
	extent := (Integer fromString: w), (Integer fromString: h).
	surface := (Surface withExtent: extent)
	    fillRectangle: (PointZero extent: extent) withColour: ColourWhite.
	newImage := surface asBox bePaintable.
	newImage propertiesAt: #bmpName put: fileName.
	newImage linkBefore: dot.
	dot container layoutChanged].
    box moveTo: (window width - box width / 2), (window height - box height / 2).
    window addFirst: box.
    window layoutChanged.
]

"Construct a new image dialog. The block accepts three arguments for
filename, width, and height as a string when OK button is pressed."
TextEditor buildNewImageDialog: aBlock
[
    | frame text w h |
    frame := (Box withBounds: (PointZero extent: 400, 130))
	beDraggable;
	backgroundColour: ColourWhite;
	borderColour: (Colour grey: 0.5);
	borderWidth: 1.

    frame addLast: ('New image...' asText moveTo: 10, 10).
    frame addLast: (text := Box buildTextBox: 'new image' bounds: (10, 40 extent: 380, 18) on: frame).
    frame addLast: (' width: ' asText moveTo: 10, 70).
    frame addLast: (w := Box buildTextBox: '200' bounds: (60, 70 extent: 50, 18) on: frame).
    frame addLast: (' height: ' asText moveTo: 160, 70).
    frame addLast: (h := Box buildTextBox: '200' bounds: (210, 70 extent: 50, 18) on: frame).

    frame addLast: (' cancel ' asText
			beButton: [ frame unlink ];
			moveTo: 200, 100).
    frame addLast: ('   ok   ' asText
			beButton: [ aBlock value: text asString value: w asString value: h asString.
				    frame unlink ];
			moveTo: 300, 100).
    ^ frame
]

"----------------------------------------------------------------"

PaletteHandler : EventHandler ( isDown )

PaletteHandler buttonDownEvent :event :box :point [ isDown := true ]

PaletteHandler motionEvent :event :box :point
[
    isDown ifFalse: [^ self].
    PaintTool nibColour: (Box paletteColorAt: point inExtent: box width, box height).
]

PaletteHandler buttonUpEvent :event :box :point
[ 
    self motionEvent :event :box :point.
    isDown := false.
]

Box bePalette
[
    | handler |
    handler := PaletteHandler new.
    self eventHandlersAt: #motionEvent put: handler.
    self eventHandlersAt: #buttonDownEvent put: handler.
    self eventHandlersAt: #buttonUpEvent put: handler.
]

"----------------------------------------------------------------"

[
    | argv fileName content window w h frame face text name editor |

    w := 612.
    h := 792.
    fileName := 'file name'.
    argv := OS arguments.
    [argv isEmpty]
	whileFalse:
	   [| arg |
	    arg := argv removeFirst.
	    arg = '-landscape'
		ifTrue:  [| t | t := h.  h := w.  w := t]
		ifFalse:
		   [| file |
		    (file := File open: arg ifAbsent: [File open: arg , '.doq'])
			ifTrue:
			   [content := file contents.
			    fileName := arg.
			    file close]]].
    content ifFalse: [content := SampleText].
    face := #Times roman @ 14.
    window := Window withExtent: (w + 56) , (h - 6).
    window addFirst: ((Box withBounds: (52,26 extent: (w) , (h - 36)))
			  backgroundColour: ColourWhite;
			  addFirst: ((text := Box withBounds: (36,36 extent: (w - 72) , (h - 108)))
					 backgroundColour: ColourWhite;
					 borderWidth: 10;
					 addLast: (content asParagraph: text))).
    editor := text propertiesAt: #editor.
    window
	addLast: ((frame := Box new) width: (w + 48); height: 16; depth: 2; backgroundColour: ColourWhite; moveTo: 4, 4;
		      addLast: ((name := fileName asText) beEditable: frame));
	addLast: (Box new vBox width: 1; moveTo: 4, 26;
		      addLast: (' load '   asText beButton: [editor := editor load: text as: name]);
		      smallSep;
		      addLast: (' save '   asText beButton: [editor save: text as: name]);
		      smallSep;
		      addLast: (' image '  asText beButton: [editor loadBMP: text as: name]);
		      smallSep;
		      addLast: (' print '  asText beButton: [editor print: text as: name]);
		      bigSep;
		      addLast: (' Times '  asText beButton: [editor applyFamily: #Times]);
		      addLast: (' Helv   ' asText beButton: [editor applyFamily: #Helvetica]);
		      addLast: (' Cour   ' asText beButton: [editor applyFamily: #Courier]);
		      smallSep;
		      addLast: (' bold '   asText beButton: [editor xBold]);
		      addLast: (' italic ' asText beButton: [editor xSlanted]);
		      smallSep;
"
		      addLast: ('   8pt '  asText beButton: [editor applySize:  8]);
		      addLast: ('   9pt '  asText beButton: [editor applySize:  9]);
		      addLast: (' 10pt '   asText beButton: [editor applySize: 10]);
		      addLast: (' 11pt '   asText beButton: [editor applySize: 11]);
		      addLast: (' 12pt '   asText beButton: [editor applySize: 12]);
		      addLast: (' 14pt '   asText beButton: [editor applySize: 14]);
		      addLast: (' 16pt '   asText beButton: [editor applySize: 16]);
		      addLast: (' 18pt '   asText beButton: [editor applySize: 18]);
		      addLast: (' 20pt '   asText beButton: [editor applySize: 20]);
"
		      addLast: (' 24pt '   asText beButton: [editor applySize: 24]);
		      addLast: (' 28pt '   asText beButton: [editor applySize: 28]);
		      addLast: (' 34pt '   asText beButton: [editor applySize: 34]);
		      addLast: (' 40pt '   asText beButton: [editor applySize: 40]);
		      bigSep;
		      addLast: (' info '   asText beButton: [editor printInfo]);
		      bigSep;
		      bigSep;
		      addLast: ((Box withExtent: 20,20)
				    propertiesAt: #drawOn:at:
				    put: [:sfc :pt | PaintTool nib layOutIn: RectangleZero; drawOn: sfc at: pt]; yourself);
		      smallSep;
		      addLast: (Box paletteForExtent: 44, 100);
		      smallSep;
		      addLast: ((Box makeNib: 1) beButton: [PaintTool nibSize: 1]);
		      addLast: ((Box makeNib: 2) beButton: [PaintTool nibSize: 2]);
		      addLast: ((Box makeNib: 3) beButton: [PaintTool nibSize: 3]);
		      addLast: ((Box makeNib: 5) beButton: [PaintTool nibSize: 5]);
		      addLast: ((Box makeNib: 7) beButton: [PaintTool nibSize: 7]);
		      addLast: ((Box makeNib: 9) beButton: [PaintTool nibSize: 9]);
		      smallSep;
		      addLast: (' new '  asText beButton: [editor insertNewImage: text window: window]);
		      bigSep;
		      bigSep;
		      addLast: (' quit '   asText beButton: [OS exit: 0]);
		      yourself);
	layOut;
	draw;
	mainLoop.
]

{ include <SDL/SDL_main.h> }
