/* sotype.c -- simplified outline typeface
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
 * Last edited: 2007-08-09 23:58:06 by piumarta on emilia
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/param.h>

#include "sotype.h"


static void so_printI(FILE *f, int i)	{ fprintf(f, " %d", i); }
static void so_printS(FILE *f, int i)	{ fprintf(f, " %d", i); }
static void so_printN(FILE *f, char *n)	{ fprintf(f, "%s\n", n); }

static int   so_readI(FILE *f)	{ int i;	 return 1 == fscanf(f, " %d", &i) ? 	   i  :  0 ; }
static int   so_readS(FILE *f)	{ int i;	 return 1 == fscanf(f, " %d", &i) ? 	   i  :  0 ; }
static char *so_readN(FILE *f)	{ char s[1024];  return 1 == fscanf(f, " %s",  s) ? strdup(s) : "?"; }

static void so_storeI(FILE *f, int i)
{
  fputc(((unsigned)i >> 24) & 255, f);
  fputc(((unsigned)i >> 16) & 255, f);
  fputc(((unsigned)i >>  8) & 255, f);
  fputc(((unsigned)i >>  0) & 255, f);
}

static void so_storeS(FILE *f, int i)
{
  fputc(((unsigned)i >>  8) & 255, f);
  fputc(((unsigned)i >>  0) & 255, f);
}

static void so_storeN(FILE *f, char *n)
{
  fputc((unsigned)strlen(n), f);
  while (*n) fputc(*n++, f);
}

static int so_loadI(FILE *f)	{ return (getc(f) << 24) | (getc(f) << 16) | (getc(f) << 8) | (getc(f)); }
static int so_loadS(FILE *f)	{ return (getc(f) << 8) | (getc(f)); }

static char *so_loadN(FILE *f)
{
  char buf[1024];
  int  len= getc(f);
  if ((len > 0) && fread(buf, len, 1, f))
    {
      buf[len]= '\0';
      return strdup(buf);
    }
  return "?";
}


int soFont_save(soFont_t *font, char *name, char *type)
{
  char path[MAXPATHLEN];
  FILE *f= 0;
  int i;

  snprintf(path, sizeof(path), "%s.%sa", name, type);

  if (!(f= fopen(path, "w")))
    {
      perror(path);
      return 0;
    }

  fprintf(f, "SOFA\n");
# define so_do(type, name)	so_print##type(f, font->name);
  soFont_do(so_do)
# undef so_do
  fprintf(f, "\n");
  for (i= 0;  i < font->size;  ++i)
    {
      int j;
      soGlyph_t *g= font->glyphs[i];
      if (i && (g ==font->glyphs[0]))
	fputc('@', f);
      else
	{
	  fputc('+', f);
#	  define so_do(type, name)	so_print##type(f, g->name);
	  soGlyph_do(so_do)
#	  undef so_do
	  fprintf(f, "\n");
	  for (j= 0;  j < g->size;  ++j) so_printS(f, g->outline[j]);
	}
      fprintf(f, "\n");
    }
  fprintf(f, "\n");
  fclose(f);

  snprintf(path, sizeof(path), "%s.%sb", name, type);

  if (!(f= fopen(path, "w")))
    {
      perror(path);
      return 0;
    }

  fprintf(f, "SOFB");
# define so_do(type, name)	so_store##type(f, font->name);
  soFont_do(so_do)
# undef so_do
  for (i= 0;  i < font->size;  ++i)
    {
      int j;
      soGlyph_t *g= font->glyphs[i];
      if (i && (g ==font->glyphs[0]))
	fputc('@', f);
      else
	{
	  fputc('+', f);
#	  define so_do(type, name)	so_store##type(f, g->name);
	  soGlyph_do(so_do)
#	  undef so_do
	  for (j= 0;  j < g->size;  ++j) so_storeS(f, g->outline[j]);
	}
    }
  fprintf(f, "\n");
  fclose(f);

  return 1;
}


soFont_t *soFont_loadA(FILE *f, char *path)
{
  soFont_t fbuf, *font;
  int i;

# define so_do(type, name)	fbuf.name= so_read##type(f);
  soFont_do(so_do)
# undef so_do
  font= (soFont_t *)calloc(1, sizeof(soFont_t) + (sizeof(soGlyph_t *) * fbuf.size));
  memcpy(font, &fbuf, sizeof(fbuf));
  for (i= 0;  i < fbuf.size;  ++i)
    {
      soGlyph_t gbuf, *glyph;
      int j;
      j= getc(f);
      switch (j)
	{
	case '@':
	  glyph= font->glyphs[0];
	  break;

	case '+':
#	  define so_do(type, name)	gbuf.name= so_read##type(f);
	  soGlyph_do(so_do)
#	  undef so_do
	  glyph= (soGlyph_t *)calloc(1, sizeof(soGlyph_t) + (sizeof(short) * gbuf.size));
	  memcpy(glyph, &gbuf, sizeof(gbuf));
	  for (j= 0;  j < gbuf.size;  ++j)
	    glyph->outline[j]= so_readS(f);
	  break;

	default:
	  fprintf(stderr, "corrupt font file: %s?\n", path);
	  return font;
	}
      font->glyphs[i]= glyph;
    }
  if (('\n' != (getc(f))) ||(EOF != getc(f)))
    fprintf(stderr, "corrupt font file: %s?\n", path);

  return font;
}


soFont_t *soFont_loadB(FILE *f, char *path)
{
  soFont_t fbuf, *font;
  int i;

# define so_do(type, name)	fbuf.name= so_load##type(f);
  soFont_do(so_do)
# undef so_do
  font= (soFont_t *)calloc(1, sizeof(soFont_t) + (sizeof(soGlyph_t *) * fbuf.size));
  memcpy(font, &fbuf, sizeof(fbuf));
  for (i= 0;  i < fbuf.size;  ++i)
    {
      soGlyph_t gbuf, *glyph;
      int j;
      j= getc(f);
      switch (j)
	{
	case '@':
	  glyph= font->glyphs[0];
	  break;

	case '+':
#	  define so_do(type, name)	gbuf.name= so_load##type(f);
	  soGlyph_do(so_do)
#	  undef so_do
	  glyph= (soGlyph_t *)calloc(1, sizeof(soGlyph_t) + (sizeof(short) * gbuf.size));
	  memcpy(glyph, &gbuf, sizeof(gbuf));
	  for (j= 0;  j < gbuf.size;  ++j)
	    glyph->outline[j]= so_loadS(f);
	  break;

	default:
	  fprintf(stderr, "corrupt font file: %s?\n", path);
	  return font;
	}
      font->glyphs[i]= glyph;
    }
  if (('\n' != (getc(f))) ||(EOF != getc(f)))
    fprintf(stderr, "corrupt font file: %s?\n", path);

  return font;
}


int magic(FILE *f, char *number)
{
  while (*number)
    if (getc(f) != *number++)
      return 0;
  return 1;
}


soFont_t *soFont_load(char *name)
{
  char path[MAXPATHLEN];
  FILE *f= 0;
  soFont_t *font;

  snprintf(path, sizeof(path), "%s.sofb", name);
  if ((f= fopen(path, "r")) && magic(f, "SOFB"))
    font= soFont_loadB(f, path);
  else
    {
      snprintf(path, sizeof(path), "%s.sofa", name);
      if ((f= fopen(path, "r")) && magic(f, "SOFA"))
	font= soFont_loadA(f, path);
      else
	return 0;
    }
  fclose(f);
  return font;
}


soGlyph_t *soFont_findNamedGlyph(soFont_t *font, char *name)
{
  int i;
  for (i= 0;  i < font->size;  ++i)
    if (!strcmp(name, font->glyphs[i]->name))
      return font->glyphs[i];
  return 0;
}
