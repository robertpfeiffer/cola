{ import: Object }
{ import: Geometry }
{ import: CharacterMap }

{ include "sotype.h" }

"TODO: add density (condensed, display, expanded, ...) to face selection."
"TODO: deal with faces containing both {lining, text} numerals, {italic, sloped, swash} capitals, etc."

FontMetrics : Object (
    size		"SmallInteger - the number of glyphs that I contain"
    unitsPerEm		"Number of font units per em in my layout properties below..."
    width		"width of my widest glyph"
    height		"height of my tallest glyph"
    bbMinX		"offset from reference point of left edge of smallest rectangle enclosing all my glyphs"
    bbMinY		"offset from reference point of bottom edge of smallest rectangle enclosing all my glyphs"
    bbMaxX		"offset from reference point of right edge of smallest rectangle enclosing all my glyphs"
    bbMaxY		"offset from reference point of top edge of smallest rectangle enclosing all my glyphs"
    ascender		"height above baseline of my largest ascender"
    descender		"depth below baseline my largest descender"
    hAdvanceMax		"largest horizontal advance"
    vAdvanceMax		"largest vertical advance"
    underlinePosition	"offset from baseline of bottom edge of my underline rule"
    underlineDepth	"depth of my underline rule"
)

FontMetrics size		[ ^size ]
FontMetrics unitsPerEm		[ ^unitsPerEm ]
FontMetrics width		[ ^width ]
FontMetrics height		[ ^height ]
FontMetrics bbMinX		[ ^bbMinX ]
FontMetrics bbMinY		[ ^bbMinY ]
FontMetrics bbMaxX		[ ^bbMaxX ]
FontMetrics bbMaxY		[ ^bbMaxY ]
FontMetrics ascender		[ ^ascender ]
FontMetrics descender		[ ^descender ]
FontMetrics hAdvanceMax		[ ^hAdvanceMax ]
FontMetrics vAdvanceMax		[ ^vAdvanceMax ]
FontMetrics underlinePosition	[ ^underlinePosition ]
FontMetrics underlineDepth	[ ^underlineDepth ]

FontMetrics bounds		[ ^bbMinX @ bbMinY corner: bbMaxX @ bbMaxY ]

FontMetrics withMetrics: fontMetrics scaledBy: scalePoint
[
    | sx sy |
    self := self new.
    sx := scalePoint x.
    sy := scalePoint y.
    size		:=      fontMetrics size.
    unitsPerEm		:= sx * fontMetrics unitsPerEm.
    width		:= sx * fontMetrics width.
    height		:= sy * fontMetrics height.
    bbMinX		:= sx * fontMetrics bbMinX.
    bbMinY		:= sy * fontMetrics bbMinY.
    bbMaxX		:= sx * fontMetrics bbMaxX.
    bbMaxY		:= sy * fontMetrics bbMaxY.
    ascender		:= sy * fontMetrics ascender.
    descender		:= sy * fontMetrics descender.
    hAdvanceMax		:= sx * fontMetrics hAdvanceMax.
    vAdvanceMax		:= sy * fontMetrics vAdvanceMax.
    underlinePosition	:= sy * fontMetrics underlinePosition.
    underlineDepth	:= sy * fontMetrics underlineDepth.
]

FontMetrics initialiseFrom_: _face
{
    soFont_t *face= (soFont_t *)v__face;
    self->v_size		= (oop)((long)face->size		<< 1 | 1);
    self->v_unitsPerEm		= (oop)((long)face->unitsPerEM		<< 1 | 1);
    self->v_width		= (oop)((long)face->width		<< 1 | 1);
    self->v_height		= (oop)((long)face->height		<< 1 | 1);
    self->v_bbMinX		= (oop)((long)face->bbMinX		<< 1 | 1);
    self->v_bbMinY		= (oop)((long)face->bbMinY		<< 1 | 1);
    self->v_bbMaxX		= (oop)((long)face->bbMaxX		<< 1 | 1);
    self->v_bbMaxY		= (oop)((long)face->bbMaxY		<< 1 | 1);
    self->v_ascender		= (oop)((long)face->ascender		<< 1 | 1);
    self->v_descender		= (oop)((long)face->descender		<< 1 | 1);
    self->v_hAdvanceMax		= (oop)((long)face->hAdvanceMax		<< 1 | 1);
    self->v_vAdvanceMax		= (oop)((long)face->vAdvanceMax		<< 1 | 1);
    self->v_underlinePosition	= (oop)((long)face->ulPos		<< 1 | 1);
    self->v_underlineDepth	= (oop)((long)face->ulDepth		<< 1 | 1);
}

