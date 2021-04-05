class Expense:

    def __init__(self, day, amount_of_money, the_type):
        self._day = day
        self._amount_of_money = amount_of_money
        self._type = the_type

    def get_day(self):
        return self._day
    
    def get_amount_of_money(self):
        return self._amount_of_money
    
    def get_type(self):
        return self._type

    def __eq__(self, other_expense):
        if self.get_day() == other_expense.get_day() and self.get_amount_of_money() == other_expense.get_amount_of_money() and self.get_type() == other_expense.get_type():
            return True
        else:
            return False
    
import copy

def add_to_the_list_for_undo(list_for_undo, list_of_expenses):
    new_list = copy.deepcopy(list_of_expenses)
    list_for_undo.append(new_list)