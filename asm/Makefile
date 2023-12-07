all: input.out loop.out rewrite.out hello.out

input.out: input.S
	$(CC) -Wall -Wextra -O2 -o input.out input.S

loop.out: loop.S
	$(CC) -Wall -Wextra -O2 -o loop.out loop.S

rewrite.out: rewrite.S
	$(CC) -Wall -Wextra -O2 -o rewrite.out rewrite.S

hello.out: hello.S
	$(CC) -Wall -Wextra -O2 -o hello.out hello.S

clean:
	rm -f input.out loop.out rewrite.out hello.out

.PHONY: all clean