#include "map.h"
#include "MapIterator.h"

Map::Map() {
	//complexity - theta(1)
	capacity = 10;
	number_of_elements = 0;
	elements = new TElem[10];
}

Map::~Map() {
	//complexity - theta(1)
	delete[] elements;
}

TValue Map::add(TKey c, TValue v) {
	// complexity - O(n)
	for (int i = 0; i < number_of_elements; i++)
		if (elements[i].first == c){
			TValue old_value;
			old_value = elements[i].second;
			elements[i].second = v;
			return old_value;
		}
	if (capacity == number_of_elements) {
		capacity = capacity * 2;
		TElem* new_array;
		new_array = new TElem[capacity];
		for (int i = 0; i < number_of_elements; i++)
			new_array[i] = elements[i];
		delete[] elements;
		elements = new_array;
	}
	TElem new_element;
	new_element.first = c;
	new_element.second = v;
	elements[number_of_elements++] = new_element;
	return NULL_TVALUE;
}

TValue Map::search(TKey c) const {
	//complexity - O(n)
	for (int i = 0; i < number_of_elements; i++)
		if (elements[i].first == c) {
			return elements[i].second;
		}
	return NULL_TVALUE;
}

TValue Map::remove(TKey c) {
	//complexity - O(n)
	int index = -1;
	TValue value;
	for (int i = 0; i < number_of_elements; i++)
		if (elements[i].first == c) {
			index = i;
			value = elements[i].second;
			break;
		}
	if(index == -1)
		return NULL_TVALUE;
	else {
		/*number_of_elements--;
		for (int i = index; i < number_of_elements; i++)
			elements[i] = elements[i + 1];*/
		this->number_of_elements--;
		this->elements[index] = this->elements[this->number_of_elements];
	}
	if (number_of_elements * 4 < capacity) {
		capacity = capacity / 2;
		TElem* new_array;
		new_array = new TElem[capacity];
		for (int i = 0; i < number_of_elements; i++)
			new_array[i] = elements[i];
		delete[] elements;
		elements = new_array;
	}
	return value;
}


int Map::size() const {
	//complexity - theta(1)
	return number_of_elements;
}

bool Map::isEmpty() const {
	//complexity - theta(1)
	if(number_of_elements == 0)
		return true;
	return false;
}

int Map::getValueRange() const
{
	//complexity - BC, WC and AC are the same theta(n)
	int min, max;
	if (this->number_of_elements == 0)
		return -1;
	else if (this->number_of_elements == 1)
		return 0;
	else {
		min = this->elements[0].second;
		max = this->elements[0].second;
		int i = 1;
		while(i < this->number_of_elements) {
			if (this->elements[i].second > max)
				max = this->elements[i].second;
			if (this->elements[i].second < min)
				min = this->elements[i].second;
			i++;
		}
	}
	return max - min;
}

MapIterator Map::iterator() const {
	return MapIterator(*this);
}



