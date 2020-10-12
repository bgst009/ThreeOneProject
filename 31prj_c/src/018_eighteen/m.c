#include "list4.h"

char a[20] = "Hello World!";
void showlist(List *);
int putelement(EleType *);

main() {
    List *lp;
    int n;

    lp = CreatList(sizeof(char));
    if (!lp) {
        printf("Creat?\n");
        return;
    }

    for (n = 0; a[n]; n++) {
        ListAppend(lp, a[n]);
    }
    showlist(lp);

    ListInsert(lp, 1, 'h');
    showlist(lp);
    ListInsert(lp, 8, 'a');
    showlist(lp);

    ListDelet(lp, 1);
    showlist(lp);
    ListDelet(lp, 7);
    showlist(lp);
}

void showlist(List *lp) {
    TraverseList(lp, (int (*)(void *))putelement);
    printf("\n");
}

int putelement(EleType *data) {
    if (!(data))
        return 0;
    printf("%c", *(char *)*data);
    return 1;
}