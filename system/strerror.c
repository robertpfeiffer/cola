#include <string.h>
#include <sys/errno.h>

char *strerror(int errnum)
{
  switch (errnum)
    {
    case EINTR:	 return "interrupted system call";
    case EBADF:	 return "bad file descriptor";
    case EDOM:	 return "numeric argument out of domain";
    case ERANGE: return "result too large";
    }
  return "unknown error";
}
