.section .rodata
filename:
	.string "todo_db.bin"
filemode:
	.string "wb+"
labelInput:
	.string "silahkan ketik data: "

.global main
.extern fopen
.extern fwrite
.section .text
# char *
print:
	pushq %rdi
	callq strlen
	popq %rdi
	movl %eax, %edx # param 3
	movl $1, %eax # syscall number
	movq %rdi, %rsi # param 2
	movl $1, %edi # param 1
	syscall

	retq
# char *
strlen:
	xorl %eax, %eax
	cmpb $0, (%rdi)
	je .Lend # if already 0, then return 0
.Lloop:
	incl %eax
	incq %rdi
	cmpb $0, (%rdi)
	jne .Lloop # jump until equal
.Lend:
	retq
# char *
get_input:
	decl %esi
	pushq %rdi
	xorl %eax, %eax # syscall number
	movl %esi, %edx # param 3
	movq %rdi, %rsi # param 2
	xorl %edi, %edi # param 1
	syscall
	popq %rdi
	movb $0, (%rdi, %rax)
	retq
main:
	subq $8, %rsp

	leaq filename(%rip), %rdi # param 1
	leaq filemode(%rip), %rsi # param 2
	callq fopen

	pushq %rax

	leaq labelInput(%rip), %rdi
	callq print

	subq $40, %rsp

	movq %rsp, %rdi
	movl $40, %esi
	callq get_input

	movq %rsp, %rdi # param 1
	movl $40, %esi # param 2
	movl $1, %edx # param 3
	movq 40(%rsp), %rcx # param 4
	callq fwrite

	addq $56, %rsp
	xorl %eax, %eax # return 0
	retq
