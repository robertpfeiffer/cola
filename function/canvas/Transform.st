{ import: Object }

Transform : Object ()

Transform translatedBy: aPair		[ ^self copy translateBy: aPair ]
Transform scaledBy: aPair		[ ^self copy scaledBy: aPair ]
Transform rotatedBy: anAngle		[ ^self copy rotatedBy: anAngle ]
Transform transformedBy: aTransform	[ ^self copy transformBy: aTransform ]
Transform inverted			[ ^self copy invert ]

{ include <cairo.h> }

Transform2D : Transform ()

Transform2D _sizeof	{ return (oop)sizeof(cairo_matrix_t); }

Transform2D asTransform2D	[]

Transform2D xx	[ | _fp | { v__fp= (oop)&((cairo_matrix_t *)self)->xx; }.  ^Float value_: _fp ]
Transform2D yx	[ | _fp | { v__fp= (oop)&((cairo_matrix_t *)self)->yx; }.  ^Float value_: _fp ]
Transform2D xy	[ | _fp | { v__fp= (oop)&((cairo_matrix_t *)self)->xy; }.  ^Float value_: _fp ]
Transform2D yy	[ | _fp | { v__fp= (oop)&((cairo_matrix_t *)self)->yy; }.  ^Float value_: _fp ]
Transform2D x0	[ | _fp | { v__fp= (oop)&((cairo_matrix_t *)self)->x0; }.  ^Float value_: _fp ]
Transform2D y0	[ | _fp | { v__fp= (oop)&((cairo_matrix_t *)self)->y0; }.  ^Float value_: _fp ]

Transform2D = aTransform
[
    aTransform := aTransform asTransform2D.
    ^         self xx = aTransform xx and: [self yx = aTransform yx
	and: [self xy = aTransform xy and: [self yy = aTransform yy
	and: [self x0 = aTransform x0 and: [self y0 = aTransform y0]]]]]
]

Transform2D withIdentity
[
    self := self new.
    { cairo_matrix_init_identity((cairo_matrix_t *)self); }
]

Transform2D withTranslation: aPair
[
    | x y |
    self := self new.
    x := aPair x asFloat.
    y := aPair y asFloat.
    {
	double x, y;
	memcpy(&x, v_x, sizeof(x));
	memcpy(&y, v_y, sizeof(y));
	cairo_matrix_init_translate((cairo_matrix_t *)self, x, y);
    }
]

Transform2D withScaling: aPair
[
    | x y |
    self := self new.
    x := aPair x asFloat.
    y := aPair y asFloat.
    {
	double x, y;
	memcpy(&x, v_x, sizeof(x));
	memcpy(&y, v_y, sizeof(y));
	cairo_matrix_init_scale((cairo_matrix_t *)self, x, y);
    }
]

Transform2D withRotation: radians
[
    self := self new.
    radians := radians asFloat.
    {
	double r;
	memcpy(&r, v_radians, sizeof(r));
	cairo_matrix_init_rotate((cairo_matrix_t *)self, r);
    }
]

Transform2D copy
[
    | t |
    t := self new.
    {
	memcpy(v_t, self, sizeof(cairo_matrix_t));
    }.
    ^t
]

Transform2D translateBy: aPair
[
    | x y |
    x := aPair x asFloat.
    y := aPair y asFloat.
    {
	double x, y;
	memcpy(&x, v_x, sizeof(x));
	memcpy(&y, v_y, sizeof(y));
	cairo_matrix_translate((cairo_matrix_t *)self, x, y);
    }
]

Transform2D scaleBy: aPair
[
    | x y |
    x := aPair x asFloat.
    y := aPair y asFloat.
    {
	double x, y;
	memcpy(&x, v_x, sizeof(x));
	memcpy(&y, v_y, sizeof(y));
	cairo_matrix_scale((cairo_matrix_t *)self, x, y);
    }
]

Transform2D rotateBy: radians
[
    radians := radians asFloat.
    {
	double r;
	memcpy(&r, v_radians, sizeof(r));
	cairo_matrix_rotate((cairo_matrix_t *)self, r);
    }
]

Transform2D transformBy: aTransform
[
    aTransform := aTransform asTransform2D.
    {
	cairo_matrix_multiply((cairo_matrix_t *)self, (cairo_matrix_t *)self, (cairo_matrix_t *)v_aTransform);
    }
]

Transform2D invert
{
    cairo_matrix_invert((cairo_matrix_t *)self);
}

Transform2D * aTransform		[ ^self transformedBy: aTransform ]

Transform2D transform: aPair
[
    | x y |
    x := aPair x asFloat copy.
    y := aPair y asFloat copy.
    {
	double x, y;
	memcpy(&x, v_x, sizeof(x));
	memcpy(&y, v_y, sizeof(y));
	cairo_matrix_transform_point((cairo_matrix_t *)self, &x, &y);
	memcpy(v_x, &x, sizeof(x));
	memcpy(v_y, &y, sizeof(y));
    }.
    ^x,y
]

Transform2D printOn: aStream
[
    aStream
	nextPut: ${;
	space; print: self xx; space; print: self yx;
	space; print: self xy; space; print: self yy;
	space; print: self x0; space; print: self y0;
	space; nextPut: $}
]
