#include <iostream>

#include "ShortTest.h"
#include "ExtendedTest.h"
#include "SortedMultiMap.h"

using namespace std;

int main(){
    testAll();
	//testAllExtended();
	/*int v[5] = {1,2,4,7};
	int a = 8;
	int pos;
	for (int i = 0; i < 5; i++) {
		if (a < v[i]) {
			pos = i;
			break;
		}
	}
	
	for (int i = 4; i > pos; i--)
		v[i] = v[i - 1];
	v[pos] = a;
	for (auto el : v)
		cout << el << "  ";*/
	
	

	std::cout<<"Finished SMM Tests!"<<std::endl;
	system("pause");
}
