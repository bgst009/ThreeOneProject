typedef void *va_list;

#define va_start(ap, parmN) (ap = ...)
#define va_arg(ap, type) (*((type *)(ap))++)
#define va_end(ap)
#define _va_ptr (...)

void showstr(char *, ...);
void showstr2(char *, ...);
void showstr3(char *, ...);
char *p1 = "This is a c program.";
char *p2 = "Welcome to c !";
char *p3 = "Hello world !";
int i = 0;
main() {
    /* showstr(p1, p2, p3, 0); */
    showstr3(p1, p2, p3, 0);
}
void showstr(char *str, ...) {
    /*     printf("%x\n", _BP);
        printf("%x\n", &str); */
    for (i = 0; (*(int *)(_BP + 4 + i)) != 0; i += 2) {
        printf("%s\n", *(int *)(_BP + 4 + i));
    }
}

void showstr2(char *p, ...) {
    char *ret;
    va_list ap;
    va_start(ap, p);
    ret = p;
    printf("%s\n", ret);
    for (ret; ret = va_arg(ap, char *);)
        printf("%s\n", ret);
}

void showstr3(char *pstr, ...) {
    int *p;
    for (p = &pstr; (char *)*(p); p++) {
        printf("%s\n", (char *)*(p));
    }
}
