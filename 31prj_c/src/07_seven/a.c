int n = 0x2000;
int c;
char ch;
main() {
    while (n != 0xffff && c != 'q') {
        printf("offset address %xh -> data %d\n", n, *(int *)n);
        if (kbhit()) {
            ch = getch();
            if (ch == 'q')
                break;
        }
        sleep(1);
        n++;
    }
}