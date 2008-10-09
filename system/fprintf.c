#include <stdio.h>

int fprintf(FILE *stream, const char *fmt, ...)
{
  va_list ap;
  int n;
  va_start(ap, fmt);
  n= vfprintf(stream, fmt, ap);
  va_end(ap);
  return n;
}
