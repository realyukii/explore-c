#include <unistd.h> // removeable - only used for close()
#include <stdio.h> // perror(), printf()
#include <netdb.h> // getaddrinfo(), struct addrinfo
#include <string.h> // memset()
#include <arpa/inet.h> // struct sockaddr_in, inet_pton(), htons()
#include <sys/socket.h> // socket(), send(), connect(), recv(), constant AF_INET, SOCK_STREAM

/* tag removeable - used for reduce size of binary executable
*  and not removed only for debugging and implement
*  best-practice/good habit/increase awereness
*/
int main(void)
{
	int fd;
	struct addrinfo hints, *server_addr;
	const char host[] = "neverssl.com";
	char request[] = "GET / HTTP/1.0\r\n\r\n";
	char response[5096];
	int bytes, total;

	memset(&hints, 0, sizeof(hints));
	hints.ai_family = AF_INET;
	hints.ai_socktype = SOCK_STREAM;
	hints.ai_flags |= AI_CANONNAME;

	if (getaddrinfo(host, NULL, &hints, &server_addr) != 0) {
		perror("getaddrinfo"); // removeable
		return -1;
	}

	((struct sockaddr_in *)server_addr->ai_addr)->sin_port = htons(80);

	char addrstr[100] = {0};
	inet_ntop(server_addr->ai_family, (void *)&((struct sockaddr_in *)server_addr->ai_addr)->sin_addr, addrstr, 100);
	printf("IP address: %s (%s)\nport: %d\n", addrstr, server_addr->ai_canonname, ntohs(((struct sockaddr_in *)server_addr->ai_addr)->sin_port));

	fd = socket(AF_INET, SOCK_STREAM, 0);
	if (fd < 0) {
		perror("socket"); // removeable
		freeaddrinfo(server_addr); // removeable
		return -1;
	}

	if (connect(fd, server_addr->ai_addr, server_addr->ai_addrlen) < 0) {
		perror("connect"); // removeable
		close(fd); // removeable
		freeaddrinfo(server_addr); // removeable
		return -1;
	}

	printf("Performing HTTP REQUEST...\n%s\n", request);
	unsigned short sent = 0;
	total = sizeof(request);
	do {
		bytes = send(fd, request + sent, total - sent, 0);
		if (bytes < 0) {
			close(fd); // removeable
			freeaddrinfo(server_addr); // removeable
			perror("send"); // removeable
			return -1;
		}
		if (bytes == 0)
			break;
		sent += bytes;
	} while (sent < total);

	puts("Receiving HTTP RESPONSE...");
	memset(response, 0, sizeof(response));
	total = sizeof(response) - 1;
	unsigned received = 0;
	do {
		bytes = recv(fd, response + received, total - received, 0);
		if (bytes < 0) {
			close(fd); // removeable
			freeaddrinfo(server_addr); // removeable
			perror("recv"); // removeable
			return -1;
		}
		if (bytes == 0)
			break;
		received += bytes;
	} while (received < total);

	if (received == total) {
		close(fd); // removeable
		freeaddrinfo(server_addr); // removeable
		perror("overflow"); // removeable
		return -1;
	}

	printf("response:\n%s\n", response);
	printf("TCP packet body length: %d\n", received);

	freeaddrinfo(server_addr); // removeable
	close(fd); // removeable

	return 0;
}
