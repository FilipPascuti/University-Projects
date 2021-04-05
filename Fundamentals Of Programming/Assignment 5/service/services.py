from model.expense import Expense
from test.validations import validate_expense, validate_minimum_value, validate_undo
from repo.repository import repo_add_expense, repo_filter_list_of_expenses, repo_undo, initial_list


class Service:
    def __init__(self):
        pass

    def service_add_expense(self, day, amount_of_money, the_type, list_of_expenses):
        expense = Expense(day, amount_of_money, the_type)
        validate_expense(expense)
        repo_add_expense(list_of_expenses, expense)

    def service_filter_list_of_expenses(self, list_of_expenses, minimum_value):
        validate_minimum_value(minimum_value)
        list_of_expenses = repo_filter_list_of_expenses(list_of_expenses, minimum_value)

    def service_for_undo(self, list_for_undo, list_of_expenses):
        validate_undo(list_for_undo)
        list_of_expenses = repo_undo(list_for_undo, list_of_expenses)

    def initiate_list(self):
        return initial_list()