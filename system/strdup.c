#include <string.h>
#include <stdlib.h>

char *strdup(const char *s)
{
  size_t len= strlen(s) + 1;
  char *result= (char*)malloc(len);
  if (result) memcpy(result, s, len);
  return result;
}
