#include "Bag.h"
#include "BagIterator.h"
#include <exception>
#include <iostream>
using namespace std;


Bag::Bag() {
	//TODO - Implementation
	//complexity - theta(1)
	this->head = nullptr;
	this->tail = nullptr;
	this->number_of_elements = 0;
}


void Bag::add(TElem elem) {
	//TODO - Implementation
	//complexity - O(n) where n is the number of elements
	this->number_of_elements++;
	Node* current_node;
	current_node = this->head;
	while (current_node != nullptr) {
		if (current_node->value == elem) {
			current_node->frequency++;
			return;
		}	
		current_node = current_node->next;
	}
	Node* new_node = new Node;
	new_node->value = elem;
	new_node->frequency = 1;
	new_node->next = this->head;
	new_node->previous = nullptr;
	if (this->head == nullptr) {
		this->tail = new_node;
		this->head = new_node;
	}
	else {
		this->head->previous = new_node;
		this->head = new_node;
	}
}


bool Bag::remove(TElem elem) {
	//TODO - Implementation
	//complexity - O(n)
	
	Node* current_node;
	current_node = this->head;
	while (current_node != nullptr && current_node->value != elem) {
		current_node = current_node->next;
	}
	if (current_node != nullptr)
	{
		this->number_of_elements--;
		if (current_node->frequency > 1)
			current_node->frequency--;
		else {
			if (current_node == this->head) {
				if (current_node == this->tail) {
					this->head = nullptr;
					this->tail = nullptr;
				}
				else {
					this->head = this->head->next;
					this->head->previous = nullptr;
				}
			}
			else if (current_node == this->tail) {
				this->tail = this->tail->previous;
				this->tail->next = nullptr;
			}
			else {
				current_node->next->previous = current_node->previous;
				current_node->previous->next = current_node->next;
			}
		}
		return true;
	}
	return false; 
}


bool Bag::search(TElem elem) const {
	//complexity - O(n)
	Node* current_node;
	current_node = this->head;
	while (current_node != nullptr) {
		if (current_node->value == elem) {
			return true;
		}
		current_node = current_node->next;
	}
	return false; 
}

int Bag::nrOccurrences(TElem elem) const {
	//complexity - O(n)
	Node* current_node;
	current_node = this->head;
	while (current_node != nullptr) {
		if (current_node->value == elem) {
			return current_node->frequency;
		}
		current_node = current_node->next;
	}
	return 0; 
}


int Bag::size() const {
	//TODO - Implementation
	//complexity - theta(1)
	return this->number_of_elements;
}


bool Bag::isEmpty() const {
	//TODO - Implementation
	//complexity - theta(1)
	if (this->head == nullptr)
		return true;

	return false;
}

BagIterator Bag::iterator() const {
	return BagIterator(*this);
}


Bag::~Bag() {
	//TODO - Implementation
	//complexity - theta(n)
	Node* current_node;
	if (this->head != nullptr) {
		current_node = this->head->next;
		while (current_node != nullptr) {
			delete current_node->previous;
			current_node = current_node->next;
		}
		delete this->tail;
	}
}

void Bag::addOccurrences(int nr, TElem elem)
{
	//complexity - BC = theta(1) WC = theta(n) Overall complexity = O(n)
	if (nr < 0)
		throw exception();
	Node* current_node;
	current_node = this->head;
	while (current_node != nullptr) {
		if (current_node->value == elem) {
			current_node->frequency += nr;
			return;
		}
		current_node = current_node->next;
	}
	Node* new_node = new Node;
	new_node->value = elem;
	new_node->frequency = nr;
	new_node->next = this->head;
	new_node->previous = nullptr;
	if (this->head == nullptr) {
		this->tail = new_node;
		this->head = new_node;
	}
	else {
		this->head->previous = new_node;
		this->head = new_node;
	}
}
