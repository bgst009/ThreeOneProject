void showchar(char a, int b);

main()
{
    printf("%c,%d",'a',1);
    showchar('a', 2);
} 

void showchar(char a, int b)
{
    *(char far *)(0xb8000000 + 160 * 10 + 2 * 40) = 'a';
    *(char far *)(0xb8000000 + 160 * 10 + 2 * 40 + 1) = 2;
}