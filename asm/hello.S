.section .rodata
hemlo:
	.string "Hello world!\n"
.global _start
.section .text
_start:
	movl $1, %eax
	movl $1, %edi
	leaq hemlo(%rip), %rsi
	movl $12, %edx
	syscall

	movl $60, %eax
	xorl %edi, %edi
	syscall
