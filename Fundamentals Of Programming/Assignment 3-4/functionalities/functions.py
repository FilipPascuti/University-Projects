import math

from the_model.model import set_new_number, set_element, set_new_list, set_real_part, set_imaginary_part, get_real_part, get_imaginary_part, get_element
from ui.ui_functions import ui_print_number, ui_print


def string_into_integer(the_string):
    '''
    function that converts the_string into an interger
    input: the_string - a string
    output: the_integer - the conversion of the_string into an integer
    '''
    the_integer = int(the_string)
    return the_integer


def convert_complex_number_coordonates_from_string_to_integer(complex_number_coordonates):
    real = get_real_part(complex_number_coordonates)
    real = string_into_integer(real)
    imaginary = get_imaginary_part(complex_number_coordonates)
    imaginary = string_into_integer(imaginary)
    set_real_part(complex_number_coordonates, real)
    set_imaginary_part(complex_number_coordonates, imaginary)
    
# FIRST PART    


def add_to_the_list(the_list, parameters, list_of_steps_for_undo):
    '''
    function that appends the element contained in parameters into the_list
    input: the_list - list of complex numbers parameteres - list that containes the complex number in the elemtent with index = 0, list_of_steps_for_undo - list of the previous states of the_list
    output: -
    '''
    complex_number_coordonates = parameters[0]
    complex_number_coordonates = list(complex_number_coordonates)
    real = get_real_part(complex_number_coordonates)
    imaginary = get_imaginary_part(complex_number_coordonates)
    real = string_into_integer(real)
    imaginary = string_into_integer(imaginary)
    set_real_part(complex_number_coordonates, real)
    set_imaginary_part(complex_number_coordonates, imaginary)
    set_new_number(the_list, real, imaginary)
    add_to_list_of_steps_for_undo(the_list, list_of_steps_for_undo)


def insert_into_list(the_list, parameters, list_of_steps_for_undo):
    '''
    function that inserts a complex number, stored in parameters[0], at the index, stored in parameters[1], in the_list
    input: the_list - list of complex numbers, parameters: list of complex number and the index, list_of_steps_for_undo - list of the previous states of the_list
    output: -
    '''
    complex_number_coordonates = parameters[0]
    complex_number_coordonates = complex_number_coordonates[0]
    integer_numbers = parameters[1]
    complex_number_coordonates = list(complex_number_coordonates)
    real = get_real_part(complex_number_coordonates)
    imaginary = get_imaginary_part(complex_number_coordonates)
    real = string_into_integer(real)
    imaginary = string_into_integer(imaginary)
    set_real_part(complex_number_coordonates, real)
    set_imaginary_part(complex_number_coordonates, imaginary)
    integer_numbers = string_into_integer(integer_numbers[0])
    set_new_number(the_list, 0, 0)
    index = len(the_list) - 1
    while index > integer_numbers:
        set_element(the_list, index, get_element(the_list, index - 1))
        index = index - 1
    set_element(the_list, integer_numbers, complex_number_coordonates)
    add_to_list_of_steps_for_undo(the_list, list_of_steps_for_undo)

# SECOND PART


def remove_complex_number_from_the_list(the_list, parameters, list_of_steps_for_undo):
    integer_numbers = parameters
    if len(integer_numbers) == 1:
     first_position = integer_numbers[0]
     last_position = integer_numbers[0]
    else:
        first_position = integer_numbers[0]
        last_position = integer_numbers[1]
    first_position = string_into_integer(first_position)
    last_position = string_into_integer(last_position)
    while last_position >= first_position:
        the_list.pop(first_position)
        last_position -= 1
    add_to_list_of_steps_for_undo(the_list, list_of_steps_for_undo)


def replace_complex_number_in_the_list(the_list, parameters, list_of_steps_for_undo):
    complex_number_coordonates = parameters
    number_to_replace = complex_number_coordonates[0]
    replacement_number = complex_number_coordonates[1]
    number_to_replace = list(number_to_replace)
    replacement_number = list(replacement_number)
    convert_complex_number_coordonates_from_string_to_integer(number_to_replace)
    convert_complex_number_coordonates_from_string_to_integer(replacement_number)
    for index in range (0, len(the_list)):
        if number_to_replace == get_element(the_list, index):
            set_element(the_list, index, replacement_number)
    add_to_list_of_steps_for_undo(the_list, list_of_steps_for_undo)

# THIRD PART


def print_functionality_decider_based_on_the_parameters(the_list, parameters, list_of_steps_for_undo):
    if parameters == 0:
        ui_print(the_list)
    else:
        symbol = parameters[0]
        symbol = symbol[0]
        if symbol == '<':
            integer_numbers = parameters[1]
            modulo_smaller_than(the_list, integer_numbers)
        elif symbol == '=':
            integer_numbers = parameters[1]
            modulo_equal_to(the_list, integer_numbers) 
        elif symbol == '>':
            integer_numbers = parameters[1]
            modulo_greater_than(the_list, integer_numbers)
        else:
            integer_numbers = parameters
            real_number_verifier(the_list, integer_numbers)


def real_number_verifier(the_list, number_positions):
    first_position = number_positions[0]
    last_position = number_positions[1]
    first_position = string_into_integer(first_position)
    last_position = string_into_integer(last_position)
    for index in range(first_position, last_position + 1):
        if get_imaginary_part(get_element(the_list, index)) == 0:
            ui_print_number(get_element(the_list, index))


def number_modulo(the_list, index):
    complex_number_coordonates = get_element(the_list, index)
    real = get_real_part(complex_number_coordonates)
    imaginary = get_imaginary_part(complex_number_coordonates)
    return math.sqrt(real * real + imaginary * imaginary)


