.section .rodata
filename:
        .string "todo_db.bin"
filemode:
        .string "wb+"

.global _start
.extern fopen
.section .text
_start:
        subq $8, %rsp

        leaq filename(%rip), %rdi
        leaq filemode(%rip), %rsi
        callq fopen

        addq $8, %rsp
        retq
