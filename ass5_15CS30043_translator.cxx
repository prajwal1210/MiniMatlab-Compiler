#include "ass5_15CS30043_translator.h"
extern int yydebug;
extern char * yytext;
extern int yyparse();

extern int yylex();
#include <iostream>
#include <string>
#include <vector>
#include <sstream>
#include <iomanip>
#include <map>
#include <bits/stdc++.h>
using namespace std;
extern int yyerror(string);

symboltable* globalsymboltable=new symboltable("ST(GLOBAL)");		//Global symbol table
	
symboltable* currentsymboltable=globalsymboltable;					//pointer to the currentsymoltable. We start with it pointing to the global table

quadArray* quads = new quadArray();									//pointer to our quadArray

int count_temp=0; 													//counter for compiler generated temporaries 

map<string,int> strings;	 
vector<string> stringkeys; 

//default constructor for the type class
type::type(){}

//Parameterized constructor for the type class
//Inputs -> basictype b
//Output -> an object of the class type with basictype actype = b
type::type(basictype b)
{
	actype = b;
	rows = 0;
	cols = 0;
	size = this->get_size();
	pointerto = NULL;
	retval = NULL;


}


//Parameterized constructor for the type class used for matrices
//Inputs -> basictype b, rows and cols
//Output -> an object of the class type with basictype actype = b and rows and cols defined 
type::type(basictype b, int rows, int cols)
{
	actype = b;
	this->rows = rows;
	this->cols = cols;
	size = this->get_size();
	this->pointerto=NULL;
	this->retval = NULL;

}


//Function to get the size of the type
//Output -> size in bytes
//Algo -> Mostly trivial but the size of matrix involves multiplying rows and cols and 8(size of double) + 8(to store the no. of rows and cols)
int type::get_size()
{
	switch(this->actype){
		
		case t_integer: return SIZE_INT;
						break; 
		
		case t_double: 	return SIZE_DOUBLE;
					   	break;
		
		case t_char:	return SIZE_CHAR;
						break;
		
		case t_void:	return SIZE_VOID;
						break;

		case t_func: 	return SIZE_VOID;
						break;
		
		case t_pointer:	return SIZE_POINTER;
						break;
		
		case t_mat:		return (this->rows*this->cols*SIZE_DOUBLE + 2*SIZE_INT);
						break;
	}
}

//Function to check if two type objects are same or not
//Input - type E1, type E2, bool cmatsize which is false by default
//Output - true if they are of same types 
//The cmatsize == true denotes that we do not need to check the sizes of matrices being equal which is required in cases of pointers to matrices 
bool are_same_type(type E1, type E2, bool cmatsize)
{
	if(E1.pointerto == NULL && E2.pointerto == NULL)
	{

	if(E1.actype==E2.actype &&(cmatsize || ((E1.rows==E2.rows && E1.cols==E2.cols) && (E1.size==E2.size))))
		return true;
	else 
		return false;
	}
	else if(E1.pointerto != NULL && E2.pointerto !=NULL) 
		return are_same_type(*(E1.pointerto),*(E2.pointerto),true);
	else 
		return false;
}


//Constructor to create a symbol table entry with the given name
symentry::symentry(string name)
{
	this->name = name;
	this->size = 0;
	this->offset = 0;
	this->nested_table = NULL;
	this->wasInit = false;
	this->isParam = false;
	this->isConst = false;
}

//Function to set the initial value of the symbol table entry 
void symentry::setInitialVal(initialVal i)
{
	this->init = i;
	this->wasInit = true;
}

//Constructors to create a symbol table with the name s  
symboltable::symboltable(string s)
{
	offset = 0;
	name = s;
}

//Function to check if an entry with the name n is already present in the symbol table
//Input -> name of the entry to be searched as a string
//Output -> boolean value
//Algo -> The function iterates overall the symbol table entries and sees if the name gets matched
bool symboltable::isPresent(string n)
{
	int size = symentries.size();
	for(int i=0;i<size;i++)
	{
		if(symentries[i]->name == n)
			return true;
	}
	return false;
}


