#ifndef _UNISTD_H_
#define _UNISTD_H_

#include <stdint.h>
#include <sys/types.h>

long	syscall(long sysno, ...);

int	access(const char *path, int amode);

#define R_OK	4
#define W_OK	2
#define X_OK	1
#define F_OK	0

int 	close(int fd);
int 	isatty(int fd);
ssize_t read(int fildes, void *buf, size_t nbyte);
ssize_t write(int fildes, const void *buf, size_t nbyte);

void *brk(const void *addr);
void *sbrk(ssize_t increment);

#endif /* _UNISTD_H_ */
