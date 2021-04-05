import math 


def ui_read():
    print("Enter the number n:")
    input_variable = int(input())
    return input_variable


def ui_print(number):
    print(number)
    return


#The function prime_number_validator is verifing if the parameter is a prime number
def prime_number_validator(number):
   for i in range(2, int(math.sqrt(number)) + 1):  
      if number % i == 0:
         return False
   return True 


#The function the_n_th_element_of_the_sequence is subtracting the number of elements of the sequence from the given number and at the same time saves the value of the current element in the sequence. Everything being done without memorasing the elements of the sequence.
def the_n_th_element_of_the_sequence():
    index_of_element_wanted = ui_read()
    current_number = 2
    index_of_element_wanted = index_of_element_wanted - 1
    posible_solution = 1  
    while index_of_element_wanted > 0:
        if prime_number_validator(current_number) == True:
            index_of_element_wanted = index_of_element_wanted - 1
            posible_solution = current_number
        else:
            for i in range(2, current_number // 2 + 1):
                if current_number % i == 0 and prime_number_validator(i) == True and index_of_element_wanted > 0:
                    index_of_element_wanted = index_of_element_wanted - i
                    posible_solution = i
        current_number = current_number + 1
    return posible_solution
    
ui_print(the_n_th_element_of_the_sequence())
