#include "vbprintf.h"
#include <stdio.h>
#include <string.h>

int vsprintf(char *string, const char *fmt, va_list ap)
{
  struct buffer b;
  buffer_init(&b);
  vbprintf(&b, fmt, ap);
  memcpy(string, b.buffer, b.position);
  string[b.position]= '\0';
  buffer_release(&b);
  return b.position;
}
