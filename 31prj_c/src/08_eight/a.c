struct stu {
    unsigned char c;
    unsigned char os;
    unsigned char masm;
    unsigned char java;
    struct stu *next;
};

int n;
struct stu a[375];
struct stu *s;
int sum;
main() {
    long address = 0x00000000;
    printf("%lx", address);

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
        printf("c: %c,os: %c,masm: %c,java: %c,sum: %d\n", s->c, s->os, s->masm,
               s->java, sum);
    }
}
