def ui_read()
    print("Enter the number n: ")
    input_variable = int(input())
    return input_variable

#The primegenerator is generatings a list of all the prime numbers smaller than the FunctionVariable
def primegenerator(FunctionVariable):
    primes = []
    for i in range(2,FunctionVariable + 1):
        prime = True
        for a in range(2,i//2+1):
            if i % a == 0:
                prime = False
        if prime == True:
            primes.append(i)    
    return primes

#The function sequence_follower is subtracting the number of elements of the sequence from the given number and at the same time saves the value of the current element in the sequence. Everything being done without memorasing the elements of the sequence.
def sequence_follower(MainVariable): 
    
    primes = primegenerator(MainVariable)
    MainVariable = MainVariable - 1
    NumberHolder = 2 
    Solution = 1
    while MainVariable > 0:
        for i in primes:
            if i <= NumberHolder and NumberHolder % i == 0 and MainVariable > 0:
                if i == NumberHolder:
                    Solution = i
                    MainVariable = MainVariable - 1
                else:
                    MainVariable = MainVariable - i
                    Solution = i
        NumberHolder = NumberHolder + 1
    return Solution

print(sequence_follower(MainVariable))
