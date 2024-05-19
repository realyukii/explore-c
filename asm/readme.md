### Exploring how things work on machine-code / asm level

### Reference that guide me through this journey

- [guyinatuxedo](https://guyinatuxedo.github.io/01-intro_assembly/reversing_assembly/index.html)
- [fibonacci section](https://www.youtube.com/watch?v=yOyaJXpAYZQ)

### GDB - The GNU Debugger

have several functions and are classified by these category:
- List of classes of commands
  - aliases
  - breakpoints
  - data
    - disassemble `...`
    - set disassembly-flavor `...`
  - files
  - internals - developer GDB-only (?)
  - obscure
    - record `...`
  - misc
  - running - doable commands once the program is running inside GDB
    - reverse-stepi - Target multi-thread does not support this command. See [the stackoverflow](https://stackoverflow.com/questions/7517236/how-do-i-enable-reverse-debugging-on-a-multi-threaded-program)
  - stack
  - status
    - info register
  - support
  - text-user-interface - doable commands once the TUI mode was enabled (?)
  - tracepoints
  - user-defined
  - Unclassified

### Paradigm

I think it's functional programming

### Stack
In order to understand stack, first we need to understand thread. So here's the thing:
> Something to execute the executable program

What do we mean by "Something"? of course _*the operating system*_ execute the program for us; but specifically, in what way did it do that? the answer is *thread*.
A thread is conceptually just an instance of execution in a program

- [reference](https://www.bytelab.codes/what-is-memory-part-3-registers-stacks-and-threads/)

#### Ricing TUI GDB kayaknya menarik, biar style syntaxnya lebih colorful :v

[keyword](https://www.google.com/search?q=gdb+styling+configuration&sca_esv=579403293&source=hp&ei=rwRGZbfVE4zm4-EPo9-QqAM&iflsig=AO6bgOgAAAAAZUYSv5TlraUGu0gPhNKsn45n2r_cP1Vl&ved=0ahUKEwj36PCn-qmCAxUM8zgGHaMvBDUQ4dUDCAo&uact=5&oq=gdb+styling+configuration&gs_lp=Egdnd3Mtd2l6IhlnZGIgc3R5bGluZyBjb25maWd1cmF0aW9uMgUQIRigAUjtJ1AAWIIncAF4AJABAJgBeKAB_A6qAQQyMi40uAEDyAEA-AEBwgILEAAYgAQYsQMYgwHCAhEQLhiABBixAxiDARjHARjRA8ICCxAuGIoFGLEDGIMBwgIIEAAYgAQYsQPCAgsQLhiDARixAxiABMICBRAAGIAEwgILEC4YgAQYxwEY0QPCAgYQABgWGB7CAgkQABgNGBMYgATCAggQABgeGA0YE8ICCBAAGBYYHhgPwgIIEAAYCBgeGA3CAggQABgeGA0YD8ICBxAhGKABGAo&sclient=gws-wiz#vhid=AJ22b6VQOQIroM&vssid=l)

done automatically by [gef](https://github.com/hugsy/gef) :v

### Todo app in asm

Used libc: just see the .extern section in the `todo.S` file

### lightweight hello world program
this program designed to be lightweight as smol as possible, by stripping all symbol, minimum elf header and no main section

how to compile:
```
as hello_64.S -o hemlo.o
ld --strip-all --omagic hemlo.o -o hemlo
strip --remove-section=.note.gnu.property hemlo
```

for compiling 32-bit version: just add `--32` to `as` and `-melf_i386` to `ld` command.

the size of hello world program is 624 Bytes (optimized) and 332 Bytes for 32-bit version.

atleast it's not [120 MB](https://youtu.be/rPVeu4bsn3U?t=630) XD

tapi ada program di sebuah [gist](https://gist.github.com/willurd/5720255?permalink_comment_id=4934858#gistcomment-4934858), program web server yang hanya berukuran 228 bytes doang njir :v
