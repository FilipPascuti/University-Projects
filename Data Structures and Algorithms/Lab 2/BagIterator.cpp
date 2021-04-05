#include <exception>
#include "BagIterator.h"
#include "Bag.h"

using namespace std;


BagIterator::BagIterator(const Bag& c): bag(c)
{
	//TODO - Implementation
	//complexity - theta(1)
	this->current_element = bag.head;
	
	this->frequency = 1;
}

void BagIterator::first() {
	//complexity - theta(1)
	this->current_element = bag.head;
	this->frequency = 1;
	//TODO - Implementation
}


void BagIterator::next() {
	//complexity - theta(1)
	if (valid() == false)
		throw exception();
	if (current_element->frequency > frequency)
		this->frequency++;
	else {
		this->current_element = current_element->next;
		this->frequency = 1;
	}
	//TODO - Implementation
}


bool BagIterator::valid() const {
	//TODO - Implementation
	//complexity - theta(1)
	if (this->current_element == NULL)
		return false;
	return true;
}



TElem BagIterator::getCurrent() const
{
	//TODO - Implementation
	//complexity - theta(1)
	if (valid() == false)
		throw exception();
	else
		return this->current_element->value;
	return NULL_TELEM 
}
