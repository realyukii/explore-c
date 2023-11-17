# Simple CRUD todo list in C Language

## Feature:

- membaca input dari terminal
- membaca, menambahkan, mengupdate, mendelete todo task
- disimpan ke file dalam format binary

## Related Conversation

- [Non-Blocking Illusion](https://t.me/GNUWeeb/836693) :v

## Journey

Apakah offset dapat dikatakan [file position indicator](<https://man7.org/linux/man-pages/man3/fseek.3.html#:~:text=fseek()%20function%20sets%20the-,file%20position%20indicator,-for%20the%0A%20%20%20%20%20%20%20stream%20pointed%20to>) (?)

[The explanation](https://man7.org/linux/man-pages/man2/lseek.2.html) of SEEK_SET, SEEK_CUR, and SEEK_END
Also, here's the constant value described in [this stackoverflow question](https://stackoverflow.com/questions/38226713/fseekf-0-2-how-does-this-work-without-seek-cur-seek-set-or-seek-end)

it turns out that the stdin buffer doesn't come from current stack, see [libc internals](https://stackoverflow.com/questions/31074433/can-i-dump-stdin-with-gdb#:~:text=contain%20pointers%20to%20internal%20buffers%20containing%20buffered%20data) for how the buffer are implemented

- in scanf, is stdin not flushed after user input? or does it only leave the line-feed? no have idea to confirm it

- couldn't find example passing stdin (not file descriptor, but FILE *) as parameter to a function in assembly

- `todo.S:31`, also see https://t.me/AssemblyID/9282

- todo: fix conv.S code, the program goals are to avoid using format specifiers with transform ascii code manually to int