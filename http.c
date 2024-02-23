#include <unistd.h> // removeable - only used for close()
#include <stdio.h> // perror(), printf()
#include <netdb.h> // getaddrinfo(), struct addrinfo
#include <string.h> // memset()
#include <arpa/inet.h> // struct sockaddr_in, inet_pton(), htons()
#include <sys/socket.h> // socket(), send(), connect(), recv(), constant AF_INET, SOCK_STREAM
#include <wolfssl/options.h>
#include <wolfssl/ssl.h>

/* tag removeable - used for reduce size of binary executable
*  and not removed only for debugging and implement
*  best-practice/good habit/increase awereness
*/
int main(void)
{
	signed char fd;
	signed char ret;
	struct addrinfo hints, *server_addr;
	// use neverssl.com for HTTP-only
	const char host[] = "tls-v1-2.badssl.com"; 
	char request[] = "GET / HTTP/1.0\r\n\r\n";
	char response[5096];
	int bytes, total;
	WOLFSSL_CTX *ctx;
	WOLFSSL *ssl;

	memset(&hints, 0, sizeof(hints));
	hints.ai_family = AF_INET;
	hints.ai_socktype = SOCK_STREAM;
	hints.ai_flags |= AI_CANONNAME;

	if ((ret = getaddrinfo(host, NULL, &hints, &server_addr)) != 0) {
		perror("getaddrinfo"); // removeable
		goto free_addr;
	}

	// change to port 80 for HTTP
	// the port 1012 is unusual for SSL/TLS btw
	((struct sockaddr_in *)server_addr->ai_addr)->sin_port = htons(1012);

	char addrstr[100] = {0};
	inet_ntop(server_addr->ai_family, (void *)&((struct sockaddr_in *)server_addr->ai_addr)->sin_addr, addrstr, 100);
	printf("IP address: %s (%s)\nport: %d\n", addrstr, server_addr->ai_canonname, ntohs(((struct sockaddr_in *)server_addr->ai_addr)->sin_port));

	fd = socket(AF_INET, SOCK_STREAM, 0);
	if (fd < 0) {
		perror("socket"); // removeable
		ret = -1;
		goto free_addr;
	}

	if ((ret = connect(fd, server_addr->ai_addr, server_addr->ai_addrlen)) < 0) {
		perror("connect"); // removeable
		goto socket_cleanup;
	}


	if ((ret = wolfSSL_Init()) != WOLFSSL_SUCCESS) {
		fprintf(stderr, "ERROR: Failed to initialize wolfssl\n");
		goto socket_cleanup;
	}

	if ((ctx = wolfSSL_CTX_new(wolfTLSv1_2_client_method())) == NULL) {
		fprintf(stderr, "ERROR: Failed to create WOLFSSL_CTX\n");
		ret = -1;
		goto socket_cleanup;
	}

	if ((ret = wolfSSL_CTX_load_system_CA_certs(ctx)) != WOLFSSL_SUCCESS) {
		fprintf(stderr, "ERROR: failed to load cer");
		goto ctx_cleanup;
	}

	if ((ssl = wolfSSL_new(ctx)) == NULL) {
		fprintf(stderr, "ERROR: Failed to create WOLFSSL object\n");
		ret = -1;
		goto ctx_cleanup;
	}

	if ((ret = wolfSSL_set_fd(ssl, fd)) != WOLFSSL_SUCCESS) {
		fprintf(stderr, "ERROR: Failed to set the file descriptor\n");
		goto cleanup;
	}

	if ((ret = wolfSSL_connect(ssl)) != WOLFSSL_SUCCESS) {
		fprintf(stderr, "ERROR: Failed to connect to wolfSSL\n");
		goto cleanup;
	}

	printf("Performing HTTP REQUEST...\n%s\n", request);
	unsigned short sent = 0;
	total = sizeof(request);
	do {
		bytes = wolfSSL_write(ssl, request + sent, total - sent);
		if (bytes < 0) {
			perror("send"); // removeable
			ret = -1;
			goto cleanup;
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
		bytes = wolfSSL_read(ssl, response + received, total - received);
		if (bytes < 0) {
			perror("recv"); // removeable
			ret = -1;
			goto cleanup;
		}
		if (bytes == 0)
			break;
		received += bytes;
	} while (received < total);

	if (received == total) {
		perror("overflow"); // removeable
		ret = -1;
		goto cleanup;
	}

	printf("response:\n%s\n", response);

	// just for checking the actual length
	// int i = 0;
	// char *ptr_char = &response;
	// while (*ptr_char) {
	//	ptr_char++;
	//	i++;
	// }
	// printf("%d\n", i);

	printf("TCP packet body length: %d\n", received);
	while (wolfSSL_shutdown(ssl) == WOLFSSL_SHUTDOWN_NOT_DONE) {
		puts("shutdown not complete yet");
	}
	puts("shutdown complete");
	ret = 0;

cleanup:
	wolfSSL_free(ssl);
ctx_cleanup:
	wolfSSL_CTX_free(ctx);
	wolfSSL_Cleanup();
socket_cleanup:
	close(fd); // removeable
free_addr:
	freeaddrinfo(server_addr); // removeable
	return ret;
}
