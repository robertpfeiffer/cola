#include <X11/Xlib.h>
#include <X11/Xutil.h>

#include <assert.h>

static Display	*xdpy= 0;
static Window    xwin;
static GC	 xgc;
static Visual	*xvisual= 0;
static void	*xbits= 0;
static int	 xpitch= 0;
static XImage	*ximage= 0;
static int	 xdepth;

static uint32_t	*displayBits= 0;
static int	 width= 0;
static int	 height= 0;
static int	 depth= 0;
static int	 pitch= 0;

static void openWindow(uint32_t *newDisplayBits, int newWidth, int newHeight)
{
  xdpy= XOpenDisplay(0);
  if (!xdpy) error("could not open display");
  xdepth= DefaultDepth(xdpy, DefaultScreen(xdpy));
  {
    XVisualInfo xvi;
    if (!XMatchVisualInfo(xdpy, DefaultScreen(xdpy), xdepth, TrueColor, &xvi)) error("could not find TrueColor visual");
    xvisual= xvi.visual;
  }
  {
    XSetWindowAttributes xwa;
    xwa.background_pixel= 0xffffff;
    xwa.backing_store=	  Always;
    xwa.event_mask=	  KeyPressMask | KeyReleaseMask | ButtonPressMask | ButtonReleaseMask | PointerMotionMask;
    xwin= XCreateWindow(xdpy, DefaultRootWindow(xdpy),
			100, 100, width= newWidth, height= newHeight, 0, xdepth,
			InputOutput, xvisual,
			CWBackPixel | CWBackingStore | CWEventMask, &xwa);
  }
  {
    XGCValues gcv;
    gcv.function=   	    GXcopy;
    gcv.plane_mask= 	    0xffffffffUL;
    gcv.foreground= 	    0xffffffUL;
    gcv.background= 	    0x000000UL;
    gcv.line_width= 	    0;
    gcv.line_style= 	    LineSolid;
    gcv.cap_style=  	    CapButt;
    gcv.join_style= 	    JoinMiter;
    gcv.fill_style= 	    FillSolid;
    gcv.fill_rule=  	    EvenOddRule;
    gcv.subwindow_mode=     ClipByChildren;
    gcv.graphics_exposures= 1;
    gcv.clip_x_origin=      0;
    gcv.clip_y_origin=      0;
    gcv.clip_mask=          None;
    xgc= XCreateGC(xdpy, xwin,
		   GCFunction | GCPlaneMask | GCForeground | GCBackground
		   | GCLineWidth | GCLineStyle | GCCapStyle | GCJoinStyle | GCFillStyle | GCFillRule
		   | GCSubwindowMode | GCGraphicsExposures | GCClipXOrigin | GCClipYOrigin | GCClipMask,
		   &gcv);
  }
  XMapWindow(xdpy, xwin);
}

typedef void     (*putter)(uint32_t *bits, int l, int t, int r, int b, XImage *image);

unsigned cmap[256]= {
# include "io-cmap.h"
};

#define pixel(N)		(bits[(pitch * y) + (x / (32/N))] >> (N * ((32/N-1) - (x & (32/N-1)))))

#define get1(bits, x, y)	cmap[pixel(1) &   1]
#define get2(bits, x, y)	cmap[pixel(2) &   3]
#define get4(bits, x, y)	cmap[pixel(4) &  15]
#define get8(bits, x, y)	cmap[pixel(8) & 255]

#define get16(bits, x, y)	({ uint32_t w= pixel(16);			\
			           (w &0x7c00) << 9 | (w & 0x7000) << 4 |	\
				   (w &0x03e0) << 6 | (w & 0x0380) << 1 |	\
				   (w &0x001f) << 3 | (w & 0x001f) >> 2; })

# define get32(bits, x, y)	bits[(y * pitch) + x]

