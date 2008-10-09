#include <stdio.h>

int fputs(const char *str, FILE *stream)
{
  int c;
  while ((c= *str++))
    if (fputc(c, stream) < 0)
      return -1;
  return 0;
}

#ifdef TEST

int main()
{
  write(2, "test\n", 5);
  fputs("Hello, world\n", stderr);
  return 0;
}

#endif
