from model.expense import Expense


def set_new_element(list_of_expenses, day, amount_of_money, the_type):
    expense = Expense(day, amount_of_money, the_type)
    list_of_expenses.append(expense)


def initial_list():
    list_of_expenses = []
    set_new_element(list_of_expenses, 5, 100, 'food')
    set_new_element(list_of_expenses, 7, 20, 'internet')
    set_new_element(list_of_expenses, 3, 34, 'housekeeping')
    set_new_element(list_of_expenses, 12, 88, 'food')
    set_new_element(list_of_expenses, 26, 57, 'transport')
    set_new_element(list_of_expenses, 30, 63, 'transport')
    set_new_element(list_of_expenses, 8, 645, 'housekeeping')
    set_new_element(list_of_expenses, 7, 20, 'internet')
    set_new_element(list_of_expenses, 9, 43, 'food')
    set_new_element(list_of_expenses, 23, 54, 'housekeeping')
    return list_of_expenses


def repo_add_expense(list_of_expenses, expense_being_added):
    for expense in list_of_expenses:
        if expense == expense_being_added:
            raise Exception("existing expense!\n")
    list_of_expenses.append(expense_being_added)


def repo_filter_list_of_expenses(list_of_expenses, minimum_value):
    index = 0
    while index < len(list_of_expenses):
        if list_of_expenses[index].get_amount_of_money() <= minimum_value:
            list_of_expenses.pop(index)
        else:
            index += 1
    return list_of_expenses


def repo_undo(list_for_undo, list_of_expenses):
    list_for_undo.pop(len(list_for_undo) - 1)
    intermediary_list = list_for_undo[len(list_for_undo) - 1]
    list_of_expenses.clear()
    for index in range(len(intermediary_list)):
        list_of_expenses.append(intermediary_list[index])
    return list_of_expenses