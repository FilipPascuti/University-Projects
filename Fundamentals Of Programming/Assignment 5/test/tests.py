from model.expense import Expense
from test.validations import validate_expense
from repo.repository import repo_add_expense

# def test_created_expense():
#     expense = Expense(25, 233, 'food')
#     assert(expense.get_day() == 25)
#     assert(expense.get_amount_of_money() == 233)
#     assert(expense.get_type() == 'food')

def get_day__expense__value_of_day():
    expense = Expense(25, 233, 'food')
    assert(expense.get_day() == 25)

def get_amount_of_money__expense__value_of_amount_of_money():
    expense = Expense(25, 233, 'food')
    assert(expense.get_amount_of_money() == 233)

def get_type__expense__value_of_type():
    expense = Expense(25, 233, 'food')
    assert(expense.get_type() == 'food')

def validate_expense__good_expense__nothing():
    expense = Expense(25, 233, 'food')
    validate_expense(expense)

def validate_expense__bad_expense__exception():
    expense = Expense(25, 233, 'food')
    validate_expense(expense)
    bad_expense = Expense(6, -5, '')
    try:
        validate_expense(bad_expense)
        assert(False)
    except Exception as ex:
        assert(str(ex) == "invalid amount of money!\ninvalid type!\n")

def repo_add_expense__expense__is_in_the_list():
    list_of_expenses = []
    expense = Expense(5, 35, 'food')
    repo_add_expense(list_of_expenses, expense)
    assert(expense in list_of_expenses)

def repo_add_expense__repeated_expense__exception():
    list_of_expenses = []
    expense = Expense(5, 35, 'food')
    repo_add_expense(list_of_expenses, expense)
    try:
        repo_add_expense(list_of_expenses, expense)
        assert(False)
    except Exception as ex:
        assert(str(ex) == "existing expense!\n")


def run_all_tests():
    get_day__expense__value_of_day()
    get_amount_of_money__expense__value_of_amount_of_money()
    get_type__expense__value_of_type()
    validate_expense__good_expense__nothing()
    validate_expense__bad_expense__exception()
    repo_add_expense__expense__is_in_the_list()
    repo_add_expense__repeated_expense__exception()