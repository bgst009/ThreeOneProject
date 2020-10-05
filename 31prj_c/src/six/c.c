long *f(int a);
long res[2];
long p;
long l;
main() {
    long *a = f(5);
    p = a[0];
    l = a[1];

    printf("parm  %d ,address %lx\n", *(long *)a[0], p);
    printf("local %d ,address %lx\n", *(long *)a[1], l);
}

long *f(int parm) {
    int local = 1;
    local += parm;
    printf("parm  %d address %lx\n", parm, (long)&parm);
    printf("local %d address %lx\n", local, (long)&local);

    res[0] = (long)&parm;
    res[1] = (long)&local;

    /*     printf("parm %d ,address %lx\n", *(long *)res[0], res[0]);
        printf("parm %d ,address %lx\n", *(long *)res[1], res[1]); */
    return res;
}