# explore whole process of compilation pipeline

- print executable file header: `objdump -f index.exe`
- print shared object that dynamicly linked at runtime: `ldd index.exe` (in this case the file extension will be .dll since it's windows)
- print symbol table with: `objdump -t index.o`

### transforming

- assembly file from source code: `gcc -S -fverbose-asm -g -O2 index.c`
- assembly interlaced with source lines: `gcc -g -O0 -c -fverbose-asm -Wa,-adhln index.c > index.lst`
- assembly file from object code: `objdump -S --disassemble index.exe > index.dump`
- object file: `gcc -c index.c` (not an executable & linked) manual link the object file `gcc index.o source.o -o index`
- executable file: `gcc index.c` (linked)

### dumping preprocessor to terminal

`gcc -E index.c`

### Compile with dynamic link option

```bash
gcc -c arithmetic.c util.c
gcc -shared -o libtests.dll arithmetic.o util.o
gcc index.c -L. -ltests
export LD_LIBRARY_PATH=.
```

### Print internal representation graph

```bash
gcc -fdump-tree-all-graph -g index.c source.c
dot.exe -Tpng your_generated_file.dot
```

if the generated file invalid, [try to fix the syntax manually](https://stackoverflow.com/questions/67247147/graphviz-doesnt-understand-gcc-output). [also see](https://t.me/CCpp_Indonesia/74516)

and then open/view the file using graphviz software

### Simple object file Loader program

```bash
# generate object file
gcc -c arithmetic.c
# on unix system
gcc -o unix_loader unix_loader.c
./unix_loader
# on windows system (not yet done)
gcc -o win_loader windows_loader.c
./win_loader
```

to disable lint error caused by `MAP_ANON` enum, try to enable [this macro](https://ftp.gnu.org/old-gnu/Manuals/glibc-2.2.3/html_node/libc_13.html#:~:text=should%20be%20defined.-,Macro%3A%20_GNU_SOURCE,-If%20you%20define) | [see more](https://unix.stackexchange.com/questions/498176/how-does-use-misc-referenced-in-glibc-work)

### Things that are covered in the practice of making a simple loader

doing this process manually instead of generate shared object makes you understand what the operating system linker and loader do

Here's my question related to this topic:

- [Why does Android APK need to be aligned on a 4-byte?](https://www.quora.com/Why-does-Android-APK-need-to-be-aligned-on-a-4-byte)
- [What is offset in code units? I found the terms in a smali-related discussion.](https://www.quora.com/What-is-offset-in-code-units-I-found-the-terms-in-a-smali-related-discussion)
- [structure object file](https://t.me/idcplc/243299/246739)
- [How to inspect sections on object code](https://github.com/hasherezade/pe-bear/issues/34)

# Todo

findout how hook or inject a program works, maybe it has implications with [runtime linking](https://noise.getoto.net/2021/03/02/how-to-execute-an-object-file-part-1/#:~:text=process%20is%20called-,runtime%20linking,-%3A%20when%20our%20executable) and some [injection techniques](https://twitter.com/C5pider/status/1555256782590775298#:~:text=Injection%20Techniques)?

### Reference

- [Object files](https://paperbun.org/c-object-files-and-memory-layout-erprd7vfkaao/)
- [A program header table, if present, tells the system how to create a process image](https://docs.oracle.com/cd/E19683-01/817-3677/chapter6-46512/index.html#:~:text=A%20program%20header%20table%2C%20if%20present%2C%20tells%20the%20system%20how%20to%20create%20a%20process%20image)
- [Loading an object file into the process memory](https://noise.getoto.net/2021/03/02/how-to-execute-an-object-file-part-1/#:~:text=Loading%20an%20object%20file%20into%20the%20process%20memory)
- [A brief introduction on memory stuff](https://www.youtube.com/watch?v=p9yZNLeOj4s&ab_channel=ComputerScience)
- [Windown | Introduction to Portable Executable Format](https://0xrick.github.io/categories/#win-internals)

#### [where's C docs?](https://t.me/GNUWeeb/322371) just a meme :v
