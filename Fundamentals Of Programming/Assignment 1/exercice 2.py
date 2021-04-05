n = int(input())
def primegenerator(n):
    primes = []
    for i in range(2,n):
        prime = True
        for a in range(2,i//2+1):
            if i % a == 0:
                prime = False
        if prime == True:
            primes.append(i)    
    return primes

primes = primegenerator(n)
pairs = []

for prime1 in primes:
    for prime2 in primes:
        if prime1 + prime2 == n and [prime1,prime2] not in pairs and [prime2,prime1] not in pairs:
            print(prime1, prime2)
            pairs.append([prime1, prime2])
