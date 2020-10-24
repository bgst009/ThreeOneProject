#define Buffer ((char far*)*(int far*)0x200)
void f(void);
main()
{
    printf("%x", main);
    (char far *) B =Buffer = (char *)malloc(20);
    Buffer[10] = 0;
    while (Buffer[10] != 8)
    {
        Buffer[Buffer[10]] = 'a' + Buffer[10];
        printf("%c",Buffer[Buffer[10]]);
        Buffer[10]++;
    }
    free(Buffer);
}
void f(void)
{
    int c1, c2, c3;
    c1 = 0xc1;
    c2 = 0xc2;
    c3 = 0xc3;
}