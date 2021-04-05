import socket
import time


def main():
    server = socket.socket(socket.AF_INET, socket.SOCK_DGRAM, socket.IPPROTO_UDP)

    server.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)

    message = b"your very important message"
    while True:
        server.sendto(message, ('<broadcast>', 37020))
        print("message sent!")
        time.sleep(1)

if __name__ == "__main__":
    main()

