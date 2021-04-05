import socket
import pickle
import os

def main():
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.bind(("0.0.0.0", 5555))
    server.listen(5)
    cs, _ = server.accept()
    
    cs.send(pickle.dumps("Wassup dude\n"))
    response = cs.recv(50)
    print(pickle.loads(response))


if __name__ == "__main__":
    main()