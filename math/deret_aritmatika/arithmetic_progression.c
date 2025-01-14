#include <stdio.h>

/** 
 * calculator program
 *
 * Deret aritmatika
 * Arithmetic progression
 *
 * */
int main(void)
{
	// selisih per-baris atau b
	int common_difference;
	printf("common difference: ");
	fflush(stdout);
	scanf("%d", &common_difference);


	// progression
	int total_baris;
	printf("sum of sequence/progression: ");
	fflush(stdout);
	scanf("%d", &total_baris);

	// U1 atau a.
	int kursi_depan;
	printf("first terms: ");
	fflush(stdout);
	scanf("%d", &kursi_depan);
	
	// persoalannya... berapa jumlah atau total kursi yang ada di gedung tersebut?
	// Sn = n/2(a+Un)
	
	// jumlah keseluruhan kursi yang ada pada gedung tersebut
	for (;total_baris<52;total_baris++) {
		int hasil = total_baris * (2*kursi_depan + (total_baris-1)*common_difference)/2;
		if (hasil == 0) {
			printf("sum of sequence/progression: %d\n", total_baris);
			printf("Jumlah keseluruhan suku: %d\n", hasil);
		}
	}
	

	return 0;
}

