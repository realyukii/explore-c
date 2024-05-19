.section .rodata
hello_str:
	.string "Hello World!\n"
	len = . - hello_str

.global main
.section .text
main:
	movl	$1, %eax
	movl	$1, %edi
	leaq	hello_str(%rip), %rsi
	movl	$len, %edx
	syscall

	movl	$60, %eax
	xorl	%edi, %edi
	syscall
	retq
