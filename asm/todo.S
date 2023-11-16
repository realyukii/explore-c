.section .rodata
clear:
	.string "\033c"
header:
	.string "====== Todo Program ======\n"
opt_1:
	.string "1. Add\n"
opt_2:
	.string "2. Update\n"
opt_3:
	.string "3. Delete\n"
opt_4:
	.string "4. List\n"
opt_5:
	.string "5. Exit\n"
divider:
	.string "==========================\n"
labelInput:
	.string "Choose the option: "
holdKey:
	.string "Press Enter to continue..."
dataFormat:
	.string "%d\. %s\n"
invalidOpt:
	.string "Invalid option\n"
labelData:
	.string "Masukin data: "
filename:
	.string "todo_db.bin"
filemode:
	.string "wb+"

.global main
.extern getchar
.extern rewind
.extern fread
.extern fseek
#todo .extern fclose
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
# char *data, int len
get_input:
	decl %esi # preserve null byte
	pushq %rdi
	xorl %eax, %eax # syscall number
	movl %esi, %edx # param 3
	# preserve one byte for content len
	leaq 1(%rdi), %rsi # param 2
	xorl %edi, %edi # param 1
	syscall
	popq %rdi
	movb $0, (%rdi, %rax) # replace \n with null
	movb %al, (%rdi) # store content len to first byte of rsp
	incb %al # add space for the content len in the db record
	retq
# void
choose_menu:
	subq $8, %rsp

	movq $0, (%rsp)

	xorl %eax, %eax # syscall number
	movl $8, %edx # param 3
	movq %rsp, %rsi # param 2
	xorl %edi, %edi # param 1
	syscall

	movzbq (%rsp), %rax

	addq $8, %rsp
	retq
# void
update_data:
	subq $8, %rsp
	callq list_data

	movq %rsp, %rdi
	movl $1, %esi
	callq get_input

	addq $8, %rsp
	retq
# void
insert_data:
	leaq labelData(%rip), %rdi
	callq print

	subq $40, %rsp

	# input data
	movq %rsp, %rdi # param 1
	movl $40, %esi # param 2
	callq get_input

	movq %rsp, %rdi # param 1
	movl %eax, %esi # param 2
	movl $1, %edx # param 3
	# 40 +24 for callq from the caller
	movq 64(%rsp), %rcx # param 4 - file stream handle
	callq fwrite

	addq $40, %rsp
	retq
# void
show_menu:
	leaq clear(%rip), %rdi
	callq print

	leaq header(%rip), %rdi
	callq print

	leaq opt_1(%rip), %rdi
	callq print

	leaq opt_2(%rip), %rdi
	callq print

	leaq opt_3(%rip), %rdi
	callq print

	leaq opt_4(%rip), %rdi
	callq print

	leaq opt_5(%rip), %rdi
	callq print

	leaq divider(%rip), %rdi
	callq print

	leaq labelInput(%rip), %rdi
	callq print

	retq
# void
list_data:
	pushq %rbx
	subq $48, %rsp # Because printf uses SIMD instructions, we must ensure that it is aligned correctly to prevent a segfault (?)

	xorl %ebx, %ebx

	# 56 +24 for callq from the caller
	movq 80(%rsp), %rdi # param 1 - file stream handle
	callq rewind

	leaq divider(%rip), %rdi
	callq print

.Lloop_list_data:
	incl %ebx

	movq %rsp, %rdi # param 1
	movl $1, %esi # param 2
	movl $1, %edx # param 3
	# 56 +24 for callq from the caller
	movq 80(%rsp), %rcx # param 4
	callq fread
	cmpb $0, %al
	je .Lexit_list_data

	movzbl (%rsp), %esi # param 2
	movq %rsp, %rdi # param 1
	movl $1, %edx # param 3
	# 56 +24 for callq from the caller
	movq 80(%rsp), %rcx # param 4
	callq fread

	pushq %rax # the terminator loop
	subq $8, %rsp # make it aligned, balancing with pushq %rax

	leaq dataFormat(%rip), %rdi # param 1
	movl %ebx, %esi # param 2
	leaq 16(%rsp), %rdx # param 3
	callq printf

	addq $8, %rsp
	popq %rax
	cmpb $0, %al
	jne .Lloop_list_data

	leaq divider(%rip), %rdi
	callq print
	
.Lexit_list_data:
	leaq holdKey(%rip), %rdi
	callq print
	callq getchar

	addq $48, %rsp
	popq %rbx
	retq
# void
handle_menu:
	callq show_menu

	callq choose_menu
	cmpl $49, %eax # opt 1
	je .Lhandle_add
	cmpl $50, %eax # opt 2
	je .Lhandle_update
	cmpl $51, %eax # opt 3
	je .Lexit # For now, simply exit because it has not yet been implemented.
	cmpl $52, %eax # opt 4
	je .Lhandle_show
	cmpl $53, %eax # opt 5
	je .Lexit
	jne .Linvalid_opt

.Lhandle_add:
	callq insert_data

	jmp .Lcontinue
.Lhandle_show:
	callq list_data

	jmp .Lcontinue
.Lhandle_update:
	callq update_data

	jmp .Lcontinue
.Lcontinue:
	xorl %eax, %eax # return 0
	jmp .Lend_handle_menu
.Linvalid_opt:
	leaq invalidOpt(%rip), %rdi
	callq print
.Lexit:
	movl $1, %eax # return 1
.Lend_handle_menu:
	retq
# void
loop_menu:
.Lloop_menu:
	callq handle_menu
	cmpb $0, %al # is it becoming more efficient?
	je .Lloop_menu
.Lend_menu:
	retq
main:
	subq $8, %rsp

	leaq filename(%rip), %rdi # param 1
	leaq filemode(%rip), %rsi # param 2
	callq fopen

	movq %rax, (%rsp) # store file stream handle to stack

	callq loop_menu

	addq $8, %rsp
	xorl %eax, %eax # return 0
	retq
