#include <setjmp.h>

#if defined(__i386)

asm ("	.text			\n\
	.align	4		\n\
	.globl	longjmp		\n\
longjmp:			\n\
	movl	4(%esp),%edx	\n\
	movl	8(%esp),%eax	\n\
	movl	(%edx),%ebx	\n\
	movl	4(%edx),%esp	\n\
	movl	8(%edx),%ebp	\n\
	movl	12(%edx),%esi	\n\
	movl	16(%edx),%edi	\n\
	jmp	*20(%edx)	\n"
     );

#else
# error architecture not supported
#endif
