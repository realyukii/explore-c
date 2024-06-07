### Exploring how things work on machine-code / asm level

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

and 128 bytes for extreme version, see [this post](https://reverseengineering.stackexchange.com/questions/32975/reduce-size-of-executable-elf-program/32976#32976) for further info

atleast it's not [120 MB](https://youtu.be/rPVeu4bsn3U?t=630) XD

ditambah, ada sebuah program di [gist](https://gist.github.com/willurd/5720255?permalink_comment_id=4934858#gistcomment-4934858), program web server yang hanya berukuran 228 bytes doang njir :v

executable that violate ELF standard:
```
echo "7f454c4601010100000000000000000002000300010000004e8004082e0000000000000000000000340020000100010000004e0000004e800408548004082d0000002d0000000700000000000000b804000000bb01000000b96d800408ba0e000000cd80b80100000031dbcd8068656c6c6f20776f726c64210a" | xxd -r -p > hello_wurld
```
