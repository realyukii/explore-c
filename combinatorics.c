#include <errno.h>
#include <stdlib.h>
#include <stdio.h>

#define DIGIT 12

long convert_to_int(char *str)
{
	int base = 0;
	long val;
	char *endptr;

	errno = 0;    /* To distinguish success/failure after call */
	val = strtol(str, &endptr, base);

	/* Check for various possible errors. */

	if (errno == ERANGE) {
		perror("strtol");
		exit(EXIT_FAILURE);
	}

	if (endptr == str) {
		fprintf(stderr, "No digits were found\n");
		exit(EXIT_FAILURE);
	}

	return val;
}

long factorial(int n) {
	long result = 1;
	for (int i = 1; i <= n; i++)
	{
		result *= i;
	}

	return result;
}

int main(void)
{
	puts("Menu:");
	puts("1. Permutation (repeats allowed)");
	puts("2. Permutation (no repeats)");
	puts("3. Combination (repeats allowed)");
	puts("4. Combination (no repeats)");

	for (;;) {
		printf("Choose: ");
		int response = fgetc(stdin);
		if (response == '\n') continue;
		if (response == EOF) break;
		char number[DIGIT] = {0};

		if (response == '1') {
			puts("The formula is freaking simple, number of things ^ choosed number\nCalculate yourself, or use bc instead.");
			break;
		} else if (response == '2') {
			printf("The formula is: n! / (n - r)!\n");
			long sanitized_n, sanitized_r;

			printf("Please enter number for n: ");
			// remove any trailing new line from previous input
			getchar();
			fgets(number, DIGIT, stdin);
			
			sanitized_n = convert_to_int(number);

			// clear the input buffer: https://stackoverflow.com/questions/7898215/how-can-i-clear-an-input-buffer-in-c
			// while ((response = getchar()) != '\n' && response != EOF) { }

			printf("Please enter number for r: ");
			fgets(number, DIGIT, stdin);

			sanitized_r = convert_to_int(number);

			long factorial_n = factorial(sanitized_n);
			long factorial_nr = factorial(sanitized_n - sanitized_r);
			printf("the result is %ld possible permutation exists\n", factorial_n/factorial_nr);
		} else if (response == '4') {
			printf("The formula is: n! / (n - r)! * r!\n");
			long sanitized_n, sanitized_r;

			printf("Please enter number for n: ");
			// remove any trailing new line from previous input
			getchar();
			fgets(number, DIGIT, stdin);
			
			sanitized_n = convert_to_int(number);

			// clear the input buffer: https://stackoverflow.com/questions/7898215/how-can-i-clear-an-input-buffer-in-c
			// while ((response = getchar()) != '\n' && response != EOF) { }

			printf("Please enter number for r: ");
			fgets(number, DIGIT, stdin);

			sanitized_r = convert_to_int(number);

			long factorial_n = factorial(sanitized_n);
			long factorial_nr = factorial(sanitized_n - sanitized_r);
			long factorial_r = factorial(sanitized_r);
			printf("The result is %ld possible combination exists\n", factorial_n/factorial_nr/factorial_r);
		} else if (response == '3') {
			printf("The formula is: (r + n - 1)! / (n - r)! * r!\n");
			long sanitized_n, sanitized_r;

			printf("Please enter number for n: ");
			// remove any trailing new line from previous input
			getchar();
			fgets(number, DIGIT, stdin);
			
			sanitized_n = convert_to_int(number);

			// clear the input buffer: https://stackoverflow.com/questions/7898215/how-can-i-clear-an-input-buffer-in-c
			// while ((response = getchar()) != '\n' && response != EOF) { }

			printf("Please enter number for r: ");
			fgets(number, DIGIT, stdin);

			sanitized_r = convert_to_int(number);

			long factorial_nplusrminus1 = factorial(sanitized_n + sanitized_r - 1);
			long factorial_nminus1 = factorial(sanitized_n - 1);
			long factorial_r = factorial(sanitized_r);
			printf("The result is %ld possible combination exists\n", factorial_nplusrminus1/factorial_nminus1/factorial_r);
		} else {
			printf("Your response %c is invalid\n", response);
			break;
		}
	}

	return 0;
}
