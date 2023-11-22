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
invalid_opt:
	.string "Invalid option!"
temp_str:
	.string "Add Data\n"
str_fmt_int:
	.string "%d"

.extern printf
.extern scanf

.global main
.section .text

# int show_menu(void); todo: exit on ret less than 0
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

	cmpl $1, %eax
	jl .Lshow_menu_err

	movl (%rsp), %eax

	addq $8, %rsp
	retq

.Lshow_menu_err:
	movl $-1, %eax

	addq $8, %rsp
	retq

# void menu_add(void)
menu_add:
	subq $8, %rsp

	leaq temp_str(%rip), %rdi
	xorl %eax, %eax
	callq printf

	addq $8, %rsp
	retq

# int handle_menu(int n);
handle_menu:
	subq $8, %rsp

	cmpl $1, %edi
	je .Lhandle_add

	cmpl $5, %edi
	je .Lexit_loop

	jne .Linvalid_opt

.Lhandle_add:
	callq menu_add
	jmp .Lcontinue_loop

.Lexit_loop:
	movl $-1, %eax
	addq $8, %rsp
	retq

.Linvalid_opt:
	leaq invalid_opt(%rip), %rdi
	xorl %eax, %eax
	callq printf

.Lcontinue_loop:
	xorl %eax, %eax
	addq $8, %rsp
	retq

main:
	subq $8, %rsp

.Lloop_program:
	callq show_menu

	cmpl $-1, %eax
	je .Lexit_program

	movl %eax, %edi
	callq handle_menu

	cmpl $-1, %eax
	jne .Lloop_program

.Lexit_program:
	xorl %eax, %eax
	addq $8, %rsp
	retq