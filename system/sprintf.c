#include <stdio.h>

int sprintf(char *string, const char *fmt, ...)
{
  va_list ap;
  int n;
  va_start(ap, fmt);
  n= vsprintf(string, fmt, ap);
  va_end(ap);
  return n;
}