//Function to check if an entry with the name n is already present in the symbol table and return a pointer to it. If not then it creates an entry with that name and returns a pointer to it.
//Input -> name of the entry to be searched as a string
//Output -> pointer to the symbol table entry 
//Algo -> The function iterates overall the symbol table entries and sees if the name gets matched. If not matched, creates an entry with that name
symentry* symboltable::lookup(string n)
{
	int size = symentries.size();
	for(int i=0;i<size;i++)
	{
		if(symentries[i]->name == n)
			return symentries[i];
	}
	symentry* newentry= new symentry(n);
	symentries.push_back(newentry);
	return newentry;

}


//Function to generate a temporary of the given type and return a pointer to the corresponding symbol table entry 
//Input -> type of the temporary
//Output -> pointer to the symbol table entry of the generated temporary 
//Algo -> Calls the constructor appropriately to generate a symbol table entry for the temporary and assigns its name according to count_temps. It also updates the offset of the symbol table
symentry* symboltable::gentemp(type ty)
{
	symentry* temp = new symentry("t");
	string s = "t";
	ostringstream str1;
	str1 << count_temp;
	s = s+str1.str();
	temp->name = string(s);
	count_temp++;
	temp->t=ty;
	temp->size=ty.get_size();
	temp->offset = this->offset;
	this->offset += temp->size;
	symentries.push_back(temp);
	return temp;
}

//Function to the update the type of a symbol table entry 
//Input -> pointer to the symbol table entry to be updated, type 
//The function updates the type and adjusts the offset accordingly. WE NEED TO KEEP IN MIND THAT THIS FUNCTION WILL ONLY BE USED TO UPDATE TYPES IMMEDIATELY AFTER CREATING THE TABLE ENTRY SO OFFSET READJUSTMENT IS NOT REQUIRED
void symboltable::update(symentry* entry,type t)
{
	entry->t = t;
	entry->size = t.get_size();
	entry->offset = offset;
	this->offset += entry->size;
}


//Function to print the symbol table in a formatted manner
//printentry sybroutine call prints each entry 
void symboltable::print(){
	cout << setfill('-');
	cout << setw(150) << '-' << endl;
	cout << setfill(' ');
	cout <<left << setw(70) << this->name << endl;
	cout << left << setw(10) << "Name";
	cout << left << setw(50) << "Type";
	cout << left << setw(10) << "Size";
	cout << left << setw(10) << "Offset";
	cout << left << setw(30) << "Initial Value";
	cout << left << setw(20) << "Nested Table" << endl;
	cout << setfill('-');
	cout << setw(150) << '-' << endl;
	int s = symentries.size();
	for(int i=0;i<s;i++)
	{
		printentry(*symentries[i]);
		cout << endl;
	}
	cout << endl;
}


//Function to print symbol table entry in a formatted manner
//Input -> the symbol table entry to be printed
//Algo -> The function uses the iomanip library functions to properly format the output 
void symboltable::printentry(symentry entry){
	cout<< setfill(' ');
	cout << left << setw(10) << entry.name;
	cout << left << setw(50) << printtype(entry.t);
	cout << left <<setw(10);
	cout << entry.size;
	cout << left <<  setw(10);
	cout << entry.offset;
	cout << left << setw(30);
	if(entry.wasInit== true)
	{
		if(entry.t.actype == t_integer) 
			cout << entry.init.intVal;
		else if(entry.t.actype ==t_double)
			{
			char buff[50];
			sprintf(buff,"%lf",entry.init.dbVal.db);
			cout << buff;
			}
		else if(entry.t.actype == t_char)  
			 cout << entry.init.charVal;
		else if(entry.t.actype == t_mat)		
			{
				ostringstream tmp;
				int size = entry.init.matVal->size();
				tmp << "{";	
				for(int i=0;i<size;i++)
					tmp << (*entry.init.matVal)[i] << ",";
				tmp << "}";
				cout << tmp.str();
			}
		else
		 cout << "NIL";
	}
	else
		cout << "NIL";
	cout << left << setw(20);
	if(entry.t.actype == t_func)
		cout << entry.nested_table->name;
	else
		cout << "NULL";
	}

