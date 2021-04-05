import unittest
from validations.validator import Validator
from domain.entities import Table
from service.services import Player_service


class Test_validator(unittest.TestCase):
    
    def test_validate_add__good_values__no_exception(self):
        validator = Validator()
        validator.validate_add(1, 1, 'N', 'battleship')

    def test_validate_add__bad_values__does_not_fit_exception(self):
        validator = Validator()
        try:
            validator.validate_add(1, 1, 'S', 'battleship')
            assert False
        except Exception as ex:
            self.assertEqual(str(ex), "does not fit!")
    
    def test_validate_add__bad_values__invalid_orientation_exception(self):
        validator = Validator()
        try:
            validator.validate_add(1, 1, 'f', 'battleship')
            assert False
        except Exception as ex:
            self.assertEqual(str(ex), "invalid orientation\n")

    def test_validate_computer_move__bad_input__raise_exception(self):
        validator = Validator()
        try:
            validator.validate_computer_move(-1, 9)
            assert False
        except Exception as ex:
            self.assertEqual(str(ex), "bad input!")
    
    def test_validate_computer_move__good_input__no_exception(self):
        validator = Validator()    
        validator.validate_computer_move(2, 3)
    
    def test_validate_player_move__good_input__no_exception(self):
        validator = Validator()
        validator.validate_player_move(1, 'A')
        
    def test_validate_player_move__bad_input__raises_exception(self):
        validator = Validator()
        try:
            validator.validate_player_move(-1, 9)
            assert False
        except Exception as ex:
            self.assertEqual(str(ex), "bad input!")


class Test_table(unittest.TestCase):
    
    def test_move__coordonates_for_missed_move__changed_hit_matrix(self):
        table = Table()
        table.move(0, 0)
        self.assertEqual(table.get_hit_matrix()[0][0], '*')
        
    def test__move__coordonates_for_good_move__changed_matrix(self):
        table = Table()
        table.add_ship(1, 1, 'N', 'cruiser')
        table.move(1, 1)
        self.assertEqual(table.get_matrix()[1][1], '2')
    
    def test__move__coordonates_for_good_move__changed_hit_matrix(self):
        table = Table()
        table.add_ship(1, 1, 'N', 'cruiser')
        table.move(1, 1)
        self.assertEqual(table.get_hit_matrix()[1][1], 'x')
        
    def test__add_shit__1_1_W_destroyer__changed_matrix(self):
        table = Table()
        table.add_ship(1, 1, 'W', 'destroyer')
        self.assertEqual(table.get_matrix()[1][1:3], ['1', '1'])

        
class Test_player_service(unittest.TestCase):

    def test_check_if_computer_won__table_without_ships__True(self):
        validator = Validator()
        table = Table()
        service = Player_service(validator, table)
        self.assertEqual(service.check_if_computer_won(), True)
    
    def test_check_if_computer_won__table_with_ships__False(self):
        validator = Validator()
        table = Table()
        table.add_ship(1, 1, 'N', 'cruiser')
        service = Player_service(validator, table)
        self.assertEqual(service.check_if_computer_won(), False)
