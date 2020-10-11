main() {
    int a;
    char *str = "welcome to c";
    char far *p = (char far *)(0xb8000000 + 160 * 10 + 70);

    for (a = 0; str[a]; a++) {
        p[a * 2] = str[a];
        p[a * 2 + 1] = a + 1;
    }
    getch();
    CMain();
}