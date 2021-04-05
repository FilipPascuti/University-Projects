import socket
import pickle

def main():
    server = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    server.bind(("0.0.0.0", 5555))
    message, address = server.recvfrom(50)
    list1, list2 = pickle.loads(message)
    print(list1, list2)
    result = list(set(list1).difference(set(list2)))
    server.sendto(pickle.dumps(result), address)

if __name__ == "__main__":
    main()