from test.tests import run_all_tests
from test.validations import validate_expense
from model.expense import Expense
from ui.ui import Console
from service.services import Service

def main():
    run_all_tests()
    service = Service()
    console = Console(service)
    console.run()
main()