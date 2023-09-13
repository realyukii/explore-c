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

if the generated file invalid, [try to fix the syntax manually](https://stackoverflow.com/questions/67247147/graphviz-doesnt-understand-gcc-output)

and then open/view the file using graphviz software

# todo

findout how hook or inject a program works (maybe it has implications with dynamic linker?)

#### [where's C docs?](https://t.me/GNUWeeb/322371)
