.section .rodata
string:
	.string "hello"
ending:
	.string "he"

.extern strlen
.extern strcmp
.global main
.section .text
# bool solution(char *string, char *ending)
solution:
	pushq	%rbp
	pushq	%rbx
	movq	%rsp, %rbp
	subq	$24, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)

	# rdi already filled with string variable
	callq	strlen
	movl	%eax, %ebx

	movq	-16(%rbp), %rdi
	callq	strlen

	# int len
	subl	%eax, %ebx
	
	cmpl	$0, %ebx
	js	.Linvalid

	addq	-8(%rbp), %rbx
	movq	%rbx, %rdi
	movq	-16(%rbp), %rsi
	callq	strcmp
	jmp	.Lexit
.Linvalid:
	movl	$1, %eax

.Lexit:
	addq	$24, %rsp
	popq	%rbx
	popq	%rbp
	retq

# int main(void)		
main:
	subq	$8, %rsp
	leaq	string(%rip), %rdi
	leaq	ending(%rip), %rsi
	callq	solution
	int3

	movl	$60, %eax
	xorl	%edi, %edi
	syscall
	addq	$8, %rsp
	retq

