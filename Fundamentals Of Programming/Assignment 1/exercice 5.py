def ui_read():
   print("Enter the number n: ")
   number = int(input())
   return number


#The function prime_number_validator is verifing if the parameter is prime or not 
def prime_number_validator(number):
   for i in range(2, number//2 + 1):  
      if number % i == 0:
         return False
   return True 


#The function prime_number_search_smaller_than is seaching for the smallest prime number smaller than the parameter
def prime_number_search_smaller_than():
  number = ui_read()
  potencial_solution = number - 1
  while True:    
      if prime_number_validator(potencial_solution) == False:
         potencial_solution = potencial_solution - 1
      else:
         return potencial_solution, number


#Verifies if there is any prime number smaller than n
def virifies_that_there_is_a_smaller_prime():
   solution, number = prime_number_search_smaller_than()
   if( solution == 1):
         print("There is no prime number smaller than", number)
   else:
      print(solution)

virifies_that_there_is_a_smaller_prime()     
#prime_number_search_smaller_than()