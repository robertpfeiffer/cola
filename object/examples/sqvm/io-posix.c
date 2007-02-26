#include <sys/time.h>

#if 0
static unsigned counter= 0;
#endif

unsigned ioMilliSecs(void)
{
#if 0
  return ++counter;
#else
  struct timeval tv;
  gettimeofday(&tv, 0);
  return tv.tv_sec * 1000 + tv.tv_usec / 1000;
#endif
}

unsigned ioMicroSecs(void)
{
#if 0
  return counter * 1000;
#else
  struct timeval tv;
  gettimeofday(&tv, 0);
  return tv.tv_sec * 1000000 + tv.tv_usec;
#endif
}
