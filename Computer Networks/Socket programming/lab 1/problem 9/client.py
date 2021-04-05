import socket
import pickle

def main():
    client = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    message = pickle.dumps([[1,2,3,4,5,6], [1,3,5]])
    client.sendto(message, ("127.0.0.1", 5555))
    result, _ = client.recvfrom(50)
    result = pickle.loads(result)
    print(result)
    
if __name__ == "__main__":
    main()