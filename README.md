# explore-c

### generating

assembly file from source code: `gcc -S -fverbose-asm -g -O2 index.c`
assembly interlaced with source lines: `gcc -g -O0 -c -fverbose-asm -Wa,-adhln index.c > index.lst`
assembly file from object code: `objdump -S --disassemble index.exe > index.dump`
object file: `gcc -c index.c` (not linked)
executable file: `gcc index.c` (linked)

### dumping preprocessor to terminal

`gcc -E index.c`

### Print internal representation graph

```
gcc -fdump-tree-all-graph -g index.c source.c
dot.exe -Tpng your_generated_file.dot
```

if the generated file invalid, [try to fix the syntax manually](https://stackoverflow.com/questions/67247147/graphviz-doesnt-understand-gcc-output)

and then open/view the file using graphviz software
