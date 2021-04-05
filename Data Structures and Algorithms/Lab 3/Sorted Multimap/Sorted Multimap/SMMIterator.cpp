#include "SMMIterator.h"
#include "SortedMultiMap.h"

SMMIterator::SMMIterator(const SortedMultiMap& d) : map(d){
	//complexity - theta(1)
	this->currentPosition = map.head;
}

void SMMIterator::first(){
	//complexity - theta(1)
	this->currentPosition = map.head;
}

void SMMIterator::next(){
	//complexity - theta(1)
	if (this->currentPosition == NULL_TVALUE)
		throw exception();
	this->currentPosition = map.elements[this->currentPosition].next;
}

bool SMMIterator::valid() const{
	//complexity - theta(1)
	if (this->currentPosition == NULL_TVALUE)
		return false;
	return true;
}

TElem SMMIterator::getCurrent() const{
	//complexity - theta(1)
	if (this->currentPosition == NULL_TVALUE)
		throw exception();
	return map.elements[this->currentPosition].value;
}


