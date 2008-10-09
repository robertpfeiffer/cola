#include <unistd.h>
#include <syscall.h>

void *brk(const void *addr)
{
  return (void *)syscall(SYS_brk, addr);
}
