#ifndef _SETJMP_H_
#define _SETJMP_H_

#if defined(__i386)
typedef struct _jmp_buf { int ebx, esp, edp, esi, edi, eip; } jmp_buf[1];
#elif defined(__ppc__)
# define _JBLEN32	(26 + 18*2 + 129 + 1)
# define _JBLEN		_JBLEN32
  typedef int jmp_buf[_JBLEN];
#else
# error architecture not supported
#endif

extern int  setjmp(jmp_buf env);
extern void longjmp(jmp_buf env, int val);

#endif /* _SETJMP_H_ */