FontMetrics scaledBy: aPoint
[
    ^self withMetrics: self scaledBy: aPoint
]

FontMetrics printOn: aStream
[
    super printOn: aStream.
    aStream nextPut: $(; cr;
	tab; nextPutAll:       'size			'; print: size; cr;
	tab; nextPutAll:       'unitsPerEm		'; print: unitsPerEm; cr;
	tab; nextPutAll:       'width			'; print: width; cr;
	tab; nextPutAll:       'height			'; print: height; cr;
	tab; nextPutAll:       'bbMinX			'; print: bbMinX; cr;
	tab; nextPutAll:       'bbMinY			'; print: bbMinY; cr;
	tab; nextPutAll:       'bbMaxX			'; print: bbMaxX; cr;
	tab; nextPutAll:       'bbMaxY			'; print: bbMaxY; cr;
	tab; nextPutAll:       'ascender		'; print: ascender; cr;
	tab; nextPutAll:       'descender		'; print: descender; cr;
	tab; nextPutAll:       'hAdvanceMax		'; print: hAdvanceMax; cr;
	tab; nextPutAll:       'vAdvanceMax		'; print: vAdvanceMax; cr;
	tab; nextPutAll:       'underlinePosition	'; print: underlinePosition; cr;
	tab; nextPutAll:       'underlineDepth		'; print: underlineDepth; cr;
	nextPut: $).
]

"----------------------------------------------------------------"

Typeface : Object (
    _face		"my external typeface structure"
    family		"String - name of typeface: serif, sans, mono"
    series		"String - weight: medium, bold"
    shape		"String - style: roman, italic, slanted"
    metrics		"FontMetrics"
    fonts		"Dictionary of fonts created from me"
    glyphs		"Dictionary of my Glyphs"
    characterMap	"CharacterMap associating code points and glyph names"
)

Typeface printOn: aStream	[ aStream nextPutAll: self name ]

Typeface _face		[ ^_face ]
Typeface family		[ ^family ]
Typeface series		[ ^series ]
Typeface shape		[ ^shape ]
Typeface metrics	[ ^metrics ]
Typeface characterMap	[ ^characterMap ]

Typeface name		[ ^family, '-', series, '-', shape ]

CachedTypefaces := [ IdentityDictionary new ]

Typeface newFamily: familyString series: seriesString shape: shapeString metrics: typefaceMetrics
[
    self := self new.
    family  	 := familyString.
    series  	 := seriesString.
    shape   	 := shapeString.
    metrics 	 := typefaceMetrics.
    fonts   	 := IdentityDictionary new.
    glyphs  	 := IdentityDictionary new.
    characterMap := CharacterMap default.
]

Typeface family: familyString series: seriesString shape: shapeString ifAbsent: errorBlock
[
    | name |
    name := (familyString, '-', seriesString, '-', shapeString) asSymbol.
    ^CachedTypefaces
	at:       name
	ifAbsent: [self withFamily: familyString series: seriesString shape: shapeString ifAbsent: errorBlock].
]

Typeface withFamily: familyString series: seriesString shape: shapeString ifAbsent: errorBlock
[
    self := self newFamily: familyString series: seriesString shape: shapeString metrics: nil.
    self loadIfAbsent: [^errorBlock value].
    CachedTypefaces at: self name asSymbol put: self.
]

Typeface loadIfAbsent: errorBlock
[
    | name |
    name := 'fonts/', self name.
    "StdOut nextPutAll: 'loading typeface '; println: name."
    (_face := self _load_: name _stringValue) ifFalse: [^errorBlock value].
    metrics := FontMetrics new initialiseFrom_: _face.
]

