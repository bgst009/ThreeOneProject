void f(int *a);

main() {
    void (*p)(void *);
    int a = 5;
    p = f;
    p(&a);
}

void f(int *a) { printf("%d\n", *a); }