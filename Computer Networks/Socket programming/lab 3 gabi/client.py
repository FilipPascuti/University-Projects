import socket 
import pickle

def main():
    client = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)  
    message = pickle.dumps("Hello from client\n")
    client.sendto(message, ("192.168.100.109", 5555))
    response, _ = client.recvfrom(100)
    response = pickle.loads(response) 

    print(response)

if __name__ == "__main__":
    main()