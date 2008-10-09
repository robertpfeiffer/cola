#if defined(__i386)

asm("	.align	16		\n\
	.globl	syscall		\n\
syscall:			\n\
	push	%ebp		\n\
	push	%edi		\n\
	push	%esi		\n\
	push	%ebx		\n\
	mov	0x2c(%esp),%ebp	\n\
	mov	0x28(%esp),%edi	\n\
	mov	0x24(%esp),%esi	\n\
	mov	0x20(%esp),%edx	\n\
	mov	0x1c(%esp),%ecx	\n\
	mov	0x18(%esp),%ebx	\n\
	mov	0x14(%esp),%eax	\n\
	int	$0x80		\n\
	pop	%ebx		\n\
	pop	%esi		\n\
	pop	%edi		\n\
	pop	%ebp		\n\
	ret");

#else
# error architecture not supported
#endif
