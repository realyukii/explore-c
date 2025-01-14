#include <stdio.h>

int main(void)
{
	// the beginning of progression
	int a;
	printf("Masukkan suku pertama: ");
	fflush(stdout);
	scanf("%d", &a);
	// the diff
	int b;
	printf("Masukkan nilai beda: ");
	fflush(stdout);
	scanf("%d", &b);

	// the n-th of progression
	int nth;
	printf("Masukkan deret ke berapa yang ingin dicari: ");
	fflush(stdout);
	scanf("%d", &nth);

	// TODO: figure out the value in the n-th of progression
	// the formula: a + n-1 * b
	
	printf("nilai pada suku ke-%d: %d\n", nth, a + (nth-1)*b);

	return 0;
}
