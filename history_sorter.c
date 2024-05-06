// description: sorting and grouping the command from bash history
// scanning the entire file contents
// the stages:
// 1. looking for the newline 
// 2. store the result to the data structure, array of offset/pointer to the stream
// 3. and since we already know or track each buffer on each line, then
// 4. we can trim spaces in the beginning of each line  and
// 5. pairing all match command on each time scanning, sorting & re-group the entire file contents
// 6. so we make sure no paired-command left and thus ready to looking for other command to be sorted
//
// How it works?
// The main goal of the program is to reduce the size of the history file
// by reviewing the sorted history file and manually decide to remove redundant command
// thus make the file more smoll, and overwrite it manually after you've done on reviewing it.
//
// TODO:
// 1. cara memanipulasi array
// 2. sifat pointer ketika array digunakan
//
// condition and circumtances:
// the algorithm are relying on newline to separate command,
// and space character

#include <stdio.h>
#include <stdlib.h>
#define HISTORY_FILE "/home/reyuki/.bash_eternal_history"

int main(void)
{
	FILE *file_history = fopen(HISTORY_FILE, "r");
	if (file_history == NULL) {
		printf("cannot open file: %s\n", HISTORY_FILE);
		return 1;
	}


	char *loaded_buffer = malloc(1024 * 1024);
	char *shift = loaded_buffer;
	while (1) {
		if (fread(shift, 1, 1, file_history) == 0) {
			*shift = '\0';
			break;
		}
		shift++;
	}
	printf("%s\n", loaded_buffer);

	return 0;
}
