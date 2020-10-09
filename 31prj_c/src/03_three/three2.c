void f(void);
main() {
    f();
    f();
}
void f(void) {
    int n = 0;
    static int a = 0;
    n++;
    a++;
    printf("  %d  %d\n", n, a);
}