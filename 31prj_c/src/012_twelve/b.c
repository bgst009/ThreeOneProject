char *codes = "+-";
int add(int a, int b) { return a + b; }
int sub(int a, int b) { return a - b; }
int (*func[2])(int, int) = {add, sub};
main() {
    char a[20];
    char b[20];
    char ch;

    int n;

    gets(a);
    printf("%c\n", ch = getch());
    gets(b);

    for (n = 0; codes[n] && codes[n] != ch; n++)
        ;
    if (!codes[n]) {
        printf("error!");
        return;
    }

    printf("--------------\n");

    printf("%d", func[n](atoi(a), atoi(b)));
}