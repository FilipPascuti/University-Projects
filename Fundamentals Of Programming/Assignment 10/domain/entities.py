class Table(object):
    
    def __init__(self):
        self.__matrix = [
            ['0', '0', '0', '0', '0', '0', '0', '0'],
            ['0', '0', '0', '0', '0', '0', '0', '0'],
            ['0', '0', '0', '0', '0', '0', '0', '0'],
            ['0', '0', '0', '0', '0', '0', '0', '0'],
            ['0', '0', '0', '0', '0', '0', '0', '0'],
            ['0', '0', '0', '0', '0', '0', '0', '0'],
            ['0', '0', '0', '0', '0', '0', '0', '0'],
            ['0', '0', '0', '0', '0', '0', '0', '0']
            ]
        
        self.__hit_matrix = [
            ['0', '0', '0', '0', '0', '0', '0', '0'],
            ['0', '0', '0', '0', '0', '0', '0', '0'],
            ['0', '0', '0', '0', '0', '0', '0', '0'],
            ['0', '0', '0', '0', '0', '0', '0', '0'],
            ['0', '0', '0', '0', '0', '0', '0', '0'],
            ['0', '0', '0', '0', '0', '0', '0', '0'],
            ['0', '0', '0', '0', '0', '0', '0', '0'],
            ['0', '0', '0', '0', '0', '0', '0', '0']
            ]

    def get_matrix(self):
        return self.__matrix
    
    def get_hit_matrix(self):
        return self.__hit_matrix
    
    def str(self):
        """
        method that returns the printing format of the object
        """
        string_form = "  A B C D E F G H\n"
        for i in range(0, 8):
            string_form += str(i + 1) + " "
            for j in range(0, 8):
                string_form += str(self.__hit_matrix[i][j]) + " "
            string_form += "\n"
        return string_form
    
    def move(self, x_coordonate, y_coordonate):
        """
        method that takes 2 coordonates: x and y and changes the value of the coresponding element in the self.__matrix as well as in the self.__hit_matrix
        input: x_coordonate - the x coordonate, y_coordonate - the y coordonate
        output: -
        """
        if self.__matrix[x_coordonate][y_coordonate] == '1':
            self.__matrix[x_coordonate][y_coordonate] = '2'
            self.__hit_matrix[x_coordonate][y_coordonate] = 'x'
        if  self.__matrix[x_coordonate][y_coordonate] == '2':
            print("already tried this!\n")
        if self.__matrix[x_coordonate][y_coordonate] == '0':
            self.__hit_matrix[x_coordonate][y_coordonate] = '*'
            print("you missed!\n")
            
    def add_ship(self, x_coordonate, y_coordonate, orientation, the_type):
        """
        method that uses the x_coordonate, y_coordonate, orientation and type to add the ship
        input: x_coordonate - integer value between 0 and 7 representing the x coordonate, y_coordonate - integer value between 0 and 7 representing the y coordonate, orientation - a character that specifies the orientation of the ship, type - the type of the ship
        output: -
        """
        if the_type == "battleship":
            size = 4
        if the_type == 'cruiser':
            size = 3
        if the_type == 'destroyer':
            size = 2 
            
        if orientation == 'N':
            i = x_coordonate
            while i < x_coordonate + size:
                if self.__matrix[i][y_coordonate] == '1':
                    raise Exception("overlaping")
                self.__matrix[i][y_coordonate] = '1'
                i += 1
                
        if orientation == 'S':
            i = x_coordonate
            while i > x_coordonate - size:
                if self.__matrix[i][y_coordonate] == '1':
                    raise Exception("overlaping")
                self.__matrix[i][y_coordonate] = '1'
                i -= 1
                
        if orientation == 'W':
            i = y_coordonate
            while i < y_coordonate + size:
                if self.__matrix[x_coordonate][i] == '1':
                    raise Exception("overlaping")
                self.__matrix[x_coordonate][i] = '1'
                i += 1
                
        if orientation == 'E':
            i = y_coordonate 
            while i > y_coordonate - size:
                if self.__matrix[x_coordonate][i] == '1':
                    raise Exception("overlaping")
                self.__matrix[x_coordonate][i] = '1'
                i -= 1
