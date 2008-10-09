#include <stdio.h>

int puts(const char *str)
{
  if (   fputs(str,  stdout) < 0
      || fputc('\n', stdout) < 0)
    return -1;
  return 0;
}