//Helper Function to the print the type of the symboltable entry
//Input -> Type to be printed
//Out -> The formatted string to be printed 
//The algorithm is a simple switch case algorithm but the pointer type recursively calls the function
string symboltable::printtype(type t)
{
	string s = "";
	ostringstream r;
	ostringstream c;
	switch(t.actype)
	{
		case t_integer: s= "INT";
						break;
		case t_double: s= "DOUBLE";
						break;
		case t_char: s= "CHAR";
						break;
		case t_void: s="VOID";
						break;
		case t_func: s="FUNCTION";
					break;
		case t_pointer: s="POINTER(";
						s = s+printtype(*t.pointerto);
						s=s + ")";
						break;
		case t_mat: r << t.rows;
					c << t.cols;
					s ="MATRIX(" + r.str() + "," + c.str() + ", double)";
					break;
		default: s= "Invalid Type";
	}
	return s;

}

//Constructor to generate a quad for operations x=yopz i.e Binary operations
quadentry::quadentry(string op, string arg1, string arg2, string res)
{
	this->op = op;
	this->arg1 = arg1;
	this->arg2 = arg2;
	this->res = res;
}

//Constructor to generate quads of unary operations
quadentry::quadentry(string op, string arg1, string res)
{
	this->op = op;
	this->arg1 = arg1;
	this->arg2 = "";
	this->res = res;
}

//Constructor for the copy operation
quadentry::quadentry(string arg1,string res)
{
	this->op = "copy";
	this->arg1 = arg1;
	this->arg2 = "";
	this->res = res;
}

//Constructor to create the quadArray object 
quadArray::quadArray(){
	nextinstr = 0;
}

//Emit function for quads of the form x=yopz or any other quads in which all three addresses are used(Binary ops)
void quadArray::emit(string op, string arg1, string arg2, string res)
{
	quadentry newentry(op,arg1,arg2,res);
	this->quadarray.push_back(newentry);
	this->nextinstr++;
}

//Emit function for unary operations
void quadArray::emit(string op, string arg1, string res)
{
	quadentry newentry(op,arg1,res);
	this->quadarray.push_back(newentry);
	this->nextinstr++;
}

//Emit function for the copy operation
void quadArray::emit(string arg1, string res)
{
	quadentry newentry(arg1,res);
	this->quadarray.push_back(newentry);
	this->nextinstr++;
}

