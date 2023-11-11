CC=gcc
CFLAGS=-Wall -Wextra
test:
	touch todo_tmp
	rm todo_*
	$(CC) reimpl.c -o main.out $(CFLAGS)
	./main.out