#define ERR 1
#define OK 0
#define BUFF 200 


int printStr(char* str)
{
	int i=0;
	while(str[i]!='\0')
	{
		i++;
	}
	int size = i;
	int flag;
	__asm__ __volatile__(
		"movl $1, %%eax\n\t"
		"movq $1, %%rdi\n\t"
		"syscall\n\t"
		:"=a"(flag)
		:"S"(str), "d"(size)
		) ; // $1: write, $1: on stdin
	
	if(flag < 0)
		return ERR;
	else 
		return flag; 

}


int readInt(int* n)
{
	int temp = 0;
	char buff[BUFF]="";
	int i = 0;
	int neg = 0; 
	int len;
	__asm__ __volatile(
		"movl $0,%%eax \n\t"
		"movq $0, %%rdi \n\t"
		"syscall \n\t"
		:"=a"(len)
		:"S"(buff),"d"(BUFF)
		);
	len = len - 1;
	if(buff[0] == '-')
	{
		neg = 1;
		i++;
		if(len == 1)
			return ERR;
	}
	else if(buff[0] < '0' || buff[0] > '9')
	{
		return ERR;
	}
	while(i <= len - 1)
	{	
		if(buff[i] >= '0' && buff[i] <= '9')
		{
			temp = temp*10 + (int)(buff[i] - '0');
			i++;
		}
		else 
		{
			len = -1; 
			break;
		}
	}
	if(neg == 1)
		temp = -temp;
	
	if(len < 0)
		return ERR;
	else{
		*n = temp;
		return OK; 
	}
}




int printInt(int n)
{
	char buff[BUFF];
	int i=0,j,k,size;
	if(n==0)
		buff[i++]='0';
	else{
		if(n<0){
			buff[i]='-';
			n = -n;
			i = i+1;
		}
		int m = n;
		while(m){
			int dig = m%10;
			buff[i]=(char)('0'+dig);
			m/=10;
			i++;
		}
		if(buff[0]=='-')
			j=1;
		else 
			j=0;
		k=i-1;
		while(j<k){
			char temp = buff[j];
			buff[j] = buff[k];
			buff[k] = temp;
			j++;
			k--;
		}
	}
	size = i;
	int flag;
	__asm__ __volatile__(
		"movl $1, %%eax\n\t"
		"movq $1, %%rdi\n\t"
		"syscall\n\t"
		:"=a"(flag)
		:"S"(buff), "d"(size)
		) ; 
	
	if(flag < 0)
		return ERR;
	else 
		return flag; 

}



int readFlt(double* f)  // the following inputs have also been considered valid : .23 , 55. , -.27 
{
	double temp;
	double temp1 = 0;
	double temp2 = 0;
	int i = 0;
	int neg = 0;
	int len;
	char buff[BUFF] = "";
	__asm__ __volatile(
		"movl $0,%%eax \n\t"
		"movq $0, %%rdi \n\t"
		"syscall \n\t"
		:"=a"(len)
		:"S"(buff),"d"(BUFF)

		); // $1: write, $1: on stdin
	len = len -1;
	if(buff[0] == '-')
	{
		neg = 1;
		i++;
		if(len == 1)
			return ERR;
	}
	else if((buff[0] < '0' || buff[0] > '9') && buff[0] != '.')
	{
		return ERR;
	}
	while(buff[i] != '.' && i <= len - 1)
	{	
		if(buff[i] >= '0' && buff[i] <= '9')
		{
			temp1 = temp1*10 + (int)(buff[i] - '0');
			i++;
		}
		else
		{
			len = -1; 
			break;
		}
	}
	if(buff[i] == '.')
	{
		if(len == 1 || (len == 2 && neg == 1))
			return ERR;
		int k = 0;
		i++;
		while(i <= len -1)
		{
			if(buff[i] >= '0' && buff[i] <= '9')
			{
				temp2 = temp2*10 + (int)(buff[i] - '0');
				i++;
				k++;
			}
			else
			{
				len = -1; 
				break;
			}
		}
	while(k--)
	{
		temp2 = temp2/10;
	}
	}
	temp = temp1 + temp2;
	if(neg == 1)
		temp = -temp;
	if(len < 0)
		return ERR;
	else{
		*f = temp;
		return OK; 
	}
}





int printFlt(double f)
{
	char buff[BUFF];
	int i=0,j,k,size;
	if(f<0){
			buff[i]='-';
			f = -f;
			i = i+1;
		}
	int int_part = (int)f;
	double flt_part = f - int_part;
	if(int_part==0)
		buff[i++]='0';
	else{
		int m = int_part;
		while(m){
			int dig = m%10;
			buff[i]=(char)('0'+dig);
			m/=10;
			i++;
		}
		if(buff[0]=='-')
			j=1;
		else 
			j=0;
		k=i-1;
		while(j<k){
			char temp = buff[j];
			buff[j] = buff[k];
			buff[k] = temp;
			j++;
			k--;
		}
	}
		buff[i++]='.';
		if(flt_part == 0)
		{
			buff[i++] = '0';
		}
		else{
			int k = 1;
			while((int)flt_part != flt_part && i < BUFF && k<=6)
			{
				flt_part = flt_part * 10; 
				buff[i++] = (char)((int)(flt_part) + '0');
				flt_part = flt_part - (int)(flt_part);
				k++;
			}
		}
	size = i;
	int flag;
	__asm__ __volatile__(
		"movl $1, %%eax\n\t"
		"movq $1, %%rdi\n\t"
		"syscall\n\t"
		:"=a"(flag)
		:"S"(buff), "d"(size)
		) ; 
	
	if(flag < 0)
		return ERR;
	else 
		return flag; 

}


