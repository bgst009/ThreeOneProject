main() {
    char a[20];
    char b[20];
    char ch;

    gets(a);
    printf("%c\n", ch = getch());
    gets(b);

    if (ch != '+' && ch != '-' && ch != '*' && ch != '/') {
        printf("error!");
        return;
    }
    printf("------------------\n");
    switch (ch) {
    case '+':
        printf("%d", atoi(a) + atoi(b));
        break;
    case '-':
        printf("%d", atoi(a) - atoi(b));
        break;
    case '*':
        printf("%d", atoi(a) * atoi(b));
        break;
    case '/':
        if (atoi(b) == 0) {
            printf("error!");
            break;
        }
        printf("%d", atoi(a) / atoi(b));
        break;

    default:
        break;
    }
}