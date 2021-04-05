import socket
import pickle

def main():
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.bind(("0.0.0.0", 5555))
    server.listen(5)
    cs, _ = server.accept()
    message = cs.recv(50)
    string, index, length = pickle.loads(message)
    cs.send(pickle.dumps(string[index:index+length]))

if __name__ == "__main__":
    main()