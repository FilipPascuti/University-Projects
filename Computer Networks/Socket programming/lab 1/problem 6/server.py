import socket
import pickle

def main():
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.bind(("0.0.0.0",5555))
    server.listen(5)
    cs, _ = server.accept()
    message = cs.recv(50)
    message = pickle.loads(message)
    string, letter = message
    appearances = list()
    for i in range(0,len(string)):
        if(string[i] == letter):
            appearances.append(i)
    cs.send(pickle.dumps(appearances))

if __name__ == "__main__":
    main()