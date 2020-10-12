typedef void *ElemType;

typedef struct node {
    ElemType data;
    struct node *next;

} ChainNode;

typedef struct {
    ChainNode *head;

    int Nodesize;

    ChainNode *tail;
} List;

List *CreateList(int); /* 创建链表 */

void DestoryList(List *); /* 销毁链表 */

void ClearList(List *); /* 清空链表 */

int ListAppend(List *, ...); /* 追加元素 */

int ListInsert(List *, int, ...); /* 加入元素 */

int ListDelete(List *, int); /* 删除第几个元素 */

int GetElem(List *, int, ElemType *); /* 取得第几个元素的值用第三个参数返回 */

ChainNode *GetAddr(List *, int); /* 取得编号为N的元素所在地址 */

int TraverseList(List *,
                 int (*)(ElemType)); /* 遍历访问，反问某个节点元素用函数处理 */

ChainNode *NewChainNode(ElemType);

List *CreateList(int size) {
    List *pt = 0;
    ElemType data = 0;
    pt = (List *)malloc(sizeof(List));

    if (!pt)
        return 0;
    pt->head = NewChainNode(data);
    if (!pt->head) {
        free(pt);
        return 0;
    }

    pt->Nodesize = size;

    pt->tail = pt->head;
    return pt;
}
/*==================*/
void DestoryList(List *plist) {
    ClearList(plist);

    free(plist->head);
    plist->head = 0;

    free(plist);
    plist = 0;
}

/*==================*/

int ListAppend(List *plist, ...) {
    ChainNode *newpt = 0;
    void *data;
    void *pos;
    pos = &plist + 1;

    if (!(plist && plist->head))
        return 0;

    data = (void *)malloc(plist->Nodesize);
    if (!data)
        return 0;

    memcpy(data, pos, plist->Nodesize);
    newpt = NewChainNode(data);

    if (!newpt)
        return 0;

    plist->tail->next = newpt;
    plist->tail = newpt;
    return 1;
}

/*==================*/
int ListInsert(List *plist, int n, ...) {
    ChainNode *pt = 0;
    ChainNode *newpt = 0;
    void *data;
    void *pos = &plist + 2;
    pt = GetAddr(plist, n - 1);
    if (!(pt))
        return 0;
    data = (void *)malloc(plist->Nodesize);

    if (!data)
        return 0;
    memcpy(data, pos, plist->Nodesize);

    newpt = NewChainNode(data);
    if (!newpt)
        return 0;

    if (pt->next == plist->tail)
        plist->tail = newpt;

    newpt->next = pt->next;

    pt->next = newpt;

    return 1;
}

/*==================*/
int GetElem(List *plist, int n, ElemType *data) {
    ChainNode *pt = 0;

    if (!data)
        return 0;

    pt = GetAddr(plist, n);
    if (!pt)
        return 0;

    memcpy(data, pt->data, plist->Nodesize);

    return 1;
}

/*==================*/
int TraverseList(List *plist, int (*f)(ElemType)) {
    ChainNode *pt = 0;
    int a = 0;

    /**/
    if (!(plist && plist->head))
        return 0;
    for (a = 0, pt = plist->head->next; pt; pt = pt->next) {
        if (!f((pt->data)))
            return a + 1;
        a++;
    }
    return 0;
}

/*==================*/
void ClearList(List *plist) {
    while (ListDelete(plist, 1))
        ;
}

/*==================*/
int ListDelete(List *plist, int n) {
    ChainNode *pt = 0;
    ChainNode *pf = 0;

    if (!plist->head->next)
        return 0;

    pt = GetAddr(plist, n - 1);

    if (pt->next == plist->tail)
        plist->tail = pt;

    if (!(pt && pt->next))
        return 0;

    pf = pt->next;
    pt->next = pt->next->next;

    free(pf->data);
    free(pf);

    return 1;
}

ChainNode *GetAddr(List *plist, int n) {
    ChainNode *pt = 0;
    int a = 0;

    if (n < 0)
        return 0;

    pt = plist->head;

    while (pt && a < n) {
        pt = pt->next;
        a++;
    }
    return pt;
}

/*==================*/
ChainNode *NewChainNode(ElemType data) {
    ChainNode *pChain = 0;
    pChain = (ChainNode *)malloc(sizeof(ChainNode));

    if (!pChain)
        return 0;

    pChain->data = data;
    pChain->next = 0;

    return pChain;
}