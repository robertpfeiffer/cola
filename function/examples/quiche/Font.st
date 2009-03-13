" Font.st -- TrueType fonts on SDL surfaces

  Copyright (c) 2009 Ian Piumarta
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

  Last edited: 2009-03-13 11:08:44 by piumarta on emilia
"

{ import: Surface }

{ include <SDL/SDL_ttf.h> }

{ TTF_Init(); }

ISO8859_1 := [ #("ISO8859-15 would be better, but I can't find the table for it and am to lazy to construct it by hand."
	"0"		"1"		"2"		"3"		"4"		"5"		"6"		"7"
  "00"	#'.notdef'	controlSTX	controlSOT	controlETX	controlEOT	controlENQ	controlACK	controlBEL
  "01"	controlBS	controlHT	controlLF	controlVT	controlFF	controlCR	controlSO	controlSI
  "02"	controlDLE	controlDC1	controlDC2	controlDC3	controlDC4	controlNAK	controlSYN	controlETB
  "03"	controlCAN	controlEM	controlSUB	controlESC	controlFS	controlGS	controlRS	controlUS
  "04"	space		exclam		quotedbl	numbersign	dollar		percent		ampersand	quotesingle
  "05"	parenleft	parenright	asterisk	plus		comma		hyphen		period		slash
  "06"	zero		one		two		three		four		five		six		seven
  "07"	eight		nine		colon		semicolon	less		equal		greater		question
  "10"	at		A		B		C		D		E		F		G
  "11"	H		I		J		K		L		M		N		O
  "12"	P		Q		R		S		T		U		V		W
  "13"	X		Y		Z		bracketleft	backslash	bracketright	asciicircum	underscore
  "14"	grave		a		b		c		d		e		f		g
  "15"	h		i		j		k		l		m		n		o
  "16"	p		q		r		s		t		u		v		w
  "17"	x		y		z		braceleft	bar		braceright	asciitilde	controlDEL
  "20"	#'.notdef'	#'.notdef'	#'.notdef'	#'.notdef'	#'.notdef'	#'.notdef'	#'.notdef'	#'.notdef'
  "21"	#'.notdef'	#'.notdef'	#'.notdef'	#'.notdef'	#'.notdef'	#'.notdef'	#'.notdef'	#'.notdef'
  "22"	#'.notdef'	#'.notdef'	#'.notdef'	#'.notdef'	#'.notdef'	#'.notdef'	#'.notdef'	#'.notdef'
  "23"	#'.notdef'	#'.notdef'	#'.notdef'	#'.notdef'	#'.notdef'	#'.notdef'	#'.notdef'	#'.notdef'
  "24"	nbspace		exclamdown	cent		sterling	currency	yen		brokenbar	section
  "25"	dieresis	copyright	ordfeminine	guillemotleft	logicalnot	softhyphen	registered	macron
  "26"	degree		plusminus	twosuperior	threesuperior	acute		mu		paragraph	periodcentered
  "27"	cedilla		onesuperior	ordmasculine	guillemotright	onequarter	onehalf		threequarters	questiondown
  "30"	Agrave		Aacute		Acircumflex	Atilde		Adieresis	Aring		AE		Ccedilla
  "31"	Egrave		Eacute		Ecircumflex	Edieresis	Igrave		Iacute		Icircumflex	Idieresis
  "32"	Eth		Ntilde		Ograve		Oacute		Ocircumflex	Otilde		Odieresis	multiply
  "33"	Oslash		Ugrave		Uacute		Ucircumflex	Udieresis	Yacute		Thorn		germandbls
  "34"	agrave		aacute		acircumflex	atilde		adieresis	aring		ae		ccedilla
  "35"	egrave		eacute		ecircumflex	edieresis	igrave		iacute		icircumflex	idieresis
  "36"	eth		ntilde		ograve		oacute		ocircumflex	otilde		odieresis	divide
  "37"	oslash		ugrave		uacute		ucircumflex	udieresis	yacute		thorn		ydieresis )
]

