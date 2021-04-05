""" 
This a very simple hardcoded game of planes
"""
import socket
import struct
import threading
import random

FORMAT = 'utf-8'

def print_board(board):
    for line in board:
        print(*line, end="\n")

def print_state(server_board, client_board):
    print("Server board: \n")
    print_board(server_board)
    print("Client board: \n")
    print_board(client_board)

def get_client_board(client_socket, client_address):
    board = list()
    for _ in range(0,9):
        encoded_line, _ = client_socket.recvfrom(40)
        board.append(list(struct.unpack("i"*9, encoded_line)))
    return board

def send_server_board(client_socket, client_address, board):
    for line in board:
        client_socket.sendto(struct.pack("i"*9, *line),client_address)

def game_won(board):
    for line in board:
        if 1 in line:
            return False
    return True

def receive_hit(client_socket, client_address):
    x, _ = client_socket.recvfrom(4)
    x = struct.unpack("i", x)[0]
    y, _ = client_socket.recvfrom(4)
    y = struct.unpack("i", y)[0]
    return x, y

def send_hit(client_socket, client_address, x, y):
    client_socket.sendto(struct.pack("i", x), client_address)
    client_socket.sendto(struct.pack("i", y), client_address) 

def choose_hit(client_board):
    while True:
        x = random.randint(0, 8)
        y = random.randint(0, 8)
        if client_board[x][y] == 0 or client_board[x][y] == 1:
            return x, y

def handle_client(client_socket, client_address):
    connection_confirmation, _ = client_socket.recvfrom(100)
    print(connection_confirmation.decode(FORMAT))

    server_board = [
        [0,1,0,0,0,0,0,0,0],
        [1,1,1,0,0,0,0,0,0],
        [0,1,0,0,0,0,0,0,0],
        [1,1,1,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
    ]
    send_server_board(client_socket, client_address, server_board)
    client_board = get_client_board(client_socket, client_address)
    while True:
        print_state(server_board, client_board)
        if game_won(client_board) or game_won(server_board):
            break
        x, y = receive_hit(client_socket, client_address)
        print(x," ", y)
        if server_board[x][y] == 1:
            server_board[x][y] = 2
        else:
            server_board[x][y] = -1
        x, y = choose_hit(client_board)
        send_hit(client_socket, client_address, x, y)
        if client_board[x][y] == 1:
            client_board[x][y] = 2
        else:
            client_board[x][y] = -1

    print("Thread is ending here\n")
    client_socket.close()

def main():
    server = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    server.bind(("0.0.0.0", 5555))
    while True:
        _, client_address = server.recvfrom(100)
        client_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        client_socket.sendto("This is the socket we will play through: \n\0".encode(FORMAT),
                         client_address)
        client_thread = threading.Thread(target=handle_client, args=[client_socket, client_address,])
        client_thread.start()

if __name__ == "__main__":
    main()