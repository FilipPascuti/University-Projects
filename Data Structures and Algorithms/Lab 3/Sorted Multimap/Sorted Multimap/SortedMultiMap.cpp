#include "SMMIterator.h"
#include "SortedMultiMap.h"
#include <iostream>
#include <vector>
#include <exception>
using namespace std;

//void SortedMultiMap::print()
//{
//	for (int i = 0; i <= this->capacity - 1; i++)
//		cout << i << "\t\t" <<this->elements[i].previous << "  " << this->elements[i].next << "   "  << this->elements[i].value.first << " " << this->elements[i].value.second << endl;
//}


SortedMultiMap::SortedMultiMap(Relation r) {
	//complexity - theta(1) because capacity is fixed and small
	this->relation = r;
	this->capacity = INITIAL_CAPACITY;
	this->current_size = 0;
	this->elements = new Node[this->capacity];
	this->head = NULL_TVALUE;
	this->tail = NULL_TVALUE;
	this->firstEmpty = 0;

	this->elements[0].next = 1;
	this->elements[0].previous = NULL_TVALUE;
	
	for (int i = 1; i < this->capacity - 1; i++) {
		this->elements[i].next = i + 1;
		this->elements[i].previous = i - 1;
	}
	
	this->elements[this->capacity - 1].next = NULL_TVALUE;
	this->elements[this->capacity - 1].previous = this->capacity - 2;
	
	/*for (int i = 0; i <= this->capacity - 1; i++)
		cout << this->elements[i].next << "  " << this->elements[i].previous << endl;*/
}

int SortedMultiMap::allocate()
{
	//complexity - theta(1)
	int newElement = this->firstEmpty;
	if (newElement != NULL_TVALUE) {
		this->firstEmpty = this->elements[this->firstEmpty].next;
		if (this->firstEmpty != NULL_TVALUE)
			this->elements[this->firstEmpty].previous = NULL_TVALUE;
		this->elements[newElement].next = NULL_TVALUE;
		this->elements[newElement].previous = NULL_TVALUE;
	}
	return newElement;
}



void SortedMultiMap::add(TKey c, TValue v) {
	//complexity - O(n)
	TElem newValue{ c, v };
	int newElement = this->allocate();

	// resize if needed
	if (newElement == NULL_TVALUE) {
		this->capacity *= 2;
		Node* auxiliarElements = new Node[this->capacity];
		for (int i = 0; i < this->current_size; i++)
			auxiliarElements[i] = this->elements[i];
		delete[] this->elements;
		this->elements = auxiliarElements;
		//this->elements[this->size].next = this->size + 1;
		//this->elements[this->size].previous = NULL_TVALUE;
		//newElement = this->size;
		this->elements[this->current_size].next = this->current_size + 1;
		this->elements[this->current_size].previous = NULL_TVALUE;
		for (int i = this->current_size + 1; i < this->capacity - 1; i++){
			this->elements[i].next = i + 1;
			this->elements[i].previous = i - 1;
		}
		this->elements[this->capacity - 1].next = NULL_TVALUE;
		this->elements[this->capacity - 1].previous = this->capacity - 2;
		this->firstEmpty = this->current_size;
		//this->elements[this->firstEmpty].previous = NULL_TVALUE;
		newElement = this->allocate();
	}
	

	if (this->current_size == 0) {
		this->elements[newElement].value = newValue;
		this->head = newElement;
		this->tail = newElement;
		this->elements[newElement].previous = NULL_TVALUE;
		this->elements[newElement].next = NULL_TVALUE;
		this->current_size++;
		return;
	}
	/*if (this->current_size == 1) {
		if (this->relation(c, this->elements[this->head].value.first) == true) {
			this->elements[newElement].value = newValue;
			this->elements[newElement].next = this->head;
			this->elements[newElement].previous = NULL_TVALUE;
			this->elements[this->head].previous = newElement;
			this->head = newElement;
		}
		else {
			this->elements[newElement].value = newValue;
			this->elements[newElement].previous = this->tail;
			this->elements[newElement].next = NULL_TVALUE;
			this->elements[this->tail].next = newElement;
			this->tail = newElement;
		}
		this->current_size++;
		return;
	}*/
	int currentPosition = this->head;
	while (currentPosition != NULL_TVALUE && this->relation(c, this->elements[currentPosition].value.first) == false) {
		currentPosition = this->elements[currentPosition].next;
	}
	if (currentPosition == this->head) {
		this->elements[newElement].value = newValue;
		this->elements[newElement].next = this->head;
		this->elements[newElement].previous = NULL_TVALUE;
		this->elements[this->head].previous = newElement;
		this->head = newElement;
	}
	else if (currentPosition == NULL_TVALUE) {
		this->elements[newElement].value = newValue;
		this->elements[newElement].previous = this->tail;
		this->elements[newElement].next = NULL_TVALUE;
		this->elements[this->tail].next = newElement;
		this->tail = newElement;
	}
	else {
		int previousNode = this->elements[currentPosition].previous;
		this->elements[newElement].value = newValue;
		this->elements[newElement].next = currentPosition;
		this->elements[newElement].previous = previousNode;
		this->elements[previousNode].next = newElement;
		this->elements[currentPosition].previous = newElement;
	}
	this->current_size++;
}

