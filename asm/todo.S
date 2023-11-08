.section .rodata
filename:
        .string "todo_db.bin"
filemode:
        .string "wb+"

.global main
.extern fopen
.section .text
main:
        subq $8, %rsp

        leaq filename(%rip), %rdi
        leaq filemode(%rip), %rsi
        callq fopen

        addq $8, %rsp
        xorl %eax, %eax
        retq
