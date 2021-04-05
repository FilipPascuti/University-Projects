#include "Map.h"
#include "MapIterator.h"
#include <exception>
using namespace std;


MapIterator::MapIterator(const Map& d) : map(d)
{
	//TODO - Implementation
	//complexity - theta(1)
	current_position = 0;
}


void MapIterator::first() {
	//TODO - Implementation
	//complexity - theta(1)
	current_position = 0;
}


void MapIterator::next() {
	//TODO - Implementation
	//complexity - theta(1)
	if (current_position == map.number_of_elements)
		throw exception();
	else
		current_position++;
}


TElem MapIterator::getCurrent() {
	//TODO - Implementation
	//complexity - theta(1)
	if (current_position < map.number_of_elements)
		return map.elements[current_position];
	throw exception();
}


bool MapIterator::valid() const {
	//complexity - theta(1)
	if (current_position < map.number_of_elements)
		return true;
	return false;
}



