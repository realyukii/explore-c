// description: sorting and grouping the command from bash history
// scanning the entire file contents
// the stages:
// 1. looking for the newline 
// 2. load the file contents into a variable
// 3. scan the array and perform sorting algorithm
//
// The purpose of program?
// The main goal of the program is to reduce the size of the history file
// by reviewing the sorted history file and manually decide to remove redundant command
// thus make the file more smoll, and overwrite it manually after you've done on reviewing it.

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
	char *loaded_buffer = calloc(1, 1024 * 1024);
	char *shift = loaded_buffer;
	while (1) {
		if (fread(shift, 1, 1, file_history) == 0)
			break;
		shift++;
	}

	int incr = 0;
	shift = loaded_buffer;
	while (*shift != '\0') {
		if (*shift == '#')
			shift += 12;
		if (*shift == '\n') {
		}
		incr++;
		shift++;
	}
	printf("%d\n", incr);
	exit(0);

	char pattern[32] = {0};
	char *next_ptr;
	shift = loaded_buffer;
	do {
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
			// put the next_ptr on the next newline
			while (shift++) {
				if (*shift == '\n') {
					next_ptr = shift+1;
					break;
				}
			}

			// determina swapping or not by:
			// check if the next command are same or not
			// while (*shift != ' ')
		}
		
		shift++;
	} while (*shift != '\0');

	// printf("%s\n", loaded_buffer);

	return 0;
}
