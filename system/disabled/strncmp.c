#include <string.h>

int strncmp(register const char *s1, register const char *s2, size_t len)
{
  while ((*s1 == *s2) && len)
    if (!*s1)
      return 0;
    else
      ++s1, ++s2, --len;
  if (!len)
    return 0;
  return (int)(*s1 - *s2);
}
