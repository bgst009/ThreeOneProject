typedef struct {
    int number;
    char c;
    char name[8];
} stu;

stu a;

char *pchar;
int *pint;
stu *pstu;

main() {
    pstu = &a;

    pstu->number = 1;
    (*pstu).c = 80;
    pstu->name[0] = 'T';
    pstu->name[1] = 'o';
    (*pstu).name[2] = 'm';
    (*pstu).name[3] = '0';

    pchar = 0;
    pint = 0;
    pstu = 0;

    pchar = pchar + 1;
    pint = pint + 1;
    pstu = pstu + 1;
}