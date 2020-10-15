#include "list5.h"
typedef struct student {
    int number;
    int math;
    int c;
    int java;
} stu;
typedef stu MyElementType;
MyElementType a[8] = {
    1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4,
    1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4,
};
void showlist(List *);
int putelement(MyElementType *);

main() {
    List *lp;
    int n;

    lp = CreatList(sizeof(MyElementType));
    if (!lp) {
        printf("Creat?\n");
        return;
    }

    for (n = 0; n < 8; n++) {
        ListAppend(lp, &(a[n]));
    }
    showlist(lp);

/*     n = 8;
    ListInsert(lp, 1, &n);
    showlist(lp);
    n = 18;
    ListInsert(lp, 8, &n);
    showlist(lp);

    ListDelet(lp, 1);
    showlist(lp);
    ListDelet(lp, 7);
    showlist(lp); */
}

void showlist(List *lp) {
    TraverseList(lp, (int (*)(void *))putelement);
    printf("\n");
}

int putelement(MyElementType *element) {
    printf("%d %d %d %d \n", element->number, element->math, element->c,
           element->java);
    sleep(1);
    return 1;
}