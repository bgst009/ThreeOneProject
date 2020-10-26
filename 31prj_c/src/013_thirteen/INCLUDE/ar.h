typedef struct {
    double a;
    double b;
    char ch;
} pra;
typedef struct {
    char op;
    void (*f)(double, double);
} exType;

void arithmetic(pra, exType *, int);
void arithmetic(pra p, exType *ex, int n) {
    char ch = p.ch;
    int a;

    /* printf("%lf,%lf", p.a, p.b); */

    for (a = 0; ex[a].op != ch && a < n; a++)
        ;

    printf("--------------\n");
    ex[a].f(p.a, p.b);
}