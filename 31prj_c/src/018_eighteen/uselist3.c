#include "list4.h"
/*提供两种数据测试*/
typedef struct {
    char ch;
    int id;
    char name[10];
    int r;
} myElemType;

/*
typedef  char myElemType;
*/

myElemType a[20] = {{'a', 1, "niei", 2},  {'b', 2, "aini", 2},
                    {'c', 3, "love", 2},  {'d', 4, "jack", 2},
                    {'e', 5, "alice", 2}, {'f', 6, "ben", 2},
                    {'g', 7, "carlo", 2}, {'h', 8, "mason", 2}};

/*
myElemType a[20]="Hello world!";
*/

void showList(List *);

int putElem(myElemType *);
void main() {
    List *mylist;
    int n = 0;
    myElemType data;
    myElemType data2;

    myElemType *pdata;
    mylist = CreateList(sizeof(myElemType));

    if (!mylist) {
        printf("error");
        return;
    }
    for (n = 0; n < 8; n++)
        ListAppend(mylist, a[n]);

    showList(mylist);

    data.ch = '*';
    data.id = 8;
    strcpy(data.name, "1223");
    data.r = 2;

    /*	a[0]='E';
            a[1]='r';
            a[2]='r';
            a[3]='o';
            a[4]='r';
    */
    ListInsert(mylist, 1, data);
    showList(mylist);

    /**/ data2.ch = 'A';
    data2.id = 54;
    strcpy(data2.name, "bill");
    data2.r = 4;
    ListInsert(mylist, 7, data2);
    showList(mylist);

    ListDelete(mylist, 7);
    showList(mylist);

    ListDelete(mylist, 1);
    showList(mylist);

    if (GetElem(mylist, 5, &data2))
        /*	printf("[%c %d %s %d] ",data2.ch,data2.id,data2.name,data2.r);*/
        printf("[%c]", data2);

    ClearList(mylist);
    showList(mylist);

    DestoryList(mylist);
    mylist = 0;

    showList(mylist);
}
/*==================*/
void showList(List *plist) {
    if (!plist)
        return;
    TraverseList(plist, (int (*)(void *))putElem);
    printf("\n");
}
/*输出字符*/
/*
int putElem(myElemType *data)
{

        if( ! ( data) )
                return 0;

        printf("%c",*data);
        return 1;
}
*/
/*输出结构体*/
/**/
int putElem(myElemType *data) {

    if (!(data))
        return 0;
    printf("[%c %d %s %d] ", (data)->ch, (data)->id, (data)->name, (data)->r);

    return 1;
}