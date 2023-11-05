.section .rodata
inputLabel:
	.string "Enter your name: "
sayHello:
	.string "Hello "

.section .text
.global _start

strlen:
	xorl %eax, %eax
	cmpb $0, (%rdi)
	je .Lend
.Lloop:
	incq %rax
	incq %rdi
	cmpb $0, (%rdi)
	jne .Lloop
.Lend:
	retq

get_input:
	decq %rsi
	pushq %rdi
	xorl %eax, %eax # sys num for read
	movq %rsi, %rdx # move buf from first args to second param read
	movq %rdi, %rsi # move len from second args to third param read
	xorl %edi, %edi # stdin

	syscall
	popq %rdi
	movb $0, (%rdi, %rax)
	retq

# args: char *
print:
	pushq %rdi
	callq strlen
	popq %rsi
	movl %eax, %edx
	movl $1, %edi
	movl $1, %eax
	syscall

	retq

_start:
	xorl %ebp, %ebp
	andq $-16, %rsp

	callq main

	movl %eax, %edi
	movl $60, %eax
	syscall

main:
	subq $40, %rsp

	leaq inputLabel(%rip), %rdi
	callq print

	movq %rsp, %rdi
	movl $40, %esi
	callq get_input

	leaq sayHello(%rip), %rdi
	callq print

	movq %rsp, %rdi
	callq print

	addq $40, %rsp
	retq

