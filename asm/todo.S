#define MAX_INPUT_LEN 255
#define SEEK_END 2

.section .rodata
clear:
	.string "\033c"
file_name:
	.string "todo_db.bin"
tmp_file_name:
	.string "tmp_db.bin"
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
label_add_data:
	.string "Enter the data: "
label_choose_delete:
	.string "Enter the record ID to delete: "
label_choose_update:
	.string "Enter the record ID to update: "
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
str_fmt_record:
	.string "%d\. %s\n"

.extern remove
.extern rename
.extern printf
.extern scanf
.extern fgets
.extern stdin
.extern strlen
.extern fwrite
.extern fread
.extern fseek
.extern fopen

.global main
.section .text

# int show_menu(void);
show_menu:
	subq	$8, %rsp

	leaq	clear(%rip), %rdi
	xorl	%eax, %eax
	callq	printf

	leaq	menu(%rip), %rdi
	xorl	%eax, %eax
	callq	printf

	leaq	str_fmt_int(%rip), %rdi
	movq	%rsp, %rsi
	xorl	%eax, %eax
	callq	scanf

	cmpl	$1, %eax
	jl	.Lshow_menu_err

	movl	(%rsp), %eax

	addq	$8, %rsp
	retq

.Lshow_menu_err:
	movl	$-1, %eax

	addq	$8, %rsp
	retq

# FILE *__open_file(char *file_name)
__open_file:
	pushq	%rbp

	movq	%rdi, %rbp

	leaq	open_file_mode(%rip), %rsi
	callq	fopen

	# check whether the return value zero or not
	testq	%rax, %rax
	# skip .Lfailed_open if not 0 (the file already exists)
	jnz	.Lskip_create

.Lfailed_open:
	movq	%rbp, %rdi
	leaq	create_file_mode(%rip), %rsi
	callq	fopen
	testq	%rax, %rax
	jnz	.Lskip_create

.Lerror_create:
	leaq	error_create_file(%rip), %rdi
	movq	%rbp, %rsi
	xorl	%eax, %eax
	callq	printf

	xorl	%eax, %eax
	popq	%rbp
	retq

.Lskip_create:
	popq	%rbp
	retq

# FILE *open_file(void);
open_file:
	subq	$8, %rsp

	leaq	file_name(%rip), %rdi
	callq	__open_file

	addq	$8, %rsp
	retq

# int menu_add(void);
menu_add:
	pushq	%rbp
	subq	$256, %rsp

	callq	open_file
	testq	%rax, %rax
	jz	.Lmenu_add_err
	movq	%rax, %rbp

	leaq	label_add_data(%rip), %rdi
	xorl	%eax, %eax
	callq	printf

	movq	%rbp, %rdi
	movl	$0, %esi
	movl	$SEEK_END, %edx
	callq	fseek

	leaq	1(%rsp), %rdi
	movq	$MAX_INPUT_LEN, %rsi
	movq	stdin(%rip), %rdx
	callq	fgets
	testq	%rax, %rax
	jz	.Lmenu_add_err_close

	movq	%rax, %rdi
	callq	strlen
	testq	%rax, %rax
	jz	.Lmenu_add_err_close

	cmpb	$'\n', (%rsp, %rax)
	jne	.Lmenu_add_save

	# cut the new line
	decq	%rax

.Lmenu_add_save:
	movb	%al, (%rsp)

	# preserve 1 byte for len
	incb	%al

	movq	%rsp, %rdi
	movl	$1, %esi
	movl	%eax, %edx
	movq	%rbp, %rcx
	callq	fwrite

	movq	%rbp, %rdi
	callq	fclose

	xorl	%eax, %eax
	addq	$256, %rsp
	popq	%rbp
	retq

.Lmenu_add_err_close:
	movq	%rbp, %rdi
	callq	fclose
.Lmenu_add_err:
	movl	$-1, %eax
	addq	$256, %rsp
	popq	%rbp
	retq

# size_t iterate_db(FILE *handle, struct data *d)
iterate_db:
	pushq	%rbp
	pushq	%rbx
	subq	$8, %rsp

	movq	%rdi, %rbp
	movq	%rsi, %rbx

	movq	%rbx, %rdi
	movl	$1, %esi
	movl	$1, %edx
	movq	%rbp, %rcx
	callq	fread
	testq	%rax, %rax
	jz	.Lexit_iterate_db

	leaq	1(%rbx), %rdi
	movl	$1, %esi
	movzbl	(%rbx), %edx
	movq	%rbp, %rcx
	callq	fread
	testq	%rax, %rax
	jz	.Lexit_iterate_db

	# add null terminator
	movb	$0, 1(%rbx, %rax)

