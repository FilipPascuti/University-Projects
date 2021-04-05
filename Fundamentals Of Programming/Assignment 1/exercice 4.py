n = int(input())

digitlist = []

while n > 0:
    digitlist.append(n%10)
    n= n // 10

lenght = len(digitlist)

for i in range(0, lenght):
    for j in range(0, lenght):
        if(digitlist[i] > digitlist[j]):
            auxiliary = digitlist[i]
            digitlist[i] = digitlist[j]
            digitlist[j] = auxiliary

m = 0

for i in range(0,  lenght):
    m = m * 10 + digitlist[i]

print(m)
