import socket
import pickle

mySocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
mySocket.connect(("127.0.0.1", 5555))
mySocket.send(pickle.dumps(20))
divisors = mySocket.recv(50)
divisors = pickle.loads(divisors)
print(divisors)
mySocket.close()