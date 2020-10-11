#include "menu.h"
void putstr(char *);

char text1[20] = "(1) add";
char text2[20] = "(2) sub";
char text3[20] = "(3) mul";
char text4[20] = "(4) div";
char a[20], b[20];
int n = 0;
void add() {
    gets(a);
    gets(b);
    printf("---------\n%d\n", atoi(a) + atoi(b));
}
void sub() {
    gets(a);
    gets(b);
    printf("---------\n%d\n", atoi(a) - atoi(b));
}
void mul() {
    gets(a);
    gets(b);
    printf("---------\n%d\n", atoi(a) * atoi(b));
}
void div() {
    gets(a);
    gets(b);
    if (atoi(b) == 0) {
        printf("error!\n");
        return;
    } else
        printf("---------\n%d\n", atoi(a) / atoi(b));
}

main() {

    ItemType item[4] = {text1, '1', add, text2, '2', sub,
                        text3, '3', mul, text4, '4', div};
    while (1) {
        menu(item, 4);
    }
}