Typeface _load_: _name
{
    _return (oop)soFont_load((char *)v__name);
}

Typeface family: aString	[ ^self family: aString ifAbsent: [self substituteFamily: aString] ]
Typeface series: aString	[ ^self series: aString ifAbsent: [self substituteSeries: aString] ]
Typeface shape:  aString	[ ^self shape:  aString ifAbsent: [self substituteShape:  aString] ]

Typeface family: aString ifAbsent: errorBlock	[ ^self family: aString series: series  shape: shape   ifAbsent: errorBlock ]
Typeface series: aString ifAbsent: errorBlock	[ ^self family: family  series: aString shape: shape   ifAbsent: errorBlock ]
Typeface shape:  aString ifAbsent: errorBlock	[ ^self family: family  series: series  shape: aString ifAbsent: errorBlock ]

Typeface substituteFamily: aString	[ ^self substituteFamily: aString with: (self substitutionsFor: aString) series: series  with: (Array with:             series ) shape: shape   with: (Array with:            shape  ) ]
Typeface substituteSeries: aString	[ ^self substituteFamily: family  with: (Array with:            family ) series: aString with: (self  substitutionsFor: aString) shape: shape   with: (Array with:            shape  ) ]
Typeface substituteShape:  aString	[ ^self substituteFamily: family  with: (Array with:            family ) series: series  with: (Array with:             series ) shape: aString with: (self substitutionsFor: aString) ]

TypefaceSubstitutions := [
    IdentityDictionary new
	"weights"
	at: #light	put: #(medium);
	at: #medium	put: #(light bold);
	at: #bold	put: #(black medium);
	at: #black	put: #(bold);
	"shapes"
	at: #roman	put: #(upright regular);
	at: #upright	put: #(roman   regular);
	at: #regular	put: #(roman   upright);
	at: #italic	put: #(sloped  oblique slanted);
	at: #sloped	put: #(oblique slanted italic );
	at: #oblique	put: #(sloped  slanted italic );
	at: #slanted	put: #(sloped  oblique italic );
	yourself
]

Typeface substitutionsFor: aString	[ ^TypefaceSubstitutions at: aString asSymbol ifAbsent: [Array with: aString] ]

Typeface substituteFamily: wantedFamily with: familyArray series: wantedSeries with: seriesArray shape: wantedShape with: shapeArray
[
    familyArray do: [:familyString |
	seriesArray do: [:seriesString |
	    shapeArray do: [:shapeString |
		| face |
		(face := self family: familyString series: seriesString shape: shapeString ifAbsent: [])
		    ifTrue:
		       [StdErr
			    nextPutAll: 'Typeface: substituting ';
			    nextPutAll: face name;
			    nextPutAll: ' for ';
			    nextPutAll: wantedFamily; nextPut: $-; nextPutAll: wantedSeries; nextPut: $-; nextPutAll: wantedShape;
			    cr.
			^face]]]].
    StdErr
	nextPutAll: 'Typeface: using ';
	nextPutAll: self name;
	nextPutAll: ' in place of missing ';
	nextPutAll: wantedFamily; nextPut: $-; nextPutAll: wantedSeries; nextPut: $-; nextPutAll: wantedShape;
	cr.
    ^self
]

Typeface sans		[ ^self family: 'sans' ]
Typeface serif		[ ^self family: 'serif' ]
Typeface mono		[ ^self family: 'mono' ]

Typeface light		[ ^self series: 'light' ]
Typeface medium		[ ^self series: 'medium' ]
Typeface bold		[ ^self series: 'bold' ]
Typeface black		[ ^self series: 'black' ]

Typeface roman		[ ^self shape: 'roman']
Typeface italic		[ ^self shape: 'italic' ]
Typeface sloped		[ ^self shape: 'sloped' ]

Typeface glyphAt: codePoint ifAbsent: errorBlock
[
    ^glyphs at: codePoint ifAbsent: [self newGlyphAt: codePoint ifAbsent: errorBlock]
]

