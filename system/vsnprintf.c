#include "vbprintf.h"
#include <stdio.h>
#include <string.h>

int vsnprintf(char *string, size_t size, const char *fmt, va_list ap)
{
  struct buffer b;
  buffer_init(&b);
  vbprintf(&b, fmt, ap);
  if (b.position < size)
    {
      memcpy(string, b.buffer, b.position);
      string[b.position]= '\0';
    }
  buffer_release(&b);
  return b.position;
}
