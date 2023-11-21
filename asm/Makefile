all: todo.out

todo.out: todo.S
	$(CC) -Wall -Wextra -O2 -o todo.out todo.S

clean:
	rm -f todo.out

.PHONY: all clean