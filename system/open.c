#include <unistd.h>
#include <syscall.h>

int open(const char *path, int flags, mode_t mode)
{
  return syscall(SYS_open, flags, mode);
}
