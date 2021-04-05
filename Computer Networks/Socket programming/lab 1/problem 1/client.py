import socket
import pickle
s=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)  
message = b"hey"
l = [1,2,3,4,5]
s.sendto(pickle.dumps(l),("127.0.0.1",5555))  
response, _ = s.recvfrom(10)
print(pickle.loads(response))