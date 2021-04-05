# def consistent(candidate_solution, the_list):
#     if len(candidate_solution) < 2:
#         return True
#     if candidate_solution[-1] <= candidate_solution[-2]:
#         return False
    
#     if len(candidate_solution) >=3:     
#         return colinear( the_list[candidate_solution[-1]], the_list[candidate_solution[-2]], the_list[candidate_solution[-3]])
#     return True
    
# def colinear(point_1_in_the_plane, point_2_in_the_plane, point_3_in_the_plane):
#     return point_1_in_the_plane[0] * (point_2_in_the_plane[1] - point_3_in_the_plane[1]) +  point_2_in_the_plane[0] * (point_3_in_the_plane[1] - point_1_in_the_plane[1]) +  point_3_in_the_plane[0] * (point_1_in_the_plane[1] - point_2_in_the_plane[1]) == 0

# def solution(candidate_solution, lenght):
#     return len(candidate_solution)>= 3 and len(candidate_solution) <= lenght

# def backtracking_iterative_version(the_list, lenght):
#     candidate_solution=[-1] #candidate solution
#     while len(candidate_solution)>0:
#         choosed = False
#         while not choosed and candidate_solution[-1]<lenght-1:
#             candidate_solution[-1] = candidate_solution[-1]+1 #increase the last component
#             choosed = consistent(candidate_solution, the_list)
#         if choosed:
#             if solution(candidate_solution, lenght):
#                 solution_found(candidate_solution, the_list)
#             candidate_solution.append(-1) # expand candidate solution
#         else:
#             candidate_solution = candidate_solution[:-1] #go back one component
    
# def solution_found(candidate_solution, the_list):
#     printing_string = "solution : "
#     for element in candidate_solution:
#         printing_string += str(the_list[element][0]) + " " + str(the_list[element][1]) + "    "  
#     print(printing_string, "\n")
    

# def backtracking_recursive_version(candidate_solution, the_list, lenght):
#     candidate_solution.append(0) #add a new component to the candidate solution
#     for i in range(0, lenght):
#         candidate_solution[-1] = i #set current component
#         if consistent(candidate_solution, the_list):
#             if solution(candidate_solution, lenght):
#                 solution_found(candidate_solution, the_list)
#             backtracking_recursive_version(candidate_solution, the_list, lenght) #recursive invocation to deal with next components
#     candidate_solution.pop()


# print("The iterative version:")
# backtracking_iterative_version( [[1,1], [0,0], [1,-1], [2,2], [2,-2], [3,3], [3,-3]], 7)
# print("The recursive version:")
# backtracking_recursive_version([], [[1,1], [0,0], [1,-1], [2,2], [2,-2], [3,3], [3,-3]], 7)



# the_list = [("A",1),("A",2),("A",3)]

# if ("A",1) in the_list:
#     print("player hit!")
# else:
#     print("plyer missed!")

# class A:
#     def f(self, l,nr):
#         l.append(nr)
# class B:
#     def g(self, l, nr):
#         nr=nr-1
#         l = l + [-2]
# a = A()
# b = B()
# l = [1,2]
# c = -1
# a.f(l,6)
# b.g(l, c)
# print(l,c)

# def complexity_1(x):
#     m = len(x)
#     found = False
#     while m >= 1:
#         print(m)
#         c = m - m / 3 * 3
#         if c == 1:
#             found = True
#         m = m / 3

# x = list(range(1,101))
# complexity_1(x)

# def complexity_3(n, i):
#     if n > 1:
#         i *= 2
#         m = n // 2
#         complexity_3(m, i - 2)
#         complexity_3(m, i - 1)
#         complexity_3(m, i + 2)
#         complexity_3(m, i + 1)
#     else:
#         print(i)

# complexity_3(9, 0)

"""
Binary search
"""

