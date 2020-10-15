int ia = 1;
int *pia = &ia;
int **ppia = &pia;
char ca = 'a';
char *pca = &ca;
char **ppca = &pca;
long la = 1;
long *pla = &la;
long **ppla = &pla;
main() {
    printf("-------- int --------\n");
    printf("ia:   %d, ia+1:  %d , &ia:  %x\n", ia, ia + 1, &ia);
    printf("pia:  %x, pia+1: %x ,step: %ld, &pia: %x\n", pia, pia + 1,
           ((long)(pia + 1) - (long)pia), &pia);
    printf("ppia: %x, ppia+1:%x ,step: %ld, &ppia:%x\n", ppia, ppia + 1,
           ((long)(ppia + 1) - (long)ppia), &ppia);
    printf("-------- char --------\n");
    printf("ca:   %c, ca+1:  %c , &ca:  %x\n", ca, ca + 1, &ca);
    printf("pca:  %x, pca+1: %x ,step: %ld, &pca: %x\n", pca, pca + 1,
           ((long)(pca + 1) - (long)pca), &pca);
    printf("ppca: %x, ppca+1:%x ,step: %ld, &ppca:%x\n", ppca, ppca + 1,
           ((long)(ppca + 1) - (long)ppca), &ppca);
    printf("-------- long --------\n");
    printf("la:   %ld, la+1:  %ld , &la:  %x\n", la, la + 1, &la);
    printf("pla:  %x, pla+1: %x ,step: %ld, &pla: %x\n", pla, pla + 1,
           (long)(pla + 1) - (long)pla, &pla);
    printf("ppla: %x, ppla+1:%x ,step: %ld, &ppla:%x\n", ppla, ppla + 1,
           ((long)(ppla + 1) - (long)ppla), &ppla);
}