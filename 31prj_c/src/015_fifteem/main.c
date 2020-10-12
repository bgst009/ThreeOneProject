extern char *codes;
extern int (**func)(int, int);
/* extern int add(int a, int b);
extern int sub(int a, int b);
extern int mul(int a, int b);
extern int div(int a, int b); */

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