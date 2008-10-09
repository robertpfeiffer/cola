#include "vbprintf.h"
#include <stdlib.h>

struct buffer *buffer_init(struct buffer *b)
{
  b->buffer= malloc(b->length= 32);
  b->position= 0;
  return b;
}

void buffer_release(struct buffer *b)
{
  free(b->buffer);
}

static void buffer_putc(struct buffer *b, int c)
{
  if (b->position >= b->length) b->buffer= realloc(b->buffer, b->length *= 2);
  b->buffer[b->position++]= c;
}

static void buffer_puts(struct buffer *b, char *s)
{
  while (*s) buffer_putc(b, *s++);
}

static void buffer_putn(struct buffer *b, unsigned long x, int sign, int base, int fieldlen, int padchar, int upcase)
{
  static char lc_digits[]= "0123456789abcdef";
  static char uc_digits[]= "0123456789ABCDEF";
  char buf[32], *s= buf;
  if (sign && (long)x < 0)
    {
      *s++= '-';
      x= -x;
    }
  do {
      unsigned long j= x % base;
      *s++= upcase ? uc_digits[j] : lc_digits[j];
      x -= j;
      x /= base;
  } while (x);
  for (fieldlen -= (s - buf);  fieldlen > 0;  --fieldlen)
    buffer_putc(b, padchar);
  for (--s;  s >= buf;  --s)
    buffer_putc(b, *s);
}

void vbprintf(struct buffer *b, const char *fmt, va_list ap)
{
  int c;
  int fieldlen;
  int padchar;
  while ((c= *fmt++))
    {
      if (c != '%')
	{
	  buffer_putc(b, c);
	  continue;
	}
      if ((c= *fmt++) == '\0')
	goto out;
      if (c == '.')
	if ((c= *fmt++) == '\0')
	  goto out;
      padchar= ' ';
      if (c == '0')
	{
	  padchar= c;
	  if ((c= *fmt++) == '\0')
	    goto out;
	}
      fieldlen= 0;
      while (c >= '0' && c <= '9')
	{
	  fieldlen= (fieldlen * 10) + (c - '0');
	  if ((c= *fmt++) == '\0')
	    goto out;
	}
      for (;;)
	{
	  switch (c)
	    {
	    case 'h':
	    case 'j':
	    case 'l':
	    case 't':
	    case 'z':
	      if ((c= *fmt++) == '\0')
		goto out;
	      break;
	    default:
	      goto cont;
	    }
	}
    cont:
      switch (c)
	{
	case 'p':
	case 'x': buffer_putn(b, va_arg(ap, unsigned long), 0, 16, fieldlen, padchar, 0);	break;
	case 'P':
	case 'X': buffer_putn(b, va_arg(ap, unsigned long), 0, 16, fieldlen, padchar, 1);	break;
	case 'o': buffer_putn(b, va_arg(ap, unsigned long), 0,  8, fieldlen, padchar, 0);	break;
	case 'd': buffer_putn(b, va_arg(ap, unsigned long), 1, 10, fieldlen, padchar, 0);	break;
	case 'i': buffer_putn(b, va_arg(ap, unsigned long), 1, 10, fieldlen, padchar, 0);	break;
	case 'u': buffer_putn(b, va_arg(ap, unsigned long), 0, 10, fieldlen, padchar, 0);	break;
	case 'c': buffer_putc(b, va_arg(ap, int));						break;
	case 's': buffer_puts(b, va_arg(ap, char *));						break;
	case '%': buffer_putc(b, c);								break;
	default:
	  buffer_putc(b, c);
	  buffer_putc(b, '<');
	  buffer_putn(b, va_arg(ap, unsigned long), 0, 16, fieldlen, padchar, 1);
	  buffer_putc(b, '>');
	  break;
	}
    }
 out:
  return;
}
