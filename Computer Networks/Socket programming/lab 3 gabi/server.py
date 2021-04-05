import socket 
import pickle

def main():
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.bind(("0.0.0.0", 5555))
    server.listen(5)
    cs, _ = server.accept()
    result = cs.recv(100)
    print(pickle.loads(result))
    message = pickle.dumps("Good\n")
    cs.send(message)

if __name__ == "__main__":
    main()

# doua limbaje
# server concurent
# 2 masini
# trateaza erori de retele!!!!