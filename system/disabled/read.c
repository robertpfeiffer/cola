#include <unistd.h>
#include <syscall.h>

ssize_t read(int fd, void *buf, size_t nbytes)
{
  return (ssize_t)syscall(SYS_read, fd, buf, nbytes);
}
