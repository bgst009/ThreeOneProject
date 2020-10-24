struct returnStruct
{
    int i_num;
    float f_num;
    double d_num;
};

struct returnStruct f(struct returnStruct);

main()
{
    struct returnStruct s;
    struct returnStruct r;

    s.i_num = 1;
    s.f_num = 1.1;
    s.d_num = 1.11;

    r=f(s);

    /*printf("%d %f %f",r.i_num,r.f_num,r.d_num);*/
}

struct returnStruct f(struct returnStruct r){
    r.i_num++;
    r.f_num++;
    r.d_num++;

    return r;
}
