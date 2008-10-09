#include <unistd.h>
#include <syscall.h>

ssize_t write(int fd, const void *buf, size_t nbytes)
{
  return (ssize_t)syscall(SYS_write, fd, buf, nbytes);
}
