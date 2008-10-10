#include <string.h>

void *memcpy(void *dst, const void *src, register size_t len)
{
  register char *d= (char *)dst;
  register char *s= (char *)src;
  while (len--) *d++= *s++;
  return dst;
}

