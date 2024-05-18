.section .rodata
hello_str:
	.string	"hello world!\n"
	len = . - hello_str

.section .text
.global _start
_start:
	movl	$1, %eax
	movl	$1, %edi
	leaq	hello_str(%rip), %rsi
	movl	$len, %edx
	syscall

	movl	$60, %eax
	xorl	%edi, %edi
	syscall

