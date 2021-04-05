import re


def parse_the_input(command):
    """
    the function that split the input data(command) into different lists containing different types of information 
    input: command - the input data
    output: complex_number_coordonates_matches - the list of tuples that contain the coordonates of the complex numbers found in command
            command_matches - the list of words found in command (command_matches[0] should be a key from the commands dictionary)
            integer_numbers_matches - positive interger numbers found in the command
            symbol_matches - a list of "<", "=", ">" found in command 
            meaningless_input_matches - contains any caracter that is not in the previous lists
    """
    command = command + ' '
    pattern_complex_complex_number_coordonatess = re.compile(r'(-\d+|\d+)(\+\d+|-\d+)i')
    pattern_command = re.compile(r'([a-zA-z]+)')
    pattern_integer_numbers_matches = re.compile(r' (\d+) ')
    pattern_for_symbol_matchess = re.compile(r'[<=>]')
    pattern_for_meaningless_input_matches = re.compile(r'[^a-zA-z0-9 +-<=>]|/')
    meaningless_input_matches = pattern_for_meaningless_input_matches.findall(command)
    symbol_matches = pattern_for_symbol_matchess.findall(command)
    complex_number_coordonates_matches = pattern_complex_complex_number_coordonatess.findall(command)
    command_matches = pattern_command.findall(command)
    integer_numbers_matches = pattern_integer_numbers_matches.findall(command)
    print(complex_number_coordonates_matches, command_matches, integer_numbers_matches, symbol_matches, meaningless_input_matches)
    return complex_number_coordonates_matches, command_matches, integer_numbers_matches, symbol_matches, meaningless_input_matches
