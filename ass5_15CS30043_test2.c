//Testing Recursive calls and other basic operations on data types

int printInt(int n);
int readInt(int* n);
int printStr(char* str);
int readFlt(double* f);
int printFlt(double f);

int fact(int a)
{
	if(a==1)
		return 1;
	else 
	return a*fact(a-1);
}

int sum(int a, int b)
{
	int c;
	c = a+b;
	return c;
}

char sumchar(char a, char b)
{
	char c;
	c = a+b;
	return c;
}

void main(){
	int m,n,c; 
	int i;
	i = printStr("Enter an integer M:\n");		
	i = readInt(&m);
	i = printStr("Enter an integer n:\n");		
	i = readInt(&n);
	c = sum(n,m);
	i = printStr("Sum of the two integers :\n");		
	i = printInt(c);
	i = printStr("\n");
	i = printStr("Difference of the two integers :\n");				
	c = m-n;	
	i=printInt(c);
	i = printStr("\n");
	i = printStr("Product of the two integers :\n");				
	c = m*n;	
	i=printInt(c);
	i = printStr("\n");
	i = printStr("Quotient of the two integers :\n");				
	c = m/n;	
	i=printInt(c);
	i = printStr("\n");
	i = printStr("Remainder of the two integers :\n");				
	c = m%n;	
	i=printInt(c);
	i = printStr("\n");
	i = printStr("Factorial of M :\n");				
	c = fact(m);	
	i=printInt(c);
	i = printStr("\n");
	i = printStr("Factorial of N :\n");				
	c = fact(n);	
	i=printInt(c);
	i = printStr("\n");
	char schar2 = 'a';
	char schar3 = 'b';
	char schar = sumchar(schar2,schar3);
	double x,y,z;
	i = printStr("Enter an double X:\n");		
	i = readFlt(&x);
	i = printStr("Enter an double Y:\n");		
	i = readFlt(&y);
	i = printStr("Sum of the two doubles :\n");				
	z = x+y;	
	i=printFlt(z);
	i = printStr("\n");
	i = printStr("Difference of the two doubles :\n");				
	z = x-y;	
	i=printFlt(z);
	i = printStr("\n");
	i = printStr("Product of the two doubles :\n");				
	z = x*y;	
	i=printFlt(z);
	i = printStr("\n");
	i = printStr("Division of the two doubles :\n");				
	z = x/y;	
	i=printFlt(z);
	i = printStr("\n");
	//char schar,schar2,schar3;
	//int d = fact(5);
	//int k=printInt(d);
	return;
}

