import socket
import pickle
s=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)  
s.bind(("0.0.0.0",5555))                          
buff,addr=s.recvfrom(100)                        
l = pickle.loads(buff)
mySum = sum(l)
s.sendto(pickle.dumps(mySum), addr)    