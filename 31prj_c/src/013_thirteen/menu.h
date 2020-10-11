typedef struct {
    char *text;     /* 菜单项的描述字符串 */
    char key;       /* 菜单项对应的选择按键的AsCI码 */
    void (*func)(); /* 菜单项对应的函数 */
} ItemType;

void menu(ItemType *, int);
void menu(ItemType *item, int n) {
    int a, b;
    char ch;
    /* 显示菜单项 */
    for (a = 0; a < n; a++) {
        b = strlen(item[a].text);
        if (b > 20 || b < 0) {
            printf("error!");
            return;
        }
        printf("%s\n", item[a].text);
    }
    /* 检测用户按键，找到按键所对应的菜单项，调用所对应的函数。 */
    do {
        ch = getch();
        for (a = 0; item[a].key != ch && a < n; a++)
            ;
    } while (a == n);
    printf("---%s----\n", item[a].text);
    item[a].func();
}