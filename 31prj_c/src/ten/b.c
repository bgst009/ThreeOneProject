int far f(char, char);
main() {
    int a;
    int b;
    long c;
    int(far * p)(char, char);

    p = f;
    b = (int)f;
    c = (long)f;

    printf("main offset=%x\n", main);
    printf("main=%lx\n", (long)main);
    printf("f offset=%x\n", (int)f);
    printf("f=%lx\n", f);
    printf("p=%lx b=%x c=%lx\n", p, b, c);

    a = p(1, 2);
    printf("%d\n", a);

    a = ((int(far *)(char, char))c)(1, 2);
    printf("%d\n", a);
}
int far f(char a, char b) { return a + b; }