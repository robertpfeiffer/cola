{ import: Surface }
{ import: events }
{ import: Color }

{ include <SDL/SDL.h> }
{ include "SDL_prims.h" }

SDLSurface : Surface ( _display _surface _pixmap )

Surface platformSurface [ ^SDLSurface ]

SDLSurface _surface	[ ^_surface ]

SDLSurface new: dimensions
[
    | name index _name |
    name := OS argumentAt: 0.
    [index := name indexOf: $/ ifAbsent: [nil]] whileTrue: [name := name copyFrom: index + 1].
    name isEmpty ifTrue: [name := '.'].
    _name := name _elements.
    self := super basicNew: dimensions.
    {
      SDL_Surface *screen;
      int w= (long)self->v_width >> 1;
      int h= (long)self->v_height >> 1;
      self->v__display= (oop)(screen= SDL_SetVideoMode(w, h, 32, SDL_HWSURFACE | SDL_DOUBLEBUF /* | SDL_RESIZABLE | SDL_FULLSCREEN */));
      self->v__surface= (oop)SDL_CreateRGBSurface(SDL_HWSURFACE, w, h, 32,
						  screen->format->Rmask, screen->format->Gmask, screen->format->Bmask, screen->format->Amask);
      SDL_SetAlpha((SDL_Surface *)self->v__surface, 0, 0);
      SDL_WM_SetCaption((char *)v__name, (char *)v__name);
    }.
]

SDLSurface nextEvent
[
    | type x y state detail dx dy |
    {
      int x= 0, y= 0, state= 0, detail= 0, dx= 0, dy= 0;
      do
	{
	  SDL_Event event;
	  SDL_WaitEvent(&event);
	  switch (event.type)
	    {
	    case SDL_KEYDOWN:
	    case SDL_KEYUP:
	      v_type= (event.key.state == SDL_PRESSED) ? v_KeyDownEvent : v_KeyUpEvent;
	      SDL_GetMouseState(&x, &y);
	      state= event.key.keysym.mod;
	      detail= event.key.keysym.unicode;
	      break;

	    case SDL_MOUSEBUTTONDOWN:
	    case SDL_MOUSEBUTTONUP:
	      v_type= (event.button.state == SDL_PRESSED) ? v_ButtonDownEvent : v_ButtonUpEvent;
	      x= event.button.x;
	      y= event.button.y;
	      state= SDL_GetModState();
	      detail= event.button.button;
	      break;

	    case SDL_MOUSEMOTION:
	      v_type= v_MotionEvent;
	      x= event.motion.x;
	      y= event.motion.y;
	      state= SDL_GetModState();
	      detail= event.motion.state;
	      dx= event.motion.xrel;
	      dy= event.motion.yrel;
	      break;

	    case SDL_QUIT:
	      SDL_Quit();
	      exit(0);
	      break;

	    case SDL_VIDEORESIZE:
	      v_type= v_ResizeEvent;
	      x= event.resize.w;
	      y= event.resize.h;
	      state= SDL_GetModState();
	      break;
	    }
	}
      while (!v_type);
      v_x	= (oop)(long)(x      << 1 | 1);
      v_y	= (oop)(long)(y      << 1 | 1);
      v_state	= (oop)(long)(state  << 1 | 1);
      v_detail	= (oop)(long)(detail << 1 | 1);
      v_dx	= (oop)(long)(dx     << 1 | 1);
      v_dy	= (oop)(long)(dy     << 1 | 1);
    }.
    ^type withX: x withY: y state: state detail: detail dx: dx dy: dy.
]

[ KeyDownEvent. KeyUpEvent.  ButtonDownEvent. ButtonUpEvent.  MotionEvent.  ResizeEvent. ]

SDLSurface flush
{
  SDL_BlitSurface((SDL_Surface *)self->v__surface, 0, (SDL_Surface *)self->v__display, 0);
  SDL_Flip((SDL_Surface *)self->v__display);
}

SDLSurface close
{
  SDL_Quit();
  exit(0);
}

"----------------------------------------------------------------"

SDLContext : DrawingContext ( _surface color transform stack )

DrawingContext platformDrawingContext	[ ^SDLContext ]

SDLContext color	[ ^color ]
SDLContext transform	[ ^transform ]

SDLContext new: aSurface
[
    self := super basicNew: aSurface.
    _surface := aSurface _surface.
    color := ColorWhite.
    transform := 0,0.
    stack := OrderedCollection new.
]

SDLContext translate: offset	[ transform := transform + offset ]
SDLContext saveTransform	[ stack addLast: transform ]
SDLContext restoreTransform	[ transform := stack removeLast ]

SDLContext color: aColor	[ color := aColor ]
SDLContext saveColor		[ stack addLast: color ]
SDLContext restoreColor		[ color := stack removeLast ]

