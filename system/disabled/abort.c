#include <stdlib.h>
#include <unistd.h>

void abort(void)
{
  write(2, "\naborted\n", 9);
  exit(70);
}
