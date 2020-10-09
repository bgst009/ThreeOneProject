int f(char, char);
main() {
    int a;
    int b;
    long c;
    int (*p)(char, char);

    p = f;
    b = (int)f;
    c = (long)f;

    printf("main=%x f=%x\n", main, f);
    printf("p=%x    b=%x c=%lx\n", p, b, c);

    a = p(1, 2);
    printf("%d\n", a);

    a = ((int (*)(char, char))b)(1, 2);
    printf("%d\n", a);
}
int f(char a, char b) { return a + b; }