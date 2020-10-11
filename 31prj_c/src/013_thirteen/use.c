#include "menu.h"
void putstr(char *);

char text1[20] = "(1) hello";
char text2[20] = "(2) art";
char text3[20] = "(3) welcomn";

void f1();
void f2();
void f3();

ItemType item[3] = {text1, '1', f1, text2, '2', f2, text3, '3', f3};

main() { menu(item, 3); }

void f1() { putstr("hello world!"); }
void f2() { putstr("the art of c"); }
void f3() { putstr("welcome to c"); }

void putstr(char *str) {
    int far *scr = (int far *)(0xb8000000 + 160 * 10 + 33 * 2);
    int n;
    for (n = 0; str[n]; ++n)
        scr[n] = str[n] + (n + 1) * 0x100;
}