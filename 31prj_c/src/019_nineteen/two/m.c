#include "list.h"

char a[20] = "Hello world!";
void showlist(List *);
int putelement(EleType *);

main() {
    List *plist;
    int n = 0;

    plist = CreateList(sizeof(a) / sizeof(a[0]));
    if (!plist) {
        printf("CreateList failed\n");
        return;
    }

    for (n = 0; a[n]; n++) {
        ListAppend(plist, a[n]);
    }
    showlist(plist);

    ListInsert(plist, 1, 'h');
    showlist(plist);
    ListInsert(plist, 8, 'a');
    showlist(plist);

    ListDelete(plist, 1);
    showlist(plist);
    ListDelete(plist, 7);
    showlist(plist);
}

void showlist(List *plist) {
    TraverseList(plist, putelement);
    printf("\n");
}
int putelement(EleType *data) {
    printf("%c", *data);
    return 1;
}
