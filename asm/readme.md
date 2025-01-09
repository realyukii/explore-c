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

### diff the file at character level

```
[hemlo@zero asm]$  xxd -p hello_extreme | tr -d '\n' > extreme_hexformat_str
[hemlo@zero asm]$  cat extreme_hexformat_str
7f454c46010101000000000000000000020003000100000054800408340000000000000000000000340020000100000000000000010000005400000054800408548004082d0000002d0000000700000000000000b804000000bb01000000b973800408ba0e000000cd80b80100000031dbcd8068656c6c6f20776f726c64210a[hemlo@zero asm]$
[hemlo@zero asm]$   xxd -p hello_wurld_smol | tr -d '\n' > smol_hexformat_str
[hemlo@zero asm]$  cat smol_hexformat_str
7f454c4601010100000000000000000002000300010000004e8004082e0000000000000000000000340020000100010000004e0000004e800408548004082d0000002d0000000700000000000000b804000000bb01000000b96d800408ba0e000000cd80b80100000031dbcd8068656c6c6f20776f726c64210a[hemlo@zero asm]$
[hemlo@zero asm]$  git diff --no-index --word-diff=color --word-diff-regex=. ./smol_hexformat_str ./extreme_hexformat_str
diff --git a/./smol_hexformat_str b/./extreme_hexformat_str
index 87a7d67..bba4a7f 100644
--- a/./smol_hexformat_str
+++ b/./extreme_hexformat_str
@@ -1 +1 @@
7f454c46010101000000000000000000020003000100000054e8004082e3400000000000000000000003400200001000000000000000100000054e00000054e800408548004082d0000002d0000000700000000000000b804000000bb01000000b96d73800408ba0e000000cd80b80100000031dbcd8068656c6c6f20776f726c64210a
```

ref: [stackoverflow](https://stackoverflow.com/questions/1721738/using-diff-or-anything-else-to-get-character-level-diff-between-text-files)