Glyph : Surface ( font name unicode hBearing extent hAdvance offset )

Glyph  isGlyph	[ ^self ]
Object isGlyph	[ ^nil ]

Glyph font	[ ^font ]
Glyph name	[ ^name ]
Glyph unicode	[ ^unicode ]
Glyph hBearing	[ ^hBearing ]
Glyph extent	[ ^extent ]
Glyph hAdvance	[ ^hAdvance ]

Glyph isSpace		[ ^name == #space ]
Glyph isNewline		[ ^name == #controlLF or: [name == #controlCR]]

Surface isSpace		[ ^nil ]
Surface isNewline	[ ^nil ]

Glyph width	[ ^hAdvance ]
Glyph height	[ ^font ascent ]
Glyph depth	[ ^font descent ]
Glyph lineSkip	[ ^font lineSkip ]
Glyph style	[ ^font style ]
Glyph pointSize	[ ^font pointSize ]

Glyph newWithFont: aFont index: glyphIndex
[
    | _font style hBearingX hBearingY width height |
    self := self new.
    font := aFont.
    name := glyphIndex < 256 ifTrue: [ISO8859_1 at: glyphIndex] ifFalse: [#unknown].
    style := 0"aFont face style".
    unicode := glyphIndex.
    _font := aFont _font.
    glyphIndex == 10 ifTrue: [glyphIndex := 32].
    glyphIndex == 1 ifTrue: [glyphIndex := 8212].
  {
    SDL_Color black= { 0x20, 0x20, 0x20, 0 };
    SDL_Surface *glyph;
    int xmin, xmax, ymin, ymax, advance;
    TTF_SetFontStyle((TTF_Font *)v__font, (long)v_style >> 1);
    glyph= TTF_RenderGlyph_Blended((TTF_Font *)v__font, (long)v_glyphIndex >> 1, black);
    if (!glyph) { _return(0); }
    TTF_GlyphMetrics((TTF_Font *)v__font, (long)v_glyphIndex >> 1, &xmin, &xmax, &ymin, &ymax, &advance);
    v_hBearingX	      = (oop)((long)( xmin) 	  << 1 | 1);
    v_hBearingY	      = (oop)((long)( ymax) 	  << 1 | 1);
    v_width	      = (oop)((long)(xmax - xmin) << 1 | 1);
    v_height	      = (oop)((long)(ymax - ymin) << 1 | 1);
    self->v_hAdvance  = (oop)((long)advance       << 1 | 1);
    self->v__surface  = (oop)glyph;
  }.
    hBearing := hBearingX , hBearingY.
    extent   := width , height.
    offset   := hBearingX , (aFont ascent - hBearingY).
]

Glyph withSize: aSize		[ ^(font face withSize: aSize) glyphAt: unicode ]
Glyph withFamily: aFamily	[ ^(((Family withName: aFamily) withStyle: self style) withSize: self pointSize) glyphAt: unicode ]
Glyph withFace: aFace		[ ^(aFace withSize: font pointSize) glyphAt: unicode ]
Glyph withFont: aFont		[ ^aFont glyphAt: unicode ]
Glyph withStyle: styleMask	[ ^self withFont: (font withStyle: styleMask) ]

Glyph   normal		[ ^self withFont: font normal ]
Glyph   bold		[ ^self withFont: font bold ]		Glyph   medium	[ ^self withFont: font medium ]
Glyph   italic		[ ^self withFont: font italic ]		Glyph   upright	[ ^self withFont: font upright ]
Glyph   underlined	[ ^self withFont: font underlined ]	Glyph   unlined	[ ^self withFont: font unlined ]

Glyph drawOn: aSurface at: aPoint	[ super drawOn: aSurface at: aPoint + offset]

Glyph printOn: aStream
[
    super printOn: aStream.
    aStream
	nextPut: $(;
	print: font;
	space; print: name;
	space; print: unicode;
	space; print: hBearing;
	space; print: extent;
	space; print: hAdvance;
	nextPut: $)
]

"----------------------------------------------------------------"

Family : Object ( name faces )
Face : Object ( family style fonts )
Font : Object ( face pointSize _font height ascent descent lineSkip isFixedWidth glyphs )

Families := [ IdentityDictionary new ]

"----------------"

Family : Object ( name faces )

Family name	[ ^name ]

Family withName: nameString
[
    | nameSymbol |
    nameSymbol := nameString asSymbol.
    ^Families at: nameSymbol ifAbsent: [Families at: nameSymbol put: (Family newWithName: nameSymbol)]
]

Family newWithName: nameSymbol
[
    self := self new.
    name := nameSymbol.
    faces := Array new: 8.	"underline | slanted | bold"
]

Family withStyle: styleIndex	[ ^(faces at: styleIndex) ifNil: [faces at: styleIndex put: (Face newWithFamily: self style: styleIndex)] ]

Family boldStyleMask		[ ^1 ]
Family italicStyleMask		[ ^2 ]
Family underlineStyleMask	[ ^4 ]

Symbol roman		[ ^(Family withName: self) withStyle: 0 ]
Symbol bold		[ ^(Family withName: self) withStyle: 1 ]
Symbol italic		[ ^(Family withName: self) withStyle: 2 ]
Symbol underline	[ ^(Family withName: self) withStyle: 4 ]

Family printOn: aStream
[
    super printOn: aStream.
    aStream
	nextPut: $(;
	print: name;
	nextPut: $)
]

"----------------"

Face : Object ( family style fonts )

Face family	[ ^family ]
Face style	[ ^style ]

Face name	[ ^family name ]

Face newWithFamily: fontFamily style: styleIndex
[
    self := self new.
    family := fontFamily.
    style := styleIndex.
    fonts := IdentityDictionary new.
]

Face @ ptSize		[ ^self withSize: ptSize ]

Face withSize: pointSize
[
    | font |
    (font := fonts at: pointSize ifAbsent: [fonts at: pointSize put: (Font newWithFace: self size: pointSize)]) ifTrue: [^font].
    ^style == 0
	ifTrue:  [self error: 'cannot load font ', self printString]
	ifFalse: [(self withStyle: 0) withSize: pointSize]
]

Face withStyle: aStyle		[ ^family withStyle: aStyle ]

Face   normal		[ ^family withStyle: 0 ]
Face   bold		[ ^family withStyle: (style bitOr: 1) ]		Face   medium	[ ^family withStyle: (style bitAnd: 6) ]
Face   italic		[ ^family withStyle: (style bitOr: 2) ]		Face   upright	[ ^family withStyle: (style bitAnd: 5) ]
Face   underlined	[ ^family withStyle: (style bitOr: 4) ]		Face   unlined	[ ^family withStyle: (style bitAnd: 3) ]

Face isPlain		[ ^style == 0 ]
Face isBold		[ ^(style bitAnd: 1) ~~ 0 ]
Face isItalic		[ ^(style bitAnd: 2) ~~ 0 ]

Face printOn: aStream
[
    super printOn: aStream.
    aStream
	nextPut: $(;
	print: family;
	space; print: style;
	nextPut: $)
]

"----------------"

Font : Object ( face pointSize _font height ascent descent lineSkip isFixedWidth glyphs )

Font face		[ ^face ]
Font pointSize		[ ^pointSize ]
Font _font		[ ^_font ]
Font height		[ ^height ]
Font ascent		[ ^ascent ]
Font descent		[ ^descent ]
Font lineSkip		[ ^lineSkip ]
Font isFixedWidth	[ ^isFixedWidth ]
Font glyphs		[ ^glyphs ]

Font name		[ ^face name ]
Font style		[ ^face style ]

Font isPlain		[ ^face isPlain ]
Font isBold		[ ^face isBold ]
Font isItalic		[ ^face isItalic ]

TrueTypeFontMap := [
    IdentityDictionary new
	at: #'Times'		put: 'Times';
	at: #'Times-B'		put: 'Times-Bold';
	at: #'Times-S'		put: 'Times-Italic';
	at: #'Times-BS'		put: 'Times-BoldItalic';
	at: #'Helvetica'	put: 'Helvetica';
	at: #'Helvetica-B'	put: 'Helvetica-Bold';
	at: #'Helvetica-S'	put: 'Helvetica-Oblique';
	at: #'Helvetica-BS'	put: 'Helvetica-BoldOblique';
  	at: #'Courier'		put: 'Courier';
	at: #'Courier-B'	put: 'Courier-Bold';
	at: #'Courier-S'	put: 'Courier-Oblique';
	at: #'Courier-BS'	put: 'Courier-BoldOblique';
	yourself
]

Font newWithFace: typeFace size: size
[
    | name style _name _size _style |
    self := self new.
    face := typeFace.
    pointSize := size.
    name   := face family name.
    style  := face style.	"underline | slanted | bold"
    style == 0 ifFalse: [name := name , '-'].
    (style bitAnd: 1) ~~ 0 ifTrue: [name := name , 'B'].
    (style bitAnd: 2) ~~ 0 ifTrue: [name := name , 'S'].
    (style bitAnd: 4) ~~ 0 ifTrue: [name := name , 'U'].
    name := TrueTypeFontMap
	at: name asSymbol
	ifAbsent:
	   [StdErr nextPutAll: 'substituting Times for missing font ', name.
	    'Times'].
    _name  := name _stringValue.
    _size  := size _integerValue.
    _style := 0 "face style" _integerValue.
  {
    char path[1024];
    TTF_Font *font;
    snprintf(path, sizeof(path), "fonts/%s.ttf", (const char *)v__name);
    font= TTF_OpenFont(path, (long)v__size);
    if (!font) { _return(0); }
    self->v__font= (oop)font;
    self->v_height= (oop)(TTF_FontHeight(font) << 1 | 1);
    self->v_ascent= (oop)(TTF_FontAscent(font) << 1 | 1);
    self->v_descent= (oop)(-TTF_FontDescent(font) << 1 | 1);
    self->v_lineSkip= (oop)(TTF_FontLineSkip(font) << 1 | 1);
    self->v_isFixedWidth= (oop)(TTF_FontFaceIsFixedWidth(font) ? v_Object : 0);
  }.
    glyphs := IdentityDictionary new.
]

Font withFace: aFace	[ ^aFace @ pointSize ]
Font withStyle: aStyle	[ ^self withFace: (face withStyle: aStyle) ]

Font   normal		[ ^self withFace: face normal ]
Font   bold		[ ^self withFace: face bold ]		Font   medium	[ ^self withFace: face medium ]
Font   italic		[ ^self withFace: face italic ]		Font   upright	[ ^self withFace: face upright ]
Font   underlined	[ ^self withFace: face underlined ]	Font   unlined	[ ^self withFace: face unlined ]

Font printOn: aStream
[
    super printOn: aStream.
    aStream
	nextPut: $(;
	print: face;
	space; print: pointSize;
	space; print: height;
	space; print: ascent;
	space; print: descent;
	space; print: lineSkip;
	space; print: isFixedWidth;
	nextPut: $)
]

Font glyphAt: glyphIndex
[
    ^glyphs at: glyphIndex ifAbsent: [glyphs at: glyphIndex put: (self newGlyphAt: glyphIndex)]
]

Font newGlyphAt: glyphIndex
[
    ^Glyph newWithFont: self index: glyphIndex.
]

"----------------------------------------------------------------"

DefaultSize := [ 14 ]
DefaultFont := [ #Times roman @ DefaultSize ]
