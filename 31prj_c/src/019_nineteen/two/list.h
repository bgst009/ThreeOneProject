/* 定义线性表存储的元素类型 */
typedef char EleType;

/* 定义线性表类型 */
typedef struct {
    EleType *buf;     /* 元素的存储空间 */
    unsigned int n;   /* 元素的个数 */
    unsigned int max; /* 可以存储元素的最大数 */
} List;
/* 声明t的操作函数，程序员可以调用这些函数来使用 */
/* 创线性表，入口参数为线性表储空间的最多可以存储元素的数量，返回线性表的指针 */
List *CreateList(int);
/* 撤销线性表，入口参数为线性表的指针 */
void DestoryList(List *);
/* 清空线性表，即删除所有元素入口参数为线性表的指针＊ */
void ClearList(List *);
/* 追加元素，在线性表最后一个元素的后面加一个元素入门参数为线性表的指针，和要追加的数据。返回操作是否成功，1表示成功，0表示不成功。*/
int ListAppend(List *, EleType);
/* 加入元素，在线性表编号为N的元素的前面加一个元素。入口参数为线性表的指针、编号和要加入的数据，返回操作是否成功，1表示成功，0表示不成功。*/
int ListInsert(List *, int, EleType);
/* 删除元素，删除编号为N的元素。入口参数为线性表的指针、编号。返回操作是否成功，1表示成功，0表示不成功。*/
int ListDelete(List *, int);
/* 元素，取编号为N的元素的值。入口参数为线性表的指针、编号和要存储读取的值的
EleType 型内存单元（变量）的地址。返回操作是否成功，1表示成功，0表示不成功。 */
int GetElement(List *, int, EleType *);
/* 判空判断线性表是为空非0表示空， */
int IsEmpty(List *);
/* 判满，判断线性表是否为满，非0表示满1 */
int IsFull(List *);
/* 遍历，依次访问线性表中的每一个元素，每问一个元素都用某个函数对这个元素进行某种处理遍历了全部元表返0，否则返回当前访
元素的编号 */
int TraverseList(List *, int (*)(EleType *));

List *CreateList(int number) {
    List *plist;
    plist = (List *)malloc(sizeof(List));
    if (!plist)
        return 0;

    plist->buf = (EleType *)malloc(sizeof(EleType) * number);
    if (!plist->buf)
        return 0;
    plist->max = number;
    plist->n = 0;
    return plist;
}
void DestoryList(List *plist) {
    ClearList(plist);
    free(plist);
}
void ClearList(List *plist) {
    free(plist->buf);
    plist->max = plist->n = 0;
}
int ListAppend(List *plist, EleType data) {
    if (plist->n < plist->max) {
        plist->buf[plist->n++] = data;
        return 1;
    } else
        return 0;
}
int ListInsert(List *plist, int n, EleType data) {
    int i = 0;
    if (n < 0 || n > plist->max || plist->n == plist->max)
        return 0;

    for (i = plist->n; i >= n - 1; i--) {
        plist->buf[i + 1] = plist->buf[i];
    }
    plist->buf[n - 1] = data;
    plist->n += 1;
    return 1;
}
int ListDelete(List *plist, int n) {
    int i = 0;
    if (n < 1 || n > plist->n)
        return 0;
    for (i = n; i < plist->n; i++) {
        plist->buf[i - 1] = plist->buf[i];
    }
    plist->n -= 1;
    return 1;
}
int GetElement(List *plist, int n, EleType *data) {
    if (n < 0 || n > plist->max)
        return 0;
    *data = plist->buf[n];
    return 1;
}
int IsEmpty(List *plist) { return plist->n; }
int IsFull(List *plist) { return plist->n == plist->max; }
int TraverseList(List *plist, int (*f)(EleType *)) {
    int i = 0;
    for (i = 0; i < plist->n; i++) {
        if (!f(&(plist->buf[i])))
            return i;
    }
    return 0;
}