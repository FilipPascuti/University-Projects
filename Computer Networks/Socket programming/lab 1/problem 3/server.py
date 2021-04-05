import socket
import pickle

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind(("0.0.0.0", 5555))
string1, address = sock.recvfrom(50)
string2, _ = sock.recvfrom(50)

string1 = pickle.loads(string1)
string2 = pickle.loads(string2)

mergedString = ""

i = 0
j = 0
while(i < len(string1) and j < len(string2)):
    if(string1[i] < string2[j]):
       mergedString += string1[i]
       i += 1
    else:
        mergedString += string2[j]  
        j += 1

while( i< len(string1) ):
    mergedString += string1[i]
    i += 1

while( j< len(string2) ):
    mergedString += string2[j]  
    j += 1

print(mergedString)

sock.sendto(pickle.dumps(mergedString), address)