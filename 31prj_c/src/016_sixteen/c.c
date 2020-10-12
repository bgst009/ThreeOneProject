#define screen ((char far *)0xb8000000)

#define new(x) (x*)malloc(sizeof(x))

typedef struct c {
    char chr;
    char color;
    void (*put)(struct c *, int, int);
} ch;
void f(ch *, int, int);

main() {
    int n;

    ch *a = new(ch);
    /*ch *a = (ch*)malloc(sizeof(ch));*/

    a->chr = 'c';
    a->color = 2;
    a->put = f;
    a->put(a, 10, 40);
}

/* 函数，在屏幕的row行和col列打印字符，row、co1从1开始编号。＊ */
void f(ch *p, int row, int col) {
    screen[(row - 1) * 160 + (col - 1) * 2] = p->chr;
    screen[(row - 1) * 160 + (col - 1) * 2 + 1] = p->color;
}