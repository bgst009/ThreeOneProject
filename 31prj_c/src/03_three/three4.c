/*定义一个结构体类型stu，这个结构体类型描述一个学生的成绩。其中包括
    : 学号（整型）、C、Os、masm三门课程的成绩（字符型）*/
struct stu {
    int number;
    char c;
    char os;
    char masm;
};
/*注意，在实际程序设计中，程序员往往需要定义新的数据类型来对数据进行抽象。C语言支持用基本的数据类型如“char”、“int”等等来构造新的更为复杂的数据类型。

“整型”这一数据类型的名称为“int”:“字符型这一数据类型的名称为“char”:
以上定义了一个 新的数据类型“struct stu”，这个数据类型的名称为“stu

structstu型数据包括4个数据项 : number、c、os、masm*/

struct stu a; /*定义一个struct stu型的变量a*/

main() {
    /*定义一个struct stu型的变量b*/
    struct stu b;

    a.number = 1;
    a.c = 80;
    a.os = 82;
    a.masm = 88;

    b.number = 2;
    b.c = 90;
    b.os = 92;
    b.masm = 98;

    printf("number c  os masm\n");
    printf("-----------------\n");

    printf("%d     %d  %d  %d\n", a.number, a.c, a.os, a.masm);
    printf("%d     %d  %d  %d\n", b.number, b.c, b.os, b.masm);
}