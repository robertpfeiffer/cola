#include <unistd.h>
#include <syscall.h>

int close(int fd)
{
  return syscall(SYS_close, fd);
}
