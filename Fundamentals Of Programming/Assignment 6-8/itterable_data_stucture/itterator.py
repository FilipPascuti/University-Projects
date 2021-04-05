class My_data_structure_iter:

    def __init__(self, data):
        self.length = len(data)
        self.position = 0
        self.data = data

    def __iter__(self):
        return self

    def __next__(self):
        if self.position < self.length:
            self.position += 1
            return self.data[self.position - 1]
        else:
            raise StopIteration


class My_data_structure:

    def __init__(self, data=None):
        if data is None:
            self._data = []
        else:
            self._data = data

    def append(self, value):
        self._data.append(value)
        
    def pop(self, index):
        self._data.pop(index)

    def __setitem__(self, key, value):
        self._data[key] = value

    def __iter__(self):
        return My_data_structure_iter(self._data)

    def __getitem__(self, key):
        return self._data[key]

    def __len__(self):
        return len(self._data)

    def __str__(self):
        return str(self._data)


def gnome_sort(data, key=lambda x: x):
    i = 0
    while i < len(data):
        if i == 0 or key(data[i]) >= key(data[i - 1]):
            i += 1
        else:
            data[i], data[i - 1] = data[i - 1], data[i]
            i -= 1
    return data


def custom_filter(data, acceptance_function):
    i = 0
    while i < len(data):
        if acceptance_function(data[i]):
            i += 1
        else:
            del data[i]
            i -= 1
    return data


import unittest


class Test(unittest.TestCase):
    
    def test_my_data_structure_append___value__value_at_the_end(self):
        data_structure = My_data_structure()
        data_structure.append(5)
        self.assertIn(5, data_structure)
    
    def test_my_data_structure_pop__index__value_with_that_index_not_in_my_data_structure(self):
        data_structure = My_data_structure()
        data_structure.append(5)
        data_structure.pop(0)
        self.assertNotIn(5, data_structure)
    
    def test_gnome_sort__unsorted_list__sorted_list(self):
        the_list = [1, 3, 5, 2, 4]
        the_list = gnome_sort(the_list)
        self.assertEqual(the_list, list(range(1, 6)))
        
    def test_gnome_sort__unsorted_data_structure__sorted_data_structure(self):
        data_structure = My_data_structure([1, 4, 6, 2, 3, 5])
        data_structure = gnome_sort(data_structure)
        self.assertEqual(str(data_structure), str([1, 2, 3, 4, 5, 6]))
    
    def test_filter_custom__list_function_that_checks_the_divisability_by_3__filtered_list(self):
        the_list = [0, 1, 2, 3, 4, 5, 6]
        the_list = custom_filter(the_list, lambda x: x % 3 == 0)
        self.assertEqual(the_list, [0, 3, 6])
    
    def test_filter_custom__data_structure_function_that_checks_the_divisability_by_5__filtered_data_structure(self):
        data_structure = My_data_structure([2, 3, 5, 10, 7, 15])
        data_structure = custom_filter(data_structure, lambda x: x % 5 == 0)
        self.assertEqual(str(data_structure), str([5, 10, 15]))
