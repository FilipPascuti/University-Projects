import socket
import pickle

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

string1 = pickle.dumps("aceg")
string2 = pickle.dumps("bdfh")
sock.sendto(string1, ("127.0.0.1", 5555))
sock.sendto(string2, ("127.0.0.1", 5555))
result, _ = sock.recvfrom(50)
print(pickle.loads(result))