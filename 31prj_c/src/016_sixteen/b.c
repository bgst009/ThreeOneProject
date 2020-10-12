#define screen ((char far *)0xb8000000)

typedef struct c {
    char chr;
    char color;
    void (*setch)(struct c *, char);
    void (*setcolor)(struct c *, char);
    void (*put)(struct c *, int, int);
} ch;

void f(ch *, int, int);
void f1(ch *, char);
void f2(ch *, char);

main() {
    int n;
    ch a;

    a.put = f;
    a.setch = f1;
    a.setcolor = f2;

    a.setch(&a, 'c');
    a.setcolor(&a, 2);
    a.put(&a, 10, 40);
}

void f(ch *p, int row, int col) {
    screen[(row - 1) * 160 + (col - 1) * 2] = p->chr;
    screen[(row - 1) * 160 + (col - 1) * 2 + 1] = p->color;
}

void f1(ch *p, char a) { p->chr = a; }
void f2(ch *p, char color) { p->color = color; }