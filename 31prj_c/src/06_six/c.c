long *f(int a);
long res[2];

main() {
    f(5);
    printf("============\n");
    f(8);
}

long *f(int parm) {
    int local = 1;
    local += parm;

    printf("parm  %d address %lx\n", parm, (long)&parm);
    printf("local %d address %lx\n", local, (long)&local);

    return res;
}