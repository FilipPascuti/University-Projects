from service.services import Service
from model.expense import Expense, add_to_the_list_for_undo


class Console:
    def __init__(self, service):
        self._service = service
    
    def print_menu(self):
        print("1. Add a new expense.\n2. Show the list of expenses.\n3. Filter the list so that it contains only expenses above a certain value.\n4. Undo the last operation.\n")    

    def read_numerical(self, message, function):
        number = input(message)
        while True:
            try:
                number = function(number)
                return number
            except Exception as ex:
                print("invalid numerical value!please reinsert:")
                number = input()

    def ui_add(self, list_of_expenses, list_for_undo):
        day = self.read_numerical("Insert day:\n", int)
        amount_of_money = self.read_numerical("Insert amount of money:\n", float)
        the_type = input("Insert the type:\n")
        try:
            self._service.service_add_expense(day, amount_of_money, the_type, list_of_expenses)
            add_to_the_list_for_undo(list_for_undo, list_of_expenses)
        except Exception as ex:
            print(ex)
            print("Please reinsert expense:")
            self.ui_add(list_of_expenses, list_for_undo)


    def ui_print(self, list_of_expenses, list_for_undo):
        for index in range(len(list_of_expenses)):
            print("day: " + str(list_of_expenses[index].get_day()) + ", amount of money: " + str(list_of_expenses[index].get_amount_of_money()) + ", type: " + str(list_of_expenses[index].get_type()) + "\n")
    

    def ui_filter(self, list_of_expenses, list_for_undo):
        minimum_value = self.read_numerical("insert the minimum value:\n", float)
        try:
            self._service.service_filter_list_of_expenses(list_of_expenses, minimum_value)
            add_to_the_list_for_undo(list_for_undo, list_of_expenses)
        except Exception as ex:
            print(ex)
            self.ui_filter(list_of_expenses, list_for_undo)

    def ui_undo(self, list_of_expenses, list_for_undo):
        try:
            self._service.service_for_undo(list_for_undo, list_of_expenses)
        except Exception as ex:
            print(ex)
        

    def run(self):
        list_of_expenses = self._service.initiate_list()
        list_for_undo = []
        add_to_the_list_for_undo(list_for_undo, list_of_expenses)
        self.print_menu()
        commands_dictionary = {"1": self.ui_add,
                         "2": self.ui_print,
                         "3": self.ui_filter,
                         "4": self.ui_undo}
        while True:
            command = input(">>>")
            if command == 'x':
                return
            elif command in commands_dictionary:
                commands_dictionary[command](list_of_expenses, list_for_undo)
            else:
                print("invalid command!")

