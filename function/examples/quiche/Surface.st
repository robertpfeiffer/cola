{ import: Geometry }

{ include <SDL/SDL.h> }
{ include "SDL_prims.c" }

{ SDL_Init(SDL_INIT_VIDEO); }

Surface : Object ( _surface )

Surface _surface	[ ^_surface ]

Surface width		{ _return (oop)(((SDL_Surface *)self->v__surface)->w  << 1 | 1); }
Surface height		{ _return (oop)(((SDL_Surface *)self->v__surface)->h  << 1 | 1); }
Surface depth		[ ^0 ]
Surface lineSkip	[ ^0 ]

Surface withExtent: aPoint
[
    | _w _h |
    self := super new.
    _w := aPoint x _integerValue.
    _h := aPoint y _integerValue.
  {
    SDL_Surface *surface;
    surface= SDL_CreateRGBSurface(SDL_SWSURFACE /*| SDL_SRCALPHA*/, (long)v__w, (long)v__h, 32, 0, 0, 0, 0);
    if (!surface) {
      fprintf(stderr, "could not create surface\n");
      abort();
    }
    /*SDL_SetAlpha(surface, SDL_SRCALPHA, 128);*/
    self->v__surface= (oop)surface;
  }.
]

Surface fromFile: fileName
[
    | _path |
    self := self new.
    _path := fileName _stringValue.
    {
      SDL_Surface *surface= SDL_LoadBMP((const char *)v__path);
      if (!surface) { _return(0); }
      SDL_SetColorKey(surface, SDL_SRCCOLORKEY, SDL_MapRGB(surface->format, 255, 0, 255));
      self->v__surface= (oop)surface;
    }.
]

Surface clear
{
    SDL_Color white= { 0xff, 0xff, 0xff, 0 };
    SDL_FillRect((SDL_Surface *)self->v__surface, NULL, SDL_MapRGB(((SDL_Surface *)self->v__surface)->format, white.r, white.g, white.b));
}

Surface hBearing	[ ^self extent ]
Surface hAdvance	[ ^self width  ]

Surface at: x at: y
[
    | _x _y pixel |
    _x := x _integerValue.
    _y := y _integerValue.
    {
      SDL_Surface *sfc= (SDL_Surface *)self->v__surface;
      long x= (long)v__x;
      long y= (long)v__y;
      unsigned char *base;
      long pixel;
      base= (unsigned char *)sfc->pixels + y * sfc->pitch + x * 3;
      pixel= (base[0] << 0) + (base[1] << 8) + (base[2] << 16);
      v_pixel= (oop)((long)pixel << 1 | 1);
    }.
    ^pixel
]

Surface redAt: x at: y
[
    | _x _y pixel |
    _x := x _integerValue.
    _y := y _integerValue.
    {
      SDL_Surface *sfc= (SDL_Surface *)self->v__surface;
      long x= (long)v__x;
      long y= (long)v__y;
      unsigned char *base;
      long pixel;
      base= (unsigned char *)sfc->pixels + y * sfc->pitch + x * 3;
      pixel= base[2];
      v_pixel= (oop)((long)pixel << 1 | 1);
    }.
    ^pixel
]

Surface greenAt: x at: y
[
    | _x _y pixel |
    _x := x _integerValue.
    _y := y _integerValue.
    {
      SDL_Surface *sfc= (SDL_Surface *)self->v__surface;
      long x= (long)v__x;
      long y= (long)v__y;
      unsigned char *base;
      long pixel;
      base= (unsigned char *)sfc->pixels + y * sfc->pitch + x * 3;
      pixel= base[1];
      v_pixel= (oop)((long)pixel << 1 | 1);
    }.
    ^pixel
]

