from domain.entities import Table
from service.services import Player_service, Computer_service
from validations.validator import Validator
from presentation.ui import Console


def main():
    player_table = Table()
    computer_table = Table()
    
    table_validator = Validator()
    
    service_player = Player_service(table_validator, player_table)
    service_computer = Computer_service(table_validator, computer_table)
    
    console = Console(service_player, service_computer)

    console.run()


main()
