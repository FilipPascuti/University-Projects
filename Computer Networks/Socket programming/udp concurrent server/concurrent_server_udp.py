import socket
import threading
import time

FORMAT = 'utf-8'

def handle_client(client_socket, client_address):
    print("Here we are in the client thread\n")
    # time.sleep(5)
    i = 5
    while i > 0:
        response, _ = client_socket.recvfrom(500)
        response = response.decode(FORMAT)
        print(response)
        i -= 1
    client_socket.sendto("Ending the discution\n\0".encode(FORMAT), client_address)


def main():
    server = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    server.bind(("0.0.0.0", 5555))
    while True:
        response, address = server.recvfrom(100)
        print(response.decode(FORMAT), address)

        new_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        default_message = "Here is the address to send stuff to\n\0".encode(FORMAT)

        new_socket.sendto(default_message, address)
        client_thread = threading.Thread(target=handle_client, args=[new_socket,address])
        client_thread.start()

if __name__ == "__main__":
    main()