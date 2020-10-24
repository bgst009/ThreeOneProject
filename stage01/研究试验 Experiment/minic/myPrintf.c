void print(char *str, ...);

void main()
{
    print("%c,%d", 'a', 8);
}

void print(char *str, ...)
{
    int strnum = 0;
    int stacknum = 0;
    char ch = str[strnum++];
    int scrnum = 80 * 2 * 10;
    int quotient = 0;
    int pushnum = 0;
    while (ch)
    {
        if (ch == '%')
        {

            ch = str[strnum++];

            switch (ch)
            {

            case 'c':
                *(char far *)(0xb8000000 + (scrnum++)) = *(int *)(_BP + 6 + (stacknum++));
                *(char far *)(0xb8000000 + (scrnum++)) = 2;
                break;

            case 'd':
                pushnum = 0;
                quotient = *(int *)(_BP + 6 + (stacknum++));
                if (quotient == 0)
                {
                    *(char far *)(0xb8000000 + (scrnum++)) = '0';
                    *(char far *)(0xb8000000 + (scrnum++)) = 2;
                }
                while (quotient)
                {
                    _CX = quotient % 10;
                    _SP -= 2;
                    *(int *)(_SP) = _CX;
                    pushnum++;
                    quotient /= 10;
                }
                while (pushnum--)
                {
                    _CX = *(int *)(_SP);
                    _SP += 2;
                    *(char far *)(0xb8000000 + (scrnum++)) = _CL + 48;
                    *(char far *)(0xb8000000 + (scrnum++)) = 2;
                }
                break;
            }
            stacknum++;
        }
        else
        {
            *(char far *)(0xb8000000 + (scrnum++)) = ch;
            *(char far *)(0xb8000000 + (scrnum++)) = 2;
        }

        ch = str[strnum++];
    }
}
