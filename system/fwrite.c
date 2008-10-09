#include <stdio.h>

size_t fwrite(const void *ptr, size_t size, size_t nmemb, FILE *stream)
{
  size *= nmemb;
  while (size--)
    fputc(*(char *)ptr++, stream);
  return nmemb;
}
