#include <string.h>

size_t strlen(const char *s)
{
  register const char *t= s;
  while (*t++)
    ;
  return t - s - 1;
}
