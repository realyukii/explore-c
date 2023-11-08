.section .rodata
filename:
	.string "todo_db.bin"
filemode:
	.string "wb+"
testcontent:
	.string "first content ^^"

.global main
.extern fopen
.extern fwrite
.section .text
main:
	subq $8, %rsp

	leaq filename(%rip), %rdi # param 1
	leaq filemode(%rip), %rsi # param 2
	callq fopen

	leaq testcontent(%rip), %rdi # param 1
	movl $16, %esi # param 2
	movl $1, %edx # param 3
	movq %rax, %rcx # param 4
	callq fwrite

	addq $8, %rsp
	xorl %eax, %eax
	retq
