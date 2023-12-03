#include <string.h>
#include <stdio.h>

/*
* TIL, the args just *point* to the caller's variable
* jadi ketika anda memodifikasi argument seperti yang
* dicontohkan dalam entri fungsi ini, itu hanya memainkan
* *pointer* nya saja, argument/parameter pada edit_line
* tetap menjadi bagian dari stack frame dari fungsi edit_line
*/ 
void edit_line(char *buf, int current_line)
{
	for (size_t i = 0; i < current_line; i++) {
		buf = strchr(buf, '\n') + 1;
	}

	char *line_end = strchr(buf, '\n');
	char saved[1024] = {0};

	strcpy(saved, line_end);
	scanf("%s", buf);
	strcpy(buf + strlen(buf), saved);
}

int main(int argc, char **argv)
{
	FILE *f = fopen(argv[1], "r");
	char buf[1024] = {0};
	int current_line;

	fread(buf, 1024, 1, f);
	fclose(f);

	printf("Contents:\n%s\n", buf);

	scanf("%d", &current_line);
	edit_line(buf, current_line);

	f = fopen(argv[1], "w");
	fwrite(buf, strlen(buf), 1, f);
	fclose(f);

	return 0;
}