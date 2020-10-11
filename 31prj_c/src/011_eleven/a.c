/* char a[200] = "BB00B88EC3BB900626C60763CB"; */
/* main() { ((void(far *)())(long)a)(); } */
char a[200] = {0xBB, 0x00, 0xB8, 0x8E, 0xC3, 0xBB, 0x90,
               0x06, 0x26, 0xC6, 0x07, 0x63, 0xCB};
void far f();
void(far *b)();
main() {
    /* f(); */
    ((void(far *)())(long)a)();
}
void far f() { *(char far *)(0xb8000000 + 160 * 10 + 80) = 'c'; }