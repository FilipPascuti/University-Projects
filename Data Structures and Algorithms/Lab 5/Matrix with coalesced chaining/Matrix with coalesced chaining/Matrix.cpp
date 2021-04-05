#include "Matrix.h"
#include <exception>
#include <iostream>
using namespace std;


int Matrix::hash(int i, int j) const
{
	return (i + j)%this->m;
}

void Matrix::resize()
{
	int old_size = this->size;
	int old_capacity = this->m;
	this->m *= 2;
	int line, column, value, pos;
	bool exists;
	int first_empty = 0;
	square* aux_elems = new square[this->m];
	int* aux_next = new int[m];
	for (int k = 0; k < this->m; k++)
		aux_next[k] = -2;
	for (int k = 0; k < old_capacity; k++) {
		//cout << endl << first_empty << endl;
		if (this->next[k] != -2) {
			line = this->elems[k].line;
			column = this->elems[k].column;
			value = this->elems[k].value;
			pos = this->hash(line, column);
			exists = false;
			if (aux_next[pos] == -2) {
				if (pos == first_empty) {
					first_empty++;
					while (first_empty < this->m && aux_next[first_empty] != -2)
						first_empty++;
				}
				aux_elems[pos].line = line;
				aux_elems[pos].column = column;
				aux_elems[pos].value = value;
				aux_next[pos] = -1;
			}
			//if the element is already in the hashtable
			else if (aux_next[pos] == -1 && aux_elems[pos].line == line && aux_elems[pos].column == column) {
				aux_elems[pos].line = line;
				aux_elems[pos].column = column;
				aux_elems[pos].value = value;
			}
			else {
				while (aux_next[pos] != -1) {
					// if the element was already in the hashtable
					if (aux_elems[pos].line == line && aux_elems[pos].column == column) {
						aux_elems[pos].line = line;
						aux_elems[pos].column = column;
						aux_elems[pos].value = value;
						exists = true;
					}
					pos = aux_next[pos];
				}
				if (exists == false) {
					aux_elems[first_empty].line = line;
					aux_elems[first_empty].column = column;
					aux_elems[first_empty].value = value;
					aux_next[first_empty] = -1;
					aux_next[pos] = first_empty;
					first_empty++;
					while (first_empty < this->m && aux_next[first_empty] != -2)
						first_empty++;
				}
			}
		}
	}
	this->elems = aux_elems;
	this->next = aux_next;
	this->first_empty = first_empty;
}

void Matrix::print()
{
	for (int i = 0; i < this->m; i++) {
		cout << this->elems[i].line << " " << this->elems[i].column << " " << this->elems[i].value << " " << " ----- " << this->next[i] << endl;
	}
	//cout << endl << endl << (double)this->size / (double)this->m << endl << endl;
	cout << endl << this->m << endl;
	cout << endl << endl << this->size << endl << endl;
}

void Matrix::change_first_empty()
{
	this->first_empty++;
	while (this->first_empty < this->m && this->next[this->first_empty] != -2)
		this->first_empty++;
}

Matrix::Matrix(int nrLines, int nrCols) {
	   
	//TODO - Implementation
	this->nr_lines = nrLines;
	this->nr_cols = nrCols;
	this->m = 2;
	this->elems = new square[this->m];
	this->size = 0;
	this->first_empty = 0;
	this->next = new int[this->m];
	for (int i = 0; i < this->m; i++) {
		this->next[i] = -2;
	}
}


int Matrix::nrLines() const {
	//TODO - Implementation
	return this->nr_lines;
}


int Matrix::nrColumns() const {
	//TODO - Implementation
	return this->nr_cols;
}




TElem Matrix::element(int i, int j) const {
	//TODO - Implementation
	if (i > this->nr_lines-1 || j > this->nr_cols-1 || i < 0 || j < 0)
		throw exception();
	int current_position = this->hash(i, j);
	if (this->next[current_position] == -2)
		return NULL_TELEM;
	while (current_position >= 0) {
		if (this->elems[current_position].line == i && this->elems[current_position].column == j)
			return this->elems[current_position].value;
		current_position = this->next[current_position];
	}
	return NULL_TELEM;
}

