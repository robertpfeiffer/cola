#ifndef _FCNTL_H_
#define _FCNTL_H_

#define O_RDONLY	0x0000
#define O_WRONLY	0x0001
#define O_RDWR		0x0002
#define O_CREAT		0x0200
#define O_TRUNC		0x0400
#define S_IRWXU		(S_IRUSR | S_IWUSR | S_IXUSR)
#define S_IRUSR		0000400
#define S_IWUSR		0000200
#define S_IXUSR		0000100
#define S_IRWXG		(S_IRGRP | S_IWGRP | S_IXGRP)
#define S_IRGRP		0000040
#define S_IWGRP		0000020
#define S_IXGRP		0000010
#define S_IRWXO		(S_IROTH | S_IWOTH | S_IXOTH)
#define S_IROTH		0000004
#define S_IWOTH		0000002
#define S_IXOTH		0000001

int open(const char *path, int oflag, ...);

#endif /* _FCNTL_H_ */
