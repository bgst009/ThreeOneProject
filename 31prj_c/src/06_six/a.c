int ia = 6;
long la = 7;
double da = 8;
main() {
    int i;
    /*     printf("%x %x %x %x\n", &ia, ((int)(&ia) + 1), (char *)((char)(&ia) +
     *1), (char *)((char)(&ia) + 1)); */
    printf("int %d          ,address %lx,size %d\n", ia, (long)&ia,
           sizeof(int));
    for (i = 0; i < sizeof(int); ++i) {
        printf("address  %lx ", (long)&ia + i);
        printf("value  %x ", *(char *)((int)(&ia) + i));
    }
    printf("\n");

    printf("long %ld         ,address %lx,size %d\n", la, (long)&la,
           sizeof(long));
    for (i = 0; i < sizeof(long); ++i) {
        if (i % 2 == 0)
            printf("\n");
        printf("address  %lx ", (long)&la + i);
        printf("value  %x ", *(char *)((int)(&la) + i));
    }
    printf("\n");
    printf("double %lf,address %lx,size %d\n", da, (long)&da, sizeof(double));
    for (i = 0; i < sizeof(double); ++i) {
        if (i % 2 == 0)
            printf("\n");
        printf("address  %lx ", (long)&da + i);
        printf("value  %x ", *(char *)((int)(&da) + i));
    }
}