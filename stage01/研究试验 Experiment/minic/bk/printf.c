void print(int color, int row, int col, char *str, ...);

void main()
{
    print(2, 13, 30, "12345");
    print(3, 14, 30, "%c,%c,%c,%c", 'a', 'b', 'c', 'd');
    print(4, 15, 30, "%d,%d", 7, 8);
    print(5, 20, 12, "%c,%d,123abc,%d", 'z', 13, 3456);
}

/*参数列表：颜色，行，列，打印格式，附加参数1，附加参数2...*/
void print(int color, int row, int col, char *str, ...)
{
    int strnum = 0;                      /*字符串位置计数器*/
    int stacknum = 0;                    /*栈字符位置计数器*/
    char ch = str[strnum++];             /*要处理的下一个字符*/
    int scrnum = 80 * 2 * row + col * 2; /*显存位置*/
    int quotient = 0;                    /*保存每次除法的商*/
    int pushnum = 0;                     /*除法时入栈次数计数器*/
    while (ch)                           /*如果下一个字符为0，则跳出循环*/
    {
        if (ch == '%')
        {
            /*如果ch是%，那么先读出下一个字符*/
            ch = str[strnum++];
            /*判断下一个字符是c还是d，并分别处理*/
            switch (ch)
            {
            /*如果是c，按照字符型输出栈中相应数据*/
            case 'c':
                *(char far *)(0xb8000000 + (scrnum++)) = *(int *)(_BP + 12 + (stacknum++));
                *(char far *)(0xb8000000 + (scrnum++)) = color;
                break;

            /*如果是d，按照十进制整形输出栈中相应的数据*/
            case 'd':
                pushnum = 0;
                quotient = *(int *)(_BP + 12 + (stacknum++));
                if (quotient == 0)
                {
                    *(char far *)(0xb8000000 + (scrnum++)) = '0';
                    *(char far *)(0xb8000000 + (scrnum++)) = color;
                }
                while (quotient)
                {
                    _CX = quotient % 10;
                    _SP -= 2; /*模拟入栈过程*/
                    *(int *)(_SP) = _CX;
                    pushnum++;
                    quotient /= 10;
                }
                while (pushnum--)
                {
                    _CX = *(int *)(_SP); /*模拟出栈过程*/
                    _SP += 2;
                    *(char far *)(0xb8000000 + (scrnum++)) = _CL + 48;
                    *(char far *)(0xb8000000 + (scrnum++)) = color;
                }
                break;
            }
            stacknum++;
        }
        else /*如果当前ch值不是%，那么直接将ch写入到显存*/
        {
            *(char far *)(0xb8000000 + (scrnum++)) = ch;
            *(char far *)(0xb8000000 + (scrnum++)) = color;
        }

        /*读取下一个字符*/
        ch = str[strnum++];
    }
}