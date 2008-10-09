#include <stdio.h>

int snprintf(char *string, size_t size, const char *fmt, ...)
{
  va_list ap;
  int n;
  va_start(ap, fmt);
  n= vsnprintf(string, size, fmt, ap);
  va_end(ap);
  return n;
}
