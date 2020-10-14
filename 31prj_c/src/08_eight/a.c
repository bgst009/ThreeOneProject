struct stu {
    unsigned char c;
    unsigned char os;
    unsigned char masm;
    unsigned char java;
    struct stu far *next;
};
void f1();
void f2();
int n;
struct stu a[375];
struct stu *s = 0x00000000;
int sum;
main() {
    system("cls");
    f2();
}

void f1() {
    long address = 0x00000000;
    printf("%lx", address);

    printf(" %d", sizeof(unsigned char));
    sleep(1);
    for (n = 0; n < 375; n++) {
        a[n].c = *(char far *)address++;
        a[n].os = *(char far *)address++;
        a[n].masm = *(char far *)address++;
        a[n].java = *(char far *)address++;
        address++;
        address++;
        address++;
        address++;
    }

    s->next = 0;
    for (n = 0; n < 375; n++) {
        if (a[n].c + a[n].os + a[n].masm + a[n].java < 400 &&
            a[n].c + a[n].os + a[n].masm + a[n].java > 200) {
            a[n].next = s->next;
            s->next = &a[n];
        }
    }

    n = 0;
    while (s->next) {
        s = s->next;
        if (!s)
            break;
        printf("%d: ", ++n);
        sum = s->c + s->os + s->masm + s->java;
        printf("c: %u,os: %u,masm: %u,java: %u,sum: %d \n", s->c, s->os,
               s->masm, s->java, sum);
        /* sleep(1); */
    }
}
void f2() {
    system("cls");
    for (n = 0; n < 375; n++) {
        a[n] = *s++;
        printf("%x ", s);
        sleep(1);
    }
    s->next = 0;
    for (n = 0; n < 375; n++) {
        if (a[n].c + a[n].os + a[n].masm + a[n].java < 400 &&
            a[n].c + a[n].os + a[n].masm + a[n].java > 200) {
            a[n].next = s->next;
            s->next = &a[n];
        }
    }

    n = 0;
    while (s->next) {
        s = s->next;
        if (!s)
            break;
        printf("%d: ", ++n);
        sum = s->c + s->os + s->masm + s->java;
        printf("c: %u,os: %u,masm: %u,java: %u,sum: %d \n", s->c, s->os,
               s->masm, s->java, sum);
        /* sleep(1); */
    }
}