#include <stdio.h>
#include <stdlib.h>

char *codes = "+-*/";
double add(double a, double b) {
    printf("%lf,%lf", a, b);
    return a + b;
}
double sub(double a, double b) { return a - b; }
double mul(double a, double b) { return a * b; }
double div_d(double a, double b) {
    if (b == 0) {
        printf("error!");
        return -1;
    } else
        return a / b;
}
double (*func[4])(double, double) = {add, sub, mul, div_d};
main() {
    char a[20];
    char b[20];
    char ch;
    double d_a = 0, d_b = 0;

    int n;

    gets(a);
    printf("%c\n", ch = getch());
    gets(b);

    d_a = atof(a);
    d_b = atof(b);

    for (n = 0; codes[n] && codes[n] != ch; n++)
        ;
    if (!codes[n]) {
        printf("error!");
        return;
    }

    printf("--------------\n");

    printf("%lf", func[n](d_a, d_b));
}