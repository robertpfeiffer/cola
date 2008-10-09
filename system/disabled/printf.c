#include <stdio.h>

int printf(const char *fmt, ...)
{
  va_list ap;
  int n;
  va_start(ap, fmt);
  n= vfprintf(stdout, fmt, ap);
  va_end(ap);
  return n;
}

