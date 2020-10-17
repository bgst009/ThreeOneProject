typedef char EleType;

typedef struct node {
    EleType data;
    struct node *next;
} ChainNode;

typedef struct {
    ChainNode *head;
} List;

List *CreateList(void);
void DestoryList(List *);
void ClearList(List *);
int ListAppend(List *, EleType);
int ListInsert(List *, int, EleType);
int ListDelete(List *, int);
int GetElement(List *, int, EleType *);
ChainNode *GetAddr(List *, int);
int TraverseList(List *, int (*)(EleType *));
ChainNode *NewChainNode(EleType);

List *CreateList(void) {
    EleType data = 0;
    List *plist = (List *)malloc(sizeof(List));
    if (!plist)
        return 0;
    plist->head = NewChainNode(data);
    if (!plist->head)
        return 0;
    return plist;
}
void DestoryList(List *plist) {
    ClearList(plist);
    free(plist->head);
    free(plist);
}
void ClearList(List *plist) {
    while (ListDelete(plist, 1))
        ;
}
int ListAppend(List *plist, EleType data) {
    ChainNode *temp = plist->head;
    ChainNode *newp = NewChainNode(data);
    if (!newp)
        return 0;

    for (; temp->next; temp = temp->next)
        ;
    newp->next = 0;
    temp->next = newp;
    return 1;
}
int ListInsert(List *plist, int n, EleType data) {
    ChainNode *temp;
    ChainNode *newp;

    temp = GetAddr(plist, n - 1);
    if (!temp)
        return 0;

    newp = NewChainNode(data);
    if (!newp)
        return 0;

    newp->next = temp->next;
    temp->next = newp;
    return 1;
}
int ListDelete(List *plist, int n) {
    ChainNode *temp;
    ChainNode *temp1;
    if (!plist->head->next)
        return 0;
    temp = GetAddr(plist, n - 1);
    if (!(temp && temp->next))
        return 0;
    temp1 = temp->next;
    temp->next = temp1->next;
    free(temp1);
    return 1;
}
int GetElement(List *plist, int n, EleType *data) {
    ChainNode *temp;
    temp = GetAddr(plist, n);
    if (!temp)
        return 0;
    *data = temp->data;
    return 1;
}
ChainNode *GetAddr(List *plist, int n) {
    ChainNode *temp;
    int i;

    if (n < 0)
        return 0;

    temp = plist->head;
    i = 0;
    while (temp && i < n) {
        temp = temp->next;
        i++;
    }
    return temp;
}
int TraverseList(List *plist, int (*f)(EleType *)) {
    ChainNode *temp;
    int i=0;
    for (temp = plist->head; temp; temp = temp->next) {
        if (!f(&(temp->data)))
            return i++;
        i++;
    }
    return 0;
}
ChainNode *NewChainNode(EleType data) {
    ChainNode *temp = (ChainNode *)malloc(sizeof(ChainNode));
    if (!temp)
        return 0;
    temp->next = 0;
    temp->data = data;
    return temp;
}