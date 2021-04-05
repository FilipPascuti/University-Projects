

def ui_read():
    input_data = input("Type in the command:")
    return input_data


def ui_print_menu():
    print("Commands:\nAdd numbers to the list: \nadd <number>\ninsert <number> at <position>\n\nModify elements from the list:\nremove <position>\nremove <start position> to <end position>\nreplace <old number> with <new number>\n\nWrite numbers having different properties:list\nlist real <start position> to <end position>\nlist modulo [ < | = | > ] <number>")


def ui_print(value):
    print(value)


def ui_print_number(number_coordonates):
    print(number_coordonates)
