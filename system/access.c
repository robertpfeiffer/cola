#include <unistd.h>
#include <syscall.h>

int access(const char *path, int mode)
{
  return (int)syscall(SYS_access, path, mode);
}
