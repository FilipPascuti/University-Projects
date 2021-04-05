import socket
import pickle

mySocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
mySocket.bind(("0.0.0.0", 4444))

message, address = mySocket.recvfrom(50)

message = pickle.loads(message)

message = message[::-1]

mySocket.sendto(pickle.dumps(message), address)