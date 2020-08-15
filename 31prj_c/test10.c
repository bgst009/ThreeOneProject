struct Date {
    int year;
    int mon;
    int day;
};
int setDate(struct Date *, char, int);
int getType(char);
main() {
    struct Date date = {2000, 1, 1};
    char type;
    int data;
    printf("%d/%d/%d\n", date.year, date.mon, date.day);
    printf("order:");
    scanf("%c %d", &type, &data);
    setDate(&date, type, data);
    printf("--------------\n");
    printf("%d/%d/%d\n\n\n", date.year, date.mon, date.day);
    getch();
}
int setDate(struct Date *datep, char type, int data) {
    int n = getType(type);
    switch (n) {
    case 0:
        datep->year = data;
        break;
    case 1:
        datep->mon = data;
        break;
    case 2:
        datep->day = data;
        break;
    }
    return n == -1 ? 0 : 1;
}
int getType(char type) {
    int i = -1;
    char str[3] = {'y', 'm', 'd'};
    while (i < 3) {
        if (str[i] == type)
            break;
        i++;
    }
    return i > 2 ? 0 : i;
}