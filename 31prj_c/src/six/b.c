typedef struct {
    int num;
    unsigned char c;
    unsigned char os;
    unsigned char masm;
    char name[20];
} stu;

main() {
    int i = 0;
    stu s;
    s.num = 9;
    s.c = '1';
    s.os = '2';
    s.masm = '3';
    s.name[0] = 'L';
    s.name[1] = 'i';
    s.name[2] = 'L';
    s.name[3] = '\0';

    printf("size: %d,address: %lx\n", sizeof(s), (long)&s);
    printf("num :    %d,address: %lx\n", s.num, (long)&(s.num));
    for (i = 0; i < sizeof(int); ++i) {
        printf("address  %lx ", (long)&(s.num) + i);
        printf("value  %d ", *(&(s.num) + i));
    }
    printf("\n");
    printf("c   :    %c,address: %lx\n", s.c, (long)&(s.c));
    for (i = 0; i < sizeof(char); ++i) {
        printf("address  %lx ", (long)&(s.c) + i);
        printf("value  %c ", *(&(s.c) + i));
    }
    printf("\n");
    printf("os  :    %c,address: %lx\n", s.os, (long)&(s.os));
    for (i = 0; i < sizeof(char); ++i) {
        printf("address  %lx ", (long)&(s.os) + i);
        printf("value  %c ", *(&(s.os) + i));
    }
    printf("\n");
    printf("masm:    %c,address: %lx\n", s.masm, (long)&(s.masm));
    for (i = 0; i < sizeof(char); ++i) {
        printf("address  %lx ", (long)&(s.masm) + i);
        printf("value  %c ", *(&(s.masm) + i));
    }
    printf("\n");
    printf("name:  %s,address: %lx\n", s.name, (long)&(s.name));
    /* printf("%d", sizeof(char *)); */
    for (i = 0; i < 20; i++) {
        printf("address  %lx ", (long)&(s.name) + i);
        printf("value  %c ", *((*(&s.name)) + i));
    }
    printf("\n");
}