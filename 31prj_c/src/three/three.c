/*
// Created by bgst on 2020/9/24.
*/

unsigned int n;
void f1();
int f2(int, int);
void far f3();

main() {
    n = 0;
    f1();
    n = f2(1, 2);
    f3();
}

void f1() { n = 1; }
int f2(int a, int b) {
    int c;
    c = a + b;
    return c;
}

void far f3() { return 10; }