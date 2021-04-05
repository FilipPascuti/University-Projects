import socket
import pickle

def main():
    client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client.connect(("127.0.0.1", 5555))
    message = pickle.dumps(['ababafaca', 'a'])
    client.send(message)
    response = client.recv(50)
    response = pickle.loads(response)
    print(response)

if __name__ == "__main__":
    main()