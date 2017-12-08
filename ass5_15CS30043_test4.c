int printInt(int n);
int readInt(int* n);
int printStr(char* str);

void main()
{
    int num, temp, remainder, reverse = 0;
    int i = printStr("Enter an integer \n");
    i = readInt(&num);
    /*  original number is stored at temp */
    temp = num;
    while (temp > 0)
    {
        remainder = temp % 10;
        reverse = reverse * 10 + remainder;
        temp = temp/10;
    }
    i = printStr("Given number is = ");
    i = printInt(num);
    i = printStr("\n");
    i = printStr("Its reverse is  = ");
    i = printInt(reverse);
    i = printStr("\n");
    if (num == reverse)
        i = printStr("Number is a palindrome \n");
    else
        i = printStr("Number is not a palindrome \n");
    return;
}