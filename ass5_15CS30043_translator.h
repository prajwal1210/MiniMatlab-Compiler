#ifndef __TRANSLATOR_H
#define __TRANSLATOR_H

#include <iostream>
#include <string>
#include <vector>
#include <stdlib.h>
#include <stdio.h>
#include <bits/stdc++.h>


using namespace std;

#define SIZE_CHAR 		1 		//Size of a character in bytes		
#define SIZE_INT 		4 		//Size of an integer in bytes
#define SIZE_DOUBLE 	8 		//Size of a double in bytes
#define SIZE_VOID 		0 		//Size of a void type (function) in bytes
#define SIZE_POINTER 	8		//Size of a pointer in bytes

typedef enum{
	t_integer = 0,				//integer type
	t_double,					//double type
	t_char,						//character type 
	t_void,						//void type
	t_func,						//function type
	t_pointer,					//pointer type 
	t_mat,						//matrix type 
	t_Bool						//Implicit Boolean type	
}basictype;	 



class type;

class type{									//class to store the information related to the type of variable
public:

	basictype actype;						//basic type of the variable

	int size;								//size in bytes of the variable

	int rows;								//for Matrix
	int cols;								//for Matrix

	type* pointerto;						//for pointers 	

	type* retval;							//for functions						

	type();									//default constructor 

	type(basictype b);						//constructor to make a type for the basictype b
	type(basictype b,int rows, int cols);	//constructor for 2D matrices  

	int get_size();							//function to get the size of the type
};



class symboltable;							//class for the symbol table 

union doubleVal{
	double db;
	unsigned int db_arr[2];
};

union initialVal{							//a union to store the initial value of the symbol table entry which can be either an int, double, char or string
	int intVal;
	doubleVal dbVal;
	char charVal;
	vector<double> *matVal;
	};

class symentry{								//class for a symbol table entry 
public:

	string name;							//name of the entry 

	type t;									//type of the entry 

	initialVal init;						//initial value of the entry 

        int offset;							//offset value 

	int size;								//size in bytes required for the variable

	bool wasInit;							//to check whether it is initialized or not	

	bool isParam;							//marker if it is a parameter to the function
	
	bool isConst;							//marker for constant values

	symboltable* nested_table;				//pointer to a nested symbol table in case of functions 

	symentry(string name);					//constructor to create a new entry with the name passed as a parameter 

	void setInitialVal(initialVal i);		//function to set the initial value field of the symbol table entry

};

class symboltable{							//class definition for the symtoltable
public:

	int offset;								//offset of the last entry of the symbol table 

	string name;							//name of the symbol table 

	vector<symentry*> symentries;			//Entries in the symbol table are being stored in a vector

	symboltable(string s);					//constructor to create a symbol table with name s 

	bool isPresent(string);					//Function to check if an entry with the given name is present or not

	symentry* lookup(string n);				//checks if an entry with name n is present in the symbol table and returns a pointer to it if present. If not, creates an entry with name n in the symbol table and returns a pointer to it

	symentry* gentemp(type ty);				//generates a temporary variable of type ty and adds it to the symbol table 

	void update(symentry* entry,type t);	//updates the type of a symbol table entry

	void update(symentry* entry,symboltable* nestedtable);	//updates the nestedtable field of an entry 

	void print();							//prints the symbol table

	void printentry(symentry entry);

	string printtype(type t);
};

class quadentry{							//class for a quad
public:	

	string op;								//operation
	string arg1;							//argument 1 
	string arg2;							//argument 2 
	string res;								//result 

	quadentry(string op, string arg1, string arg2, string res);	//constructor of a quad for a binary operation with all fields present
	quadentry(string op, string arg1, string res);				//constructor of a quad for a unary operation
	quadentry(string arg1, string res);							//constructor of a quad for a copy operation
};

class quadArray{													//class definition for Quad Array
public:
	int nextinstr;													//The next intruction index no.

	vector<quadentry> quadarray;									//a vector of quads

	quadArray();													//default constructor 

	void emit(string op, string arg1, string arg2, string res); 	//emit for binary operations 

	void emit(string op, string arg1, string res);					//emit for unary operations

	void emit(string arg1, string res);								//emit for copy operation

	void print(ofstream &fout);													//function to print the quads in the quadarray
};

struct exp_attr{													//attribute to be used for grammar symbols

	symentry* addr;													//pointer to the corresponding symbol table entry 
	
	type* t_exp;													//type of the expression/declarator

	symentry* mat;													//Used for dereferencing matrices

	vector<int>	*truelist;											//truelist for boolean expressions

	vector<int>	*falselist;											//falselist for boolean expressions

	bool isMattype;													//Boolean value which is true if the matrix mat has to be deferenced first
	bool isPtrtype;													//Boolean value which is true if a pointer type has to be deferenced first

	int num_stars;													//to store the no. of dereferences to be done for pointers

	bool isConst;													//to check whether the expression is a const

	bool isString;

	int strkey; 
};

typedef struct{														//attribute for identifiers
	char* name;														//name of the identifier

	symentry* loc;													//symboltable location of the id
}id_attr;

typedef struct 
{
	type* t_dec;													//type of the declaration

	int size;														//size in bytes	
}dec_attr;

typedef struct{
	struct exp_attr E;												//for non-matrix initialization , the attribute for expression
	
	vector<exp_attr> *matlist;										//used for matrix initialization
}init;


vector<symboltable*> symtables;										//vector of symbol tables

bool are_same_type(type E1,type E2,bool cmatsize = false);			//function to check whether E1 and E2 are of the same type or not

vector<int>* makelist(int i);										//creates a new list with the element i

vector<int>* merge(vector<int>* p1, vector<int>* p2);				//merges two lists - p1 and p2 and returns a pointer to the merged list

void backpatch(vector<int>* p, int i);								//Method to backpatch 

void typecheck(exp_attr* E1, exp_attr* E2);							//Typecheck method 	

bool parametercheck(symboltable* function, vector<exp_attr>* args);	//Method to check if the parameters match when making a function call

void double2int(exp_attr* E);										//converts double to int and generates appropriate quad

void int2double(exp_attr* E);										//converts int to double and generates appropriate quad										

void char2int(exp_attr* E);											//converts char to int and generates appropriate quad

void int2char(exp_attr* E);											//converts int to char and generates appropriate quad

void bool2int(exp_attr* E);											//converts implicit bool to int and generates appropriate quad

void int2bool(exp_attr* E);											//generates quads for non bool expressions

#endif