SDLContext fillRectangle: origin extent: extent
[
    | x y w h r g b a |
    color ifFalse: [^self].
    origin := transform + origin.
    x := origin x rounded.  y := origin y rounded.  w := extent x rounded.  h := extent y rounded.
    r := color r.  g := color g.  b := color b.  a := color a.
    {
      SDL_Rect rect= { (long)v_x >> 1, (long)v_y >> 1, (long)v_w >> 1, (long)v_h >> 1 };
      Uint32 pixel= SDL_MapRGBA(((SDL_Surface *)self->v__surface)->format, (long)v_r >> 1, (long)v_g >> 1, (long)v_b >> 1, (long)v_a >> 1);
      SDL_FillRect((SDL_Surface *)self->v__surface, &rect, pixel);
    }
]

SDLContext drawRectangle: origin extent: extent
[
    | x y w h r g b a |
    color ifFalse: [^self].
    origin := transform + origin.
    x := origin x rounded.  y := origin y rounded.  w := extent x rounded.  h := extent y rounded.
    r := color r.  g := color g.  b := color b.  a := color a.
    {
      SDL_Rect rect= { (long)v_x >> 1, (long)v_y >> 1, (long)v_w >> 1, (long)v_h >> 1 };
      Uint32 pixel= SDL_MapRGBA(((SDL_Surface *)self->v__surface)->format, (long)v_r >> 1, (long)v_g >> 1, (long)v_b >> 1, (long)v_a >> 1);
      SDL_DrawRect((SDL_Surface *)self->v__surface, &rect, pixel);
    }
]

SDLContext drawLine: start to: end
[
    | x1 y1 x2 y2 r g b a |
    color ifFalse: [^self].
    start := transform + start.
    end := transform + end.
    x1 := start x rounded.  y1 := start y rounded.  x2 := end x rounded.  y2 := end y rounded.
    r := color r.  g := color g.  b := color b.  a := color a.
    {
      Uint32 pixel= SDL_MapRGBA(((SDL_Surface *)self->v__surface)->format, (long)v_r >> 1, (long)v_g >> 1, (long)v_b >> 1, (long)v_a >> 1);
      SDL_DrawLine((SDL_Surface *)self->v__surface, (long)v_x1 >> 1, (long)v_y1 >> 1, (long)v_x2 >> 1, (long)v_y2 >> 1, pixel);
    }
]

SDLContext drawImage_: _src width: w height: h
[
    | x y |
    x := transform x rounded.
    y := transform y rounded.
    {
      int x= (long)v_x >> 1;
      int y= (long)v_y >> 1;
      int w= (long)v_w >> 1;
      int h= (long)v_h >> 1;
      SDL_Rect srcRect= { 0, 0, w, h };
      SDL_Rect dstRect= { x, y, w, h };
      SDL_BlitSurface((SDL_Surface *)v__src, &srcRect, (SDL_Surface *)self->v__surface, &dstRect);
    }
]

"----------------------------------------------------------------"

SDLImage : Image ( color _surface _pixmap )

SDLImage basicFromLuminanceMap_: _lumap width: w pitch: p height: h
[
    self := super basicNew: w,h.
    {
      long width  = (long)v_w >> 1;
      long pitch  = (long)v_p >> 1;
      long height = (long)v_h >> 1;
      Uint32 *pixels= _libid->balloc(4 * width * height);
      SDL_Surface *image= SDL_CreateRGBSurfaceFrom(pixels, width, height, 32, 4 * width, 255U << 24, 255U << 16, 255U << 8, 255U);
      int y;
      Uint8  *in= (Uint8 *)v__lumap;
#    if 1
      Uint32 *out= pixels;
      /* alpha channel */
      for (y= 0;  y < height;  ++y)
	{
	  int x;
	  for (x= 0;  x < width;  ++x) out[x]= in[x];
	  in += pitch;
	  out= (void *)out + image->pitch;
	}
#    else
      Uint32 *out= (void *)pixels + image->pitch * height;
      /* alpha channel */
      for (y= 0;  y < height;  ++y)
	{
	  out= (void *)out - image->pitch;
	  int x;
	  for (x= 0;  x < width;  ++x) out[x]= in[x];
	  in += pitch;
	}
#    endif
      self->v__surface= (oop)image;
      self->v__pixmap= (oop)pixels;
    }.
]

SDLImage color: aColor
[
    | r g b |
    r := aColor r.
    g := aColor g.
    b := aColor b.
    {
      long width     = (long)self->v_width >> 1;
      long height    = (long)self->v_height >> 1;
      long size      = width * height;
      long rgb       = ((long)v_r << 24) | ((long)v_g << 16) | ((long)v_b << 8);
      Uint32 *pixmap = (Uint32 *)self->v__pixmap;
      /* rgb channels */
      while (size--)
	{
	  Uint32 alpha= *pixmap & 255;
	  *pixmap++= rgb | alpha;
	}
    }.
    color := aColor.
]

SDLImage drawOn: aContext
[
    | fgColor |
    (fgColor := aContext color) == color ifFalse: [self color: fgColor].
    aContext drawImage_: _surface width: width height: height.
]

Image platformImage	[ ^SDLImage ]
