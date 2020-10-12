#include "list4.h"
typedef struct {
    char a;
    char b;
} MyElementType;
MyElementType a[8] = {'a', 1, 'b', 2, 'c', 3, 'd', 4,
                      'e', 5, 'f', 6, 'g', 7, 'h', 8};
void showlist(List *);
int putelement(MyElementType *);

main() {
    List *lp;
    int n;
    MyElementType data;

    lp = CreatList(sizeof(MyElementType));
    if (!lp) {
        printf("Creat?\n");
        return;
    }

    for (n = 0; n < 8; n++) {
        ListAppend(lp, a[n]);
    }
    showlist(lp);

    data.a = '*';
    data.b = 20;
    ListInsert(lp, 1, data);
    showlist(lp);
    data.a = 'a';
    data.b = 20;
    ListInsert(lp, 8, data);
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

int putelement(MyElementType *data) {
    printf("%c %d", data->a, data->b);
    return 1;
}