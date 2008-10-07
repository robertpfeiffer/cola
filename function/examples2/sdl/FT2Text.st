{ import: Text }

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
