int printFlt(double f);
int printStr(char* str);
int printInt(int n);

void spiralPrint(int m, int n, Matrix a[4][3])
{
	int p;
    int i, k = 0, l = 0;
    while (k < m && l < n)
    {
        for (i = l; i < n; ++i)
        {
            p = printFlt(a[k][i]);
            p = printStr(" ");
        }
        k++;
        for (i = k; i < m; ++i)
        {
            p = printFlt(a[i][n-1]);
            p = printStr(" ");
        }
        n--;
 
        if (k < m)
        {
            for (i = n-1; i >= l; --i)
            {
                p = printFlt(a[m-1][i]);
                p = printStr(" ");
            }
            m--;
        }
 
        if (l < n)
        {
            for (i = m-1; i >= k; --i)
            {
                p = printFlt(a[i][l]);
                p = printStr(" ");
            }
            l++;    
        }        
    }
    return;
}

void spiralPrintTrans(int m, int n, Matrix a[3][4])
{
	int p;
    int i, k = 0, l = 0;
    //p = printInt(k);
    //p = printInt(l);
    while (k < m && l < n)
    {
        for (i = l; i < n; ++i)
        {
            p = printFlt(a[k][i]);
            p = printStr(" ");
        }
        k++;
        for (i = k; i < m; ++i)
        {
            p = printFlt(a[i][n-1]);
            p = printStr(" ");
        }
        n--;
 
        if (k < m)
        {
            for (i = n-1; i >= l; --i)
            {
                p = printFlt(a[m-1][i]);
                p = printStr(" ");
            }
            m--;
        }
 
        if (l < n)
        {
            for (i = m-1; i >= k; --i)
            {
                p = printFlt(a[i][l]);
                p = printStr(" ");
            }
            l++;    
        }        
    }
    return;
}

 
int main()
{
	int p;
    Matrix a[4][3] = {1,2,3;4,5,6;7,8,9;10,11,12};
    int i,j;
    p = printStr("The given matrix is :\n");
    for(i=0;i<4;i++)
	{
		for(j=0;j<3;j++)
		{
			p=printFlt(a[i][j]);
			p = printStr(" ");
		}
		p = printStr("\n");
	}
    p = printStr("The matrix printed in spiral form is:\n");
    spiralPrint(4,3,a);
    Matrix b[3][4];
    b = a.';
    p = printStr("\n");
    p = printStr("\n");
    p = printStr("The transposed matrix is :\n");
    for(i=0;i<3;i++)
	{
		for(j=0;j<4;j++)
		{
			p=printFlt(b[i][j]);
			p = printStr(" ");
		}
		p = printStr("\n");
	}
	p = printStr("The transposed matrix printed in spiral form is:\n");
    spiralPrintTrans(3,4,b);
   	p = printStr("\n");
    return 0;
}