//Function to print the quadArray by carefully interpretting each operation and generating well formatted Three Address codes
void quadArray::print(ofstream &fout)
{
	int s=quadarray.size();
	for(int i=0;i<s;i++)
		{
			fout << setfill('0') << right <<  setw(4) << i << " : ";
			if(quadarray[i].op == "copy")
				fout << quadarray[i].res << " = " << quadarray[i].arg1;
			else if(quadarray[i].op == "ret")
				fout << "return " << quadarray[i].res;
			else if(quadarray[i].op == "*")
				fout << quadarray[i].res << " = " << quadarray[i].arg1 << "*" << quadarray[i].arg2;
			else if(quadarray[i].op == "+")
				fout << quadarray[i].res << " = " << quadarray[i].arg1 << "+" << quadarray[i].arg2;
			else if(quadarray[i].op == "=[]")
				fout << quadarray[i].res << " = " << quadarray[i].arg1 << "[" << quadarray[i].arg2 << "]";
			else if(quadarray[i].op == "[]=")
				fout << quadarray[i].res << "[" << quadarray[i].arg2 << "] = " << quadarray[i].arg1;
			else if(quadarray[i].op == "-")
				fout << quadarray[i].res << " = " << quadarray[i].arg1 << "-" << quadarray[i].arg2;
			else if(quadarray[i].op == "-u")
				fout << quadarray[i].res << " = -" << quadarray[i].arg1;
			else if(quadarray[i].op == ".'")
				fout << quadarray[i].res << " =" << quadarray[i].arg1 << ".'";
			else if(quadarray[i].op == "&")
				fout << quadarray[i].res << " = &addr(" << quadarray[i].arg1 << ")";
			else if(quadarray[i].op == "*val")
				fout << quadarray[i].res << " = *(" << quadarray[i].arg1 << ")";
			else if(quadarray[i].op == "/")
				fout << quadarray[i].res << " = " << quadarray[i].arg1 << "/" << quadarray[i].arg2;
			else if(quadarray[i].op == "%")
				fout << quadarray[i].res << " = " << quadarray[i].arg1 << "%" << quadarray[i].arg2;
			else if(quadarray[i].op == "<<")
				fout << quadarray[i].res << " = " << quadarray[i].arg1 << "<<" << quadarray[i].arg2;
			else if(quadarray[i].op == ">>")
				fout << quadarray[i].res << " = " << quadarray[i].arg1 << ">>" << quadarray[i].arg2;
			else if(quadarray[i].op == "if<")
				fout << "if " << quadarray[i].arg1 << "<" << quadarray[i].arg2 <<" goto " <<quadarray[i].res;
			else if(quadarray[i].op == "if>")
				fout << "if " << quadarray[i].arg1 << ">" << quadarray[i].arg2 <<" goto " <<quadarray[i].res;
			else if(quadarray[i].op == "if<=")
				fout << "if " << quadarray[i].arg1 << "<=" << quadarray[i].arg2 <<" goto " <<quadarray[i].res;
			else if(quadarray[i].op == "if>=")
				fout << "if " << quadarray[i].arg1 << ">=" << quadarray[i].arg2 <<" goto " <<quadarray[i].res;
			else if(quadarray[i].op == "if==")
				fout << "if " << quadarray[i].arg1 << "==" << quadarray[i].arg2 <<" goto " <<quadarray[i].res;
			else if(quadarray[i].op == "if!=")
				fout << "if " << quadarray[i].arg1 << "!=" << quadarray[i].arg2 <<" goto " <<quadarray[i].res;
			else if(quadarray[i].op == "&bit")
				fout << quadarray[i].res << " = " << quadarray[i].arg1 << "&" << quadarray[i].arg2;
			else if(quadarray[i].op == "^")
				fout << quadarray[i].res << " = " << quadarray[i].arg1 << "^" << quadarray[i].arg2;
			else if(quadarray[i].op == "|")
				fout << quadarray[i].res << " = " << quadarray[i].arg1 << "|" << quadarray[i].arg2;
			else if(quadarray[i].op == "*copy")
				fout << "*(" << quadarray[i].res << ") =" << quadarray[i].arg1;
			else if(quadarray[i].op == "if")
				fout << "if " << quadarray[i].arg1 <<" goto " << "" <<quadarray[i].res;
			else if(quadarray[i].op == "goto")
				fout <<  "goto " <<quadarray[i].res;
			else if(quadarray[i].op == "(int)")
				fout << quadarray[i].res << " = (int)" << quadarray[i].arg1;
			else if(quadarray[i].op == "(double)")
				fout << quadarray[i].res << " = (double)" << quadarray[i].arg1;
			else if(quadarray[i].op == "(char)")
				fout << quadarray[i].res << " = (char)" << quadarray[i].arg1;
			else if(quadarray[i].op == "param")
				fout << "param " << quadarray[i].res; 
			else if(quadarray[i].op == "=call")
				fout << quadarray[i].res << " = " <<"call " << quadarray[i].arg1 << "," << quadarray[i].arg2;
			else if(quadarray[i].op == "f()") 
				fout << quadarray[i].res<< ":";
			//else if(quadarray[i].op == "negmat")
			//	cout << "negate " << quadarray[i].res << "["<<  quadarray[i].arg1 << "]";
			//cout << quadarray[i].op <<":"<< quadarray[i].arg1 <<":"<< quadarray[i].arg2 << ":"<<quadarray[i].res;
			fout << endl;
			
		}
}


//Function for integer to character conversion
//Input -> Pointer to the attribute of the expression
//Algo-> The function changes the type of the attribute to char and generates a new temporary of char type. It emits appropriate quad for the conversion
void int2char(exp_attr* E)
{
	exp_attr* E2 = new exp_attr();
	*E2 = *E;
	basictype t = t_char;
	E2->t_exp = new type(t);
	E2->addr = currentsymboltable->gentemp(*(E2->t_exp));
	quads->emit("(char)",E->addr->name,E2->addr->name);
	*E = *E2;

}


