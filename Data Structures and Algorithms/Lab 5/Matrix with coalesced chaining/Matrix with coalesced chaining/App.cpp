
#include <iostream>
#include "Matrix.h"
#include "ExtendedTest.h"
#include "ShortTest.h"

using namespace std;


int main() {
	int a = 4, b = 5;

	/*Matrix m(4, 4);
	m.print();
	m.modify(1, 1, 5);
	m.print();
	m.modify(2, 3, 7);
	m.print();
	m.modify(0, 0, 10);
	m.print();*/
	
	
	//testAll();
	testAllExtended();
	cout << "Test End" << endl;
	system("pause");
}