def modulo_equal_to(the_list, integer_numbers):
    number = integer_numbers[0]
    number = string_into_integer(number)
    for index in range(0, len(the_list)):
        modulo = number_modulo(the_list, index)
        if modulo == number:
            ui_print_number(get_element(the_list, index))


def modulo_greater_than(the_list, integer_numbers):
    number = integer_numbers[0]
    number = string_into_integer(number)
    for index in range(0, len(the_list)):
        modulo = number_modulo(the_list, index)
        if modulo > number:
            ui_print_number(get_element(the_list, index))


def modulo_smaller_than(the_list, integer_numbers):
    number = integer_numbers[0]
    number = string_into_integer(number)
    for index in range(0, len(the_list)):
        modulo = number_modulo(the_list, index)
        if modulo < number:
            ui_print_number(get_element(the_list, index))

# FOURTH PART


def product_of_numbers(the_list, parameters, list_of_steps_for_undo):
    number_positions = parameters
    product = [1, 0]
    first_position = number_positions[0]
    last_position = number_positions[1]
    first_position = string_into_integer(first_position)
    last_position = string_into_integer(last_position)
    for index in range (first_position, last_position + 1):
        real_of_product = get_real_part(product)
        imaginary_of_product = get_imaginary_part(product)
        real_number_of_index = get_real_part(get_element(the_list, index))
        imaginary_number_of_index = get_imaginary_part(get_element(the_list, index))  
        product[0] = real_of_product * real_number_of_index - imaginary_of_product * imaginary_number_of_index
        product[1] = real_of_product * imaginary_number_of_index + imaginary_of_product * real_number_of_index
    ui_print_number(product)


def sum_of_numbers(the_list, parameters, list_of_steps_for_undo):
    number_positions = parameters
    sum = [0, 0]
    first_position = number_positions[0]
    last_position = number_positions[1]
    first_position = string_into_integer(first_position)
    last_position = string_into_integer(last_position)
    for index in range (first_position, last_position + 1):
        sum[0] = sum[0] + get_real_part(get_element(the_list, index))
        sum[1] = sum[1] + get_imaginary_part(get_element(the_list, index))
    ui_print_number(sum)

# FIFTH PART


def filter_functionality_decider_based_on_the_parameters(the_list, parameters, list_of_steps_for_undo):
    if parameters == 0:
        filter_keep_real(the_list, list_of_steps_for_undo)
    else:
        symbol = parameters[0]
        symbol = symbol[0]
        if symbol == '<':
            integer_numbers = parameters[1]
            filter_keep_if_modulo_smaller_than(the_list, integer_numbers, list_of_steps_for_undo)
        elif symbol == '>':
            integer_numbers = parameters[1]
            filter_keep_if_modulo_greater_than(the_list, integer_numbers, list_of_steps_for_undo)
        else:
            integer_numbers = parameters[1]
            filter_keep_if_modulo_equal_to(the_list, integer_numbers, list_of_steps_for_undo)


def filter_keep_real(the_list, list_of_steps_for_undo):
    index = 0
    while index < len(the_list):
        if get_imaginary_part(get_element(the_list, index)) != 0:
            the_list.pop(index)
        else:
            index = index + 1   
    add_to_list_of_steps_for_undo(the_list, list_of_steps_for_undo)


def filter_keep_if_modulo_equal_to(the_list, integer_numbers, list_of_steps_for_undo):
    number = integer_numbers[0]
    number = string_into_integer(number)
    index = 0
    while index < len(the_list):
        modulo = number_modulo(the_list, index)    
        if modulo == number:
            the_list.pop(index)
        else:
            index = index + 1  
    add_to_list_of_steps_for_undo(the_list, list_of_steps_for_undo)


def filter_keep_if_modulo_greater_than(the_list, integer_numbers, list_of_steps_for_undo):
    number = integer_numbers[0]
    number = string_into_integer(number)
    index = 0
    while index < len(the_list):
        modulo = number_modulo(the_list, index)    
        if modulo < number:
            the_list.pop(index)
        else:
            index = index + 1  
    add_to_list_of_steps_for_undo(the_list, list_of_steps_for_undo)


def filter_keep_if_modulo_smaller_than(the_list, integer_numbers, list_of_steps_for_undo):
    number = integer_numbers[0]
    number = string_into_integer(number)
    index = 0
    while index < len(the_list):
        modulo = number_modulo(the_list, index)    
        if modulo > number:
            the_list.pop(index)
        else:
            index = index + 1  
    add_to_list_of_steps_for_undo(the_list, list_of_steps_for_undo)

# SIXTH PART


import copy


def add_to_list_of_steps_for_undo(the_list, list_of_steps_for_undo):
    '''
    funtion that appends the_list to list_of_steps_for_undo
    input: the_list - list of complex numbers, list_of_steps_for_undo - the list of privios states of the_list
    output: -
    '''
    new_list = copy.deepcopy(the_list)
    list_of_steps_for_undo = set_new_list(list_of_steps_for_undo, new_list)


def move_to_previous_state_of_the_list(the_list, list_of_steps_for_undo):
    list_of_steps_for_undo.pop(len(list_of_steps_for_undo) - 1)
    the_list = list_of_steps_for_undo[len(list_of_steps_for_undo) - 1]
    return the_list


def undo(the_list, parameters, list_of_steps_for_undo):
    the_list.clear() 
    previous_list = move_to_previous_state_of_the_list(the_list, list_of_steps_for_undo)
    for index in range(0, len(previous_list)):
        set_new_number(the_list, get_real_part(get_element(previous_list, index)), get_imaginary_part(get_element(previous_list, index)))
