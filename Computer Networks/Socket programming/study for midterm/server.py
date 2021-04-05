import socket 
import time 

def main():
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.bind(("0.0.0.0",5555))
    server.listen(5)
    client_socket, address = server.accept()
    print("Client address: ", address)
    message1 = client_socket.recv(100)
    print(message1)
    client_socket.send("Hello from server.".encode('utf-8'))
    message2 = client_socket.recv(100)
    print(message2)
    # client_socket.send(pickle.dumps("Hello from Server."))

if __name__ == "__main__":
    main()