Surface blueAt: x at: y
[
    | _x _y pixel |
    _x := x _integerValue.
    _y := y _integerValue.
    {
      SDL_Surface *sfc= (SDL_Surface *)self->v__surface;
      long x= (long)v__x;
      long y= (long)v__y;
      unsigned char *base;
      long pixel;
      base= (unsigned char *)sfc->pixels + y * sfc->pitch + x * 3;
      pixel= base[0];
      v_pixel= (oop)((long)pixel << 1 | 1);
    }.
    ^pixel
]

Surface drawOn: aSurface at: aPoint
[
    | _x _y _sfc |
    _x := aPoint x _integerValue.
    _y := aPoint y _integerValue.
    _sfc := aSurface _surface.
  {
    SDL_Surface *src= (SDL_Surface *)self->v__surface;
    SDL_Surface *dst= (SDL_Surface *)v__sfc;
    SDL_Rect dstrect= { (long)v__x, (long)v__y, src->w, src->h };
    SDL_BlitSurface(src, NULL, dst, &dstrect);
  }
]

"
Surface at: aPoint drawSurface: aSurface
[
    | _x _y _sfc |
    _x := aPoint x _integerValue.
    _y := aPoint y _integerValue.
    _sfc := aSurface _surface.
  {
    SDL_Surface *dst= (SDL_Surface *)self->v__surface;
    SDL_Surface *src= (SDL_Surface *)v__sfc;
    SDL_Rect dstrect= { (long)v__x, (long)v__y, src->w, src->h };
    SDL_BlitSurface(src, NULL, dst, &dstrect);
  }
]
"

Surface drawRectangle: aRectangle withColour: aColour
[
    | _x _y _w _h _r _g _b |
    _x := aRectangle left      _integerValue.
    _y := aRectangle top       _integerValue.
    _w := aRectangle width     _integerValue.
    _h := aRectangle height    _integerValue.
    _r := (aColour r * 255.9)  _integerValue.
    _g := (aColour g * 255.9)  _integerValue.
    _b := (aColour b * 255.9)  _integerValue.
  {
    SDL_Rect dstrect= { (long)v__x, (long)v__y, (long)v__w, (long)v__h };
    SDL_DrawRect((SDL_Surface *)self->v__surface, &dstrect, SDL_MapRGB(((SDL_Surface *)self->v__surface)->format, (long)v__r, (long)v__g, (long)v__b));
  }.
]

Surface fillRectangle: aRectangle withColour: aColour
[
    | _x _y _w _h _r _g _b |
    _x := aRectangle left      _integerValue.
    _y := aRectangle top       _integerValue.
    _w := aRectangle width     _integerValue.
    _h := aRectangle height    _integerValue.
    _r := (aColour r * 255.9)  _integerValue.
    _g := (aColour g * 255.9)  _integerValue.
    _b := (aColour b * 255.9)  _integerValue.
  {
    SDL_Rect dstrect= { (long)v__x, (long)v__y, (long)v__w, (long)v__h };
    SDL_FillRect((SDL_Surface *)self->v__surface, &dstrect, SDL_MapRGB(((SDL_Surface *)self->v__surface)->format, (long)v__r, (long)v__g, (long)v__b));
  }.
]

Surface drawPolygon: vertices withColour: aColour
[
    | points _points _size  _r _g _b |
    points := ByteArray new: vertices size * 4.
    vertices doWithIndex: [:point :index |
	points s16at: index * 2     put: point x.
	points s16at: index * 2 + 1 put: point y].
    _points := points _elements.
    _size := vertices size _integerValue.
    _r := (aColour r * 255.9)  _integerValue.
    _g := (aColour g * 255.9)  _integerValue.
    _b := (aColour b * 255.9)  _integerValue.
  {
    SDL_DrawPolygon((SDL_Surface *)self->v__surface, (SDL_Point *)v__points, (long)v__size,
		    SDL_MapRGB(((SDL_Surface *)self->v__surface)->format, (long)v__r, (long)v__g, (long)v__b));
  }.
]

