{ import: XWindow }
{ import: Geometry }
{ import: Font }
{ import: _cairo }

Cairo : Object ( _surface _cr paths )

Cairo _surface	[ ^_surface ]
Cairo _cr	[ ^_cr ]

Cairo withSurface_: _sfc
[
    self := self new.
    _surface := _sfc.
    _cr := libcairo _cairo_create :_sfc.
]

Cairo createImageSurface: extent
[
    ^self withSurface_:
	(libcairo _cairo_image_surface_create
	     : (libcairo _CAIRO_FORMAT_ARGB32)
	     : extent x ceiling _integerValue
	     : extent y ceiling _integerValue).
]

Cairo createMaskSurface: extent
[
    ^self withSurface_:
	(libcairo _cairo_image_surface_create
	     : (libcairo _CAIRO_FORMAT_A8)
	     : extent x ceiling _integerValue
	     : extent y ceiling _integerValue).
]

Cairo destroy				[ libcairo cairo_destroy		:_cr.
					  libcairo cairo_surface_destroy	:_surface.
					  _cr := _surface := nil ]

Cairo newPath				[ libcairo _cairo_new_path		:_cr ]
Cairo stroke				[ libcairo _cairo_stroke		:_cr ]
Cairo fill				[ libcairo _cairo_fill			:_cr ]
Cairo clip				[ libcairo _cairo_clip			:_cr ]
Cairo resetClip				[ libcairo _cairo_reset_clip		:_cr ]

Cairo save				[ libcairo _cairo_save			:_cr ]
Cairo restore				[ libcairo _cairo_restore		:_cr ]

Cairo setSourceColour: clr		[ libcairo _cairo_set_source_rgba	:_cr :clr r asFloat :clr g asFloat :clr b asFloat :clr a asFloat ]
Cairo setSource_: _ptn			[ libcairo _cairo_set_source		:_cr :_ptn ]

Cairo identityMatrix			[ libcairo _cairo_identity_matrix	:_cr ]

Cairo rotate: a				[ libcairo _cairo_rotate		:_cr :a asFloat ]

Cairo translateX: x Y: y		[ libcairo _cairo_translate		:_cr :x asFloat :y asFloat ]
Cairo scaleX: x Y: y			[ libcairo _cairo_scale			:_cr :x asFloat :y asFloat ]

Cairo setStrokeWidth: w			[ libcairo _cairo_set_line_width	:_cr :w asFloat ]
Cairo getStrokeWidth			[^libcairo  cairo_get_line_width	:_cr ]
Cairo moveTo: p				[ libcairo _cairo_move_to		:_cr :p x asFloat :p y asFloat ]
Cairo moveBy: p				[ libcairo _cairo_rel_move_to		:_cr :p x asFloat :p y asFloat ]
Cairo lineTo: p				[ libcairo _cairo_line_to		:_cr :p x asFloat :p y asFloat ]
Cairo lineBy: p				[ libcairo _cairo_rel_line_to		:_cr :p x asFloat :p y asFloat ]
Cairo lineTo_: x _: y			[ libcairo _cairo_line_to		:_cr :(SmallInteger value_: x) asFloat :(SmallInteger value_: y) asFloat ]
Cairo arcX: x Y: y R: r A1: a1 A2: a2	[ libcairo _cairo_arc			:_cr :x asFloat :y asFloat :r asFloat :a1 asFloat :a2 asFloat ]

Cairo rectangle: r			[ libcairo _cairo_rectangle		:_cr :r x asFloat :r y asFloat :r width asFloat :r height asFloat ]

Cairo showText: s			[ libcairo _cairo_show_text		:_cr :s _stringValue ]

Cairo setSourceR: r G: g B: b		[ libcairo _cairo_set_source_rgb	:_cr :r asFloat :g asFloat :b asFloat ]
Cairo setSourceR: r G: g B: b A: a	[ libcairo _cairo_set_source_rgba	:_cr :r asFloat :g asFloat :b asFloat :a asFloat ]

Cairo mask_: _ptn			[ libcairo _cairo_mask			:_cr :_ptn ]
Cairo paint				[ libcairo _cairo_paint			:_cr ]

Cairo deviceToUser: pt
[
    | x y |
    x := pt x copy asFloat.
    y := pt y copy asFloat.
    libcairo _cairo_device_to_user :_cr :x :y.
    ^Point x: x y: y
]

