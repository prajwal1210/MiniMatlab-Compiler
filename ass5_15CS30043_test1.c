//Tests passing matrices to functions, matrix initializations and operations

int printFlt(double n);
int printStr(char* str);
int readFlt(double* f);

double sum(Matrix mat[3][3]){
	double s = 0;
	Matrix m[3][3] = {1.1,2.2,3.3;4.5,5.6,6.7;4.8,6.9,5.7};
	int p,q;
	int x;
	m = m.';
	x = printStr("The matrix to be added : \n");	
	for(p=0;p<3;p++)
	{
		for(q=0;q<3;q++)
		{
			x=printFlt(m[p][q]);
			x = printStr(" ");
		}
		x = printStr("\n");
	}
	m = m+mat;
	int i,j;
	for(i=0;i<3;i++)
	{
		for(j=0;j<3;j++)
		{
			s = s + m[i][j];
		}
	}
	return s;
}

double diffsum(Matrix mat[3][3]){
	double s = 0;
	Matrix m[3][3] = {1.1,2.2,3.3;4.5,5.6,6.7;4.8,6.9,5.7};
	int i,j,p,q,x;
	x = printStr("The matrix from which the input will be subtracted : \n");	
	for(p=0;p<3;p++)
	{
		for(q=0;q<3;q++)
		{
			x=printFlt(m[p][q]);
			x = printStr(" ");
		}
		x = printStr("\n");
	}
	m = m-mat;
	for(i=0;i<3;i++)
	{
		for(j=0;j<3;j++)
		{
			s = s + m[i][j];
		}
	}
	return s;
}

Matrix negate(Matrix mat[3][3])
{
	Matrix m[3][3];
	int p,q,x;
	m = -mat;
	x = printStr("The negated matrix is: \n");	
	for(p=0;p<3;p++)
	{
		for(q=0;q<3;q++)
		{
			x=printFlt(m[p][q]);
			x = printStr(" ");
		}
		x = printStr("\n");
	}
	return m;
}


int main(){
	Matrix mat[3][3];
	int i;	
	int a;
	int b;
	int p,q,x;
	double k;
	i = printStr("Enter 9 values for the matrix : \n");
	for(p=0;p<3;p++)
	{
		for(q=0;q<3;q++)
		{
			i=readFlt(&mat[p][q]);
		}
	}
	i = printStr("\nInput Matrix:\n");
	for(p=0;p<3;p++)
	{
		for(q=0;q<3;q++)
		{
			i=printFlt(mat[p][q]);
			i = printStr(" ");
		}
		i = printStr("\n");
	}
	
	a = 10;
	b = 9;
	double c;
	i = printStr("\nCalling Sum:\n");
	c =sum(mat);
	i = printStr("The sum of all elements in the addition of the two matrices: ");	
	i = printFlt(c);	
	i = printStr("\n\n");
	i = printStr("Calling SumDiff:\n");
	c = diffsum(mat);
	i = printStr("The sum of all elements in the subtraction of the two matrices: ");	
	i = printFlt(c);
	i = printStr("\n\n");
	i = printStr("\nCalling Negate to negate the input matrix:\n");
	mat = negate(mat);
	i = printStr("\n");	
	i = printStr("\nCalling Sum with the negated matrix:\n");	
	c = sum(mat);
	i = printStr("The sum of all elements in the addition of the two matrices: ");	
	i = printFlt(c);
	i = printStr("\n");	
	return 0;
}
