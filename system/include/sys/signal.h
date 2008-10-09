#ifndef _SYS_SIGNAL_H_
#define _SYS_SIGNAL_H_

#define SIG_IGN		((void (*)(int))1)

#define SIGINT		 2
#define SIGALRM		14
#define SIGWINCH	28

void    (*signal(int, void (*)(int)))(int);

#endif /* _SYS_SIGNAL_H_ */
