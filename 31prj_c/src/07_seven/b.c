int n = 0x2000;
int t;
char ch;
main() {
    while (n != 0xffff && ch != 'q') {
        printf("offset address %xh -> data %x\n", n, *(int *)n);
        if (kbhit()) {
            ch = getch();
        }
        sleep(1);
        n = *(int *)n;
    }
}