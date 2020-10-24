void myPrintf(char *, ...);

main()
{
    myPrintf(" char: %c%n int: %d", 'x', 5);
}

void myPrintf(char *str, ...)
{
    int stackIndex = 0;
    int stringIndex = 0;
    int screenIndex = 0;
    int screenBenchmark = 160 * 10;

    while (str[stringIndex] != 0)
    {
        if (str[stringIndex] == '%')
        {
            if (str[stringIndex + 1] == 'c')
            {
                *(char far *)(0xb8000000 + screenBenchmark + screenIndex) = *(char *)(_BP + 6 + stackIndex);
                *(char far *)(0xb8000000 + screenBenchmark + screenIndex + 1) = 2;
                screenIndex += 2;
                stringIndex += 2;
                stackIndex += 2;
            }
            else if (str[stringIndex + 1] == 'd')
            {
                *(char far *)(0xb8000000 + screenBenchmark + screenIndex) = *(char *)(_BP + 6 + stackIndex) + 0x30;
                *(char far *)(0xb8000000 + screenBenchmark + screenIndex + 1) = 2;

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