// description: sorting and grouping the command from bash history
// scanning the entire file contents
// the stages:
// 1. looking for the newline 
// 2. load the file contents into variable that contains array of characters a.k.a string.
// 3. scan the array and perform sorting algorithm
//
// How it works?
// The main goal of the program is to reduce the size of the history file
// by reviewing the sorted history file and manually decide to remove redundant command
// thus make the file more smoll, and overwrite it manually after you've done on reviewing it.
//
// condition and circumtances:
// the algorithm are relying on newline to separate command,
// and space character

// remove trailing space at the beginning of the command on each line
// cat ~/.bash_history | sed -e 's/^[[:space:]]*//' > ~/.bash_history_trimmed

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define HISTORY_FILE "/home/reyuki/.bash_eternal_history_trimmed"

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
	do {
		char pattern[32] = {0};
		char command[32];
		
		// skip the timestamp
		if (*shift == '#')
			shift += 12;

		// ensure the command is on the beginning line
		if (*(shift-1) == '\n') {
			// mark command as pattern, renew pattern each time (...)
			int i = 0;
			while (*shift != ' ')
				pattern[i++] = *(shift++);
			pattern[i] = '\0';
			printf("%s\n", pattern);
		}
		shift++;
	} while (*shift != '\0');

	// printf("%s\n", loaded_buffer);

	return 0;
}
