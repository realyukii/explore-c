.section .text
.global _start
_start:
	movl	$4, %eax
	movl	$1, %ebx
	movl	$hello_str, %ecx
	movl	$len, %edx
	int	$0x80

	movl	$1, %eax
	xorl	%ebx, %ebx
	int	$0x80
hello_str:
	.string	"hello world!\n"
	len = . - hello_str

