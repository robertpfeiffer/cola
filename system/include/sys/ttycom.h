#ifndef _SYS_TTYCOM_H_
#define _SYS_TTYCOM_H_

#include <sys/ioccom.h>

#define TIOCGWINSZ	_IOR('t', 104, struct winsize)

struct winsize
{
  unsigned short  ws_row;
  unsigned short  ws_col;
  unsigned short  ws_xpixel;
  unsigned short  ws_ypixel;
};

#endif /* _SYS_TTYCOM_H_ */
