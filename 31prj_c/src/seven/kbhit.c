void f1() {
    char ch;
    while (!kbhit()) {
        cprintf("hello world\n");
        sleep(1);
        if (kbhit()) {
            ch = getch();
            if (ch == 27)
                break;
        }
    }
    cprintf("end\n");
}
void f2() {
    int a;
    /* 当用户再循环时不按下任何键时，bioskey(1) 一直为0，则 !bioskey(1)
     * 为1，条件成立，继续循环，printf（），直到，用户任意按下一个键时，bioskey(1)不为0，成功退出。
     */
    a = 1;
    while (!bioskey(a)) {
        cprintf("biosKey\n");
        sleep(1);
    }
    cprintf("end\n");

    /*  当cmd是0，bioskey()返回下一个在键盘键入的值（它将等待到按下一个键）。
     *  它返回一个16位的二进制数，包括两个不同的值。当按下一个普通键时，
     * 它的低8位数存放该字符的ASCII码,高8位存放该键的扫描码；对于特殊键（如方向键、F1～F12等等），
     * 低8位为0，高8位字节存放该键的扫描码。
     */
    a = 0;
    printf("\n%c\n", bioskey(0));
}

void f3() {
    int a, b, c, d;
    scanf("%d", &a);           /*输入整数并赋值给变量a */
    scanf("%d", &b);           /* 输入整数并赋值给变量b */
    printf("a+b=%d\n", a + b); /* 计算a+b的值 */
    scanf("%d %d", &c, &d);    /* 输入两个整数并分别赋值给c、d */
    printf("c*d=%d\n", c * d); /* 计算c*d的值 */
}

void f4() {
    char c;
    c = getche();
    printf("c='%c'\n", c);
}
void f5() {
    char c = getch();
    printf("c='%c'\n", c);
}

void f6() {
    /* gets() 会读取用户输入的整行内容，包括空格。而 scanf()
     * 遇到空格就结束读取，也就是说，使用 scanf()
     * 读取的字符串中永远不会包含空格。 */
    char str1[30], str2[30]; /* 定义两个字符数组 */
    gets(str1);
    scanf("%s", str2);
    puts(str1);
    puts(str2);
}
main() { f6(); }