//Function for integer to character conversion
//Input -> Pointer to the attribute of the expression
//Algo-> The function changes the type of the attribute to char and generates a new temporary of char type. It emits appropriate quad for the conversion
void char2int(exp_attr* E)
{
	exp_attr* E2 = new exp_attr();
	*E2 = *E;
	basictype t = t_integer;
	E2->t_exp = new type(t);
	E2->addr = currentsymboltable->gentemp(*(E2->t_exp));
	quads->emit("(int)",E->addr->name,E2->addr->name);
	*E = *E2;

}

//Function for integer to double conversion
//Input -> Pointer to the attribute of the expression
//Algo-> The function changes the type of the attribute to double and generates a new temporary of double type. It emits appropriate quad for the conversion
void int2double(exp_attr* E)
{
	exp_attr* E2 = new exp_attr();
	*E2 = *E;
	basictype t = t_double;
	E2->t_exp = new type(t);
	E2->addr = currentsymboltable->gentemp(*(E2->t_exp));
	quads->emit("(double)",E->addr->name,E2->addr->name);
	*E = *E2;

}


//Function for double to integer conversion
//Input -> Pointer to the attribute of the expression
//Algo-> The function changes the type of the attribute to integer and generates a new temporary of integer type. It emits appropriate quad for the conversion
void double2int(exp_attr* E)
{
	exp_attr* E2 = new exp_attr();
	*E2 = *E;
	basictype t = t_integer;
	E2->t_exp = new type(t);
	E2->addr = currentsymboltable->gentemp(*(E2->t_exp));
	quads->emit("(int)",E->addr->name,E2->addr->name);
	*E = *E2;
}

//Function for implicit bool type to integer conversion
//Input -> Pointer to the attribute of the expression
//Algo-> The function changes the type of the attribute to char and generates a new temporary of char type. It emits appropriate quad for the conversion
void bool2int(exp_attr* E)
{
	exp_attr* E2 = new exp_attr();
	*E2 = *E;
	E2->truelist = NULL;
	E2->truelist = NULL;
	basictype t = t_integer;
	E2->t_exp = new type(t);
	E2->addr = currentsymboltable->gentemp(*(E2->t_exp));
	E2->addr->isConst = true;
	backpatch(E->truelist,quads->nextinstr);
	quads->emit("1",E2->addr->name);
	ostringstream s1;
	s1 << quads->nextinstr+2;
	quads->emit("goto","",s1.str());
	backpatch(E->falselist,quads->nextinstr);
	quads->emit("0",E2->addr->name);
	*E = *E2;

}

//Function to generate appropriate quads when an integer expression is to be used as a condition 
//Input -> Pointer to the attribute of the expression
//Algo-> The function changes the type of the attribute to Bool. It emits appropriate quad for the jump statements
void int2bool(exp_attr* E)
{	
	exp_attr* E2 = new exp_attr();
	E2->truelist = makelist(quads->nextinstr);
	quads->emit("if",E->addr->name,"");
	E2->falselist = makelist(quads->nextinstr);
	quads->emit("goto","","");
	E2->t_exp = new type(t_Bool);
	E2->isConst = false;
	*E=*E2;
}


//Function to check the type of two expressions. If they are same it does nothing otherwise it checks whether they are compatible or not and always converts E1 to the compatible E2 type. Otherwise it throws an error 
//Input -> Pointers to the attribute of the expressions E1 and E2
//Algo -> The function makes call to aresametype(E1,E2) first and if the types match it returns otherwise it checks if the types are compatible. Only int to char, char to int, double to int and int to double
//are the the allowed conversions. If possible it calls the appropriate function above for the conversion. If conversion is also not possible it generates error message 
void typecheck(exp_attr* E1, exp_attr* E2)
{
	if(are_same_type(*(E1->t_exp),*(E2->t_exp)))
		return;
	else
	{
		if(E1->t_exp->actype == t_integer && E2->t_exp->actype == t_char)
			int2char(E1);
		else if(E1->t_exp->actype == t_char && E2->t_exp->actype == t_integer)
			char2int(E1);
		else if(E1->t_exp->actype == t_integer && E2->t_exp->actype == t_double)
			int2double(E1);
		else if(E1->t_exp->actype == t_double && E2->t_exp->actype == t_integer)
			double2int(E1);
		else if(E1->t_exp->actype == t_Bool && E2->t_exp->actype == t_integer)
			bool2int(E1);
		else 
		{
			cout << "Incompatible types";
			exit(-1);
		}
	}

}

