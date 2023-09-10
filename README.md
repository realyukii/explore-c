# explore-c

### generating

assembly file from source code: `gcc -S -fverbose-asm -g -O2 index.c`
assembly interlaced with source lines: `gcc -g -O0 -c -fverbose-asm -Wa,-adhln index.c > index.lst`
assembly file from object code: `objdump -S --disassemble index.exe > index.dump`
object file: `gcc -c index.c` (not linked)
executable file: `gcc index.c` (linked)

### dumping preprocessor to terminal

gcc -E index.c
