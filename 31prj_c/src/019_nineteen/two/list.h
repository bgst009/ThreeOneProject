typedef char EleType;

typedef struct {
    EleType *buf;
    unsigned int n;
    unsigned int max;
} List;

List *CreateList(int);
void DestoryList(List *);
void ClearList(List *);
int ListAppend(List *, EleType);
int ListInsert(List *, int, EleType);
int ListDelete(List *, int);
int GetElement(List *, int, EleType *);
int IsEmpty(List *);
int IsFull(List *);
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