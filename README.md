# explore-c whole process of compilation pipeline

print executable file header: `objdump -f index.exe`
print shared object that dynamicly linked at runtime: `ldd index.exe` (in this case the file extension will be .dll since it's windows)
print symbol table with: `objdump -t index.o`

### generating

assembly file from source code: `gcc -S -fverbose-asm -g -O2 index.c`
assembly interlaced with source lines: `gcc -g -O0 -c -fverbose-asm -Wa,-adhln index.c > index.lst`
assembly file from object code: `objdump -S --disassemble index.exe > index.dump`
object file: `gcc -c index.c` (not an executable & linked) manual link the object file `gcc index.o source.o -o index`
executable file: `gcc index.c` (linked)

### dumping preprocessor to terminal

`gcc -E index.c`

### Compile with dynamic link option

```
gcc -c arithmetic.c util.c
gcc -shared -o libtests.dll arithmetic.o util.o
gcc index.c -L. -ltests
export LD_LIBRARY_PATH=.
```

### Print internal representation graph

```
gcc -fdump-tree-all-graph -g index.c source.c
dot.exe -Tpng your_generated_file.dot
```

if the generated file invalid, [try to fix the syntax manually](https://stackoverflow.com/questions/67247147/graphviz-doesnt-understand-gcc-output). [also see](https://t.me/CCpp_Indonesia/74516)

and then open/view the file using graphviz software

# todo

findout how hook or inject a program works (maybe it has implications with dynamic linker?)

#### [where's C docs?](https://t.me/GNUWeeb/322371)

### Reference

- [Object Code](https://paperbun.org/c-object-files-and-memory-layout-erprd7vfkaao/)
- [A program header table, if present, tells the system how to create a process image](https://docs.oracle.com/cd/E19683-01/817-3677/chapter6-46512/index.html#:~:text=A%20program%20header%20table%2C%20if%20present%2C%20tells%20the%20system%20how%20to%20create%20a%20process%20image)
- [Loading an object file into the process memory](https://noise.getoto.net/2021/03/02/how-to-execute-an-object-file-part-1/#:~:text=Loading%20an%20object%20file%20into%20the%20process%20memory)
