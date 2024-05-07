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
// condition and circumtances:
// the algorithm are relying on newline to separate command,
// and space character

#include <stdio.h>
// remove trailing space at the beginning of the command on each line
// cat ~/.bash_history | sed -e 's/^[[:space:]]*//' > ~/.bash_history_trimmed

#include <stdlib.h>
#include <string.h>
#define HISTORY_FILE "/home/reyuki/.test_untrimmed"

int main(void)
{
	FILE *file_history = fopen(HISTORY_FILE, "r");
	if (file_history == NULL) {
		printf("cannot open file: %s\n", HISTORY_FILE);
		return 1;
	}

	// make sure to adjust the allocated size with the size of file
	char *loaded_buffer = malloc(1024 * 1024);
	char *shift = loaded_buffer;
	while (1) {
		if (fread(shift, 1, 1, file_history) == 0) {
			*shift = '\0';
			break;
		}
		shift++;
	}

	shift = loaded_buffer;
	int line = 1;
	do {
		char pattern[32] = {0};
		char command[32];
		
		// skip the timestamp
		if (*shift == '#')
			shift += 12;

		// ensure the string is on the starting line
		if (*(shift-1) == '\n') {
			line++;
			if (*shift == ' ')
				printf("untrimmed space on line: %d - %c = 0x%x\n", line, *shift, *shift);
			// mark command as pattern
			// *pattern = *shift;
		}
		shift++;
	} while (*shift != '\0');

	// printf("%s\n", loaded_buffer);

	return 0;
}