# def binary(lst, key):
#     if len(lst) == 0:
#         return -1
#     else:
#         mij = len(lst)//2
#         if lst[mij] == key:
#             return lst[mij]
#         elif lst[mij] < key:
#             return binary(lst[mij:], key)
#         else:
#             return binary(lst[:mij], key)

# lst = list(range(1,10))

# print(binary(lst, 4))

"""
Insertion sort
"""

# def insert_sort(data):
#     for i in range(1, len(data)):
#         val = data[i]
#         j = i - 1
#         while (j >= 0) and (data[j] > val):
#             data[j + 1] = data[j]
#             j = j - 1
#             data[j + 1] = val
#     return data

# data = [2,4,3,7,6,5]
# print(insert_sort(data))

"""
Quick sort
"""
# def quick(data):
#     less = []
#     equal = []
#     greater = []
#     if len(data)>1:
#         pivot = data[0] 
#         for i in range(0, len(data)):
#             if data[i] == pivot:
#                 equal.append(data[i])
#             if data[i] > pivot:
#                 greater.append(data[i])
#             if data[i] < pivot:
#                 less.append(data[i])
#         return quick(less) + equal + quick(greater)
#     else:
#         return data

# data = [2,4,3,7,6,5,11,13,10]
# print(quick(data))

"""
Merge sort
"""
# def merge(left_list, right_list):
#     final = []
#     i = 0
#     j = 0
#     while i < len(left_list) and j < len(right_list):
#         if left_list[i] < right_list[j]:
#             final.append(left_list[i])
#             i += 1
#         else:
#             final.append(right_list[j])
#             j += 1
#     while i < len(left_list):
#         final.append(left_list[i])
#         i += 1
#     while j < len(right_list):
#         final.append(right_list[j])
#         j += 1
#     return final

# def merge_sort(data):
#     if len(data) > 1:
#         left = data[:len(data)//2]
#         right = data[len(data)//2:]
#         return merge(merge_sort(left), merge_sort(right))
#     else:
#         return data

# print(merge_sort([2,4,3,7,5,6,14,13,10]))







# class Sparce_list():
#     def __init__(self):
#         self._data = list()
#         self._len = -1

#     def __setitem__(self, key, value):
#         for i in range(len(self._data)):
#             if self._data[i][0] == key:
#                 del self._data[i]
#         self._data.append([key, value])
#         if key>self._len:
#             self._len = key

#     def __len__(self):
#         return self._len +1
    
#     def __getitem__(self, key):
#         for el in self._data:
#             if el[0] == key:
#                 return el[1]
#         return 0

#     def __add__(self, other):
#         for i in range(len(other._data)):
#             other._data[i][0] += self._len
#         self._data += other._data
#         self._len += other._len
#         return self


    
# data = Sparce_list()

# data[1] = 5
# data[1] = 6
# data[6] = 9
# data[10] = 'a'

# data2 = Sparce_list()
# data2[1]=8
# dat = data + data2
# for i in range(0, len(dat)):
#     print(dat[i], end=' ')

# el = "asdfas asdf a asdf fd\n"
# print(el)
# # el = el.strip()
# print(el)
# print("ceva")

""" Sparcelist"""

class Sparce_list():

    def __init__(self):
        self._data = list()
        self._len = -1
        self._position = 0
    
    def __setitem__(self, key, value):
        for i in range(len(self._data)):
            if self._data[i][0] == key:
                del self._data[i]
        self._data.append([key,value])
        if self._len < key:
            self._len = key 

    def __len__(self):
        return self._len + 1

    def __getitem__(self, key):
        for el in self._data:
            if el[0] == key:
                return el[1]
        return 0

    def __add__(self,other):
        for el in other._data:
            el[0] += self._len
        self._data += other._data
        self._len += other._len
        return self
    
    

data = Sparce_list()

data[1] = 5
data[1] = 6
data[6] = 9
data[10] = 'a'

data2 = Sparce_list()
data2[1]=8
dat = data + data2
for el in dat:
    print(el, end=' ')