Surface fillPolygon: vertices withColour: aColour
[
    | points _points _size  _r _g _b |
    points := ByteArray new: vertices size * 4.
    vertices doWithIndex: [:point :index |
	points s16at: index * 2     put: point x.
	points s16at: index * 2 + 1 put: point y].
    _points := points _elements.
    _size := vertices size _integerValue.
    _r := (aColour r * 255.9)  _integerValue.
    _g := (aColour g * 255.9)  _integerValue.
    _b := (aColour b * 255.9)  _integerValue.
  {
    SDL_FillPolygon((SDL_Surface *)self->v__surface, (SDL_Point *)v__points, (long)v__size,
		    SDL_MapRGB(((SDL_Surface *)self->v__surface)->format, (long)v__r, (long)v__g, (long)v__b));
  }.
]

Surface flush
{
    SDL_UpdateRect((SDL_Surface *)self->v__surface, 0, 0, 0, 0);
}

Surface destroy { SDL_FreeSurface((SDL_Surface *)self->v__surface); }

"----------------"

DisplaySurface : Surface ( xPos yPos mState )

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
  }.
    xPos := yPos := mState := 0.
]

"----------------------------------------------------------------"
"
DrawingContext : Object ( translation surface )

DrawingContext withSurface: aSurface
[
    translation := PointZero.
    surface := aSurface.
]

Surface newDrawingContext	[ ^DrawingContext withSurface: self ]

DrawingContext translate: aPoint	[ translation := translation + aPoint ]

DrawingContext fillRectangle: aRectangle withColour: aColour	[ surface fillRectangle: (aRectangle translatedBy: translation) withColour: aColour ]

DrawingContext at: aPoint drawSurface: aGlyph 			[ surface at: aPoint + translation drawSurface: aGlyph ]
"
"----------------------------------------------------------------"

