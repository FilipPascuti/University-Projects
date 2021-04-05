def ui_read():
    print("Enter the number n: ")
    input_variable = int(input())
    return input_variable


def ui_print(number):
    print(number)
    return

#The function fibonacci_finder builds in n-th element of the Fibonacci seqence and then checks if it is larger than the given number 
def smallest_fibonacci_number_greater_than():
    number = ui_read()
    possible_solution = 1
    previous_fibonacci_number = 1
    while True:
        if possible_solution > number:
            ui_print(possible_solution)
            break
        else:
            next_fibonacci_number = possible_solution + previous_fibonacci_number
            previous_fibonacci_number = possible_solution
            possible_solution = next_fibonacci_number

smallest_fibonacci_number_greater_than()
