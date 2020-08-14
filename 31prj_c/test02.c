int fun(int num) { return 2 * num; }
main() {
    int i = 0;
    int result = 0;
    while (i < 20) {
        if (i % 2 == 0) {
            result = fun(i);
            printf("%d ", result);
        }
        i++;
    }
}