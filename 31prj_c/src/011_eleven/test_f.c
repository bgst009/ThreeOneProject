void f();
main() {
    printf("&f: %lx\n*f: %lx\n&(&f): %lx\n**f: %lx\n", (long)&f, (long)*f,
           (long)&(&f), (long)**f);
}
void f() { puts("hello world"); }