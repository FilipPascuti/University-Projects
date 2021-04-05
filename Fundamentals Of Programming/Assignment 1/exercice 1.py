MainVariable = input()
PotencialPrime = int(MainVariable)
PotencialPrime = PotencialPrime + 1

while True:   
   Validator = 1
   for i in range(2, PotencialPrime//2 + 1):  
      if (PotencialPrime % i) == 0:
         Validator= 0 
         break
   if Validator==0:
      PotencialPrime = PotencialPrime + 1
   else:
      print(PotencialPrime)
      break  
