import socket
import pickle

mySocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

message = pickle.dumps("turttle")

mySocket.sendto(message, ("127.0.0.1", 4444))

response, _ = mySocket.recvfrom(50)

print(pickle.loads(response))