TElem Matrix::modify(int i, int j, TElem e) {
	//TODO - Implementation
	int current_position = this->hash(i, j);
	int old;
	if (i > this->nr_lines - 1 || j > this->nr_cols - 1 || i < 0 || j < 0)
		throw exception();
	if (e != 0) {
		//if the position is empty
		if (this->next[current_position] == -2) {
			if (current_position == this->first_empty)
				this->change_first_empty();
			this->elems[current_position].line = i;
			this->elems[current_position].column = j;
			this->elems[current_position].value = e;
			this->next[current_position] = -1;
			this->size++;
			if ((double)this->size / (double)this->m > 0.7) {
				this->resize();
			}
			return NULL_TELEM;
		}
		//if the element is already in the hashtable
		if (this->next[current_position] == -1 && this->elems[current_position].line == i && this->elems[current_position].column == j) {
			old = this->elems[current_position].value;
			this->elems[current_position].line = i;
			this->elems[current_position].column = j;
			this->elems[current_position].value = e;
			this->size++;
			if ((double)this->size / (double)this->m > 0.7) {
				this->resize();
			}
			return old;
		}
		while (this->next[current_position] != -1) {
			// if the element was already in the hashtable
			if (this->elems[current_position].line == i && this->elems[current_position].column == j) {
				old = this->elems[current_position].value;
				this->elems[current_position].line = i;
				this->elems[current_position].column = j;
				this->elems[current_position].value = e;
				return old;
			}
			current_position = this->next[current_position];
		}
		// if the element is not in the hashtable
		this->size++;
		if ((double)this->size / (double)this->m > 0.7) {
			this->resize();
			//after resize and rehash
			current_position = this->hash(i, j);
			if (this->next[current_position] == -2) {
				if (current_position == this->first_empty)
					this->change_first_empty();
				this->elems[current_position].line = i;
				this->elems[current_position].column = j;
				this->elems[current_position].value = e;
				this->next[current_position] = -1;
				return NULL_TELEM;
			}
			//if the element is already in the hashtable
			if (this->next[current_position] == -1 && this->elems[current_position].line == i && this->elems[current_position].column == j) {
				old = this->elems[current_position].value;
				this->elems[current_position].line = i;
				this->elems[current_position].column = j;
				this->elems[current_position].value = e;
				return old;
			}
			while (this->next[current_position] != -1) {
				// if the element was already in the hashtable
				if (this->elems[current_position].line == i && this->elems[current_position].column == j) {
					old = this->elems[current_position].value;
					this->elems[current_position].line = i;
					this->elems[current_position].column = j;
					this->elems[current_position].value = e;
					return old;
				}
				current_position = this->next[current_position];
			}

		}
		else {
			this->elems[this->first_empty].line = i;
			this->elems[this->first_empty].column = j;
			this->elems[this->first_empty].value = e;
			this->next[this->first_empty] = -1;
			this->next[current_position] = this->first_empty;
			this->change_first_empty();
		}
	}
	else {
		//the element does not exist
		if (this->next[current_position] == -2)
			return NULL_TELEM;
		else {
			int prev = -1;
			int index = 0;
			while (current_position != -1 && !(this->elems[current_position].line == i && this->elems[current_position].column == j)) {
				prev = current_position;
				current_position = this->next[current_position];
			}
			//the element does not exist
			if (current_position == -1)
				return NULL_TELEM;
			else {
				bool over = false;
				do {
					int p = this->next[current_position];
					int pp = current_position;
					while (p != -1 && this->hash(this->elems[p].line, this->elems[p].column) != current_position) {
						pp = p;
						p = this->next[p];
					}
					if (p == -1)
						over = true;
					else {
						this->elems[current_position].line = this->elems[p].line;
						this->elems[current_position].column = this->elems[p].column;
						this->elems[current_position].value = this->elems[p].value;

						current_position = p;
						prev = pp;
					}
				} while (!over);
				if (prev == -1) {
					while (index < this->m && prev == -1) {
						if (this->next[index] == current_position)
							prev = index;
						index++;
					}
					this->next[prev] = this->next[current_position];
				}
				if (this->first_empty > current_position)
					this->first_empty = current_position;
				if (prev != -1)
					this->next[current_position] = -2;
				this->size--;
			}
		}

	}
	

	return NULL_TELEM;
}


