{ import: Objects }

Faces := [ IdentityDictionary new ]

Face : Object ( name fonts unitsPerEM ascender descender height underline maxAdvance )

Face name	[ ^name ]
Face ascender	[ ^ascender ]
Face descender	[ ^descender ]
Face height	[ ^height ]
Face underline	[ ^underline ]
Face maxAdvance	[ ^maxAdvance ]

Face default	[ ^Face named: 'verdana' ]

Face named: nameString
[
    nameString := nameString asSymbol.
    ^Faces at: nameString ifAbsent: [Faces at: nameString put: (self newFaceNamed: nameString)]
]

Face newFaceNamed: nameSymbol	[ ^self platformFace basicNewFaceNamed: nameSymbol ]

Face basicNewFaceNamed: nameSymbol
[
    self := super new.
    name := nameSymbol.
    fonts := IdentityDictionary new.
]

Face printOn: aStream
[
    super printOn: aStream.
    aStream
	nextPut:    $(;		print: name;
	nextPutAll: ' ';	print: unitsPerEM;
	nextPutAll: ' +';	print: ascender;
	nextPutAll: ' ';	print: descender;
	nextPutAll: ' =';	print: height;
	nextPutAll: ' ';	print: maxAdvance;
	nextPutAll: ' ';	print: underline;
	nextPut:    $).
]

"----------------------------------------------------------------"

Font : Object ( face size ascender descender height underline maxAdvance glyphs )

Font face	[ ^face ]
Font size	[ ^size ]
Font ascender	[ ^ascender ]
Font descender	[ ^descender ]
Font height	[ ^height ]
Font underline	[ ^underline ]
Font maxAdvance	[ ^maxAdvance ]

Font default	[ ^Face default fontAt: 12 ]

Face fontAt: pointSize
[
    pointSize := pointSize rounded.
    ^fonts at: pointSize ifAbsent: [fonts at: pointSize put: (Font withFace: self size: pointSize)]
]

Font withFace: aFace size: pointSize	[ ^self platformFont basicWithFace: aFace size: pointSize ]

Font basicWithFace: aFace size: pointSize
[
    self := super new.
    face	:= aFace.
    size	:= pointSize.
    ascender	:= pointSize * face ascender.
    descender	:= pointSize * face descender.
    height	:= pointSize * face height.
    underline	:= pointSize * face underline.
    maxAdvance	:= (pointSize * face maxAdvance x) , (pointSize * face maxAdvance y).
    glyphs	:= IdentityDictionary new.
]

Font glyphAt: ucs4	[ ^glyphs at: ucs4 ifAbsent: [glyphs at: ucs4 put: (Glyph withFont: self ucs4: ucs4)] ]

Font printOn: aStream
[
    super printOn: aStream.
    aStream
	nextPut: $(;		print: face name;
	nextPutAll: ' @';	print: size;
	nextPutAll: ' ^';	print: height;
	nextPut: $)
]

"----------------------------------------------------------------"

Glyph : Object ( font ucs4 extent offset image advance kerning )

Glyph font	[ ^font ]
Glyph ucs4	[ ^ucs4 ]
Glyph extent	[ ^extent ]
Glyph offset	[ ^offset ]
Glyph image	[ ^image ]
Glyph advance	[ ^advance ]

Glyph withFont: aFont ucs4: ucs4code	[ ^self platformGlyph basicWithFont: aFont ucs4: ucs4code ]

Glyph basicWithFont: aFont ucs4: ucs4code
[
    self := super new.
    font := aFont.
    ucs4 := ucs4code.
]

Glyph kerningFor: nextGlyph
[
    kerning ifFalse: [kerning := IdentityDictionary new].
    ^kerning at: nextGlyph ifAbsent: [kerning at: nextGlyph put: (self basicKerningFor: nextGlyph)].
]

Glyph drawOn: aContext
[
    aContext saveTransform; translate: offset.
    image drawOn: aContext.
    aContext restoreTransform.
]

Glyph basicDrawOn: aContext
[
    image drawOn: aContext.
]

