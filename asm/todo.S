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
	.ascii "==========================\n"
	.string "Enter the option: "

str_fmt_int:
	.string "%d"

.extern printf
.extern scanf

.global main
.section .text

# void show_menu(void);
show_menu:
	subq $8, %rsp

	leaq clear(%rip), %rdi
	xorl %eax, %eax
	callq printf

	leaq menu(%rip), %rdi
	xorl %eax, %eax
	callq printf

	leaq str_fmt_int(%rip), %rdi
	movq %rsp, %rsi
	xorl %eax, %eax
	callq scanf

	addq $8, %rsp
	retq

main:
	subq $8, %rsp
	callq show_menu

	xorl %eax, %eax
	addq $8, %rsp
	retq