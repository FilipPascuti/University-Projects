#include "ExtendedTest.h"
#include "ShortTest.h"

#include "Map.h"


#include <iostream>
#include <cassert>
using namespace std;

void test_getValueRange() {
	Map map;
	assert(map.getValueRange() == -1);
	map.add(1, 100);
	assert(map.getValueRange() == 0);
	map.add(2, 1);
	map.add(3, 200);
	map.add(4, 3);
	assert(map.getValueRange() == 199);
}


int main() {
	testAll();
	testAllExtended();
	test_getValueRange();
	
	cout << "That's all!" << endl;
	system("pause");
	return 0;
}


