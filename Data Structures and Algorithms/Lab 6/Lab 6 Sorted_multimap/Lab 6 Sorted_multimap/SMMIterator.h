#pragma once

#include "SortedMultiMap.h"
#include <stack>

class SMMIterator{
	friend class SortedMultiMap;
private:
	//DO NOT CHANGE THIS PART
	const SortedMultiMap& map;
	SMMIterator(const SortedMultiMap& map);
	
	//TODO - Representation
	std::stack<int> stack;
	int current_node;
	int current_position;

public:
	void first();
	void next();
	bool valid() const;
   	TElem getCurrent() const;
};

