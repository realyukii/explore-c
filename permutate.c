#include <stdio.h>
#include <string.h>

void swap(char *ptr1, char* ptr2);
void permute(char *str, int l, int r);

int main(void)
{
	char str[] = "abc";
	int len = strlen(str);

	permute(str, 0, len - 1);
	return 0;
}

void swap(char *ptr1, char *ptr2)
{
	char temp;
	temp = *ptr1;
	*ptr1 = *ptr2;
	*ptr2 = temp;
}

void permute(char *str, int l, int r)
{
	int i;
	if (l == r)
		printf("%s\n", str);
	else
	{
		for (i = l; i <= r; i++)
		{
			swap(str + l, str + i);
			permute(str, l + 1, r);
			swap(str + l, str + i);
		}
	}
}