"----------------------------------------------------------------"

{ import: Colour }

Cairo setSource: aSource		[ aSource beSourceForCanvas: self ]

Object beSourceForCanvas: aCanvas	[ self error: self debugName, ' cannot be used as a Canvas source' ]
Colour beSourceForCanvas: aCanvas	[ aCanvas setSourceColour: self ]

Cairo setClipRectangle: aRectangle
[
    self resetClip; newPath; rectangle: aRectangle; clip
]

Cairo clearClipRectangle
[
    self resetClip
]

"----------------------------------------------------------------"

CairoPath : Object ( _path )

CairoPath withPath_: _p
[
    self := self new.
    _path := _p.
]

CairoPath _path		[ ^_path ]

CairoPath destroy	[ libcairo _cairo_path_destroy :_path.  _path := nil ]


Cairo drawRectangle: r	[ self rectangle: r; stroke ]

Cairo fillRectangle: r	[ self rectangle: r; fill ]

Cairo translate: p	[ libcairo _cairo_translate	:_cr :p x asFloat :p y asFloat ]
Cairo scale:	p	[ libcairo _cairo_scale		:_cr :p x asFloat :p y asFloat ]

Cairo copyPath		[ ^CairoPath withPath_: (libcairo _cairo_copy_path :_cr) ]
Cairo appendPath: p	[ libcairo _cairo_append_path :_cr :p _path ]

Cairo savePath		[ (paths ifNil: [paths := OrderedCollection new]) addLast: self copyPath ]

Cairo restorePath
[
    | p |
    self newPath; appendPath: (p := paths removeLast).
    p destroy.
]


CairoPattern : Object ( _pattern )

CairoPattern _pattern	[ ^_pattern ]

CairoPattern createForSurface_: _sfc
[
    self := self new.
    _pattern := libcairo _cairo_pattern_create_for_surface :_sfc.
]


Cairo string: aString
[
    self string: aString font: Font default
]

Cairo string: aString font: aFont
[
    aString do: [:c |
	| g |
	self
	    save;
	    glyph: (g := aFont glyphAt: c);
	    restore;
	    translate: g metrics hAdvance @ 0]
]

Cairo glyph: aGlyph
[
    | scale |
    scale := aGlyph font scale.
    libcairo render_: _cr glyph_: aGlyph _glyph scaledX: scale x asFloat scaledY: scale y asFloat.
]

{ include "sotype.c" }
{ include <cairo.h> }

libcairo render_: _cr glyph_: _glyph scaledX: xScale scaledY: yScale
{
  soGlyph_t *glyph= (soGlyph_t *)v__glyph;
  double xScale, yScale;
  short *op= &glyph->outline[0];
# define D(X)
# define P(X) ((X) * xScale)
# define Q(Y) ((Y) * yScale)
  D(double xx= 0;  double yy= 0;)
  memcpy(&xScale, v_xScale, sizeof(double));
  memcpy(&yScale, v_yScale, sizeof(double));
#if 0
  D(xx += -P(glyph->hBearingX);  printf("GLYPH hBearing %f\n", -P(glyph->hBearingX));)
  cairo_move_to ((cairo_t *)v__cr, -P(glyph->hBearingX), 0);
#else
  cairo_move_to ((cairo_t *)v__cr, 0, 0);
#endif
  for (;;)
    switch (*op++)
      {
      case  0 :
	return (oop)(glyph->hAdvance << 1 | 1);

      case 'm': {
	  int x= *op++, y= *op++;
	  D(xx += P(x);  yy += P(y);  printf("\tmove\t%f\t%f\t(%f\t%f)\n", xx, yy, P(x), Q(y));)
	  cairo_rel_move_to((cairo_t *)v__cr, P(x), Q(y));
	}
	continue;

      case 'l': {
	  int x= *op++, y= *op++;
	  D(xx += P(x);  yy += P(y);  printf("\tline\t%f\t%f\t(%f\t%f)\n", xx, yy, P(x), Q(y));)
	  cairo_rel_line_to((cairo_t *)v__cr, P(x), Q(y));
	}
	continue;

      case '2': {
	  int x2= *op++, y2= *op++, x3= *op++, y3= *op++;
	  D(xx += P(x3);  yy += P(y3);  printf("\tcube\t%f\t%f\t(%f\t%f)\n", xx, yy, P(x3), Q(y3));)
	  cairo_rel_curve_to((cairo_t *)v__cr, /* cubic interpolation */
			     P(     (2 * (x2     ) / 3)), Q(     (2 * (y2     ) / 3)),
			     P(x2 + (    (x3 - x2) / 3)), Q(y2 + (    (y3 - y2) / 3)),
			     P(x3)                      , Q(y3));
	}
	continue;

      case '3': {
	  int x1= *op++, y1= *op++, x2= *op++, y2= *op++, x3= *op++, y3= *op++;
	  D(xx += P(x3);  yy += P(y3);  printf("\tquad\t%f\t%f\t(%f\t%f)\n", xx, yy, P(x3), Q(y3));)
	  cairo_rel_curve_to((cairo_t *)v__cr, P(x1), Q(y1), P(x2), Q(y2), P(x3), Q(y3));
	}
	continue;

      default:
	fprintf(stderr, "renderGlyph: op %d?\n", op[-1]);
	exit(1);
      }
# undef Q
# undef P
# undef D
}

