/* sotype.h -- simplified outline typeface
 *
 * Copyright (c) 2007 Ian Piumarta
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the 'Software'),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, provided that the above copyright notice(s) and this
 * permission notice appear in all copies of the Software and that both the
 * above copyright notice(s) and this permission notice appear in supporting
 * documentation.
 *
 * THE SOFTWARE IS PROVIDED 'AS IS'.  USE ENTIRELY AT YOUR OWN RISK.
 *
 * Last edited: 2007-08-09 23:58:03 by piumarta on emilia
 */

#ifndef __sotype_h
#define __sotype_h

#define soFont_do(_DO)				\
  _DO(N, name)					\
  _DO(N, family)	_DO(N, style)		\
  _DO(S, size)		_DO(S, unitsPerEM)	\
  _DO(S, width)		_DO(S, height)		\
  _DO(S, bbMinX)	_DO(S, bbMinY)		\
  _DO(S, bbMaxX)	_DO(S, bbMaxY)		\
  _DO(S, ascender)	_DO(S, descender)	\
  _DO(S, hAdvanceMax)	_DO(S, vAdvanceMax)	\
  _DO(S, ulPos)		_DO(S, ulDepth)

#define soGlyph_do(_DO)							\
  _DO(N, name)								\
  _DO(I, size)		_DO(I, index)					\
  _DO(S, width)		_DO(S, height)					\
  _DO(S, hBearingX)	_DO(S, hBearingY)	_DO(S, hAdvance)	\
  _DO(S, vBearingX)	_DO(S, vBearingY)	_DO(S, vAdvance)

# define so_N char *
# define so_I int
# define so_S short
# define so_decl(TYPE, NAME)	so_##TYPE NAME;

typedef struct {
  soGlyph_do(so_decl)
  short	outline[];
} soGlyph_t;

typedef struct {
  soFont_do(so_decl)
  soGlyph_t *glyphs[];
} soFont_t;

# undef so_N
# undef so_I
# undef so_S
# undef so_decl

extern int       soFont_save(soFont_t *font, char *name, char *type);
extern soFont_t *soFont_load(char *name);

extern soGlyph_t *soFont_findNamedGlyph(soFont_t *font, char *name);

#endif /* __sotype_h */
