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
//
// remove trailing space at the beginning of the command on each line
// cat ~/.bash_eternal_history | sed -e 's/^[[:space:]]*//' > ~/.bash_eternal_history_trimmed

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define UNIX_TIMESTAMP_LEN (1 + 10 + 1)
#define HISTORY_FILE "/home/reyuki/.bash_eternal_history"

int compare_strings(const void *a, const void *b)
{
	const char *str1 = *(char **)a;
	const char *str2 = *(char **)b;
	// char time1[UNIX_TIMESTAMP_LEN+1];
	// char time2[UNIX_TIMESTAMP_LEN+1];

	const int result = strcmp(str1+UNIX_TIMESTAMP_LEN, str2+UNIX_TIMESTAMP_LEN);
	// uncomment these line for sorting based on unix timestamp
	// for (int i = 0; i < UNIX_TIMESTAMP_LEN; i++) {
	//      time1[i] = str1[i];
	//      time2[i] = str2[i];
	// }
	// time1[UNIX_TIMESTAMP_LEN] = '\0';
	// time2[UNIX_TIMESTAMP_LEN] = '\0';
	// const int result = strcmp(time1, time2);
	return result;
}

int main(void)
{
	FILE *file_history = fopen(HISTORY_FILE, "r");
	if (file_history == NULL) {
		printf("cannot open file: %s\n", HISTORY_FILE);
		return 1;
	}

	// Array to store strings pointers (dynamically allocated)
	char **strings = NULL;
	char *str = NULL;
	int num_strings = 0;
	int isinserted = 0;
	size_t len = 0;

	// Read lines from the file and store them in the array
	char line[256];
	while (fgets(line, sizeof(line), file_history)) {
		int current_line = strlen(line);
		len += current_line;

		if (current_line == UNIX_TIMESTAMP_LEN
				&& line[0] == '#'
				&& isdigit(line[1])
				&& isdigit(line[10])
				&& isinserted) {
			isinserted = 0;
			len -= UNIX_TIMESTAMP_LEN;

			// Remove trailing newline (if present)
			if (len > 0 && str[len-1] == '\n')
				str[len-1] = '\0';

			strings = (char **)realloc(strings, ++num_strings * sizeof(char *));
			if (!strings) {
				// Handle realloc error
				perror("realloc");
				exit(1);
			}

			// Add the string pointer to the array
			strings[num_strings - 1] = str;

			str = malloc(UNIX_TIMESTAMP_LEN+1);
			if (!str) {
				perror("malloc");
				exit(1);
			}

			strcpy(str, line);
			len = UNIX_TIMESTAMP_LEN;
			continue;
		} else
			isinserted = 1;

		str = realloc(str, len+1);
		if (!str) {
			perror("realloc");
			exit(1);
		}
		strcat(str, line);
	}

	fclose(file_history);
	
	// Remove exact duplicate
	int deleted;
	do {
		deleted = 0;
		for (int i = 0; i < num_strings-1; i++) {
			for (int j = i; j < num_strings-1;) {
				j++;
				if (!strcmp(strings[i]+12, strings[j]+12)) {
					deleted = 1;
					strings[j] = strings[num_strings-1];
					num_strings--;
				}
			}
		}
	} while(deleted);

	qsort(strings, num_strings, sizeof(char *), compare_strings);

	// Print the sorted strings
	for (int i = 0; i < num_strings; i++)
		printf("%s\n", strings[i]);


	return 0;
}

