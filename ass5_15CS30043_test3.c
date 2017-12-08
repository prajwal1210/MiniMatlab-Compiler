//Test for pointers and pointer functions and increment decrement 

int printInt(int n);
int readInt(int* n);
int printStr(char* str);

int* assign(int* p)
{
	return p;
}

int main(){
	int a,*b;
	int i = printStr("Enter an integer a:\n");
	i = readInt(&a);	
	i = printStr("We have assigned a pointer b to a\n");
	b = assign(&a);
	
	i = printStr("Result of a after a<=*b+a : ");
	a = *b+a;
	i = printInt(a);
	i = printStr("\n");

	i = printStr("Result of a after a<=(*b)*a : ");
	//a = *b-a;
	//i = printInt(a);
	a = (*b) * a;
	i = printInt(a);
	i = printStr("\n");	
	
	i = printStr("Result of a after a<=(*b)/a : ");
	a = (*b)/a;
	i = printInt(a);
	i = printStr("\n");

	i = printStr("Result of a after a<=(*b)%a : ");
	a = *b%a;
	i = printInt(a);
	i = printStr("\n");
	
	i = printStr("Value of (*b) after a++ : ");
	a++;
	i = printInt(*b);
	i = printStr("\n");
	
	i = printStr("Value of (*b) after ++a : ");
	++a;
	i = printInt(*b);
	i = printStr("\n");
	
	i = printStr("Value of (*b) after a-- : ");
	a--;
	i = printInt(*b);
	i = printStr("\n");
	
	i = printStr("Value of (*b) after --a : ");	
	--a;
	i = printInt(*b);
	i = printStr("\n");
	return 1;
}
