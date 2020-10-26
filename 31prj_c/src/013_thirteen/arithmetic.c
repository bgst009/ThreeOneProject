#include "ar.h"
#include <stdlib.h>

void add_d(double a, double b);
void sub_d(double a, double b);
void mul_d(double a, double b);
void div_d(double a, double b);

pra p;
exType ex[4] = {'+', add_d, '-', sub_d, '*', mul_d, '/', div_d};

int main() {
    char ca[100], cb[100];
    char ch;

    gets(ca);
    printf("%c\n", ch = getch());
    gets(cb);

    p.a = atof(ca);
    p.b = atof(cb);
    p.ch = ch;

    arithmetic(p, ex, 4);

    return 0;
}

void add_d(double a, double b) { printf("%lf + %lf = %lf\n", a, b, a + b); }
void sub_d(double a, double b) { printf("%lf - %lf = %lf\n", a, b, a - b); }
void mul_d(double a, double b) { printf("%lf * %lf = %lf\n", a, b, a * b); }
void div_d(double a, double b) { printf("%lf / %lf = %lf\n", a, b, a / b); }