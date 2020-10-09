int func(int, int);

int a, b;

main() {
    a = f1(1, 2);
    b = f2(20, 10);
    a = func(a, b);
    printf("%d\n", a);
}

int func(int a, int b) { return a * b; }