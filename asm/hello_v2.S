.section .text
.global _start
_start:
	movl	$1, %eax
	movl	$1, %edi
	movl	$hello_str, %esi
	movl	$len, %edx
	syscall

	movl	$60, %eax
	xorl	%edi, %edi
	syscall
hello_str:
	.string	"hello world!\n"
	len = . - hello_str

