char a[600] = {0x56, 0x33, 0xF6, 0x33, 0xF6, 0xEB, 0x09, 0xB8, 0x6C, 0x06,
               0x50, 0xE8, 0x57, 0xF7, 0x59, 0x46, 0x83, 0xFE, 0x0A, 0x7C,
               0xF2, 0x33, 0xF6, 0xEB, 0x09, 0xB8, 0x6E, 0x06, 0x50, 0xE8,
               0x40, 0xF7, 0x59, 0x46, 0x83, 0xFE, 0x14, 0x7C, 0xF2, 0xB8,
               0x71, 0x06, 0x50, 0xE8, 0x32, 0xF7, 0x59, 0x33, 0xF6, 0xEB,
               0x09, 0xB8, 0x74, 0x06, 0x50, 0xE8, 0x26, 0xF7, 0x59, 0x46,
               0x83, 0xFE, 0x0A, 0x7C, 0xF2, 0x5E, 0xCB};

/* char a[200] = {0xE8, 0x98, 0x11, 0xCB}; */
/* char a[200] = {0x9A, 0x5F, 0x13, 0x6A, 0X07, 0xCB}; */
/* void far f1(); */
main() {
    ((void(far *)())(long)a)(); /* 13 字节 */
    /* f1(); */                 /* 5 字节 */
    /*  f1();  */               /* 3 字节 */
}
/* void far f1() { fun1(); } */