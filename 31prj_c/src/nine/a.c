void showstr(char *, ...);
char *p1 = "This is a c program.";
char *p2 = "Welcome to c !";
char *p3 = "Hello world !";
int i = 0;
main() { showstr(p1, p2, p3, 0); }
void showstr(char *str, ...) {
    for (i = 0; (*(int *)(_BP + 4 + i)) != 0; i += 2) {
        printf("%s\n", *(int *)(_BP + 4 + i));
    }
}
