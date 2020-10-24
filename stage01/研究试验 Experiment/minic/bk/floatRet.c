#include <stdio.h>

struct stu
{
    char *name;
    int num;
    int age;
    char group;
    float score;
};

stu f();

main()
{
    struct stu stu1;
    stu1 = f();
    return 0;
}

stu1 f()
{
    struct stu stu1;
    stu1.name = "Tom";
    stu1.num = 12;
    stu1.age = 18;
    stu1.group = 'A';
    stu1.score = 136.5;
    return stu1;
}
