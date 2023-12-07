all: conv.out input.out loop.out rewrite.out hello.out

conv.out: conv.S
	$(CC) -Wall -Wextra -O2 -o conv.out conv.S
	./conv.out

input.out: input.S
	$(CC) -Wall -Wextra -O2 -o input.out input.S
	./input.out

loop.out: loop.S
	$(CC) -Wall -Wextra -O2 -o loop.out loop.S
	./loop.out

rewrite.out: rewrite.S
	$(CC) -Wall -Wextra -O2 -o rewrite.out rewrite.S
	./rewrite.out

hello.out: hello.S
	$(CC) -Wall -Wextra -O2 -o hello.out hello.S
	./hello.out

clean:
	rm -f conv.out input.out loop.out rewrite.out hello.out

.PHONY: all clean