from functionalities.functions import add_to_the_list, add_to_list_of_steps_for_undo, insert_into_list, string_into_integer
from the_model.model import initial_list


def add_to_the_list__complex_number__complex_number_at_last_position():
    the_list = initial_list()
    add_to_the_list(the_list, [(2, 2)], [])
    assert(the_list[len(the_list) - 1] == [2, 2])


def add_to_list_of_steps_for_undo__the_list__the_list_at_last_position():
    the_list = initial_list()
    list_of_steps_for_undo = []
    add_to_list_of_steps_for_undo(the_list, list_of_steps_for_undo)
    assert(list_of_steps_for_undo[len(list_of_steps_for_undo) - 1 ] == the_list)
    

def insert_into_list_the_list__complex_number_and_the_position__complex_number_at_the_positoin():
    the_list = initial_list()
    insert_into_list(the_list, [[('2', '2')], '0'] , [])
    assert(the_list[0] == [2, 2])


def string_to_integer_string_integer():
    assert(string_into_integer('2') == int('2'))

    
def run_the_tests():
    add_to_the_list__complex_number__complex_number_at_last_position()
    add_to_list_of_steps_for_undo__the_list__the_list_at_last_position()
    insert_into_list_the_list__complex_number_and_the_position__complex_number_at_the_positoin()
    string_to_integer_string_integer()


def validate_input(the_list, complex_number_coordonates, command, integer_numbers, symbol, meaningless_input, list_of_steps_for_undo):
    """
    function that return the information needed for each type of functionality if it is valid
    input:  the_list - list of complex numbers 
            complex_number_coordonates - the list of tuples that contain the coordonates of the complex numbers entered by the user
            command - the list of words entered by the user
            integer_numbers - positive interger numbers entered by the user 
            symbol - a list of "<" or "=" or ">" entered by the user 
            meaningless_input - contains any caracter that is not in the previous lists entered by the user
    output: a tuple of the parameters needed for each specific functionality
    reases: ValueError if the input doesn't match with any functionality
    """
    if 'add' in command and len(complex_number_coordonates) == 1 and len(command) == 2 and len(integer_numbers) == 0 and len(symbol) == 0 and len(meaningless_input) == 0:
        return complex_number_coordonates
    elif 'insert' in command and 'at' in command and len(complex_number_coordonates) == 1 and len(command) == 3 and len(integer_numbers) == 1 and len(symbol) == 0 and len(meaningless_input) == 0:
        last_position = integer_numbers[0]
        last_position = string_into_integer(last_position)
        if last_position < len(the_list):
            return  complex_number_coordonates, integer_numbers
        else:
            raise ValueError('invalid command!')
    elif ('remove' in command and len(complex_number_coordonates) == 0 and len(command) == 1 and len(integer_numbers) == 1 and len(symbol) == 0 and len(meaningless_input) == 0) or ('remove' in command and 'to' in command and len(complex_number_coordonates) == 0 and len(command) == 2 and len(integer_numbers) == 2 and len(symbol) == 0 and len(meaningless_input) == 0):
        if len(integer_numbers) == 1:
            last_position = integer_numbers[0]
        else:
            last_position = integer_numbers[1]
        last_position = string_into_integer(last_position)
        if last_position < len(the_list):
            return integer_numbers 
        else:
            raise ValueError('invalid command!')
    elif 'replace' in command and 'with' in command and len(complex_number_coordonates) == 2 and len(command) == 4 and len(integer_numbers) == 0 and len(symbol) == 0 and len(meaningless_input) == 0:
        return complex_number_coordonates
    elif 'list' in command :
        if len(complex_number_coordonates) == 0 and len(command) == 1 and len(integer_numbers) == 0 and len(symbol) == 0 and len(meaningless_input) == 0:
            return 0
        elif 'real' in command and 'to' in command and len(complex_number_coordonates) == 0 and len(command) == 3 and len(integer_numbers) == 2 and len(symbol) == 0 and len(meaningless_input) == 0:
            last_position = integer_numbers[1]
            last_position = string_into_integer(last_position)
            if last_position < len(the_list):
                return integer_numbers 
            else:
                raise ValueError('invalid command!')
        elif 'modulo' in command and len(complex_number_coordonates) == 0 and len(command) == 2 and len(integer_numbers) == 1 and len(symbol) == 1 and len(meaningless_input) == 0:
            if '=' in symbol:
                return symbol, integer_numbers
            elif '>' in symbol:
                return symbol, integer_numbers
            elif '<' in symbol:
                return symbol, integer_numbers
        else:
            raise ValueError('invalid command!')
    # FOURTH PART
    elif 'sum' in command and 'to' in command and len(complex_number_coordonates) == 0 and len(command) == 2 and len(integer_numbers) == 2 and len(symbol) == 0 and len(meaningless_input) == 0:
        last_position = integer_numbers[1]
        last_position = string_into_integer(last_position)
        if last_position < len(the_list):
            return integer_numbers 
        else:
            raise ValueError('invalid command!')
    elif 'product' in command and 'to' in command and len(complex_number_coordonates) == 0 and len(command) == 2 and len(integer_numbers) == 2 and len(symbol) == 0 and len(meaningless_input) == 0:
        last_position = integer_numbers[1]
        last_position = string_into_integer(last_position)
        if last_position < len(the_list):
            return integer_numbers 
        else:
            raise ValueError('invalid command!')
    # FIFTH PART
    elif 'filter' in command and len(command) == 2 and len(meaningless_input) == 0  :
        if 'real' in command and len(complex_number_coordonates) == 0 and len(integer_numbers) == 0:
            return 0
        elif 'modulo' in command and len(complex_number_coordonates) == 0 and len(command) == 2 and len(integer_numbers) == 1 and len(symbol) == 1 and len(meaningless_input) == 0:
            if '=' in symbol:
                return symbol, integer_numbers
            elif '>' in symbol:
                return symbol, integer_numbers
            elif '<' in symbol:
                return symbol, integer_numbers
        else:
            raise ValueError("Invalid command!")
    # SIXTH PART
    elif 'undo' in command and len(list_of_steps_for_undo) > 1 and len(complex_number_coordonates) == 0 and len(command) == 1 and len(integer_numbers) == 0 and len(symbol) == 0 and len(meaningless_input) == 0:
        return 0
    else:
        raise ValueError("Invalid command!")