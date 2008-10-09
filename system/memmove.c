#include <string.h>

void *memmove(void *to, const void *from, size_t len)
{
  if (to < from)
    {
      register char *dst= (char *)to;
      register char *src= (char *)from;
      while (len--) *dst++= *src++;
    }
  else
    {
      register char *dst= (char *)to + len;
      register char *src= (char *)from + len;
      while (len--) *--dst= *--src;
    }
  return to;
}
