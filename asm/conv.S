.section .rodata
ascii_str:
        .string "12345\0"

.global _start
.section .text
_start:
        pushq %rbx
        leaq ascii_str(%rip), %rbx

        subq $8, %rsp
        xorl %eax, %eax
.Lconvert_loop:
        movb (%ebx), %sil
        cmpb $0, %sil
        je .Ldone
        incl %eax
        subb $48, %sil
        movb %sil, (%rsp)
        addq %rax, %rsp
        incl %ebx
        jmp .Lconvert_loop
.Ldone:
        subq %rax, %rsp
        xorl %edi, %edi
	movl $60, %eax
	syscall

        addq $8, %rsp
        popq %rbx
