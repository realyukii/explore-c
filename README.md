# explore-c

generating assembly file from source code: `gcc -S -fverbose-asm -g -O2 index.c`
generating assembly interlaced with source lines: `gcc -g -O0 -c -fverbose-asm -Wa,-adhln index.c > index.lst`
generating assembly file from object code: `objdump -S --disassemble index.exe > index.dump`
generating object file: `gcc -c index.c` (not linked)
generating executable file: `gcc index.c` (linked)
