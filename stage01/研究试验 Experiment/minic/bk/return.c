float f(void);

float a, b, ab;

main()
{
    float c;
    c = f();
}

float f(void)
{
    a=1.1;
    b=1.1;

    ab = a + b;
    
    return ab;
}