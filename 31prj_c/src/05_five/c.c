char *p;
char far *pf;
char str[20] = "hello world!";
int a[8] = {11, 22, 33, 44, 55, 66, 77, 88};
int n;

main() {
    pf = (char far *)0x200;
    for (n = 0; str[n]; n++)
        *(pf + n) = str[n];

    p = str;
    pf = (char far *)0x210;
    for (n = 0; p[n]; n++)
        pf[n] = *(str + n);

    for (n = 0; n < 8; n++)
        ((int far *)0x220)[n] = *(a + n);
    for (n = 0; n < 8; n++)
        *(int far *)(0x230 + n * 2) = *(&a[0] + n);
}