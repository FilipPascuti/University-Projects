# def initiate_list():
#     the_list = []
#     the_list.append(initial_complex_number_coordonates_list(1.2,0.3))
#     the_list.append(initial_complex_number_coordonates_list(2.0,3.0))
#     the_list.append(initial_complex_number_coordonates_list(2.0,3.0))
#     the_list.append(initial_complex_number_coordonates_list(2.0,3.0))
#     the_list.append(initial_complex_number_coordonates_list(2.0,0))
#     the_list.append(initial_complex_number_coordonates_list(4.0,0.8))
#     the_list.append(initial_complex_number_coordonates_list(6.0,1.5))
#     the_list.append(initial_complex_number_coordonates_list(6.0,1.5))
#     the_list.append(initial_complex_number_coordonates_list(2.0,3.0))
#     the_list.append(initial_complex_number_coordonates_list(6.0,1.5))
#     the_list.append(initial_complex_number_coordonates_list(6.0,1.5))
#     the_list.append(initial_complex_number_coordonates_list(4.0,0.7))
#     the_list.append(initial_complex_number_coordonates_list(4.0,0.7))
#     the_list.append(initial_complex_number_coordonates_list(3.0,2.0))
#     the_list.append(initial_complex_number_coordonates_list(5.0,0.5))
#     the_list.append(initial_complex_number_coordonates_list(6.0,1.5))
#     the_list.append(initial_complex_number_coordonates_list(1.0,2.0))
#     return the_list


# def initial_complex_number_coordonates_list(real, imaginary):
#     number_coordonates = [] 
#     set_real_part(number_coordonates, real)
#     set_imaginary_part(number_coordonates, imaginary)
#     return number_coordonates


# def set_real_part(number_coordonates, real_part):
#     number_coordonates.append(real_part)
#     return number_coordonates


# def set_imaginary_part(number_coordonates, imaginary):
#     number_coordonates.append(imaginary) 
#     return number_coordonates



# def get_complex(the_list, index):
#     return the_list[index]


# def longest_3_distinct_values_sequence(the_list):
#     max_lenght = 1
#     beggining_index = 0
#     for i in range (0, len(the_list) - 1):
#         current_lenght = 1    
#         index = i
#         different_values = []
#         different_values.append(get_complex(the_list, index))
#         while index < len(the_list) - 1 and len(different_values)<4:
#             current_lenght +=1
#             index +=1
#             if get_complex(the_list, index) not in different_values:
#                 different_values.append(get_complex(the_list, index))
#         if max_lenght < current_lenght:
#             max_lenght = current_lenght
#             beggining_index = i    
#     i = len(the_list) - 1
#     different_values = []
#     different_values.append(get_complex(the_list, index))
#     current_lenght = 1 
#     while i > 0 and len(different_values)<4:
#         i -= 1
#         current_lenght += 1
#         if get_complex(the_list, i) not in different_values:
#             different_values.append(get_complex(the_list, i)) 
#     if current_lenght > max_lenght:
#         max_lenght = current_lenght
#         beggining_index = i + 1
#     max_lenght -= 1
#     return beggining_index, max_lenght


# the_list = initiate_list() 
# def ui_print_sequence_second_assignment(the_list):
#     beggining_index, max_lenght= longest_3_distinct_values_sequence(the_list)
#     print(the_list[beggining_index : beggining_index + max_lenght])

# ui_print_sequence_second_assignment(the_list)