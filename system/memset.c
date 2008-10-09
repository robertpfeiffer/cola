#include <string.h>

void *memset(void *b, int c, size_t len)
{
  register unsigned char *p= (unsigned char *)b;
  register unsigned char  u= (unsigned char  )c;
  register size_t         n= len;
  while (n--) *p++= u;
  return b;
}