Typeface newGlyphAt: codePoint ifAbsent: errorBlock
[
    | glyph |
    glyph := self glyphNamed: (characterMap nameAtCodePoint: codePoint ifAbsent: [^errorBlock value])
		  ifAbsent:   [self glyphNamed: #'.notdef' ifAbsent: [^errorBlock value]].
    ^glyphs at:  codePoint
	    put: (codePoint == glyph codePoint
		      ifTrue:  [glyph]
		      ifFalse: [glyph withCodePoint: codePoint])
]

Typeface glyphNamed: nameString ifAbsent: errorBlock
[
    | nameSymbol |
    ^glyphs at: (nameSymbol := nameString asSymbol) ifAbsent: [self newGlyphNamed: nameSymbol ifAbsent: errorBlock]
]

Typeface newGlyphNamed: nameSymbol ifAbsent: errorBlock
[
    | _glyph |
    ^(_glyph := self _glyphNamed_: nameSymbol _stringValue)
	ifTrue:  [Glyph withGlyph_: _glyph font: self codePoint: (characterMap codePointAtName: nameSymbol)]
	ifFalse: [errorBlock value].
]

Typeface _glyphNamed_: _name
{
    soFont_t *font= (soFont_t *)self->v__face;
    char *name= (char *)v__name;
    int i;
    for (i= 0;  i < font->size;  ++i)
	if (!strcmp(name, font->glyphs[i]->name))
	    { _return (oop)font->glyphs[i]; }
    _return 0;
}

Typeface glyphAt: codePoint	[ ^self glyphAt: codePoint ifAbsent: [self errorKeyNotFound: codePoint] ]
Typeface glyphNamed: nameSymbol	[ ^self glyphNamed: nameSymbol ifAbsent: [self errorKeyNotFound: nameSymbol] ]

"The default Typeface"

[
    Typeface := Typeface family: 'serif' series: 'medium' shape: 'roman' ifAbsent: [Typeface error: 'cannot find default typeface: serif-medium-roman']
]

Typeface default	[ ^self ]

"----------------------------------------------------------------"

Font : Object (
    _font		"my external font structure"
    typeface		"Typeface from which I was created"
    pointSize		"Number of points between baselines when I am set solid (the sum of tallest ascender, deepest descender and built-in leading if any)"
    metrics		"FontMetrics that describe me"
    scale		"Point multiplier converting lengths from font units to points"
    glyphs		"Array of Glyphs pre-scaled to my pointSize"
)

Font typeface	[ ^typeface ]
Font pointSize	[ ^pointSize ]
Font metrics	[ ^metrics ]
Font scale	[ ^scale ]

Typeface pointSize: pointSize
[
    ^fonts at: pointSize ifAbsent: [fonts at: pointSize put: (Font withTypeface: self pointSize: pointSize)]
]

Font withTypeface: aTypeface pointSize: aPointSize
[
    self := self new.
    _font := aTypeface _face.
    typeface := aTypeface.
    pointSize := aPointSize.
    metrics := typeface metrics.
    true
	ifTrue:  [scale := aPointSize asFloat * 116.0 / 72.0 / metrics unitsPerEm asFloat]	"from fus to points"
	ifFalse: [scale := aPointSize asFloat / metrics ascender asFloat].	"from fus to points"
    scale := scale @ scale.
    metrics := metrics scaledBy: scale.	"metrics expressed in points"
    glyphs := IdentityDictionary new.
]

Font family: 	aString		[ ^(typeface family: aString) pointSize: pointSize ]
Font series: 	aString		[ ^(typeface series: aString) pointSize: pointSize ]
Font shape:  	aString		[ ^(typeface shape:  aString) pointSize: pointSize ]
Font pointSize: aNumber		[ ^(typeface                ) pointSize: aNumber ]

Font serif	[ ^self family: 'serif' ]
Font sans	[ ^self family: 'sans' ]
Font mono	[ ^self family: 'mono' ]

Font light	[ ^self series: 'light' ]
Font medium	[ ^self series: 'medium' ]
Font bold	[ ^self series: 'bold' ]
Font black	[ ^self series: 'black' ]

Font roman	[ ^self shape:  'roman' ]
Font italic	[ ^self shape:  'italic' ]
Font sloped	[ ^self shape:  'sloped' ]

Font glyphNamed: nameString
[
    ^self glyphAt: (typeface characterMap codePointAtName: nameString ifAbsent: [0])
]

Font glyphAt: codePoint
[
    ^glyphs at: codePoint ifAbsent: [self newGlyphAt: codePoint]
]

Font newGlyphAt: codePoint
[
    ^glyphs
	at:  codePoint
	put: ((typeface glyphAt: codePoint ifAbsent: [typeface glyphAt: 0])
		  withFont: self scaledBy: scale).
]

"The default Font"

[
    Font := Typeface pointSize: 12.0
]

Font default	[ ^self ]


"----------------------------------------------------------------"

GlyphMetrics : Object (
    width	"my width in pixels"
    height	"my height in pixels"
    hBearingX	"distance in pixels from my reference point to my left edge when layed out horizontally"
    hBearingY	"distance in pixels from my reference point to my top edge when layed out horizontally"
    hAdvance	"distance in pixels from my reference point to that of the next glyph on the line when layed out horizontally"
    vBearingX	"distance in pixels from my reference point to my left edge when layed out vertically"
    vBearingY	"distance in pixels from my reference point to my top edge when layed out vertically"
    vAdvance	"distance in pixels from my reference point to that of the next glyph in the column when layed out vertically"
)

GlyphMetrics width	[ ^width ]
GlyphMetrics height	[ ^height ]
GlyphMetrics hBearingX	[ ^hBearingX ]
GlyphMetrics hBearingY	[ ^hBearingY ]
GlyphMetrics hAdvance	[ ^hAdvance ]
GlyphMetrics vBearingX	[ ^vBearingX ]
GlyphMetrics vBearingY	[ ^vBearingY ]
GlyphMetrics vAdvance	[ ^vAdvance ]

GlyphMetrics hBearing	[ ^hBearingX @ hBearingY ]
GlyphMetrics vBearing	[ ^vBearingX @ vBearingY ]

GlyphMetrics ascent	[ ^hBearingY ]
GlyphMetrics descent	[ ^hBearingY - height ]
GlyphMetrics bounds	[ ^(hBearingX) @ (hBearingY - height) corner: (hBearingX + width) @ (hBearingY) ]

GlyphMetrics newFrom_: _glyph
[
    self := self new.
    {
	soGlyph_t *glyph= (soGlyph_t *)v__glyph;
	self->v_width	= (oop)((long)glyph->width	<< 1 | 1);
	self->v_height	= (oop)((long)glyph->height	<< 1 | 1);
	self->v_hBearingX	= (oop)((long)glyph->hBearingX	<< 1 | 1);
	self->v_hBearingY	= (oop)((long)glyph->hBearingY	<< 1 | 1);
	self->v_hAdvance	= (oop)((long)glyph->hAdvance	<< 1 | 1);
	self->v_vBearingX	= (oop)((long)glyph->vBearingX	<< 1 | 1);
	self->v_vBearingY	= (oop)((long)glyph->vBearingY	<< 1 | 1);
	self->v_vAdvance	= (oop)((long)glyph->vAdvance	<< 1 | 1);
    }
]

GlyphMetrics scaledBy: scalePoint
[
    ^self withMetrics: self scaledBy: scalePoint
]

GlyphMetrics withMetrics: glyphMetrics scaledBy: scalePoint
[
    | sx sy |
    self := self new.
    sx := scalePoint x.
    sy := scalePoint y.
    width	:= sx * glyphMetrics width.
    height	:= sy * glyphMetrics height.
    hBearingX	:= sx * glyphMetrics hBearingX.
    hBearingY	:= sy * glyphMetrics hBearingY.
    hAdvance	:= sx * glyphMetrics hAdvance.
    vBearingX	:= sx * glyphMetrics vBearingX.
    vBearingY	:= sy * glyphMetrics vBearingY.
    vAdvance	:= sx * glyphMetrics vAdvance.
]

GlyphMetrics printOn: aStream
[
    super printOn: aStream.
    aStream nextPut: $(; cr;
	tab; nextPutAll:       'width			'; print: width; cr;
	tab; nextPutAll:       'height			'; print: height; cr;
	tab; nextPutAll:       'hBearingX		'; print: hBearingX; cr;
	tab; nextPutAll:       'hBearingY		'; print: hBearingY; cr;
	tab; nextPutAll:       'hAdvance		'; print: hAdvance; cr;
	tab; nextPutAll:       'vBearingX		'; print: vBearingX; cr;
	tab; nextPutAll:       'vBearingY		'; print: vBearingY; cr;
	tab; nextPutAll:       'vAdvance		'; print: vAdvance; cr;
	nextPut: $).
]

"----------------------------------------------------------------"

Glyph : Object (
    _glyph	"my external glyph structure"
    font	"Font from which I was created"
    codePoint	"SmallInteger - code point within my font"
    name	"Symbol - my name"
    metrics	"GlyphMetrics that describe me"
)

Glyph isGlyph	[ ^self ]
Object isGlyph	[ ^nil ]

Glyph _glyph	[ ^_glyph ]
Glyph font	[ ^font ]
Glyph codePoint	[ ^codePoint ]
Glyph name	[ ^name ]
Glyph metrics	[ ^metrics ]

Glyph withGlyph_: _aGlyph font: aFont codePoint: codePointInteger name: nameString metrics: glyphMetrics
[
    self := self new.
    _glyph    := _aGlyph.
    font      := aFont.
    codePoint := codePointInteger.
    name      := nameString asSymbol.
    metrics   := glyphMetrics.
]

Glyph withGlyph_: _aGlyph font: aFont codePoint: anInteger
[
    ^self withGlyph_: _aGlyph
	  font:       aFont
	  codePoint:  anInteger
	  name:	      (String value_: (self _nameOf_: _aGlyph))
	  metrics:    (GlyphMetrics newFrom_: _aGlyph)
]

Glyph withFont: aFont scaledBy: scalePoint	[ ^self withGlyph_: _glyph font: aFont codePoint: codePoint name: name metrics: (metrics scaledBy: scalePoint) ]
Glyph withCodePoint: anInteger			[ ^self withGlyph_: _glyph font: font  codePoint: anInteger name: name metrics:  metrics ]

Glyph _nameOf_: _aGlyph
{
    soGlyph_t *glyph= (soGlyph_t *)v__aGlyph;
    _return (oop)glyph->name;
}

Glyph pathOn: aCanvas	[ aCanvas glyph: self ]
Glyph bounds		[ ^metrics bounds ]

Glyph font: aFont	[ ^aFont glyphAt: codePoint ]

Glyph family: 	aString		[ ^self font: (font family: aString) ]
Glyph series: 	aString		[ ^self font: (font series: aString) ]
Glyph shape:  	aString		[ ^self font: (font shape:  aString) ]
Glyph pointSize: aNumber	[ ^self font: (font pointSize: aNumber) ]

Glyph serif	[ ^self family: 'serif' ]
Glyph sans	[ ^self family: 'sans' ]
Glyph mono	[ ^self family: 'mono' ]

Glyph light	[ ^self series: 'light' ]
Glyph medium	[ ^self series: 'medium' ]
Glyph bold	[ ^self series: 'bold' ]
Glyph black	[ ^self series: 'black' ]

Glyph roman	[ ^self shape:  'roman' ]
Glyph italic	[ ^self shape:  'italic' ]
Glyph sloped	[ ^self shape:  'sloped' ]

Glyph printOn: aStream
[
    super printOn: aStream.
    aStream
	nextPut:    $(;
	print:      codePoint;
	nextPutAll: ' -> ';
	nextPutAll: name;
	nextPut:    $)
]

{ import: Views.st }

Glyph shapedView
[
    ^ShapedView withShape: self
]
