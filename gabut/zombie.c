#include <unistd.h>

/*
* note
* ps -l, see list of zombie and
* other types of process
*
* jobs, see stopped or run in
* background process
* related commands include: fg %job_id and bg
* reference: manual page and
* https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#:~:text=3.204-,Job%20Control%20Job%20ID,-A%20handle%20that
*/

int main(void)
{
	if (fork() > 0)
		while (1) { }

	return 0;
}
