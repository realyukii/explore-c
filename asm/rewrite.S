# Masukan nama
# Nama anda ...

.section .rodata
labelName:
	.string "masukkan nama anda "
yourName:
	.string "nama anda "

.global _start
.section .text
strlen:
	xorl %eax, %eax
	cmpb $0, (%rdi)
	je .Lend
.Lloop:
	# is this ok to use 32-bit incl?
	incl %eax
	incq %rdi
	cmpb $0, (%rdi)
	jne .Lloop
.Lend:
	retq

get_input:
	pushq %rdi
	xorl %eax, %eax
	movq %rdi, %rsi
	xorl %edi, %edi
	movl $39, %edx
	syscall
	popq %rdi

	# why movb use (%rdi, %rax) to indexing while leaq use index(pointer)
	movb $0, (%rdi, %rax)

	retq

printf:
	pushq %rdi
	callq strlen

	popq %rsi
	movl %eax, %edx
	movl $1, %edi
	movl $1, %eax
	syscall

	retq

_start:
	xorl %ebp, %ebp
	# in psABI document, is it guaranteed by the user code or operating system?
	# andq $-16, %rsp
	subq $40, %rsp

	leaq labelName(%rip), %rdi
	callq printf

	movq %rsp, %rdi
	callq get_input

	leaq yourName(%rip), %rdi
	callq printf

	movq %rsp, %rdi
	callq printf

	movl $60, %eax
	xorl %edi, %edi
	syscall
