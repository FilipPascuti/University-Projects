import socket
import pickle

client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

client.connect(("127.0.0.1", 5555))

client.send(pickle.dumps("ana are trei  spatii"))

result = client.recv(50)

print(pickle.loads(result))

client.close()