.Lexit_iterate_db:
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq

# int menu_show(void);
menu_show:
	pushq	%rbp
	pushq	%rbx
	subq	$(256 + 8), %rsp

	callq	open_file
	testq	%rax, %rax
	jz	.Lmenu_show_err
	movq	%rax, %rbp

	xorl	%ebx, %ebx
.Lloop_show_data:
	movq	%rbp, %rdi
	movq	%rsp, %rsi
	callq	iterate_db

	testq	%rax, %rax
	jz	.Lmenu_show_close

	incl	%ebx

	leaq	str_fmt_record(%rip), %rdi
	movl	%ebx, %esi
	leaq	1(%rsp), %rdx
	xorl	%eax, %eax
	callq	printf

	jmp	.Lloop_show_data

.Lmenu_show_close:
	callq	getchar

	movq	%rbp, %rdi
	callq	fclose
	movl	%ebx, %eax
	jmp	.Lmenu_show_exit

.Lmenu_show_err:
	movl	$-1, %eax
.Lmenu_show_exit:
	addq	$(256 + 8), %rsp
	popq	%rbx
	popq	%rbp
	retq

# int menu_update(void);
menu_update:
	pushq	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	subq	$(256 + 256 + 8), %rsp

.Lmenu_update_try_again:
	callq	menu_show
	testl	%eax, %eax
	jl	.Lmenu_update_err
	movl	%eax, %r13d

	leaq	label_choose_update(%rip), %rdi
	callq	printf

	leaq	str_fmt_int(%rip), %rdi
	leaq	512(%rsp), %rsi
	xorl	%eax, %eax
	callq	scanf

	cmpl	$1, %eax
	jl	.Lmenu_update_err

	cmpl	$0, 512(%rsp)
	jle	.Lmenu_update_invalid

	cmpl	%r13d, 512(%rsp)
	ja	.Lmenu_update_invalid

	# == 06:36:54

	leaq	label_add_data(%rip), %rdi
	xorl	%eax, %eax
	callq	printf

	leaq	(256 + 1)(%rsp), %rdi
	movq	$MAX_INPUT_LEN, %rsi
	movq	stdin(%rip), %rdx
	callq	fgets
	testq	%rax, %rax
	jz	.Lmenu_update_err

	movq	%rax, %rdi
	callq	strlen
	testq	%rax, %rax
	jz	.Lmenu_update_err

	cmpb	$'\n', 256(%rsp, %rax)
	jne	.Lmenu_update_open_file

	# cut the new line
	decq	%rax

	# ==
.Lmenu_update_open_file:
	movb	%al, 256(%rsp)

	leaq	tmp_file_name(%rip), %rdi
	callq	__open_file
	testq	%rax, %rax
	jz	.Lmenu_update_err
	movq	%rax, %rbx

	callq	open_file
	testq	%rax, %rax
	jz	.Lmenu_update_err_close_tmp
	movq	%rax, %rbp

	# reset the counter
	xorl	%r12d, %r12d
.Lloop_update_data:
	# read from original file
	movq	%rbp, %rdi
	movq	%rsp, %rsi
	callq	iterate_db
	testq	%rax, %rax
	jz	.Lmenu_update_close
	# preserve 1 byte for len
	incl	%eax
	incl	%r12d

	# todo: is it possible with test instead of cmp?
	cmpl	512(%rsp), %r12d
	je	.Linsert_updated_data

	movq	%rsp, %rdi
	movl	%eax, %edx
	jmp	.Lwrite_to_temp_file
.Linsert_updated_data:
	leaq	256(%rsp), %rdi
	movzbl	256(%rsp), %edx
	incl	%edx
.Lwrite_to_temp_file:
	movl	$1, %esi
	movq	%rbx, %rcx
	callq	fwrite
	# testq	%rax, %rax
	# jz	.Lmenu_update_close

	jmp	.Lloop_update_data

.Lmenu_update_invalid:
	leaq	clear(%rip), %rdi
	xorl	%eax, %eax
	callq	printf

	leaq	invalid_opt(%rip), %rdi
	xorl	%eax, %eax
	callq	printf
	callq	getchar
	jmp	.Lmenu_update_try_again

.Lmenu_update_err_close_tmp:
	movq	%rbx, %rdi
	callq	fclose

.Lmenu_update_err:
	movl	$-1, %eax
	jmp	.Lmenu_update_exit

.Lmenu_update_close:
	# on windows, you need to close first, then able to rename and update
	# but we use linux here XD
	leaq	file_name(%rip), %rdi
	callq	remove

	leaq	tmp_file_name(%rip), %rdi
	leaq	file_name(%rip), %rsi
	callq	rename

	movq	%rbp, %rdi
	callq	fclose

	movq	%rbx, %rdi
	callq	fclose

	xorl	%eax, %eax

