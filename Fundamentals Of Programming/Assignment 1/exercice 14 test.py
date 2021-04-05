import math 
#The function prime_validator is verifing if the parameter is a prime number
def prime_validator(function_variable):
   for i in range(2, int(math.sqrt(function_variable)) + 1):  
      if function_variable % i == 0:
         return False
   return True 

def main(MainVariable):
    Counter = 2
    MainVariable = MainVariable - 1
    Solution = 1  
    while MainVariable > 0:
        NumberHolder = Counter
        if prime_validator(NumberHolder) == True:
            MainVariable = MainVariable - 1
            Solution = NumberHolder
        else:
            for i in range(2, NumberHolder // 2 + 1):
                if NumberHolder % i == 0 and MainVariable > 0:
                    MainVariable = MainVariable - i
                    Solution = i
                    while NumberHolder % i == 0:
                        NumberHolder = NumberHolder / i 
        Counter = Counter + 1
    return Solution
    
print("Enter the number n:")
MainVariable = int(input())
print(main(MainVariable))
