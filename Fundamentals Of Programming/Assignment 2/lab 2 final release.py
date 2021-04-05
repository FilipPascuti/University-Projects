def ui_read_real():
    real = float(input("Enter the real part >"))
    return real


def ui_read_imaginary():
    imaginary = float(input("Enter the imaginary part >"))
    return imaginary


def set_real_part(number_coordonates, real_part):
    number_coordonates.append(real_part)
    return number_coordonates


def set_imaginary_part(number_coordonates, imaginary):
    number_coordonates.append(imaginary) 
    return number_coordonates


def initiate_list():
    the_list = []
    the_list.append(initial_complex_number_coordonates_list(1.2,0.3))
    the_list.append(initial_complex_number_coordonates_list(2.0,3.0))
    the_list.append(initial_complex_number_coordonates_list(2.0,3.0))
    the_list.append(initial_complex_number_coordonates_list(2.0,3.0))
    the_list.append(initial_complex_number_coordonates_list(2.0,0))
    the_list.append(initial_complex_number_coordonates_list(3.0,2.0))
    the_list.append(initial_complex_number_coordonates_list(5.0,0.5))
    the_list.append(initial_complex_number_coordonates_list(7.0,1.5))
    the_list.append(initial_complex_number_coordonates_list(1.0,2.0))
    the_list.append(initial_complex_number_coordonates_list(4.0,0.8))
    return the_list


def initial_complex_number_coordonates_list(real, imaginary):
    number_coordonates = [] 
    set_real_part(number_coordonates, real)
    set_imaginary_part(number_coordonates, imaginary)
    return number_coordonates

def create_number_coordonates_list_for_appending():
    number_coordonates = []
    real = ui_read_real()
    imaginary = ui_read_imaginary()
    set_real_part(number_coordonates, real)
    set_imaginary_part(number_coordonates, imaginary)
    return number_coordonates


def add_to_list(the_list):
    the_list.append(create_number_coordonates_list_for_appending())
    return


#TODO make it look nicer


def ui_print(the_list):
    for i in the_list:
        print("z =", get_real_part(i), " + i * ", get_imaginary_part(i))
        print()


def get_imaginary_part(number_coordonates):
    return number_coordonates[1]


def get_real_part(number_coordonates):
    return number_coordonates[0]


def get_complex(the_list, index):
    return the_list[index]


def longest_strictly_increasing_real_part_sequence(the_list):
    max_lenght = 1
    beggining_index = 0
    for i in range (0, len(the_list) - 1):
        current_lenght = 1    
        index = i
        while index < len(the_list) - 1 and get_real_part(get_complex(the_list, index)) < get_real_part(the_list[index+1]):
            current_lenght +=1
            index +=1
        if max_lenght < current_lenght:
            max_lenght = current_lenght
            beggining_index = i
    return beggining_index, max_lenght


def ui_print_sequence_first_assignment(the_list):
    beggining_index, max_lenght= longest_strictly_increasing_real_part_sequence(the_list)
    print(the_list[beggining_index : beggining_index + max_lenght])


def ui_print_sequence_second_assignment(the_list):
    beggining_index, max_lenght= longest_3_distinct_values_sequence(the_list)
    print(the_list[beggining_index : beggining_index + max_lenght])


def longest_3_distinct_values_sequence(the_list):
    max_lenght = 1
    beggining_index = 0
    for i in range (0, len(the_list) - 1):
        current_lenght = 1    
        index = i
        different_values = []
        different_values.append(get_complex(the_list, index))
        while index < len(the_list) - 1 and len(different_values)<4:
            current_lenght +=1
            index +=1
            if get_complex(the_list, index) not in different_values:
                different_values.append(get_complex(the_list, index))
        if max_lenght < current_lenght:
            max_lenght = current_lenght
            beggining_index = i    
    # Now I have to check if the smallest sequence is till the end of the list
    i = len(the_list) - 1
    different_values = []
    different_values.append(get_complex(the_list, index))
    current_lenght = 1 
    while i > 0 and len(different_values)<4:
        i -= 1
        current_lenght += 1
        if get_complex(the_list, i) not in different_values:
            different_values.append(get_complex(the_list, i)) 
    if current_lenght > max_lenght:
        max_lenght = current_lenght
        beggining_index = i + 1
    max_lenght -= 1
    return beggining_index, max_lenght


def print_sequence_menu():
    print("1. Numbers with a strictly increasing real part. \n2. Contains at most 3 distinct values \nTo choose write 1 or 2 in the console \n" )
    return


def sequence_menu(the_list):
    print_sequence_menu()
    command = input()
    if command == 'exit':
        return
    if command == '1':
        ui_print_sequence_first_assignment(the_list)
    elif command == '2':
        ui_print_sequence_second_assignment(the_list)
    else:
        print("Invalid command!")


def print_menu():
    print("1. Reading a list of complex numbers")
    print("2. Displaying the list of complex numbers")
    print("3. Displaying on the console the longest sequence that observes a given property")
    print("4. Exit")
    return


def start():
    initial_list = initiate_list()
    commands_dict = {'1': add_to_list, '2': ui_print, '3':sequence_menu}
    while True:
        print_menu()
        command = input()
        if command == '4':
            return  
        if command in commands_dict:
            commands_dict[command](initial_list)
        else:
            print("Invalid command!")


start()