int a1, a2, a3;

void f(void);

main()
{
    int b1, b2, b3;

    a1 = 0xa1;
    a2 = 0xa2;
    a3 = 0xa3;

    b1 = 0xb1;
    b2 = 0xb2;
    b3 = 0xb3;
}

void f(void)
{
    int c1, c2, c3;

    a1 = 0xfa1;
    a2 = 0xfa2;
    a3 = 0xfa3;

    c1 = 0xc1;
    c2 = 0xc2;
    c3 = 0xc3;
}