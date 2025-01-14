#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

#define BUFFSIZE 512
#define err(mess) { fprintf(stderr,"Error: %s.", mess); exit(1); }

int main(void)
{
    int fd;
    ssize_t n;
    char buf[BUFFSIZE];

    if ((fd = open("fifo_x", O_RDONLY)) < 0)
        err("open")

    while(1) {
	n = read(fd, buf, BUFFSIZE);
	// EoF occurs, implying there's no writer to the file.
	if (n == 0) {
		close(fd);
		if ((fd = open("fifo_x", O_RDONLY)) < 0)
			err("open")
		continue;
	}

        if (write(STDOUT_FILENO, buf, n) != n) { 
            break;
        }
    }

    close(fd);
    return 0;
}