Cairo glyphPoints: aGlyph
[
    | scale |
    scale := aGlyph font scale.
    libcairo render_: _cr glyphPoints_: aGlyph _glyph scaledX: scale x asFloat scaledY: scale y asFloat.
]

libcairo render_: _cr glyphPoints_: _glyph scaledX: xScale scaledY: yScale
{
  soGlyph_t *glyph= (soGlyph_t *)v__glyph;
  double xScale, yScale;
  short *op= &glyph->outline[0];
# define D(X)
# define P(X) ((X) * xScale)
# define Q(Y) ((Y) * yScale)
# define MARK()							\
	  cairo_save		((cairo_t *)v__cr);		\
	  cairo_set_source_rgb	((cairo_t *)v__cr, 0, 1, 0);	\
	  cairo_move_to		((cairo_t *)v__cr, px, py);	\
	  cairo_line_to		((cairo_t *)v__cr, xx, yy);	\
	  px=xx; py=yy;						\
	  cairo_set_line_width	((cairo_t *)v__cr, .1);		\
	  cairo_stroke		((cairo_t *)v__cr);		\
	  cairo_restore		((cairo_t *)v__cr);		\
	  cairo_move_to		((cairo_t *)v__cr, xx - .1, yy - .1);	\
	  cairo_save		((cairo_t *)v__cr);		\
	  cairo_line_to		((cairo_t *)v__cr, xx+.1, yy+.1);	\
	  cairo_set_line_width	((cairo_t *)v__cr, .2);		\
	  cairo_stroke		((cairo_t *)v__cr);		\
	  cairo_restore		((cairo_t *)v__cr)
  double xx= 0;  double yy= 0, px=xx, py=yy;
  memcpy(&xScale, v_xScale, sizeof(double));
  memcpy(&yScale, v_yScale, sizeof(double));
#if 0
  xx += -P(glyph->hBearingX);  printf("GLYPH hBearing %f\n", -P(glyph->hBearingX));
  cairo_move_to ((cairo_t *)v__cr, -P(glyph->hBearingX), 0);
#else
  cairo_move_to ((cairo_t *)v__cr, 0, 0);
#endif
  for (;;)
    switch (*op++)
      {
      case  0 :
	return (oop)(glyph->hAdvance << 1 | 1);

      case 'm': {
	  int x= *op++, y= *op++;
	  xx += P(x);  yy += P(y);
	  MARK();
	}
	continue;

      case 'l': {
	  int x= *op++, y= *op++;
	  xx += P(x);  yy += P(y);
	  MARK();
	}
	continue;

      case '2': {
	  int x2= *op++, y2= *op++, x3= *op++, y3= *op++;
	  (void)x2;  (void)y2;
	  xx += P(x3);  yy += P(y3);
	  MARK();
	}
	continue;

      case '3': {
	  int x1= *op++, y1= *op++, x2= *op++, y2= *op++, x3= *op++, y3= *op++;
	  (void)x1;  (void)y1;
	  (void)x2;  (void)y2;
	  xx += P(x3);  yy += P(y3);
	  MARK();
	}
	continue;

      default:
	fprintf(stderr, "renderGlyph: op %d?\n", op[-1]);
	exit(1);
      }
# undef MARK
# undef Q
# undef P
# undef D
}
