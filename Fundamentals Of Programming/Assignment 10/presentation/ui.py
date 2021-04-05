class Console(object):
    
    def __init__(self, service_player, service_computer):
        self.__service_player = service_player
        self.__service_computer = service_computer
    
    def print_info(self):
        print("Welcome to Battleships! Firstly you will choose where you want your planes.")

    def __add_ships(self):
        print("Enter the coordonates of the head of begining square of the ship and its orintation(N,S,W,E)")
        
        print("First the battleship\n")
        while True:
            try:
                x_coordonate = int(input("insert the line:\n")) - 1
                y_coordonate = input("insert the column:\n") 
                orientation = input("insert the orientation:\n")
                self.__service_player.add_ship(x_coordonate, y_coordonate, orientation, 'battleship')
                break
            except Exception as ex:
                print(str(ex))
                
        print("Now the cruiser\n")
        while True:
            try:
                x_coordonate = int(input("insert the line:\n")) - 1 
                y_coordonate = input("insert the column:\n")
                orientation = input("insert the orientation:\n")
                self.__service_player.add_ship(x_coordonate, y_coordonate, orientation, 'cruiser')
                break
            except Exception as ex:
                print(str(ex))
                
        print("And the destroyer\n")
        while True:
            try:
                x_coordonate = int(input("insert the line:\n")) - 1 
                y_coordonate = input("insert the column:\n")
                orientation = input("insert the orientation:\n")
                self.__service_player.add_ship(x_coordonate, y_coordonate, orientation, 'destroyer')
                break
            except Exception as ex:
                print(str(ex))

    def __print_player_table(self):
        table = self.__service_player.get_print_table()
        print(table)

    def __print_computer_table(self):
        table = self.__service_computer.get_print_table()
        print(table)

    def __ui_player_move(self):
        x_coordonate = int(input("insert the line:\n")) - 1
        y_coordonate = input("insert the column(A,B,C,D,E,F,G,H):\n")
        self.__service_computer.players_move(x_coordonate, y_coordonate)

    def __ui_computer_move(self):
        hit_table = self.__service_player.get_player_table()
        x_coordonate, y_coordonate = self.__service_computer.choose_move(hit_table)
        self.__service_player.computer_move(x_coordonate, y_coordonate)

    def run(self):
        self.print_info()
        
        while True:
            try:
                self.__add_ships()
                break
            except ValueError as ve:
                print(str(ve))
                
        self.__service_computer.add_the_ships()
        
        while True:
            try:
                if self.__service_computer.check_if_player_won() == True:
                    print("You won!")
                    return 
                if self.__service_player.check_if_computer_won() == True:
                    print("You lost!")
                    return 
                self.__ui_player_move()
                self.__ui_computer_move()
            
                self.__print_computer_table()
                print()      
                self.__print_player_table()
            except ValueError as ve:
                print(str(ve))
            except Exception as ex:
                print(str(ex))
