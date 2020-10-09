struct n {
    int a;
    int b;
    int c;
};

int f(struct n);

struct n func(void);

main() {
    struct n a;
    int b;

    a = func();
    b = f(a);

    printf(" %d", b);
    printf(" %d", f(func()));
}

int f(struct n a) { return (a.a + a.b) * a.c; }

struct n func(void) {
    struct n a;
    a.a = 1;
    a.b = 2;
    a.c = 3;
    return a;
}