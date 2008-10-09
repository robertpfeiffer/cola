#ifndef _SYS_TERMIOS_H_
#define _SYS_TERMIOS_H_

#include <sys/ttycom.h>

#define NCCS            20

#define	IGNBRK		0x00000001
#define	BRKINT		0x00000002
#define	IGNPAR		0x00000004
#define	PARMRK		0x00000008
#define	INPCK		0x00000010
#define	ISTRIP		0x00000020
#define	INLCR		0x00000040
#define	IGNCR		0x00000080
#define	ICRNL		0x00000100
#define	IXON		0x00000200
#define	IXOFF		0x00000400
#define	IXANY		0x00000800

#define	OPOST		0x00000001
#define ONLCR		0x00000002

#define	ISIG		0x00000080
#define	ICANON		0x00000100

#define CSIZE		0x00000300
#define   CS5	    	0x00000000
#define   CS6	    	0x00000100
#define   CS7	    	0x00000200
#define   CS8	    	0x00000300
#define PARENB		0x00001000

#define ECHO		0x00000008
#define	ECHONL		0x00000010
#define	IEXTEN		0x00000400

#define	TCSADRAIN	1

typedef unsigned long   tcflag_t;
typedef unsigned char   cc_t;
typedef unsigned long   speed_t;

struct termios
{
  tcflag_t        c_iflag;
  tcflag_t        c_oflag;
  tcflag_t        c_cflag;
  tcflag_t        c_lflag;
  cc_t            c_cc[NCCS];
  speed_t         c_ispeed;
  speed_t         c_ospeed;
};

int tcgetattr(int fd, struct termios *t);
int tcsetattr(int fd, int action, const struct termios *t);

#endif /* _SYS_TERMIOS_H_ */
