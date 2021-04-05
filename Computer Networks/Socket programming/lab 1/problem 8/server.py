import socket
import pickle

def main():
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.bind(("0.0.0.0",5555))
    server.listen(5)
    cs, _ = server.accept()
    message = cs.recv(50)
    list1, list2 = pickle.loads(message)
    # result = [value for value in list1 if value in list2]
    result = list(set(list1) & set(list2))
    cs.send(pickle.dumps(result))

if __name__ == "__main__":
    main()