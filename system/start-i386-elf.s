	.text
	.globl _start
_start:
	xorl	%ebp, %ebp
	popl	%esi			/* argc  */
	movl	%esp, %ecx		/* argv follows argc */
	andl	$0xfffffff0, %esp	/* 16-byte aligned stack */
	pushl	$0			/* alignment padding  */
	pushl	$0			/* envp */
	pushl	%ecx			/* argv */
	pushl	%esi			/* argc */
	call	main
	movl	%eax, 0(%esp)
	call	exit
	hlt
