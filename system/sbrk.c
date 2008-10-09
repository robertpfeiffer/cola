#include <unistd.h>
#include <syscall.h>

void *sbrk(ssize_t increment)
{
  void *newbrk, *oldbrk;
  oldbrk= brk(0);
  if (!increment) return oldbrk;
  newbrk= brk(oldbrk + increment);
  if (newbrk == oldbrk) return (void *)-1;
  return oldbrk;
}
