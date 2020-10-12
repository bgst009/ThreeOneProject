char *codes = "+-*/";
int add(int a, int b) {
    printf("++++++\n");
    return a + b;
}
int sub(int a, int b) {
    printf("-----\n");
    return a - b;
}
int mul(int a, int b) {
    printf("*******\n");
    return a * b;
}
int div(int a, int b) {
    printf("///////\n");
    if (b == 0) {
        printf("error!");
        return -1;
    } else
        return a / b;
}
int (*f[4])(int, int) = {add, sub, mul, div};
int (**func)(int, int) = f;
/* main() {
    char a[20];
    char b[20];
    char ch;

    int n;

    printf("%d %d  %d  %d\n", func[0](2, 4), func[1](2, 4), func[2](2, 4),
           func[3](2, 4));

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
} */