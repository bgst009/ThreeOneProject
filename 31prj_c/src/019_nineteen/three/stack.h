/* //--------------------------stack define ----------------------------// */
/**
 * @brief 栈元素类型
 *
 */
typedef void *ElementType;

/**
 * @brief 栈节点结构体
 *
 */
typedef struct sn {
    ElementType element;
    struct sn *next;
    struct sn *prev;
} Snode;
/**
 * @brief 栈结构
 *
 */
typedef struct s {
    Snode *base;
    Snode *top;
    int ELemSize;
} Stack;

/**
 * @brief 初始栈，数据类型大小
 *
 * @param size 数据类型大小
 * @return Stack*
 */
Stack *InitializeStack(int size);
/**
 * @brief 销毁栈参数为栈指针
 *
 * @param pStack
 * @return int
 */
int DestoryStack(Stack *pStack);
/**
 * @brief 入栈
 *
 * @param element
 * @return int
 */
int push(Stack *pStack, ElementType element);
/**
 * @brief 出栈
 *
 * @param pStack
 * @return int
 */
int pop(Stack *pStack);
/**
 * @brief 获取栈顶元素
 *
 * @param pStack
 * @param element
 * @return int
 */
int top(Stack *pStack, ElementType element);
/**
 * @brief 判空
 *
 * @param pStack
 * @return int pan
 */
int isEmpty(Stack *pStack);
/**
 * @brief Create a Node object
 *
 * @param element
 * @return Snode*
 */
Snode *CreateNode(ElementType element);
/**
 * @brief 打印栈
 *
 * @param pStack
 */
void printStack(Stack *pStack, int (*f)(ElementType));

/* //--------------------------stack test define ----------------------------//
 */
/**
 * @brief 学生信息结构体
 *
 */
typedef struct student {
    int number;
    int c;
    int masm;
} stu;
/**
 * @brief 测试整型栈
 *
 */
void testint();
/**
 * @brief 测试字符型栈
 *
 */
void testchar();
/**
 * @brief 测试结构体栈
 *
 */
void teststruct();
/**
 * @brief 打印整形数据
 *
 * @param elem
 * @return int
 */
int printInt(int *elem);
/**
 * @brief 打印字符型数据
 *
 * @param elem
 * @return int
 */
int printChar(char *elem);
/**
 * @brief 打印结构体数据
 *
 * @param elem
 * @return int
 */
int printStruct(stu *elem);
/* //------------------------stack impl -----------------------------// */
Stack *InitializeStack(int size) {
    Stack *pStack = (Stack *)malloc(sizeof(Stack));
    ElementType element = 0;
    if (!pStack)
        return 0;
    pStack->ELemSize = size;
    pStack->top = CreateNode(element);
    pStack->base = pStack->top;
    pStack->base->next = pStack->base->prev = 0;
    return pStack;
}
int DestoryStack(Stack *pStack) {

    Snode *temp = 0;
    while (!isEmpty(pStack)) {
        temp = pStack->top;
        pStack->top = temp->prev;
        free(temp->element);
        free(temp);
    }

    free(pStack->base);
    free(pStack);
    return 1;
}
int push(Stack *pStack, ElementType element) {
    Snode *newNode = 0;
    ElementType elem = (ElementType)malloc(pStack->ELemSize);
    if (!elem)
        return 0;
    memcpy(elem, element, pStack->ELemSize);
    newNode = CreateNode(elem);
    if (!newNode)
        return 0;
    newNode->next = newNode->prev = 0;

    if (isEmpty(pStack)) {
        pStack->base->next = newNode;
        newNode->prev = pStack->base;
    } else {
        pStack->top->next = newNode;
        newNode->prev = pStack->top;
    }
    pStack->top = newNode;
    return 1;
}
int pop(Stack *pStack) {
    Snode *temp = pStack->top;
    if (!pStack || isEmpty(pStack))
        return 0;
    pStack->top = temp->prev;
    free(temp->element);
    free(temp);
    return 1;
}
int top(Stack *pStack, ElementType element) {
    ElementType elem = pStack->top->element;
    if (!pStack || isEmpty(pStack))
        return 0;
    memcpy(element, elem, pStack->ELemSize);
    return 1;
}
int isEmpty(Stack *pStack) { return pStack->top == pStack->base; }
Snode *CreateNode(ElementType element) {
    Snode *newNode = (Snode *)malloc(sizeof(Snode));
    if (!newNode)
        return 0;
    newNode->prev = newNode->next = 0;
    newNode->element = element;
    return newNode;
}
void printStack(Stack *pStack, int (*f)(ElementType)) {
    ElementType elem;
    for (top(pStack, &elem); !isEmpty(pStack); top(pStack, &elem)) {
        f(&elem);
        pop(pStack);
    }
}
/* //------------------------stack test impl -----------------------------// */
void testint() {
    int n = 0;
    int a[8] = {1, 2, 3, 4, 5, 6, 7, 8};
    Stack *pStack = InitializeStack(sizeof(a[0]));

    printf("\t\tTest int Stack\n");
    for (n = 0; n < sizeof(a) / sizeof(a[0]); n++) {
        push(pStack, &(a[n]));
    }
    printStack(pStack, (int (*)(void *))printInt);
}
void testchar() {
    int n = 0;
    char a[8] = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'};
    Stack *pStack = InitializeStack(sizeof(a[0]));

    printf("\t\tTest char Stack\n");
    for (n = 0; n < sizeof(a) / sizeof(a[0]); n++) {
        push(pStack, &(a[n]));
    }
    printStack(pStack, (int (*)(void *))printChar);
}
void teststruct() {
    int n = 0;
    stu a[8] = {1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4,
                5, 5, 5, 6, 6, 6, 7, 7, 7, 8, 8, 8};
    Stack *pStack = InitializeStack(sizeof(a[0]));

    printf("\t\tTest structStack\n");
    for (n = 0; n < sizeof(a) / sizeof(a[0]); n++) {
        push(pStack, &(a[n]));
    }
    printStack(pStack, (int (*)(void *))printStruct);
}
int printInt(int *elem) {
    printf("\nelem %d\n", *elem);
    return 1;
}
int printChar(char *elem) {
    printf("\nelem %c\n", *elem);
    return 1;
}
int printStruct(stu *elem) {
    printf("\nelem %d %d %d\n", elem->number, elem->c, elem->masm);
    return 1;
}
