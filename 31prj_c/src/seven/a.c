int n = 0x2000;
int c;
int t;
main() {
    while (n != 0xffff && c != 'q') {
        printf("offset address %xh -> data %c\n", n, *(char *)n);
        printf("stop input q: ");
        scanf("%c", &c);
        printf("\ninput n: ");
        scanf("%x", &t);
        n += t;
    }
}