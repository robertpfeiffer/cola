{ import: _cairo }

cairo : libcairo ( _cr )

cairo withSurface_: _surface
[
    self := self new.
    _cr := self _cairo_create :_surface.
]

cairo newPath				[ self _cairo_new_path		:_cr ]
cairo stroke				[ self _cairo_stroke		:_cr ]
cairo fill				[ self _cairo_fill		:_cr ]
cairo clip				[ self _cairo_clip		:_cr ]

cairo save				[ self _cairo_save		:_cr ]
cairo restore				[ self _cairo_restore		:_cr ]

cairo setSourceR: r G: g B: b		[ self _cairo_set_source_rgb	:_cr :r asFloat :g asFloat :b asFloat ]

cairo translateX: x Y: y		[ self _cairo_translate		:_cr :x asFloat :y asFloat ]
cairo scaleX: x Y: y			[ self _cairo_scale		:_cr :x asFloat :y asFloat ]

cairo setLineWidth: w			[ self _cairo_set_line_width	:_cr :w asFloat ]
cairo getLineWidth			[^self  cairo_get_line_width	:_cr ]
cairo moveTo_: x _: y			[ self _cairo_move_to		:_cr :(SmallInteger value_: x) asFloat :(SmallInteger value_: y) asFloat ]
cairo lineTo_: x _: y			[ self _cairo_line_to		:_cr :(SmallInteger value_: x) asFloat :(SmallInteger value_: y) asFloat ]
cairo arcX: x Y: y R: r A1: a1 A2: a2	[ self _cairo_arc		:_cr :x asFloat :y asFloat :r asFloat :a1 asFloat :a2 asFloat ]
cairo rectangleX: x Y: y W: w H: h	[ self _cairo_rectangle		:_cr :x asFloat :y asFloat :w asFloat :h asFloat ]

cairo showText_: s			[ self _cairo_show_text		:_cr :s ]

cairo translate_: x _: y		[ self translateX: (SmallInteger value_: x) Y: (SmallInteger value_: y) ]
cairo rectangle_: x _: y _: w _: h	[ self rectangleX: (SmallInteger value_: x) Y: (SmallInteger value_: y)
							W: (SmallInteger value_: w) H: (SmallInteger value_: h) ]
cairo setLineWidth_: _w			[ self setLineWidth: (SmallInteger value_: _w) ]
cairo setSourceRGB_: r _: g _: b	[ self setSourceR: (SmallInteger value_: r) G: (SmallInteger value_: g) B: (SmallInteger value_: b) ]

"
cairo paint				[ self _cairo_paint		:_cr ]
"
