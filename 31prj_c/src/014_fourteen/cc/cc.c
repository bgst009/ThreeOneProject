main(int n, char **arg) {
    int i, j;

    char a[20] = "tcc -c ";
    char b[80] = "tlink c0s main ";
    char c[5] = ",";
    char d[20] = " ,,cs.lib ";
    char f[5] = " ";

    /* delete postfix */
    for (i = 0; i < n && arg[i][0] != ','; i++) {
        for (j = 0; arg[i][j] != 0; j++) {
            if (arg[i][j] == '.') {
                arg[i][j] = '\0';
            }
        }
    }
    system("cls");
    /* tcc */
    for (i = 1; i < n && arg[i][0] != ','; i++) {
        strcat(a, arg[i]);
        strcat(a, f);
    }
    /*     printf("%s\n", a); */
    system(a);

    /* tlink */
    for (i = 1; i < n && arg[i][0] != ','; i++) {
        strcat(b, arg[i]);
        strcat(b, f);
    }
    strcat(b, c);
    strcat(b, arg[i + 1]);
    strcat(b, d);
    /*     printf("%s\n", b); */

    system(b);
}