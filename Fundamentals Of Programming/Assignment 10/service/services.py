import random


class Computer_service(object):
    
    def __init__(self, validator, table):
        self.__validator = validator
        self.__table = table

    def add_the_ships(self):
        '''
            method that adds the ships randomly by calling the __add_ship method with random values
            input: -
            output: -
        '''
        while True:
            try:
                x_coordonate = random.randint(0, 7)
                y_coordonate = random.randint(0, 7)
                orientation = random.choice(['N', 'S', 'W', 'E'])
                self.__add_ship(x_coordonate, y_coordonate, orientation, 'battleship')
                break
            except Exception as ex:
                pass
        
        while True:
            try:
                x_coordonate = random.randint(0, 7)
                y_coordonate = random.randint(0, 7)
                orientation = random.choice(['N', 'S', 'W', 'E'])
                self.__add_ship(x_coordonate, y_coordonate, orientation, 'cruiser')
                break
            except Exception as ex:
                pass
            
        while True:
            try:
                x_coordonate = random.randint(0, 7)
                y_coordonate = random.randint(0, 7)
                orientation = random.choice(['N', 'S', 'W', 'E'])
                self.__add_ship(x_coordonate, y_coordonate, orientation, 'destroyer')
                break
            except Exception as ex:
                pass
        
    def __add_ship(self, x_coordonate, y_coordonate, orientation, type):
        """
        method that checks if the x_coordonate, y_coordonate, orientation and type are correct and adds the ship if posible
        input: x_coordonate - integer value between 0 and 7 representing the x coordonate, y_coordonate - integer value between 0 and 7 representing the y coordonate, orientation - a character that specifies the orientation of the ship, type - the type of the ship
        output: -
        """
        self.__validator.validate_add(x_coordonate, y_coordonate, orientation, type)
        self.__table.add_ship(x_coordonate, y_coordonate, orientation, type)
        
    def get_computer_table(self):
        return self.__table.get_hit_matrix()
    
    def get_print_table(self):
        return self.__table.str()
    
    def check_if_player_won(self):
        """
        method that checks if the player won by checking if there are any 1's in the self.__matrix
        input: -
        output: True: if there are no 1's or False: if there is at least a 1
        """
        table = self.__table.get_matrix()
        for i in range(0, 8):
            if '1' in table[i]:
                return False
        else:
            return True
        
    def players_move(self, x_coordonate, y_coordonate):
        """
        method that takes 2 coordonates: x and y and changes the value of the coresponding element in the matrix 
        input: x_coordonate - the x coordonate, y_coordonate - the y coordonate
        output: -
        """
        self.__validator.validate_player_move(x_coordonate, y_coordonate)
        if y_coordonate == 'A':
            y_coordonate = 0
        if y_coordonate == 'B':
            y_coordonate = 1
        if y_coordonate == 'C':
            y_coordonate = 2
        if y_coordonate == 'D':
            y_coordonate = 3
        if y_coordonate == 'E':
            y_coordonate = 4
        if y_coordonate == 'F':
            y_coordonate = 5
        if y_coordonate == 'G':
            y_coordonate = 6
        if y_coordonate == 'H':
            y_coordonate = 7    
        self.__table.move(x_coordonate, y_coordonate)
        
    def choose_move(self, hit_table):
        """
        method that chooses the move with respect to the previous moves
        input: hit_table - an array with the previous moves
        output: 2 integers representing the x and y coordonates
        """
        ok = 0
        for i in range(0, 8):
            for j in range(0, 8):
                if hit_table[i][j] == 'x':
                    options = []
                    if hit_table[i][j - 1] == "0" and j - 1 >= 0:
                        options.append([i, j - 1])
                    if hit_table[i][j + 1] == "0" and j + 1 < 8:
                        options.append([i, j + 1])
                    if hit_table[i - 1][j] == "0" and i - 1 >= 0:
                        options.append([i - 1, j])
                    if hit_table[i + 1][j] == "0" and i + 1 < 8:
                        options.append([i + 1, j])
                    if len(options) > 0:
                        return random.choice(options)
                        ok = 1 
        if ok == 0:
            return random.randint(0, 7), random.randint(0, 7)

        
class Player_service(object):
    
    def __init__(self, table_validator, table):
        self.__validator = table_validator
        self.__table = table
        
    def add_ship(self, x_coordonate, y_coordonate, orientation, type):
        """
        method that checks if the x_coordonate, y_coordonate, orientation and type are correct and adds the ship if posible
        input: x_coordonate - integer value between 0 and 7 representing the x coordonate, y_coordonate - integer value between 0 and 7 representing the y coordonate, orientation - a character that specifies the orientation of the ship, type - the type of the ship
        output: -
        """
        if y_coordonate == 'A':
            y_coordonate = 0
        if y_coordonate == 'B':
            y_coordonate = 1
        if y_coordonate == 'C':
            y_coordonate = 2
        if y_coordonate == 'D':
            y_coordonate = 3
        if y_coordonate == 'E':
            y_coordonate = 4
        if y_coordonate == 'F':
            y_coordonate = 5
        if y_coordonate == 'G':
            y_coordonate = 6
        if y_coordonate == 'H':
            y_coordonate = 7  
        self.__validator.validate_add(x_coordonate, y_coordonate, orientation, type)
        self.__table.add_ship(x_coordonate, y_coordonate, orientation, type)
        
    def get_player_table(self):
        return self.__table.get_hit_matrix()
    
    def get_print_table(self):
        return self.__table.str()
    
    def check_if_computer_won(self):
        """
        method that checks if the computer won by checking if there are any 1's in the self.__matrix
        input: -
        output: True: if there are no 1's or False: if there is at least a 1
        """
        table = self.__table.get_matrix()
        for i in range(0, 8):
            if '1' in table[i]:
                return False
        else:
            return True
        
    def computer_move(self, x_coordonate, y_coordonate):
        """
        method that takes 2 coordonates: x and y and changes the value of the coresponding element in the matrix 
        input: x_coordonate - the x coordonate, y_coordonate - the y coordonate
        output: -
        """
        try:
            self.__validator.validate_computer_move(x_coordonate, y_coordonate)
            self.__table.move(x_coordonate, y_coordonate)
        except Exception as ex:
            print(ex)
