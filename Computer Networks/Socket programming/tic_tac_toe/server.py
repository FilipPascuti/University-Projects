import socket
import struct

FORMAT = 'utf-8'

def main():
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.bind(("0.0.0.0", 6666))
    server.listen(5)
    client, _ = server.accept()
    message = "Hello from python\0"
    message = message.encode('utf-8')
    client.send(message)
    size = client.recv(500)
    size = struct.unpack('i', size)
    size = int(size[0])
    data = client.recv(500)
    pattern = "i"* size
    data = list(struct.unpack(pattern, data))
    print(data)
    

if __name__ == "__main__":
    main()

