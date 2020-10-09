int add(int a, int b) { return a + b; }
int sub(int a, int b) { return a - b; }
int mul(int a, int b) { return a * b; }
int div(int a, int b) { return a / b; }
int f2(int (*p)(int, int));
void f3(int (*p[])(int, int), int);
int (*p)(int, int);
int (*pb[4])(int, int) = {add, sub, mul, div};
int a;
int i;
main() {
    p = add;
    a = f2(p);
    printf("%d\n", a);
    f3(pb, 4);
}
int f2(int (*p)(int, int)) {
    printf("---------------f2-----------------\n");
    return p(1, 2) + 1;
}
void f3(int (*p[])(int, int), int size) {
    printf("---------------f3-----------------\n");
    for (i = 0; i < size; i++) {
        a = p[i](8, 4);
        printf("%d\n", a);
    }
}