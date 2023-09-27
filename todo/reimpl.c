#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static char storage[] = "todo_data.bin";
static char tmp_storage[] = "todo_data_tmp.bin";

struct todo {
  char data[255];
};

static int menu(void)
{
  int choice;
  system("CLS");
  printf("====== Todo Program ======\n");
  printf("1. Add\n");
  printf("2. Update\n");
  printf("3. Delete\n");
  printf("4. List Todo\n");
  printf("5. Exit\n");
  printf("==========================\n");
  printf("Choose the option: ");

  int ret = scanf("%d", &choice);
  getchar();

  if (ret != 1) {
    choice = -1;
  }

  return choice;
}
static unsigned show_information(FILE *hdr)
{
  struct todo content;
  unsigned incr = 0;
  
  rewind(hdr);
  printf("==========================\n");
  while (1)
  {
    if (!fread(&content, sizeof(content), 1, hdr)) {
      break;
    }
    printf("%u. %s\n", ++incr, content.data);
  }
  printf("==========================\n");

  return incr;
};
static int handle_add(FILE *hdr)
{
  struct todo content;
  memset(&content, 0, sizeof(content));

  printf("Enter new name: ");
  if (!fgets(content.data, sizeof(content.data), stdin)) {
    return -1;
  };
  fseek(hdr, 0, SEEK_END);
  fwrite(&content, sizeof(content), 1, hdr);
  return 0;
};
static int handle_update(FILE *hdr)
{
  struct todo content;
  unsigned choice, n;
  n = show_information(hdr);

  printf("Choose item: ");
  if (scanf("%d", &choice) != 1 || choice <= 0 || choice > n) {
    printf("Invalid input!\n");
    return -1;
  }
  getchar();

  printf("Enter updated name: ");
  fgets(content.data, sizeof(content.data), stdin);

  fseek(hdr, (choice - 1) * sizeof(content), SEEK_SET);
  fwrite(&content, sizeof(content), 1, hdr);
  return 0;
};
static int handle_delete(FILE *hdr)
{
  unsigned choice, n;
  n = show_information(hdr);
  
  printf("Choose deleted item: ");
  if (scanf("%d", &choice) != 1 || choice <= 0 || choice > n) {
    printf("Invalid input!\n");
    return -1;
  }

  rewind(hdr);
  FILE *tmp_hdr = fopen(tmp_storage, "wb");
  for (unsigned i = 0; i < n; i++)
  {
    struct todo content;
    fread(&content, sizeof(content), 1, hdr);
    if ((choice - 1) == i) {
      continue;
    }
    fwrite(&content, sizeof(content), 1, tmp_hdr);
  }

  fclose(tmp_hdr);
  fclose(hdr);
  remove(storage);
  rename(tmp_storage, storage);
  
  return 0;
};
static int handle_list(FILE *hdr)
{
  show_information(hdr);
  printf("Press Enter to continue...");
  getchar();

  return 0;
};
static int handle_menu(int option, FILE *hdr)
{
  switch (option)
  {
  case 1:
    return handle_add(hdr);
  case 2:
    return handle_update(hdr);
  case 3:
    return handle_delete(hdr);
  case 4:
    return handle_list(hdr);
  case 5:
    return -1;
  
  default:
  printf("Invalid Option: %d\n", option);
    break;
  }

  return 0;
};

int main(void)
{
  int ret, n;
  FILE *hdr;

  do {
    hdr = fopen(storage, "rb+");
    if (!hdr) {
      hdr = fopen(storage, "wb");
    }

    n = menu();
    ret = handle_menu(n, hdr);
    if (ret != 0) break;
    if (ret != 3) fclose(hdr);
  } while (n != -1);
  
  return 0;
}