#include <stdio.h>
#include <stdlib.h>

int main() {
    char str[30] = "20.30300 This is test";
    char *ptr;
    double ret;

    ret = strtod(str, &ptr);
    printf("数字（double）是 %lf\n", ret);
    printf("字符串部分是 |%s|", ptr);

    return (0);
}