Glyph printOn: aStream
[
    super printOn: aStream.
    aStream
	nextPut:    $(;		print: font face name;
	nextPutAll: ' ';	print: font size;
	nextPutAll: ' ';	print: ucs4;
	nextPutAll: ' ';	print: extent;
	nextPutAll: ' @';	print: offset;
	nextPutAll: ' +';	print: advance;
	nextPut:    $)
]

"----------------------------------------------------------------"

{ include "ft2.h" }

FT2Library : Object ( _library currentFace currentSize )

FT2Library new
[
    self := super new.
    {
      FT_Init_FreeType((FT_Library *)&self->v__library);
    }
]

FT2Library _newFace_: _name
{
    FT_Face face;
    FT_Error err;
    char path[MAXPATHLEN];
    snprintf(path, sizeof(path), "%s.ttf", (char *)v__name);
    if ((err= FT_New_Face((FT_Library)self->v__library, path, 0, &face)))
    {
      fprintf(stderr, "%s: error %d\n", path, err);
      _return 0;
    }
    _return((oop)face);
}

[
    FT2Library := FT2Library new
]

FT2Face : Face ( _face )

FT2Face _face	[ ^_face ]

FT2Face basicNewFaceNamed: nameSymbol
[
    | maxAdvanceX maxAdvanceY |
    self := super basicNewFaceNamed: nameSymbol.
    _face := FT2Library _newFace_: nameSymbol _stringValue.
    {
      FT_Face face= (FT_Face)self->v__face;
      self->v_unitsPerEM = (oop)((long)face->units_per_EM	<< 1 | 1);
      self->v_ascender	 = (oop)((long)face->ascender		<< 1 | 1);
      self->v_descender	 = (oop)((long)face->descender		<< 1 | 1);
      self->v_height	 = (oop)((long)face->height		<< 1 | 1);
      self->v_underline	 = (oop)((long)face->underline_position	<< 1 | 1);
      self->v_underline	 = (oop)((long)face->underline_position	<< 1 | 1);
      v_maxAdvanceX	 = (oop)((long)face->max_advance_width	<< 1 | 1);
      v_maxAdvanceY	 = (oop)((long)face->max_advance_height	<< 1 | 1);
    }.
    ascender	:= ascender	/ unitsPerEM.
    descender	:= descender	/ unitsPerEM.
    height	:= height	/ unitsPerEM.
    underline	:= underline	/ unitsPerEM.
    maxAdvanceX	:= maxAdvanceX	/ unitsPerEM.
    maxAdvanceY	:= maxAdvanceY	/ unitsPerEM.
    maxAdvance	:= maxAdvanceX, maxAdvanceY.
]

Face platformFace	[ ^FT2Face ]

"----------------------------------------------------------------"

Font platformFont	[ ^self ]

"----------------------------------------------------------------"

{ import: Surface }

FT2Glyph : Glyph ()

