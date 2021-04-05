import socket
import pickle

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind(("0.0.0.0", 5555))
server.listen(5)
mySocket, addr = server.accept()

message = mySocket.recv(50)

message = pickle.loads(message)

result = len(message.split(' ')) - 1

result = pickle.dumps(result)

mySocket.send(result)

mySocket.close()