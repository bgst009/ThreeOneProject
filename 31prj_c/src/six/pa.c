int *pi;
int i;
void f();
main() {
    f();
    for (i = 0; i < 10; i++) {
        printf("%d ", pi[i]);
    }
}
void f() {
    int ia[10];
    for (i = 0; i < 10; i++) {
        ia[i] = i + 1;
        printf("%d ", ia[i]);
    }
    printf("\n");
    for (i = 0; i < 10; i++) {
        printf("%d ", *(ia + i));
    }
    printf("\n");

    pi = ia;
}