FT2Glyph basicWithFont: aFont ucs4: ucs4code
[
    | _face size offsetX offsetY advanceX advanceY width height pitch _bitmap |
    self := super basicWithFont: aFont ucs4: ucs4code.
    _face := aFont face _face.
    size := aFont size.
    {
      FT_Face  face= (FT_Face)v__face;
      long     size= (long)v_size >> 1;
      long     ucs4= (long)v_ucs4code >> 1;
      FT_Error err;
      if ((err= FT_Set_Char_Size(face, 0, size << 6, 72, 72)))			{ fprintf(stderr, "set char size: error %d\n", err);  _return(0); }
      if ((err= FT_Load_Char(face, ucs4, FT_LOAD_RENDER)))			{ fprintf(stderr, "load char: error %d\n", err);  _return(0); }
      v_offsetX  = (oop)((long)( face->glyph->metrics.horiBearingX) << 1 | 1);
      v_offsetY  = (oop)((long)(-face->glyph->metrics.horiBearingY) << 1 | 1);
      v_advanceX = (oop)((long)face->glyph->advance.x               << 1 | 1);
      v_advanceY = (oop)((long)face->glyph->advance.y               << 1 | 1);
      v_width	 = (oop)((long)face->glyph->bitmap.width            << 1 | 1);
      v_pitch    = (oop)((long)face->glyph->bitmap.pitch            << 1 | 1);
      v_height   = (oop)((long)face->glyph->bitmap.rows             << 1 | 1);
      v__bitmap	 = (oop)face->glyph->bitmap.buffer;
#if 0
      {
	int x, y;
	unsigned char *in= (unsigned char *)face->glyph->bitmap.buffer;
	for (y= 0;  y < face->glyph->bitmap.rows;  ++y)
	  {
	    for (x= 0;  x < face->glyph->bitmap.width;  ++x)
	      if (in[x]) printf("%02x", in[x]); else printf("  ");
	    printf("\n");
	    in += face->glyph->bitmap.pitch;
	  }
      }
#endif
    }.
    extent	:= width,height.
    offset	:= (offsetX // 64) , (offsetY // 64 + aFont ascender).
    image	:= Image fromLuminanceMap_: _bitmap width: width pitch: pitch height: height.
    advance	:= (advanceX // 64) , (advanceY // 64).
]

FT2Glyph basicKerningFor: nextGlyph
[
    | _face size nextUcs4 x y |
    _face := font face _face.
    size := font size.
    nextUcs4 := nextGlyph ucs4.
    {
      FT_Face  	face= (FT_Face)v__face;
      long      size= (long)v_size >> 1;
      long     	aCode= (long)self->v_ucs4 >> 1;
      long     	bCode= (long)v_nextUcs4 >> 1;
      int      	left= FT_Get_Char_Index(face, aCode);
      int      	right= FT_Get_Char_Index(face, bCode);
      FT_Vector kerning;
      FT_Error err;
      if ((err= FT_Set_Char_Size(face, 0, size << 6, 72, 72)))			{ fprintf(stderr, "set char size: error %d\n", err);  _return(0); }
      if ((err= FT_Get_Kerning(face, left, right, FT_KERNING_DEFAULT, &kerning)))	{ fprintf(stderr, "get kerning: error %d\n", err);  _return(0); }
      v_x= (oop)(long)((kerning.x >> 6) << 1 | 1);
      v_y= (oop)(long)((kerning.y >> 6) << 1 | 1);
      if (kerning.x) printf("kern %c %c -> %d %d\n", (int)aCode, (int)bCode, (int)kerning.x, (int)kerning.y);
    }.
    ^(x,y)
]

Glyph platformGlyph	[ ^FT2Glyph ]

"----------------------------------------------------------------"

{ import: Box }

GlyphBox : Box ( glyph )

GlyphBox glyph	[ ^glyph ]

GlyphBox withGlyph: aGlyph
[
    | font |
    self := self new.
    self foreground: ColorWhite.
    font := aGlyph font.
    position := aGlyph offset x , font ascender.
    extent := aGlyph advance x , font height.
    glyph := aGlyph.
]

GlyphBox drawOn: aContext
[
    "super drawOn: aContext."
    aContext saveTransform; translate: position.
    glyph drawOn: aContext.
    aContext restoreTransform.
]

"----------------"

TextBox : Box ()

TextBox kernContents
[
    self do: [:gbox || previous |
	gbox position: ((previous := gbox prevLink)
			     ifTrue:  [previous position + previous glyph advance + (previous glyph kerningFor: gbox glyph)]
			     ifFalse: [0,0])]
]

TextBox fitContents
[
    extent := self naturalExtent.
]

TextBox naturalExtent
[
    | x y |
    x := y := 0.
    self do: [:g |
	x := x max: g position x + g extent x.
	y := y max: g position y + g extent y].
    ^x ceiling , y ceiling
]

"----------------"

String asText: aFont
[
    | text |
    text := TextBox new position: 0,0.
    self do: [:char | text add: (GlyphBox withGlyph: (aFont glyphAt: char))].
    ^text kernContents fitContents
]

String asText	[ ^self asText: Font default ]
