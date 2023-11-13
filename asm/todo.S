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
	.string "4. List Todo\n"
opt_5:
	.string "5. Exit\n"
divider:
	.string "==========================\n"
labelInput:
	.string "Choose the option: "
labelData:
	.string "Masukin data: "
filename:
	.string "todo_db.bin"
filemode:
	.string "wb+"

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
	movb %al, (%rdi) # store content len to first byte of rsp
	movb $0, (%rdi, %rax)
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
# char *
insert_data:
	leaq labelData(%rip), %rdi
	callq print

	subq $40, %rsp

	# input data
	movq %rsp, %rdi # param 1
	movl $40, %esi # param 2
	callq get_input

	movq %rsp, %rdi # param 1
	movzbq (%rsp), %rsi # param 2
	movl $1, %edx # param 3
	# 40 +24 for callq from the caller
	movq 64(%rsp), %rcx # param 4 - file stream
	callq fwrite

	addq $40, %rsp
	retq
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
handle_menu:
	callq show_menu

	callq choose_menu
	cmpl $49, %eax
	jne .Lexit

	callq insert_data

	xorl %eax, %eax
	retq
.Lexit:
	movl $1, %eax
	retq
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

	movq %rax, (%rsp) # store file stream to stack

	callq loop_menu

	addq $8, %rsp
	xorl %eax, %eax # return 0
	retq
