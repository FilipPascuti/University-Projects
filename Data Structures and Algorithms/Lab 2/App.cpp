#include "Bag.h"
#include "BagIterator.h"
#include "ShortTest.h"
#include "ExtendedTest.h"
#include <iostream>
#include <cassert>

using namespace std;

void test_add_number_of_occurances() {
	Bag b{};
	b.addOccurrences(3, 5);
	assert(b.nrOccurrences(5) == 3);
	b.addOccurrences(4, 5);
	assert(b.nrOccurrences(5) == 7);
	try {
		b.addOccurrences(-1, 5);
		assert(false);
	}
	catch (exception&) {
		assert(true);
	}
}


int main() {

	test_add_number_of_occurances();

	testAll();
	cout << "Short tests over" << endl;
	testAllExtended();
	cout << "All test over" << endl;
}