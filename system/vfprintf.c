#include "vbprintf.h"
#include <stdio.h>

int vfprintf(FILE *stream, const char *fmt, va_list ap)
{
  int n;
  struct buffer b;
  buffer_init(&b);
  vbprintf(&b, fmt, ap);
  for (n= 0;  n < b.position;  ++n)
    fputc(b.buffer[n], stream);
  buffer_release(&b);
  return n;
}
