{ import: XWindow }
{ import: Cairo }

XWindow newCairoContext
[
    ^(Cairo withXWindow: self)
	translate:	 (0".5") @ (windowHeight" - 0.5");
	scale:		 1 @ -1
]

Cairo withXWindow: xWindow	[ ^self withSurface_: xWindow _cairoSurface ]

XWindow _cairoSurface		[ ^libcairo _cairo_xlib_surface_create :_dpy :_buf :_vis :windowWidth :windowHeight ]
