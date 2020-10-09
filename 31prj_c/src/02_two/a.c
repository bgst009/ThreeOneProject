int a;
void f1(void) { a = 1; }
void f2(void) { a = 2; }
void f3(void) { a = 3; }
main() {
    char *string = "--------------------";
    printf("\nCS: %x\n", _CS);
    printf("%s", string);
    printf("\nf1: %lx\n", (long)f1);
    printf("\nf2: %lx\n", (long)f2);
    printf("\nf3: %lx\n", (long)f3);
}