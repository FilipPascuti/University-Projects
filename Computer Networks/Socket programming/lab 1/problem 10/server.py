import socket
import pickle

def main():
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.bind(("0.0.0.0", 5555))
    server.listen(1)
    cs, _ = server.accept()
    message = cs.recv(50)
    string1, string2 = pickle.loads(message)
    length = min(len(string1), len(string2))
    count = dict()
    for i in range(0,length):
        if string1[i] == string2[i]:
            if string1[i] in count:
                count[string1[i]] += 1
            else:
                count[string1[i]] = 1
    max_key = max(count, key=count.get)
    print(pickle.dumps(max_key))
    cs.send(pickle.dumps(max_key))


if __name__ == "__main__":
    main()