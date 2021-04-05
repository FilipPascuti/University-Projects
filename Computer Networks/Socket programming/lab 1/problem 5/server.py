import socket
import pickle

mySocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
mySocket.bind(("0.0.0.0", 5555))
mySocket.listen(5)
cs, addr = mySocket.accept()

number = cs.recv(50)
number = pickle.loads(number)

divisors = list()

for i in range(2,number):
    if number % i == 0:
        divisors.append(i)

cs.send(pickle.dumps(divisors))

cs.close()