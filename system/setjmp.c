#include <setjmp.h>

#if defined(__i386)

asm ("	.text			\n\
	.align 4		\n\
	.globl setjmp		\n\
setjmp:				\n\
	movl	4(%esp),%edx	\n\
	popl	%ecx		\n\
	xorl	%eax,%eax	\n\
	movl	%ebx,(%edx)	\n\
	movl	%esp,4(%edx)	\n\
	pushl	%ecx		\n\
	movl	%ebp,8(%edx)	\n\
	movl	%esi,12(%edx)	\n\
	movl	%edi,16(%edx)	\n\
	movl	%ecx,20(%edx)	\n\
	ret"
     );

#else
# error architecture not supported
#endif
