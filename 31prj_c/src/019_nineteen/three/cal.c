#include "stack.h"
Stack *InfixToPostfix(char *str);
int Priority(char);
void cal1();
main() {
    cal1();
    return 0;
}
void cal1() {
    char str[100];
    int n;
    char t;
    char op;
    int v, v1;
    Stack *ops = InitializeStack(sizeof(t));
    Stack *vals = InitializeStack(sizeof(v));

    printf("\t\tTest Stack\n");
    gets(str);
    for (n = 0; str[n] != '\0'; n++) {
        t = str[n];
        if (t == '(')
            ;
        else if (t == '+') {
            push(ops, &t);
        } else if (t == '-') {
            push(ops, &t);
        } else if (t == '*') {
            push(ops, &t);

        } else if (t == '/') {
            push(ops, &t);

        } else if (t == ')') {
            top(ops, &op);
            top(vals, &v);
            pop(ops);
            pop(vals);
            top(vals, &v1);
            pop(vals);
            /*             printf("v %d,op %c,v1 %d = ", v, op, v1); */

            if (op == '+')
                v = v1 + v;
            else if (op == '-')
                v = v1 - v;
            else if (op == '*')
                v = v1 * v;
            else if (op == '/')
                v = v1 / v;

            /*             printf("v %d\n", v); */
            push(vals, &v);
        } else {
            v1 = atoi((char *)&t);
            push(vals, (int *)&v1);
            /* printStack(vals, (int (*)(void *))printInt); */
        }
    }
    top(vals, &v);
    printf("\t %d", v);
}
Stack *InfixToPostfix(char *str) {
    Stack *ops, *res;
    int i;
    char c;
    char top_v;

    ops = InitializeStack(sizeof(str[0]));
    res = InitializeStack(sizeof(str[0]));

    for (i = 0; str[i] != '\0'; i++) {
        c = str[i];
        if (c == '+' || c == '-' || c == '*' || c == '/') { /* 运算符 */
        lp:
            top(ops, (char *)&top_v);
            pop(ops);
            if (top_v == '(' || isEmpty(ops)) {
                push(ops, (char *)&top_v);
            } else if (Priority(c) - Priority(top_v) == 1) {
                /* 先级比栈顶运算符的高 */
                push(ops, (char *)&top_v);
            } else {
                push(res, (char *)&top_v);
                goto lp;
            }
        } else if (c == '(' || c == ')') { /* 括号 */
            if (c == '(') {
                push(ops, &c);
            } else { /* c==')' */
                top(ops, (char *)&top_v);
                pop(ops);
                while (top_v != '(') {
                    push(res, (char *)&top_v);
                    top(ops, (char *)&top_v);
                    pop(ops);
                }
            }
        } else { /* 操作数 */
            push(res, (char *)&c);
        }
    }
    while (!isEmpty(ops)) {
        top(ops, (char *)&top_v);
        pop(ops);
        push(res, (char *)&top_v);
    }

    while (!isEmpty(res)) {
        top(res, (char *)&top_v);
        pop(res);
        printf("%c ", top_v);
    }
}
int Priority(char op) {
    switch (op) {
    case '+':
        return 1;
    case '-':
        return 1;
    case '*':
        return 2;
    case '/':
        return 2;
    }
    return -1;
}