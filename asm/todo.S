.section .rodata
clear:
	.string "\033c"
file_name:
	.string "todo_db.bin"
open_file_mode:
	.string "rb+"
create_file_mode:
	.string "wb+"
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
	.string "Invalid option! Press enter to continue..."
error_create_file:
	.string "Error! Failed to create file %s\n"
temp_str_add:
	.string "Add Data\n"
temp_str_show:
	.string "Show Data\n"
temp_str_update:
	.string "Update Data\n"
temp_str_delete:
	.string "Delete Data\n"
str_fmt_int:
	.string "%d%*c"

.extern printf
.extern scanf
.extern fopen

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

# ssize_t open_file(void)
open_file:
	subq $8, %rsp

	leaq file_name(%rip), %rdi
	leaq open_file_mode(%rip), %rsi
	callq fopen

	# check whether the return value zero or not
	testq %rax, %rax
	# skip .Lfailed_open if not 0 (the file already exists)
	jnz .Lskip_create

.Lfailed_open:
	leaq file_name(%rip), %rdi
	leaq create_file_mode(%rip), %rsi
	callq fopen
	testq %rax, %rax
	jnz .Lskip_create

.Lerror_create:
	leaq error_create_file(%rip), %rdi
	leaq file_name(%rip), %rsi
	xorl %eax, %eax
	callq printf

	xorl %eax, %eax
	addq $8, %rsp
	retq

.Lskip_create:
	movq (%rsp), %rax
	addq $8, %rsp
	retq

# int menu_add(void)
menu_add:
	pushq %rbp

	callq open_file
	testq %rax, %rax
	jz .Lmenu_add_err
	movq %rax, %rbp
	# ...

	xorl %eax, %eax
	popq %rbp
	retq

.Lmenu_add_err:
	movl $-1, %eax
	popq %rbp
	retq

# void menu_show(void)
menu_show:
	subq $8, %rsp

	leaq temp_str_show(%rip), %rdi
	xorl %eax, %eax
	callq printf

	callq getchar

	addq $8, %rsp
	retq

# void menu_update(void)
menu_update:
	subq $8, %rsp

	leaq temp_str_update(%rip), %rdi
	xorl %eax, %eax
	callq printf

	callq getchar

	addq $8, %rsp
	retq

# void menu_delete(void)
menu_delete:
	subq $8, %rsp

	leaq temp_str_delete(%rip), %rdi
	xorl %eax, %eax
	callq printf

	callq getchar

	addq $8, %rsp
	retq

# int handle_menu(int n);
handle_menu:
	subq $8, %rsp

	cmpl $1, %edi
	je .Lhandle_create
	
	cmpl $4, %edi
	je .Lhandle_read
	
	cmpl $2, %edi
	je .Lhandle_update
	
	cmpl $3, %edi
	je .Lhandle_delete

	cmpl $5, %edi
	je .Lexit_loop

	jne .Linvalid_opt

.Lhandle_create:
	callq menu_add
	jmp .Lcontinue_loop
.Lhandle_read:
	callq menu_show
	jmp .Lcontinue_loop
.Lhandle_update:
	callq menu_update
	jmp .Lcontinue_loop
.Lhandle_delete:
	callq menu_delete
	jmp .Lcontinue_loop

.Lexit_loop:
	movl $-1, %eax
	addq $8, %rsp
	retq

.Linvalid_opt:
	leaq invalid_opt(%rip), %rdi
	xorl %eax, %eax
	callq printf

	callq getchar

.Lcontinue_loop:
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