from functionalities.functions import add_to_list_of_steps_for_undo, add_to_the_list, insert_into_list, remove_complex_number_from_the_list, replace_complex_number_in_the_list, sum_of_numbers, product_of_numbers, undo, \
    print_functionality_decider_based_on_the_parameters, filter_functionality_decider_based_on_the_parameters
from the_model.model import initial_list
from utilities.parse import parse_the_input
from ui.ui_functions import ui_print_menu, ui_read

from tests.test import run_the_tests, validate_input


def main():
    run_the_tests()
    the_list = initial_list()
    list_of_steps_for_undo = []
    add_to_list_of_steps_for_undo(the_list, list_of_steps_for_undo)
    ui_print_menu()
    commands = {'add':add_to_the_list,
                'insert': insert_into_list,
                'remove':remove_complex_number_from_the_list,
                'replace':replace_complex_number_in_the_list,
                'list': print_functionality_decider_based_on_the_parameters,
                'sum':sum_of_numbers,
                'product':product_of_numbers,
                'filter': filter_functionality_decider_based_on_the_parameters,
                'undo': undo} 
    while True:
        input_data = ui_read()
        complex_number_coordonates, command, integer_numbers, symbol, meaningless_input = parse_the_input(input_data)
        if 'exit' in command:
            return
        elif command[0] in commands:
            try:
                parameters = validate_input(the_list, complex_number_coordonates, command, integer_numbers, symbol, meaningless_input, list_of_steps_for_undo)
                commands[command[0]](the_list, parameters, list_of_steps_for_undo)
            except ValueError as exception:
                print("Invalid command!")
        else:
            print("Invalid command!")

 
main()

