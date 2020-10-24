main()
{
    printf("%x\n", main);
    _AX = 1;
    _BX = 1;
    _CX = 2;
    _AX = _BX + _CX;
    _AL = _BH + _CH;
    _AH = _BL + _CL;
}