char ch;
char *p;
char **pa;
char far *pf;
int n;

main() {
    p = (unsigned char *)0x1000;
    ch = *(unsigned char *)0x1000 + *p + *(unsigned char far *)0x200;

    p = &ch;

    *p = *p + 1;

    pa = &p;
    **pa = **pa + 1;

    pf = (char far *)&ch;
    *pf = *pf + 1;

    n = (int)&ch;
    *(char *)n = *(char *)n + 1;
}