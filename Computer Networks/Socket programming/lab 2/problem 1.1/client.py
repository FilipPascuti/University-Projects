import socket
import pickle

def main():
    client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client.connect(("127.0.0.1", 5555))
    message = client.recv(500)
    print(pickle.loads(message))
    client.send(pickle.dumps("good bro\n"))

if __name__ == "__main__":
    main()