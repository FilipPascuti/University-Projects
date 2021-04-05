
#include <iostream>
#include "Matrix.h"
#include "ExtendedTest.h"
#include "ShortTest.h"
#include <cassert>
using namespace std;

void test() {
	Matrix m(4, 4);
	m.modify(1, 1, 5);
	pair<int, int> k1{ 1, 1 };
	pair<int, int> k2{ -1, -1 };
	assert(m.positionOf(5) == k1);
	assert(m.positionOf(1) == k2);
}


int main() {
	
	test();
	
	testAll();
	testAllExtended();
	cout << "Test End" << endl;
	system("pause");
}