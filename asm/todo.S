.section .rodata
clear:
	.string "\033c"
menu:
	.ascii "====== Todo Program ======\n"
	.ascii "1. Add\n"
	.ascii "2. Update\n"
	.ascii "3. Delete\n"
	.ascii "4. List\n"
	.ascii "5. Exit\n"
	.string "==========================\n"

.global main
.extern printf
.section .text

show_menu:
	subq $8, %rsp

	leaq clear(%rip), %rdi
	xorl %eax, %eax
	callq printf

	leaq menu(%rip), %rdi
	xorl %eax, %eax
	callq printf

	addq $8, %rsp
	retq

main:
	subq $8, %rsp
	callq show_menu

	addq $8, %rsp
	retq