//Helper function to print a vector of integers
void printlist(vector<int>* p)
{
	int size = p->size();
	cout << "[";
	for(int i=0;i<size;i++)
		cout << (*p)[i] << ",";
	cout << "]";
}

//Function to make a new list. These lists are the ones used for backpatching
//The list is actually a vector of integers. The integers represent quad indexes that need to patched 
//Input -> i
//Output -> pointer to a vector with i as the only value stored in it
vector<int>* makelist(int i)
{
	vector<int> *v = new vector<int>(1,i);
	return v;

}

//Function to merge the lists p1 and p2
//Input -> pointers to vectors p1 and p2
//Output -> pointer to the merged vector
//The function creates a newlist and pushes elements from each vector to it and then returns a pointer to this new vector
vector<int>* merge(vector<int>* p1, vector<int>* p2) 
{
	if(p1== NULL && p2==NULL)
		return NULL;
	vector<int> *newlist = new vector<int>();
	if(p1!=NULL)
	{	int s1 = p1->size();
		for(int i=0;i<s1;i++)
			newlist->push_back((*p1)[i]);
	}
	if(p2!=NULL)
	{	int s2 = p2->size();
		for(int i=0;i<s2;i++)
			newlist->push_back((*p2)[i]);
	}
	return newlist;

}

//Function to backpatch the list p to i
//Input -> pointer to the vector which is the list to be backpatched and the value i to backpatch 
//Algo -> The function goes to the quad indexes stored in p and backpatches the result field with string(i)
void backpatch(vector<int>* p, int i)
{
	if(p==NULL)
		return;
	int size = p->size();
	int index;
	ostringstream s1;
	s1 << i;
	string s = s1.str();
	for(int i=0;i<size;i++)
	{
		index = (*p)[i];
		quads->quadarray[index].res = s;
	}
}

//Function to check whether the arguments in the args vector match the parameters of the function whose symboltable is provided
//Input -> symbol table of the function getting called and vector of exp_attr which denote the arguments
//Algo -> The function iterates through the symboltable and checks for entries for which isParam is true. When such an entry is encountered it checks the current argument with it using typecheck and increaments the index in the aruments list.
//At the end if the no. of parameters is more than the arguments or vice versa it returns false otherwise it returns true. In case types do not match, typecheck routine will generate appropriate error
bool parametercheck(symboltable* function, vector<exp_attr>* args)
{
	if(function == NULL)
	{
		cout << "Error Occured" << endl;
		exit(-1);
	}
	int argsize = args->size();
	int k=0;
	int size = function->symentries.size();
	for(int i=0;i<size;i++)
	{
		if(function->symentries[i]->isParam == true)
		{
			exp_attr temp;
			temp.t_exp = &(function->symentries[i]->t);
			typecheck(&((*args)[k]),&(temp));
			k++;
			if(k>argsize)
			{
				cout << "Error : Insuffecient arguments" << endl;
				exit(-1);
			}
		}
		else
			continue;
	}
	if(k==argsize)
		return true;
	else
		return false;
}


/*int main()
{
	int a = yyparse();
	if(a==0)
	{
		globalsymboltable->print();
		for(int i = 0; i<(int)globalsymboltable->symentries.size();i++)
		{
			if(globalsymboltable->symentries[i]->nested_table!=NULL)
				globalsymboltable->symentries[i]->nested_table->print();
		}
		quads->print();

   
	}
	return 1;	
}*/

