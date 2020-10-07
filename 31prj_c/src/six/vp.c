char ca = 'a';
int ia = 6;
long la = 7;
char *pca = &ca;
int *pia = &ia;
long *pla = &la;
main() {
    printf("char ca: %c , ca+1: %c\n", ca, ca + 1);
    printf("int  ia: %d , ia+1: %d\n", ia, ia + 1);
    printf("long la: %ld , la+1: %ld\n", la, la + 1);
    printf("size\n");
    printf("char %d,int %d,long %d\n", sizeof(char), sizeof(int), sizeof(long));
    printf("pchar pca: %x , pca+1: %x\n", pca, pca + 1);
    printf("pint pia: %x , pia+1: %x\n", pia, pia + 1);
    printf("plong pla: %x , pla+1: %x\n", pla, pla + 1);
}