.section .rodata
format:
	.string "Loop %d\n"

.global main
.section .text
main:
	pushq %rbp
	pushq %rbx
	movq %rsp, %rbp
	subq $8, %rsp

	xorl %ebx, %ebx
.Lloop:
	xorl %eax, %eax
	leaq format(%rip), %rdi
	movl %ebx, %esi
	callq printf

	incl %ebx
	cmpl $100, %ebx
	jl .Lloop

	movq %rbp, %rsp
	popq %rbx
	popq %rbp
	retq