vector<TValue> SortedMultiMap::search(TKey c) const {
	//complexity - O(n)
	vector<TValue> values;
	int currentPosition = this->head;
	while (currentPosition != NULL_TVALUE && c != this->elements[currentPosition].value.first)
		currentPosition = this->elements[currentPosition].next;
	if (currentPosition == NULL_TVALUE)
		return values;
	while (currentPosition != NULL_TVALUE && c == this->elements[currentPosition].value.first ) {
		values.push_back(this->elements[currentPosition].value.second);
		currentPosition = this->elements[currentPosition].next;
	}
	return values;
}

bool SortedMultiMap::remove(TKey c, TValue v) {
	//complexity - O(n)
	int removePosition = NULL_TVALUE;
	int currentPosition = this->head;
	while (currentPosition != NULL_TVALUE){
		if (c == this->elements[currentPosition].value.first && v == this->elements[currentPosition].value.second) {
			removePosition = currentPosition;
			break;
		}
		currentPosition = this->elements[currentPosition].next;
	}
	if (removePosition == NULL_TVALUE)
		return false;
	if (removePosition == this->head) {
		if (removePosition == this->tail) {
			this->elements[this->firstEmpty].previous = this->head;
			this->elements[this->head].next = this->firstEmpty;
			this->firstEmpty = this->head;
			this->head = NULL_TVALUE;
			this->tail = NULL_TVALUE;
		}
		else {
			int old_head = this->head;
			this->head = this->elements[this->head].next;
			this->elements[this->head].previous = NULL_TVALUE;

			this->elements[this->firstEmpty].previous = old_head;
			this->elements[old_head].next = this->firstEmpty;
			this->firstEmpty = old_head;
		}
	}
	else if (removePosition == this->tail) {
		int old_tail = this->tail;
		this->tail = this->elements[this->tail].previous;
		this->elements[this->tail].next = NULL_TVALUE;

		this->elements[this->firstEmpty].previous = old_tail;
		this->elements[old_tail].next = this->firstEmpty;
		this->firstEmpty = old_tail;
	}
	else {
		int previousNode = this->elements[removePosition].previous;
		int nextNode = this->elements[removePosition].next;
		this->elements[previousNode].next = nextNode;
		this->elements[nextNode].previous = previousNode;

		this->elements[this->firstEmpty].previous = removePosition;
		this->elements[removePosition].previous = NULL_TVALUE;
		this->elements[removePosition].next = this->firstEmpty;
		this->firstEmpty = removePosition;
	}
	this->current_size--;
	return true;
}


int SortedMultiMap::size() const {
	//complexity - theta(1)
	return this->current_size;
}

bool SortedMultiMap::isEmpty() const {
	//complexity - theta(1)
	if (this->current_size == 0)
		return true;
	return false;
}

SMMIterator SortedMultiMap::iterator() const {
	return SMMIterator(*this);
}

SortedMultiMap::~SortedMultiMap() {
	//complexity - theta(1)
	delete[] this->elements;
}

vector<TValue> SortedMultiMap::remove_key(TKey c)
{
	//complexity - best case: theta(1) worst case: theta(n^2) total compexity O(n^2)
	vector<TValue> values;
	int currentPosition = this->head;
	while (currentPosition != NULL_TVALUE && c != this->elements[currentPosition].value.first)
		currentPosition = this->elements[currentPosition].next;
	if (currentPosition == NULL_TVALUE)
		return values;
	int first_position = currentPosition;
	while (currentPosition != NULL_TVALUE && c == this->elements[currentPosition].value.first) {
		values.push_back(this->elements[currentPosition].value.second);
		currentPosition = this->elements[currentPosition].next;
		this->remove(c, this->elements[this->elements[currentPosition].previous].value.second);
	}
	return values;
}