Event : Object ( source )
  PositionEvent : Event ( x y state localPosition )
    MotionEvent : PositionEvent ()		MotionEvent type	[ ^#motionEvent ]
    ButtonEvent : PositionEvent ( button )
      ButtonDownEvent : ButtonEvent ()		ButtonDownEvent type	[ ^#buttonDownEvent ]
      ButtonUpEvent   : ButtonEvent ()		ButtonUpEvent type	[ ^#buttonUpEvent ]
    KeyEvent : PositionEvent ( code )
      KeyDownEvent : KeyEvent ()		KeyDownEvent type	[ ^#keyDownEvent ]
      KeyUpEvent   : KeyEvent ()		KeyUpEvent type		[ ^#keyUpEvent ]

Event isMotion		[ ^nil ]	MotionEvent	isMotion	[ ^self ]
Event isButtonDown	[ ^nil ]	ButtonDownEvent isButtonDown	[ ^self ]
Event isButtonUp	[ ^nil ]	ButtonUpEvent	isButtonUp	[ ^self ]
Event isKeyDown		[ ^nil ]	KeyDownEvent	isKeyDown	[ ^self ]
Event isKeyUp		[ ^nil ]	KeyUpEvent	isKeyUp		[ ^self ]

Event source: src	[ source := src ]
Event source		[ ^source ]

Event printOn: aStream
[
    super printOn: aStream.
    aStream nextPut: $(.
    self printContentsOn: aStream.
    aStream nextPut: $)
]

PositionEvent x: xPos y: yPos state: mState
[
    self := self new.
    x := xPos.
    y := yPos.
    state := mState.
    localPosition := x,y.
]

PositionEvent x		[ ^x ]
PositionEvent y		[ ^y ]
PositionEvent state	[ ^state ]

PositionEvent position			[ ^x,y ]

PositionEvent localPosition: aPoint	[  localPosition := aPoint ]
PositionEvent localPosition		[ ^localPosition ]

PositionEvent printContentsOn: aStream	[ aStream print: x; nextPut: $,; print: y ]

ButtonEvent button: b	[  button := b ]
ButtonEvent button	[ ^button ]

ButtonEvent printContentsOn: aStream
[
    super printContentsOn: aStream.
    aStream space; print: button
]

KeyEvent code: c	[  code := c ]
KeyEvent code		[ ^code ]

KeyEvent printContentsOn: aStream
[
    super printContentsOn: aStream.
    aStream space; print: code
]

MotionEvent	x: xPos y: yPos detail: d state: s	[ ^(self x: xPos y: yPos state: s) ]
KeyDownEvent	x: xPos y: yPos detail: d state: s	[ ^(self x: xPos y: yPos state: s) code: d ]
KeyUpEvent	x: xPos y: yPos detail: d state: s	[ ^(self x: xPos y: yPos state: s) code: d ]
ButtonDownEvent	x: xPos y: yPos detail: d state: s	[ ^(self x: xPos y: yPos state: s) button: d ]
ButtonUpEvent	x: xPos y: yPos detail: d state: s	[ ^(self x: xPos y: yPos state: s) button: d ]

DisplaySurface pollEvent
{
    SDL_Event event;
    _return ((SDL_PollEvent(&event)) ? _sendv(s_makeEvent_5f_, 2, v_self, (oop)&event) : 0);
}

DisplaySurface waitEvent
{
    SDL_Event event;
    _return ((SDL_WaitEvent(&event)) ? _sendv(s_makeEvent_5f_, 2, v_self, (oop)&event) : 0);
}

DisplaySurface nextEvent
[
    | event |
    [event := self waitEvent] whileFalse.
    ^event
]

DisplaySurface makeEvent_: _event
[
    | type x y detail s |
  {
    SDL_Event *event= (SDL_Event *)v__event;
    switch (event->type) {
    case SDL_MOUSEMOTION:
      v_type   = v_MotionEvent;
      v_x      = (oop)(long)((    event->motion.x) << 1 | 1);
      v_y      = (oop)(long)((    event->motion.y) << 1 | 1);
      break;
    case SDL_KEYUP: case SDL_KEYDOWN:
      v_type   = (event->type == SDL_KEYUP) ? v_KeyUpEvent : v_KeyDownEvent;
      v_detail = (oop)(long)((event->key.keysym.unicode ? event->key.keysym.unicode : -event->key.keysym.sym) << 1 | 1);
      v_s      = (oop)(long)((                            event->key.keysym.mod                             ) << 1 | 1);
      break;
    case SDL_MOUSEBUTTONUP: case SDL_MOUSEBUTTONDOWN:
      v_type   = (event->type == SDL_MOUSEBUTTONUP) ? v_ButtonUpEvent : v_ButtonDownEvent;
      v_x      = (oop)(long)((    event->button.x	) << 1 | 1);
      v_y      = (oop)(long)((    event->button.y	) << 1 | 1);
      v_detail = (oop)(long)((    event->button.button) << 1 | 1);
      break;
    case SDL_QUIT:
      exit(0);
      break;
    default:
      _return (0);
    }
  }.
    x ifTrue: [xPos   := x] ifFalse: [x := xPos  ].
    y ifTrue: [yPos   := y] ifFalse: [y := yPos  ].
    s ifTrue: [mState := s] ifFalse: [s := mState].
    ^type x: x y: y detail: detail state: s
]

"----------------------------------------------------------------"

{ import: MacroState }

EventHandler : MacroState ( owner )

EventHandler withOwner: aBox	[ ^self new setOwner: aBox ]
EventHandler setOwner:  aBox	[ owner := aBox ]

EventHandler handle: anEvent for: aBox at: aPoint
[
    ^self perform: anEvent type with: anEvent with: aBox with: aPoint
]

EventHandler motionEvent	:event :box :point	[ ^nil ]
EventHandler buttonDownEvent	:event :box :point	[ ^nil ]
EventHandler buttonUpEvent	:event :box :point	[ ^nil ]
EventHandler keyDownEvent	:event :box :point	[ ^nil ]
EventHandler keyUpEvent		:event :box :point	[ ^nil ]
