from model.expense import Expense


def validate_expense(expense):
    # function that checks the validity of the information regarding the expense's day, amount of money and type with respect to the given problem
    # input: expense - an expense
    # output: -, when the day, amount_of_money and type of the given expense are valid
    # raises: Exception
    #    if day <0 or day > 30 ->"invalid day!\n"
    #    if amount_of_money < 0 -> "invalid amount of money!\n"
    #    if type is empty ->"invalid type!\n"
    errors = ""
    if expense.get_day() < 1 or expense.get_day() > 30:
        errors += "invalid day!\n"
    if expense.get_amount_of_money() < 0:
        errors += "invalid amount of money!\n"
    if expense.get_type() == '':
        errors += "invalid type!\n"
    if len(errors) > 0:
        raise Exception(errors)

def validate_minimum_value(minimum_value):
    """
    function that checks if the minimun_value is greater than 0
    input: minimum_value - the minimum value that an expense can have
    output: -
    raises: Exception
        if minimun_value < 0 -> "invalid value" 
    """
    if minimum_value < 0:
        raise Exception("invalid value")

def validate_undo(list_for_undo):
    if len(list_for_undo) < 2:
        raise Exception("no more undos!")