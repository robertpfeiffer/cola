#ifndef _SYS_IOCTL_H_
#define _SYS_IOCTL_H_

#include <sys/ioccom.h>

int ioctl(int fildes, unsigned long request, ...);

#endif /* _SYS_IOCTL_H_ */
