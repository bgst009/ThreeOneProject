main(int n, char **arg) {
    int i;

    char a[20] = "tcc -c ";
    char b[80] = "tlink c0s main ";
    char c[5] = ",";
    char d[20] = " ,,cs.lib ";
    char f[5] = " ";

    for (i = 0; arg[1][i] != '\0'; i++) {
        if (arg[1][i] == '.') {
            arg[1][i] = '\0';
        }
    }

    for (i = 0; arg[2][i] != '\0'; i++) {
        if (arg[2][i] == '.') {
            arg[2][i] = '\0';
        }
    }
    system("cls");
    strcat(a, arg[1]);
    system(a);
    /* printf("%s\n", a); */

    strcat(b, arg[1]);
    strcat(b, f);
    strcat(b, arg[2]);
    strcat(b, c);
    strcat(b, arg[1]);
    strcat(b, d);
    system(b);
    /* printf("%s\n", b); */
}