#define put(N) static void put##N(uint32_t *bits, int l, int t, int r, int b, XImage *image)	\
{												\
  int x, y;											\
  for (y= t;   y < b;  ++y)									\
    for (x= l;   x < r;  ++x)									\
      XPutPixel(image, x, y, get##N(bits, x, y));						\
}

put(1) put(2) put(4) put(8) put(16) put(32)

#undef put
#undef pixel

static putter putPixels= 0, PutPixels[6]= { put1, put2, put4, put8, put16, put32 };

static int Log2[33]= { /*  0 */ 0, 0, 1, 0, 2, 0, 0, 0,
		       /*  8 */ 3, 0, 0, 0, 0, 0, 0, 0,
		       /* 16 */ 4, 0, 0, 0, 0, 0, 0, 0,
		       /* 24 */ 5, 0, 0, 0, 0, 0, 0, 0, // 24 bpp poses as 32 bpp
		       /* 32 */ 5 };

static void initPixMap(uint32_t *newDisplayBits, int newWidth, int newHeight, int newDepth)
{
  assert(!ximage);
  displayBits = newDisplayBits;
  width= newWidth;
  height= newHeight;
  depth= newDepth;
  int pixPerWord= 32 / depth;
  pitch = (width + (pixPerWord - 1)) / pixPerWord;
  int bpp= (xdepth == 24) ? 32 : xdepth;
  xpitch= ((newWidth * bpp + 31) & ~31) / 8;
  xbits = malloc(xpitch * height);
  ximage= XCreateImage(xdpy, xvisual, xdepth, ZPixmap, 0, (char *)xbits, newWidth, newHeight, 32, xpitch);
  putPixels= PutPixels[Log2[depth]];
}

static void freePixMap(void)
{
  if (ximage)
    XDestroyImage(ximage);
  xbits= 0;
  ximage= 0;
}

static void checkWindow(uint32_t *newDisplayBits, int newWidth, int newHeight, int newDepth)
{
  if ((  (displayBits != newDisplayBits))
      || (width       != newWidth      )
      || (height      != newHeight     )
      || (depth       != newDepth      ))
    {
      if (!xdpy) openWindow(newDisplayBits, newWidth, newHeight);
      freePixMap();
      initPixMap(newDisplayBits, newWidth, newHeight, newDepth);
    }
}

static void redraw(int affectedL, int affectedT, int affectedR, int affectedB)
{
  if (affectedR < affectedL || affectedB < affectedT) return;
  putPixels(displayBits, affectedL, affectedT, affectedR, affectedB, ximage);
  XPutImage(xdpy, xwin, xgc, ximage, affectedL, affectedT, affectedL, affectedT, affectedR - affectedL, affectedB - affectedT);
}

static int l= 9999, t= 9999, r= 0, b= 0;

#define min(x, y) (((x) < (y)) ? (x) : (y))
#define max(x, y) (((x) > (y)) ? (x) : (y))

static int deferUpdates= 0;

void ioShowDisplayBits(uint32_t *bits, int width, int height, int depth, int affectedL, int affectedT, int affectedR, int affectedB)
{
  checkWindow(bits, width, height, depth);
  if (deferUpdates)
    {
      l= min(l, affectedL);
      t= min(t, affectedT);
      r= max(r, affectedR);
      b= max(b, affectedB);
    }
  else
    redraw(affectedL, affectedT, affectedR, affectedB);
}

static void ioForceDisplayUpdate(void)
{
  if (deferUpdates)
    {
      redraw(l, t, r, b);
      l= t= 9999;
      r= b= 0;
    }
}

static unsigned buttonMasks[4]= {
  0,
  RedButtonBit,
  BlueButtonBit,	/* historical yellow and blue reversed because of win32 2-button mouse lusers */
  YellowButtonBit,
};

static unsigned getModifierState(unsigned xmodifierState)
{
  unsigned state= 0;
  unsigned shift= (!!(xmodifierState & ShiftMask)) ^ (!!(xmodifierState & LockMask));
  if (shift                       ) state |= ShiftKeyBit;
  if (xmodifierState & ControlMask) state |= ControlKeyBit;
  if (xmodifierState & Mod1Mask   ) state |= OptionKeyBit;
  if (xmodifierState & Mod2Mask   ) state |= CommandKeyBit;
  return state;
}

int ioProcessEvents(int microSecs)
{
  int count= 0;
  if (xdpy)
    {
      ioForceDisplayUpdate();
      while (XPending(xdpy))
	{
	  XEvent evt;
	  XNextEvent(xdpy, &evt);
	  ++count;
	  switch (evt.type)
	    {
	    case MotionNotify:
	      mouseX= evt.xmotion.x;
	      mouseY= evt.xmotion.y;
	      modifierState= getModifierState(evt.xmotion.state);
	      break;

	    case ButtonPress:
	      buttonState |= buttonMasks[evt.xbutton.button & 3];
	      mouseX= evt.xbutton.x;
	      mouseY= evt.xbutton.y;
	      modifierState= getModifierState(evt.xbutton.state);
	      break;

	    case ButtonRelease:
	      buttonState &= ~buttonMasks[evt.xbutton.button & 3];
	      mouseX= evt.xbutton.x;
	      mouseY= evt.xbutton.y;
	      modifierState= getModifierState(evt.xbutton.state);
	      break;

	    case KeyPress:
	      {
		char buf[8];
		int  n= XLookupString(&evt.xkey, buf, sizeof(buf), 0, 0);
		int  i;
		for (i= 0;  i < n;  ++i)
		Buffer_nextPut(keyboardBuffer, buf[i] | (getModifierState(evt.xkey.state) << 8));
	      }
	    case KeyRelease:
	      mouseX= evt.xkey.x;
	      mouseY= evt.xkey.y;
	      modifierState= getModifierState(evt.xkey.state);
	      break;

	    default:
	      break;
	    }
	}
    }
  return count;
}

int ioHasDisplayDepth(int depth)
{
  return depth > 0;
}

static unsigned swapBits(unsigned in)
{
  unsigned out= 0, i;
  for (i= 0;  i < 8;  ++i)
    {
      out= (out << 1) | (in & 1);
      in >>= 1;
    }
  return out;
}

void ioSetCursorWithMask(uint32_t *cursorBits, uint32_t *cursorMask, int offsetX, int offsetY)
{
  if (xdpy)
    {
      if (!cursorMask) cursorMask= cursorBits;
      unsigned char bits[32], mask[32];
      unsigned i;
      for (i= 0;  i < 16;  ++i)
	{
	  bits[i*2 + 0]= swapBits(cursorBits[i] >> 24);
	  bits[i*2 + 1]= swapBits(cursorBits[i] >> 16);
	  mask[i*2 + 0]= swapBits(cursorMask[i] >> 24);
	  mask[i*2 + 1]= swapBits(cursorMask[i] >> 16);
	}
      Pixmap bitsPixmap= XCreateBitmapFromData(xdpy, DefaultRootWindow(xdpy), (char *)bits, 16, 16);
      Pixmap maskPixmap= XCreateBitmapFromData(xdpy, DefaultRootWindow(xdpy), (char *)mask, 16, 16);
      static XColor black= { 0x000000, 0x0000, 0x0000, 0x0000, DoRed | DoGreen | DoBlue };
      static XColor white= { 0xffffff, 0xffff, 0xffff, 0xffff, DoRed | DoGreen | DoBlue };
      Cursor cursor= XCreatePixmapCursor(xdpy, bitsPixmap, maskPixmap, &black, &white, -offsetX, -offsetY);
      XFreePixmap(xdpy, bitsPixmap);
      XFreePixmap(xdpy, maskPixmap);
      if (cursor != None)
	{
	  XDefineCursor(xdpy, xwin, cursor);
	  XFreeCursor(xdpy, cursor);
	}
    }
}

void ioCloseDisplay(void)
{
  if (xdpy)
    {
      freePixMap();
      XFreeGC(xdpy, xgc);
      XDestroyWindow(xdpy, xwin);	xwin= 0;
      XCloseDisplay(xdpy);		xdpy= 0;
    }
}
