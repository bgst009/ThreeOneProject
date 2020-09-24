int a;
void f1(void) { a = 1; }
void f2(void) { a = 2; }
void f3(void) { a = 3; }
main() {
    char *string = "--------------------";
    printf("\nCS: %x\n", _CS);
    printf("%s", string);
    printf("\nf1: %x\n", f1);
    printf("\nf2: %x\n", f2);
    printf("\nf3: %x\n", f3);
}