

def set_new_number(the_list, real, imaginary):
    complex_number_coordonates = []
    complex_number_coordonates.append(real)
    complex_number_coordonates.append(imaginary)
    the_list.append(complex_number_coordonates)


def set_element(the_list, index, value):
    the_list[index] = value


def set_new_list(list_of_steps, the_list):
    list_of_steps.append(the_list)


def set_real_part(complex_number_coordonates, real):
    complex_number_coordonates[0] = real


def set_imaginary_part(complex_number_coordonates, imaginary):
    complex_number_coordonates[1] = imaginary


def get_real_part(complex_number_coordonates):
    return complex_number_coordonates[0]


def get_imaginary_part(complex_number_coordonates):
    return complex_number_coordonates[1]


def get_element(the_list, index):
    return the_list[index]


def initial_list():
    the_list = []
    set_new_number(the_list, 1, 2)
    set_new_number(the_list, 2, 3)
    set_new_number(the_list, 2, 0)
    set_new_number(the_list, 3, 0)
    set_new_number(the_list, 4, 3)
    set_new_number(the_list, 7, 3)
    set_new_number(the_list, 2, 3)
    set_new_number(the_list, 9, 3)
    set_new_number(the_list, 10, 23)
    set_new_number(the_list, 15, 22)
    return the_list
