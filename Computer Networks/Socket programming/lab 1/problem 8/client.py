import socket
import pickle

def main():
    client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client.connect(("127.0.0.1", 5555))
    message = pickle.dumps([[1,2,3,4,5], [3,4,5,6,7,8]])
    client.send(message)
    result = client.recv(50)
    result = pickle.loads(result)
    print(result)

if __name__ == "__main__":
    main()