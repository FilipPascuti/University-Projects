import socket
import pickle

def main():
    client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client.connect(("127.0.0.1", 5555))

    message1 = pickle.dumps(5)
    client.send(message1)
    response = client.recv(1024)
    print(response)
    message2 = pickle.dumps(7)
    client.send(message2)
    # response = client.recv(1024)
    # print(pickle.loads(response))

if __name__ == "__main__":
    main()
