#include <stdio.h>
#include <string.h>
#include <stdlib.h>

static const char store_file[] = "./todo_data.bin";
static const char store_file_tmp[] = "./todo_data.bin.tmp";

typedef struct {
	char data[255];
} todo;

static int menu(void)
{
	int ret, n;

	system("cls");
	printf("---- Welcome to the TODO List program ----\n");
	printf("1. Add\n");
	printf("2. Update\n");
	printf("3. Delete\n");
	printf("4. Show\n");
	printf("5. Exit\n");
	printf("======================================\n");
	printf("Enter the option: ");

	ret = scanf("%d", &n);
	getchar();
	if (ret != 1) {
		return -1;
	}

	return n;
}

static int handle_add(FILE *h)
{
	// ukuran akan sesuai tipe data
	todo z;
	// ukuran pointer: 8 byte in x64
	// uninitialize pointer will cause segfault
	// reference of reference (&) vs dereference (* or ->)
	todo *d; // is that pointless if I use struct pointer instead? Dunno why trying struct pointer cause segfault XD
	memset(&d, 0, sizeof(d)); // If "struct d" is not zeroed with memset, why will the size be 257?

	printf("Enter the todo list: ");
	if (!fgets(d->data, sizeof(d->data), stdin)) {
		return -1;
	}

	fseek(h, 0, SEEK_END);

	fwrite(d, sizeof(d), 1, h);
	return 0;
}

static unsigned show_todo_list(FILE *h)
{
	// terjawab di komen atas tentang pointer
	todo d; // why if this struct is a struct pointer, I got 0xc0000374 status exit from strace which indicate STATUS_HEAP_CORRUPTION?
	size_t ret;
	unsigned i;

	// i = 0;
	// rewind(h);
	// struct {
	// 	char data[510];
	// } test;
	// while (1) {
	// 	ret = fread(&test, 255, 2, h); // why is the first item being read? the count-block is 2 so I expect it will start from second item
	// 	// and I thought that an uneven number of todo's would cause a segfault since it's not divisible by 2
	// 	// hmm sepertinya saia miskonsepsi :"
	// 	if (ret == 0) {
	// 		break;
	// 	}
	// 	printf("  %u. %s\n", ++i, test.data);
	// }

	rewind(h); 
	printf("========================================\n");
	printf("TODO List:\n");
	i = 0;
	while (1) {
		ret = fread(&d, sizeof(d), 1, h);
		if (ret == 0) {
			break;
		}
		printf("  %u. %s\n", ++i, d.data);
	}
	printf("========================================\n");
	return i;
}

static int handle_show(FILE *h)
{
	show_todo_list(h);
	printf("Press enter to continue!");
	getchar();
	return 0;
}

static int handle_update(FILE *h)
{
	unsigned n, choice;
	todo updated;
	int ret;

	n = show_todo_list(h);
	printf("Which list do you want to update? Enter the num: ");
	ret = scanf("%u", &choice);
	getchar();
	if (ret != 1) {
		return -1;
	}

	if (choice == 0 || choice > n) {
		printf("Invalid number!\n");
		return 0;
	}

	// important part to avoid file corrupt: setting the proper offsite
	fseek(h, (choice - 1) * sizeof(updated), SEEK_SET);
	printf("Enter updated data: ");
	if (!fgets(updated.data, sizeof(updated.data), stdin)) {
		return -1;
	}
	// printf("offset = %ld\n", ftell(h));
	fwrite(&updated.data, sizeof(updated.data), 1, h);
	return 0;
}

static int handle_delete(FILE *h)
{
	unsigned n, i, choice;
	FILE *th;
	int ret;

	n = show_todo_list(h);
	printf("Which list do you want to delete? Enter the num: ");
	ret = scanf("%u", &choice);
	getchar();
	if (ret != 1) {
		return -1;
	}

	if (choice == 0 || choice > n) {
		printf("Invalid number!\n");
		return 0;
	}

	// b flag is important in order to avoid mis interpretation, see https://learn.microsoft.com/en-us/cpp/c-runtime-library/reference/fopen-wfopen?view=msvc-170#:~:text=Open%20in%20binary%20(untranslated)%20mode
	th = fopen(store_file_tmp, "wb");
	if (!th) {
		perror("Failed to open the store_file_tmp");
		return -1;
	}

	// equal to fseek, set offset to zero
	rewind(h);
	for (i = 1; i <= n; i++) {
		todo d;

		fread(&d, sizeof(d), 1, h);
		if (i == choice) {
			continue;
		}
		fwrite(&d, sizeof(d), 1, th);
	}
	fclose(th);
	fclose(h);
	remove(store_file);
	rename(store_file_tmp, store_file);
	
	return 0;
}

static int handle_input_menu(int n, FILE *h)
{
	switch (n) {
	case 1:
		return handle_add(h);
	case 2:
		return handle_update(h);
	case 3:
		return handle_delete(h);
	case 4:
		return handle_show(h);
	case 5:
		/* For exit. */
		return 1;
	default:
		printf("Invalid menu %d\n", n);
		break;
	}

	return 0;
}

int main(void)
{
	int ret, n;
	FILE *h;

	do {
		h = fopen(store_file, "rb+");
		if (!h) {
			h = fopen(store_file, "w");
		}

		n = menu();
		ret = handle_input_menu(n, h);
		if (ret != 0) {
			break;
		}

		if (n != 3) fclose(h);

		// if (n == 3) {
			// todo: findout way to set errno inside delete handler and detect in this scope if possible
			// remove(store_file);
			// rename(store_file_tmp, store_file);
		// }
	} while (n != -1);
	return 0;
}