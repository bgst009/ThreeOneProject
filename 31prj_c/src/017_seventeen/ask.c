int fa(char *str, void (*f)()) {
    int n; /* 用来记录程序中得出字符串str的长度 */
    int a;
    int row; /* 用来记录程序中计算出的显示字符串的起始行号 */
    int col; /* 用来记录程序中计算出的显示字串的起始列号 */
    char far *scr = (char far *)0xb8000000;
    char *buf;
    char ch;

    /* strlen函数的功能是求字符串的长度。 */
    n = strlen(str);
    /* 根据字符串的长度计算显示字符串的行列位置 */
    if (n / 80) {
        row = (25 - (n / 80 + 1)) / 2;
        col = 3;
    } else {
        row = 12;
        col = (80 - (n % 80)) / 2;
    }

    /* 保存原显存中相应空间中的内容。在屏幕中间显示提示字符串，有可能覆盖屏幕上原有的信息所以，在显示提示字符串前，将原来显存中相应空间里的内容保存起来，在函数返回前可以进行恢复，
     */
    buf = (char *)malloc(n * 2);

    for (a = 0; a < n * 2; a++) {
        buf[a] = scr[(row - 1) * 160 + (col - 1) * 2 + a];
    }

    /* 显示提示字符串。 */
    for (a = 0; a < n; a++) {
        scr[(row - 1) * 160 + (col - 1 + a) * 2] = str[a];
        scr[(row - 1) * 160 + (col - 1 + a) * 2 + 1] = 2;
    }

    while (8) {
        ch = getch();
        if (ch == 'y' || ch == 'Y' || ch == 'n' || ch == 'N')
            break;
    }

    /* 收到用户的按键后，恢复显存相应空间中的内容 */
    for (a = 0; a < n * 2; a++) {
        scr[(row - 1) * 160 + (col - 1) * 2 + a] = buf[a];
    }

    /* 根据用户的按键，返回相应的状态信息 */

    if (ch == 'y' || ch == 'Y') {
        f();
    }
    return (ch == 'y' || ch == 'Y');
}