.Lmenu_update_exit:
	addq	$(256 + 256 + 8), %rsp
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	retq

# int menu_delete(void);
menu_delete:
	pushq	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	subq	$(256 + 8), %rsp

.Lmenu_delete_try_again:
	callq	menu_show
	testl	%eax, %eax
	jl	.Lmenu_delete_err
	movl	%eax, %r13d

	leaq	label_choose_delete(%rip), %rdi
	callq	printf

	leaq	str_fmt_int(%rip), %rdi
	leaq	256(%rsp), %rsi
	xorl	%eax, %eax
	callq	scanf

	cmpl	$1, %eax
	jl	.Lmenu_delete_err

	cmpl	$0, 256(%rsp)
	jle	.Lmenu_delete_invalid

	cmpl	%r13d, 256(%rsp)
	ja	.Lmenu_delete_invalid

	leaq	tmp_file_name(%rip), %rdi
	callq	__open_file
	testq	%rax, %rax
	jz	.Lmenu_delete_err
	movq	%rax, %rbx

	callq	open_file
	testq	%rax, %rax
	jz	.Lmenu_delete_err_close_tmp
	movq	%rax, %rbp

	# reset the counter
	xorl	%r12d, %r12d
.Lloop_delete_data:
	# read from original file
	movq	%rbp, %rdi
	movq	%rsp, %rsi
	callq	iterate_db
	testq	%rax, %rax
	jz	.Lmenu_delete_close
	# preserve 1 byte for len
	incl	%eax
	incl	%r12d

	# todo: is it possible with test instead of cmp?
	cmpl	256(%rsp), %r12d
	je	.Lloop_delete_data

	# write to temporary file
	movq	%rsp, %rdi
	movl	$1, %esi
	movl	%eax, %edx
	movq	%rbx, %rcx
	callq	fwrite
	# testq	%rax, %rax
	# jz	.Lmenu_delete_close

	jmp	.Lloop_delete_data

.Lmenu_delete_invalid:
	leaq	clear(%rip), %rdi
	xorl	%eax, %eax
	callq	printf

	leaq	invalid_opt(%rip), %rdi
	xorl	%eax, %eax
	callq	printf
	callq	getchar
	jmp	.Lmenu_delete_try_again

.Lmenu_delete_err_close_tmp:
	movq	%rbx, %rdi
	callq	fclose

.Lmenu_delete_err:
	movl	$-1, %eax
	jmp	.Lmenu_delete_exit

.Lmenu_delete_close:
	# on windows, you need to close first, then able to rename and delete
	# but we use linux here XD
	leaq	file_name(%rip), %rdi
	callq	remove

	leaq	tmp_file_name(%rip), %rdi
	leaq	file_name(%rip), %rsi
	callq	rename

	movq	%rbp, %rdi
	callq	fclose

	movq	%rbx, %rdi
	callq	fclose

	xorl	%eax, %eax

.Lmenu_delete_exit:
	addq	$(256 + 8), %rsp
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	retq

# int handle_menu(int n);
handle_menu:
	subq	$8, %rsp

	cmpl	$1, %edi
	je	.Lhandle_create
	
	cmpl	$4, %edi
	je	.Lhandle_read
	
	cmpl	$2, %edi
	je	.Lhandle_update
	
	cmpl	$3, %edi
	je	.Lhandle_delete

	cmpl	$5, %edi
	je	.Lexit_loop

	jne	.Linvalid_opt

.Lhandle_create:
	callq	menu_add
	jmp	.Lcontinue_loop
.Lhandle_read:
	callq	menu_show
	jmp	.Lcontinue_loop
.Lhandle_update:
	callq	menu_update
	jmp	.Lcontinue_loop
.Lhandle_delete:
	callq	menu_delete
	jmp	.Lcontinue_loop

.Lexit_loop:
	movl	$-1, %eax
	addq	$8, %rsp
	retq

.Linvalid_opt:
	leaq	invalid_opt(%rip), %rdi
	xorl	%eax, %eax
	callq	printf

	callq	getchar

.Lcontinue_loop:
	addq	$8, %rsp
	retq

main:
	subq	$8, %rsp

.Lloop_program:
	callq	show_menu

	cmpl	$-1, %eax
	je	.Lexit_program

	movl	%eax, %edi
	callq	handle_menu

	cmpl	$-1, %eax
	jne	.Lloop_program

.Lexit_program:
	xorl	%eax, %eax
	addq	$8, %rsp
	retq