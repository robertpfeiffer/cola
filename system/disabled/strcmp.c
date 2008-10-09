#include <string.h>

int strcmp(register const char *s1, register const char *s2)
{
  while (*s1 == *s2)
    if (!*s1)
      return 0;
    else
      ++s1, ++s2;
  return (int)(*s1 - *s2);
}
