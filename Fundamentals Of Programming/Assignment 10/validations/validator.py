class Validator(object):

    def validate_add(self, x_coordonate, y_coordonate, orientation, the_type):
        """
        method that validates the coordonates, oritation and the_type that are needed in order to add a ship
        input: x_coordonate - integer value representing the x coordonate, y_coordonate - integer value representing the y coordonate, orientation - a character that specifies the orientation of the ship, type - the type of the ship
        output: -
        raises:  if orientation not in ['N', 'S', 'W', 'E']
                    "invalid orientation\n"
                 if the coordonate added/subtracted with the size are greater/lower that 7/0
                     "does not fit!"
        """
        if the_type == "battleship":
            size = 4
        if the_type == 'cruiser':
            size = 3
        if the_type == 'destroyer':
            size = 2 
        
        if y_coordonate not in [1, 2, 3, 4, 5, 6, 7, 0]:
            raise Exception("invalid coordonate")
        
        if orientation not in ['N', 'S', 'W', 'E']:
            raise Exception("invalid orientation\n")
        
        if x_coordonate < 0 or x_coordonate > 7 or y_coordonate < 0 or y_coordonate > 7:
            raise Exception("does not fit!")
        
        if orientation == 'N' and x_coordonate + size > 7:
            raise Exception("does not fit!")
                
        if orientation == 'S' and x_coordonate - size < 0:
            raise Exception("does not fit!")
            
        if orientation == 'W' and y_coordonate + size > 7:
            raise Exception("does not fit!")
        
        if orientation == 'E' and y_coordonate - size < 0:
            raise Exception("does not fit!")
    
    def validate_computer_move(self, x_coordonate, y_coordonate):
        """
        method that takes 2 coordonates and validates them
        input: x_coordonate - teh x coordonate, y_coordonate - the y coordonate
        output: -
        raises: if x_coordonate < 0 or x_coordonate > 7 or y_coordonate < 0 or y_coordonate > 7:
                      "bad input!"
        """
        if x_coordonate < 0 or x_coordonate > 7 or y_coordonate < 0 or y_coordonate > 7:
            raise Exception("bad input!")
    
    def validate_player_move(self, x_coordonate, y_coordonate):
        """
        method that takes 2 coordonates and validates them
        input: x_coordonate - teh x coordonate, y_coordonate - the y coordonate
        output: -
        raises: if x_coordonate < 0 or x_coordonate > 7 or y_coordonate not in 'ABCDEFGH':
                      "bad input!"
        """
        if x_coordonate < 0 or x_coordonate > 7 or y_coordonate not in 'ABCDEFGH':
            raise Exception("bad input!")
