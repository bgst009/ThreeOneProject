/* 定义线性表存储的元素类型 */
typedef char EleType;
/* typedef int EleType; */
/* typedef struct {
    char a;
    char b;
} EleType; */
/* 定义链表结点类型 */
typedef struct node {
    EleType data;      /* 数据项 */
    struct node *next; /* 指针项 */
} ChainNode;

/* 定义线性表 */
typedef struct {
    ChainNode *head; /* 指向头结点的指针· */
    ChainNode *tail;
} List;

/* 声明Lst的操作函数，程序员可以调用这些函数来使用List */
/* 创建线性表，返回线性表的指针 */
List *CreatList(void);
/* 撤销线性表，入口参数为线性表的指针 */
void DestoryList(List *);
/* 清空线性表，即删除所有元素。入口参数为线性表的指针 */
void ClearList(List *);
/* 追加元素，在线性表最后一个元素的后面加一个元素，入口参数为线性表的指针，和要加的数据。返回操作是否成功，1表示成功，0表示不线功*/
int ListAppend(List *, EleType);
/* 加入元素，在线性表编号为的元素的面加一个元素，入口参数为线性表的针，编号和要加入的数据，返回操作是否成功，1表示功，表示不功
注意:线性表诸元素的编号一般都是编号，从1开始， */
int ListInsert(List *, int, EleType);
/* 删除元素，删除编号为的元素人口参数为线性表的指针、编号，回操作是
成功，0表示不成功 */
int ListDelet(List *, int);
/* 取元素，取编号为的元素的值，入口参数为线性表指针、编号和要存储读取的值的
EleType 型内存单元（变量）的地址，返回操作是否成功，1表示成功，0表示不成功 */
int GetElement(List *, int, EleType *);
/* 取编号为的元素所在的结点的地址，入口参数为线性表的指针、编号、返回结点指针，非0表示成功，0表示不成功。*/
ChainNode *GetAddr(List *, int);
/* 遍历，依次访问线性表中的每一个元素，每访问一个元素都用某个函数对这个元素进行某种处理遍历了全部元素返回0，否则返回当前访问元素的编号*/
int TraverseList(List *, int (*)(EleType *));
/* 创建一个存储元素的结点。入口参数为存储在新创建结点中的数据元素的值，返回结点指针，非0表示成功，0表示不成功。*/
ChainNode *NewChainNode(EleType);

/* 定义各操作函数 */
List *CreatList(void) {
    List *p;
    EleType *data = 0;
    p = (List *)malloc(sizeof(List));
    if (!p) {
        return 0;
    }
    p->head = NewChainNode(*data);
    if (!p->head) {
        free(p);
        return 0;
    }
    p->tail = p->head;
    return p;
}
void DestoryList(List *lp) {
    ClearList(lp);
    free(lp->head);
    free(lp);
}
void ClearList(List *lp) {
    while (ListDelet(lp, 1))
        ;
}
int ListAppend(List *lp, EleType data) {
    ChainNode *p;
    ChainNode *newp;

    newp = NewChainNode(data);
    if (!newp)
        return 0;

    newp->next = 0;
    lp->tail->next = newp;
    lp->tail = newp;

    return 1;
}
int ListInsert(List *lp, int n, EleType data) {
    ChainNode *p;
    ChainNode *newp;

    p = GetAddr(lp, n - 1);
    if (!p)
        return 0;
    newp = NewChainNode(data);
    if (!newp)
        return 0;
    newp->next = p->next;
    p->next = newp;

    return 1;
}
int ListDelet(List *lp, int n) {
    ChainNode *p;
    ChainNode *pl;

    if (!lp->head->next)
        return 0;

    p = GetAddr(lp, n - 1);
    if (!(p && p->next))
        return 0;

    pl = p->next;
    p->next = p->next->next;

    free(pl);

    return 1;
}

int GetElement(List *lp, int n, EleType *data) {
    ChainNode *p;

    p = GetAddr(lp, n);
    if (!p)
        return 0;
    *data = p->data;
    return 1;
}
int TraverseList(List *lp, int (*f)(EleType *)) {
    ChainNode *p;

    int a = 0;
    for (p = lp->head->next; p; p = p->next) {
        if (!f(&(p->data)))
            return a + 1;
        a++;
    }
    return 0;
}
ChainNode *NewChainNode(EleType data) {
    ChainNode *p;

    p = (ChainNode *)malloc(sizeof(ChainNode));
    if (!p)
        return 0;
    p->data = data;
    p->next = 0;

    return p;
}

ChainNode *GetAddr(List *lp, int n) {
    ChainNode *p;
    int a;

    if (n < 0)
        return 0;

    p = lp->head;
    a = 0;

    while (p && a < n) {
        p = p->next;
        a++;
    }

    return p;
}
