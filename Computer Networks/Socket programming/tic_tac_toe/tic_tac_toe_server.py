import socket
import threading
import time
import struct 
import random

FORMAT = 'utf-8'

def print_board(board):
    for line in board:
        print(*line, end="\n")

def game_won(board):
    for line in board:
        if line[0] == line[1] and line[1] == line[2] and line[0] == 2:
            return True
    for i in range(0,3):
        if board[0][i] == board[1][i] and board[1][i] == board[2][i] and board[0][i] == 2:
            return True
    if board[0][0] == board[1][1] and  board[1][1] == board[2][2] and board[0][0] == 2:
        return True
    if board[0][2] == board[1][1] and board[1][1] == board[2][0] and board[0][2] == 2:
        return True
    return False

def game_lost(board):
    for line in board:
        if line[0] == line[1] and line[1] == line[2] and line[0] == 1:
            return True
    for i in range(0,3):
        if board[0][i] == board[1][i] and board[1][i] == board[2][i] and board[0][i] == 1:
            return True
    if board[0][0] == board[1][1] and  board[1][1] == board[2][2] and board[0][0] == 1:
        return True
    if board[0][2] == board[1][1] and board[1][1] == board[2][0] and board[0][2] == 1:
        return True
    return False

def choose_coordonates(board):
    while True:
        x = random.randint(0,2)
        y = random.randint(0,2)
        if board[x][y] == 0:
            return x, y

def game_ended(board):
    for line in board:
        if 0 in line:
            return False
    return True

def handleClient(client_socket):
    board = [
        [0,0,0],
        [0,0,0],
        [0,0,0]
    ]
    while True:
        print_board(board)
        if game_won(board) or game_lost(board) or game_ended(board):
            break
        coordonate_x = client_socket.recv(4)
        recv_x = struct.unpack("i", coordonate_x)[0]
        coordonate_y = client_socket.recv(4)
        recv_y = struct.unpack("i", coordonate_y)[0]
        print("Received: ", recv_x, " ", recv_y)
        board[recv_x][recv_y] = 1
        if game_ended(board):
            break
        send_x, send_y = choose_coordonates(board)
        board[send_x][send_y] = 2
        client_socket.send(struct.pack("i", send_x))
        client_socket.send(struct.pack("i", send_y))

    print("Game ended")

def main():
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.bind(("0.0.0.0", 5555))
    server.listen(10)
    threads = list()


    while True:
        client_socket, client_address = server.accept()
        print(client_address)
        client_thread = threading.Thread(target=handleClient, args=(client_socket,))
        client_thread.start()
        threads.append(client_thread)


    # for thread in threads:
    #     thread.join()


if __name__ == "__main__":
    main()