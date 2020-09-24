int a;
void f1(void) { a = 1; }
void f2(void) { a = 2; }
void f3(void) { a = 3; }
main() {
    printf("%X\n", _CS);
    printf("%x:%x\n", &f1, f1);
}