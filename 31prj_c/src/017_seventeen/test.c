void f1();
void f2();

main() {
    printf("Hello world!\n");
    printf("hello \n");
    printf("world \n");

    fa("use green paint? (y/n) ", f1);

    fa("clear scr? (y/n)", f2);
}

void f1() {
    int a;
    char far *p = (char far *)0xb8000000;
    for (a = 0; a < 2000; a++)
        p[a * 2 + 1] = 2;
}
void f2() { system("cls"); }