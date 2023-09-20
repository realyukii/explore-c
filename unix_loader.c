#define _DEFAULT_SOURCE
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <elf.h>
#include <errno.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

typedef union {
  const Elf64_Ehdr *hdr;
  const uint8_t *base;
} objhdr;

static objhdr obj;
static const Elf64_Shdr *sections;
static const char *shstrtab = NULL;
static const Elf64_Sym *symbols;
static int num_symbols;
static const char *strtab = NULL;
static uint64_t page_size;
static uint8_t *text_runtime_base;

static inline uint64_t page_align(uint64_t n) {
  return (n + (page_size - 1)) & ~(page_size - 1);
}

static const Elf64_Shdr *lookup_section(const char *name) {
  size_t name_len = strlen(name);
  
  for (Elf64_Half i = 0; i < obj.hdr->e_shnum; i++)
  {
    const char *section_name = shstrtab + sections[i].sh_name;
    size_t section_name_len = strlen(section_name);

    if (name_len == section_name_len && !strcmp(name, section_name))
    {
      if (sections[i].sh_size)
      {
        return sections + i;
      }      
    }   
  }

  return NULL;
}

static void load_obj(void) {
  struct stat sb;

  int fd = open("arithmetic.o", O_RDONLY);
  if (fd <= 0) {
    perror("cannot open arithmetic.o");
    exit(errno);
  }

  if (fstat(fd, &sb))
  {
    perror("failed to get arithmetic.o info");
    exit(errno);
  }
  
  obj.base = mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
  if (obj.base == MAP_FAILED) {
    perror("maping arithmetic.o failed");
    exit(errno);
  }

  close(fd);
};

static void parse_obj(void) {
  page_size = sysconf(_SC_PAGE_SIZE);
  sections = (const Elf64_Shdr *)(obj.base + obj.hdr->e_shoff);
  shstrtab = (const char *)(obj.base + sections[obj.hdr->e_shstrndx].sh_offset);

  const Elf64_Shdr *symtab_hdr = lookup_section(".symtab");
  if (!symtab_hdr) {
    fputs("Failed to find .symtab\n", stderr);
    exit(ENOEXEC);
  }

  symbols = (const Elf64_Sym *)(obj.base + symtab_hdr->sh_offset);
  num_symbols = symtab_hdr->sh_size / symtab_hdr->sh_entsize;

  const Elf64_Shdr *strtab_hdr = lookup_section(".strtab");
  if (!strtab_hdr)
  {
    fputs("Failed to find .strtab\n", stderr);
    exit(ENOEXEC);
  }

  strtab = (const char *)(obj.base + strtab_hdr->sh_offset);
  const Elf64_Shdr *text_hdr = lookup_section(".text");
  if (!text_hdr) {
    fputs("Failed to find .text\n", stderr);
    exit(ENOEXEC);
  }

  text_runtime_base = mmap(NULL, page_align(text_hdr->sh_size), PROT_READ | PROT_WRITE,  MAP_PRIVATE | MAP_ANON, -1, 0);
  if (text_runtime_base == MAP_FAILED) {
    perror("Failed to allocate memory for .text");
    exit(errno);
  }

  memcpy(text_runtime_base, obj.base + text_hdr->sh_offset, text_hdr->sh_size);
  if (mprotect(text_runtime_base, page_align(text_hdr->sh_size), PROT_READ | PROT_EXEC)) {
    perror("Failed to make .text executable");
    exit(errno);
  }
}

static void *lookup_function(const char *name) {
  size_t name_len = strlen(name);

  for (size_t i = 0; i < num_symbols; i++)
  {
    if (ELF64_ST_TYPE(symbols[i].st_info) == STT_FUNC) {
      const char *function_name = strtab + symbols[i].st_name;
      size_t function_name_len = strlen(function_name);
      
      if (name_len == function_name_len && !strcmp(name, function_name)) {
        return text_runtime_base + symbols[i].st_value;
      }
    }
  }

  return NULL;
}

static void execute_func(void) {
  int (*sum)(int, int);

  sum = lookup_function("sum");
  if (!sum) {
    fputs("Failed to find sum function\n", stderr);
    exit(ENOENT);
  }

  puts("executing sum...");
  printf("sum(%d + %d) = %d\n", 5, 7, sum(5, 7));
}

int main(void)
{
    load_obj();
    parse_obj();
    execute_func();

    return 0;
}