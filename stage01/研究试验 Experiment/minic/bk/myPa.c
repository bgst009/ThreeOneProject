void myPrintf(char *, ...);

main()
{
    printf("%d",-3);
    myPrintf("char %c,%nint %d %nint %d", 'x', -32768, 3);
}


void myPrintf(char *str, ...)
{
    int stackIndex = 0;
    int stringIndex = 0;
    int screenIndex = 0;
    int screenBenchmark = 160 * 10;
    int quotient = 0; /*保存每次除法的商*/
    int pushnum = 0;  /*除法时入栈次数计数器*/

    while (str[stringIndex] != 0)
    {
        if (str[stringIndex] == '%')
        {
            if (str[stringIndex + 1] == 'c')
            {
                *(char far *)(0xb8000000 + screenBenchmark + screenIndex) = *(char *)(_BP + 6 + stackIndex); /*跨 push call 第一个参数 才能取到相应的值*/
                *(char far *)(0xb8000000 + screenBenchmark + screenIndex + 1) = 2;
                screenIndex += 2;
                stringIndex += 2;
                stackIndex += 2;
            }
            else if (str[stringIndex + 1] == 'd')
            {
                pushnum = 0;
                quotient = *(int *)(_BP + 6 + stackIndex);
                if (quotient == 0)
                {
                    *(char far *)(0xb8000000 + screenBenchmark + screenIndex) = 0 + 0x30;
                    *(char far *)(0xb8000000 + screenBenchmark + screenIndex + 1) = 2;

                    screenIndex += 2;
                }
                while (quotient != 0)
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
                    *(char far *)(0xb8000000 + screenBenchmark + screenIndex) = _CL + 0x30;
                    *(char far *)(0xb8000000 + screenBenchmark + screenIndex + 1) = 2;
                    screenIndex += 2;
                }

                stackIndex += 2;
                screenIndex += 2;
                stringIndex += 2;
            }
            else if (str[stringIndex + 1] == 'n')
            {
                screenBenchmark += 160;
                screenIndex = 0;
                stringIndex += 2;
            }
        }
        else
        {
            *(char far *)(0xb8000000 + screenBenchmark + screenIndex) = str[stringIndex];
            *(char far *)(0xb8000000 + screenBenchmark + screenIndex + 1) = 2;

            screenIndex += 2;
            stringIndex += 1;
        }
    }
}