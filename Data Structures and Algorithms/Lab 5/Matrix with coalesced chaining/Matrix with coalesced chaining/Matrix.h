#pragma once

//DO NOT CHANGE THIS PART
typedef int TElem;
#define NULL_TELEM 0

class Matrix {

	typedef struct square {
		int line;
		int column;
		int value;
	};

private:
	//TODO - Representation
	square* elems;
	int* next;
	int m;
	int size;
	int first_empty;
	int hash(int i, int j) const;
	int nr_lines;
	int nr_cols;

public:

	void resize();

	void print();

	void change_first_empty();

	//constructor
	Matrix(int nrLines, int nrCols);

	//returns the number of lines
	int nrLines() const;

	//returns the number of columns
	int nrColumns() const;

	//returns the element from line i and column j (indexing starts from 0)
	//throws exception if (i,j) is not a valid position in the Matrix
	TElem element(int i, int j) const;

	//modifies the value from line i and column j
	//returns the previous value from the position
	//throws exception if (i,j) is not a valid position in the Matrix
	TElem modify(int i, int j, TElem e);

};
