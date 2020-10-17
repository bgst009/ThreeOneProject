#include "stack.h"

main() {
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
    return 0;
}
