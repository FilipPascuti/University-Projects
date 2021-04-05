#include <iostream>

#include "ShortTest.h"
#include "ExtendedTest.h"
#include "SortedMultiMap.h"
#include <cassert>


int main(){
	test_remove_key();
	testAll();
	testAllExtended();




    std::cout<<"Finished SMM Tests!"<<std::endl;
	system("pause");
}
