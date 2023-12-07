all: todo.out

todo.out: todo.S
	$(CC) -Wall -Wextra -O2 -o todo.out todo.S
	./todo.out

clean:
	rm -f todo.out

.PHONY: all clean