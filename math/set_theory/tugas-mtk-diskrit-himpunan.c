#include <stdio.h>

/*
 * A program to demonstrate inclusion principle in set theory.
 * note: to change the parameter, you need to manually adjust the condition.
 *
 * */
int main(void)
{
	int start = 1;
	int end = 100;
	int result = 0;
	int range = 0;

	for (int i = start; i <= end; i++)
	{
		range++;
		if (i%5 == 0 || i%3 == 0) {
			printf("i = %d\n", i);
			result++;
		}
	}

	printf("range: %d\n", range);
	printf("the cardinality of set or collection of A where the elements is smth that can be divided either by 5 or 3 in between of %d to %d is %d\n", start, end, result);

	return result;
}
