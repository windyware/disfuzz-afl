
#define LENG_SOCKET

#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

static void x_debug(char * str){
#ifdef LENG_SOCKET
	printf("[+] x_debug : %s\n", str);
#endif
}

static
void send_fuzz_data(char * filename){
#ifdef LENG_SOCKET
	int sockfd, sock_dt;
	struct sockaddr_in my_addr;
	struct sockaddr_in dest_addr;
	int destport = 8080;
	int n_send_len = 0;
	char buf[0xFFFF];
	int buflen = 0;
	int fd;
	
	sockfd = socket(AF_INET, SOCK_STREAM, 0);
	dest_addr.sin_family = AF_INET;
	dest_addr.sin_port = htons(destport);
	dest_addr.sin_addr.s_addr = inet_addr("127.0.0.1");
	memset(&dest_addr.sin_zero, 0, 8);

	connect(sockfd, (struct sockaddr *)&dest_addr, sizeof(struct sockaddr));

	fd = open(filename, O_RDONLY, 0444);
	while(1){
		printf("%d\n%s\n", fd, filename);
		memset(buf, 0, 0xFFFF*sizeof(char));
		buflen = read(fd, buf, 0xFFFE);
		if(buflen < 0){
			printf("[-] ! Read error\n");
			exit(0);
		}
		if(buflen == 0){
			printf("[+] Read data over\n");
			break;
		}
		n_send_len = send(sockfd, buf, buflen, 0);
		printf("[+] %d bytes sent\n", n_send_len);
	}
		
	close(fd);
	close(sockfd);
	sleep(0.5);
#endif
}
