[TOC]

# 课程设计2报告

## 设计思路

1. **安装程序**

   1. 调用 **int 13** 来复制引导程序到软盘的 0面0道1扇区 。
   2. 调用 **int 13** 来复制任务程序到软盘0面0道2~3扇区。
2. **引导程序**

   1. 引导程序，将程序复制到**0:7c00**处，
   2. 设置**cs：ip**为**0:7e00h**执行Boot程序
3. **任务程序**执行所需功能。

   1. 辅助功能

      1. CLS （清屏）
      2. CHARSTACK（字符栈）
      3. DELAY（产生延时）
      4. BCD2ASCII && ASCII2BCD（BCD与ASCII的相互转换）
      5. SHOW_STR（在指定的位置，用指定的颜色，显示一个用0结尾的字符串）

   2. SHOW_MENU	；列出功能选项

      1. show options ；展示选项
      2. GET_INPUT ;获取键盘输入
      3. 执行子程序
         1. SUB1:重启计算机
            1. 将**CS : IP** 指向 **FFFF : 0**
         2. SUB2:引导硬盘现有的操作系统
            1. 读入硬盘0面0道1扇区的内容到0:7C00H
            2. CS:IP指向0:7C00H   
         3. SUB3:循环显示时间
            1. 清屏
            2. 显示提示字符串
            3. 设置读取日期的循环次数及各项的起始地址
            4. 获取键盘输入
               1. 清除键盘缓冲区 **int 16h** 的 0 号功能
         4. SUB4:修改当前日期、时间
            1. 输出提示信息
            2. 设置字符栈的位置,获取日期输入前的准备
            3. GET_DATE 获取字符并且判断
            4. 完成输入,复制 DATE_INPUT 的内容到 DATE （SET_DATE）
4. 运行过程 
   1. 编译ASM文件
   2. 在xp中运行exe文件
   3. 重新启动计算机（软盘为第一启动位）




## 设计代码

```assembly
ASSUME CS:SETUP

 

;============================================================================================

;安装程序

;将引导所需的程序写入软盘

SETUP SEGMENT

START:

    ;复制装载程序到软盘0面0道1扇区 

    MOV AX,LOAD

    MOV ES,AX

    MOV BX,0        ;ES:BX指向要写的单元

   

    MOV DX,0

    MOV CX,1

    MOV AL,1

    MOV AH,3

    INT 13H

   

    ;复制任务程序到软盘0面0道2~3扇区

    MOV AX,SYS

    MOV ES,AX       ;BX没变

   

    MOV CX,2        ;DX没变

    MOV AL,2 

    MOV AH,3

    INT 13H

   

    MOV AX,4C00H

    INT 21H

SETUP ENDS

;============================================================================================

 

 

;============================================================================================

;引导程序

LOAD SEGMENT

;装载任务程序到指定内存处(此处2000:0)

;此处程序应该按照0:7C00的观点来看

;注意,这里是用软盘启动计算机,并没有DOS中断可用

    ASSUME CS:LOAD

   

    ;读任务程序到2000:0

    MOV AX,2000H

    MOV ES,AX

    MOV BX,0

    PUSH AX

    PUSH BX

   

    MOV DX,0

    MOV CX,2

    MOV AL,2 

    MOV AH,2

    INT 13H

   

    ;将CS:IP指向任务程序的首地址2000:0

    RETF

LOAD ENDS

;============================================================================================

 

 

;============================================================================================

;任务程序

SYS SEGMENT

    ASSUME CS:SYS

   

    ;隐藏光标

    MOV AH,01H

    MOV CX,3030H 

    INT 10H

    MOV CX,OFFSET ENDSHOW-OFFSET SYS_START

 

    SYS_START:

    JMP SHOW_MENU

    DATE DB "00/00/00 00:00:00",0           ;日期字符串

    DATE_INPUT DB "00/00/0000:00:00",0 ;用户输入的日期字符串,当输入不正确或者退出输入时,

                                            ;可以避免改变原始日期

    DATE_POS DB 0,2,4,7,8,9             ;定位 CMOS RAM   中日期各项的地址

    DATE_CHAR_POS DB 15,12,9,6,3,0          ;定位日期字符串中各项的位置

    DATE_COLOR DB 2

    ;提示字符串

    PRESS_ESC   DB "PRESS ESC TORETURN MENU",0

    PRESS_F1    DB "PRESS F1 TOCHANGE COLOR",0

    INPUT_DATE  DB "INPUT A DATEIN THE FORM OF YY/MM/DD HH:MM:SS,PRESS ENTER TO END INPUT",0

    OPTION1 DB "1) RESET PC",0

    OPTION2 DB "2) START SYSTEM",0

    OPTION3 DB "3) CLOCK",0

    OPTION4 DB "4) SET CLOCK",0

    ;直接定址表

    TABLE DW SUB1,SUB2,SUB3,SUB4

   

    ;列出功能选项

    SHOW_MENU:

    CALL CLS

    PUSH CS

    POP DS

    MOV SI,OFFSET OPTION1 

    MOV DX,0

    MOV CL,2

    CALL SHOW_STR

    INC DH

    MOV SI,OFFSET OPTION2

    CALL SHOW_STR

    INC DH

    MOV SI,OFFSET OPTION3

    CALL SHOW_STR

    INC DH

    MOV SI,OFFSET OPTION4

    CALL SHOW_STR

   

    GET_INPUT:

    MOV AH,0        ;获取键盘输入

    INT 16H

   

    SUB AL,30H

    CMP AL,1

    JB  GET_INPUT

    CMP AL,4

    JA  GET_INPUT

    MOV BL,AL

    DEC BL          ;1~4转化为0~3

    MOV BH,0

    SHL BX,1

    CALL WORD PTR CS:TABLE[BX] ;进入子程序

    JMP SHOW_MENU

   

    ;重新启动计算机

    SUB1:

    MOV AX,0FFFFH

    PUSH AX

    MOV AX,0H

    PUSH AX

    RETF

   

    ;引导硬盘现有的操作系统

    SUB2:

    CALL CLS

   

    MOV AX,0

    MOV ES,AX

    MOV BX,7C00H

    PUSH AX

    PUSH BX

   

    MOV DL,80H

    MOV DH,0

    MOV CH,0

    MOV CL,1

    MOV AL,1

    MOV AH,2

    INT 13H     ;读入硬盘0面0道1扇区的内容到0:7C00H

    RETF            ;CS:IP指向0:7C00H   

   

    ;循环显示时间

    SUB3:

    ;清屏,显示提示字符串,设置读取日期的循环次数及各项的起始地址

    CALL CLS

    PRE_SHOW_DATE:

    ;输出提示信息 

    MOV SI,OFFSET PRESS_ESC

    MOV DX,0

    MOV CL,DATE_COLOR

    CALL SHOW_STR

    MOV SI,OFFSET PRESS_F1

    MOV DX,0100H

    CALL SHOW_STR

   

   

    MOV CX,6            ;循环次数=6

    MOV DI,OFFSET DATE_POS ;DI用来定位需要读取的CMOS ROM的单元

    MOV BX,OFFSET DATE_CHAR_POS  ;BX用来定位日期各项的位置

   

    ;读取字符串

    READ_DATE:

    PUSH CX         ;保存循环次数

    ;读取日期的一项,放置到日期字符串相应的位置

    MOV AL,[DI]     ;CMOS ROM 日期的某单元

    OUT 70H,AL          ;向端口70H写入要访问的单元的地址

    IN AL,71H           ;从端口71H获得要写入AL的数据

    CALL BCD2ASCII;BCD码转化为数字的ASCII码,(AH)=十位的ASCII码,(AL)=个位的ASCII码

    PUSH AX         ;压入(AX),因为后面还要传送到DATE,而紧接着改变了(AX)

    MOV AL,[BX]     ;(AL)=日期某项的位置

    MOV AH,0            ;(AH)置零

    MOV SI,AX           ;SI指向日期字符串某项的位置

    POP AX              ;恢复(AX)

    MOV BYTE PTR DATE[SI],AH    ;传送

    MOV BYTE PTR DATE[SI+1],AL

    INC DI              ;DI+1,定位到下一个单元        

    INC BX              ;BX+1,定位到DATE字符串下一个位置

    POP CX              ;恢复循环次数

    LOOP READ_DATE      ;继续传送日期的下一项到DATE

   

    ;显示日期字符串,DS:SI指向字符串首地址

    MOV DX,0300H  

    MOV CL,DATE_COLOR 

    MOV SI,OFFSET DATE 

    CALL SHOW_STR 

   

    SUB3_INPUT:

    MOV AH,1            ;获取键盘输入,非阻塞 

    INT 16H

    JZ PRE_SHOW_DATE  ;缓冲区无按键

    CMP AL,1BH          ;ESC

    JE SUB3_RET

    CMP AH,3BH          ;F1

    JE  CHG_COLOR

    JMP CLEAR_BUFFER 

    CHG_COLOR:

    INC DATE_COLOR

   

    CLEAR_BUFFER:

    MOV AH,0            ;16H中断的1号功能不会清除键盘缓冲区，下次读取还会读出

    INT 16H             ;调用0号功能清除一次

   

    CALL DELAY

    JMP PRE_SHOW_DATE

   

    SUB3_RET:

    MOV AH,0            ;16H中断的1号功能不会清除键盘缓冲区，下次读取还会读出

    INT 16H             ;调用0号功能清除一次

    MOV CL,2

    MOV DATE_COLOR,CL

    RET

   

    ;修改当前日期、时间

    SUB4:

    CALL CLS

    ;输出提示信息

    MOV SI,OFFSET PRESS_ESC

    MOV DX,0

    MOV CL,2

    CALL SHOW_STR

    MOV SI,OFFSET INPUT_DATE

    MOV DX,0100H

    CALL SHOW_STR

   

    ;设置字符栈的位置,获取日期输入前的准备

    MOV SI,OFFSET DATE_INPUT 

    MOV DX,0300H        ;显示的位置

   

    GET_DATE:

    MOV AH,0

    INT 16H

    CMP AL,20H          ;空格

    JE PUSH_CHAR

    CMP AL,3AH          ;冒号

    JE PUSH_CHAR

    CMP AL,2FH

    JB NO_DATE      ;ASCII码小于2FH,说明不是数字或斜杠'/' 

    CMP AL,39H

    JA NO_DATE          ;ASCII码大于39H,说明不是数字或斜杠'/'

   

    PUSH_CHAR:

    MOV AH,0

    CALL CHARSTACK      ;字符入栈

   

    MOV AH,2

    CALL CHARSTACK      ;字符串显示

    JMP GET_DATE

   

    NO_DATE:

    CMP AH,0EH          ;退格

    JE BACKSPACE

    CMP AH,1CH          ;ENTER

    JE PRESS_ENTER

    CMP AL,1BH          ;ESC

    JE ESC_SUB4 

    JMP GET_DATE

   

    BACKSPACE:

    MOV AH,1

    CALL CHARSTACK      ;字符出栈

    MOV AH,2

    CALL CHARSTACK      ;字符串显示

    JMP GET_DATE

   

    ESC_SUB4:           ;退出SUB4,DATE字符串的内容未被改变

    MOV AH,0

    CALL CHARSTACK

    JMP SUB4_RET

   

    PRESS_ENTER:

    MOV AL,0

    MOV AH,0

    CALL CHARSTACK      ;0入栈

 

    MOV AH,2

    CALL CHARSTACK      ;字符串显示

   

    ;完成输入,复制 DATE_INPUT 的内容到 DATE

    MOV SI,OFFSET DATE_INPUT

    PUSH CS

    POP ES

    MOV DI,OFFSET DATE

    MOV CX,18

    REP MOVSB

   

    MOV CX,6            ;循环次数=6

    MOV DI,OFFSET DATE_POS ;DI用来定位需要读取的CMOS ROM的单元

    MOV BX,OFFSET DATE_CHAR_POS  ;BX用来定位日期各项的位置

   

    SET_DATE:

    PUSH CX         ;保存循环次数

    ;读取日期的一项,放置到日期字符串相应的位置

    MOV AL,[DI]     ;CMOS ROM 日期的某单元

    OUT 70H,AL          ;向端口70H写入要访问的单元的地址

    MOV AL,[BX]

    MOV AH,0

    MOV SI,AX

    MOV AH,DATE[SI] ;传送日期项的内容

    MOV AL,DATE[SI+1]

    CALL ASCII2BCD      ;两位数字的ASCII码转化为BCD码(AH的高4位=十位,AH的低4位=个位)

    OUT 71H,AL      ;将日期项的BCD码写入到CMOS ROM

    INC DI              ;DI+1,定位到下一个单元        

    INC BX              ;BX+1,定位到DATE字符串下一个位置

    POP CX              ;恢复循环次数

    LOOP SET_DATE       ;继续传送日期的下一项到DATE

   

    SUB4_RET:

    RET

   

;--------------------------------------------------------------------------------------------

;功能:在指定的位置，用指定的颜色，显示一个用0结尾的字符串。

;参数:(DH)=行号(0~24),(DL)=列号(0~79),(CL)=颜色,DS:SI指向字符串的首地址。

;返回:无

    SHOW_STR:

    PUSH AX             ;保护现场

    PUSH ES

    PUSH DX

    PUSH DI

    PUSH SI

    MOV AX,0B800H       ;显示缓冲区段地址

    MOV ES,AX           ;(ES)=显示缓冲区段地址

    MOV AL,0A0H         ;以下计算初始字符的偏移地址

    MUL DH              ;行数×0A0H(160个字节)

    MOV DI,AX           ;转移到DI中

    MOV AL,2            ;显示缓冲区中一个字符占两个字节空间

    MUL DL              ;2×列号

    ADD DI,AX           ;获得初始字符的偏移地址

    S:

    MOV AX,DS:[SI]      ;输出字符到显示缓冲区

    MOV ES:[DI],AX

    INC DI              ;准备写入颜色信息

    MOV ES:[DI],CL      ;写入颜色信息

    INC SI              ;准备输出下一个字符

    PUSH CX             ;保存颜色=(CL)

    MOV CX,DS:[SI]      ;(CX)=下一个字符

    MOV CH,0            ;!!!若DS:[SI]的低位字节为零，但其高位字节不为零,

                        ;!!!则程序不能如期望的那样跳转到END_SHOW

    JCXZ END_SHOW       ;不为零则继续输出，为零则结束子程序

    POP CX              ;恢复颜色=(CL)

    INC DI              ;准备写入下一个字符

    JMP S               ;输出下一个字符

    END_SHOW:

    POP CX              ;!!!如果(CX)≠0,就会跳转到这里,此时(CX)在栈中还没有弹出

                        ;!!!如果不弹出就会引发错误

    POP SI              ;恢复现场

    POP DI

    POP DX

    POP ES

    POP AX

    RET

;--------------------------------------------------------------------------------------------

   

;--------------------------------------------------------------------------------------------

;功能:清屏

;参数:无

;返回:无

    CLS:

    PUSH AX

    PUSH CX

    PUSH DI

    PUSH ES

    MOV AX,0B800H

    MOV ES,AX

    MOV DI,0

    MOV CX,2000

   

    CLS_S:

    MOV BYTE PTR ES:[DI],0 ;为什么把BYTE改成WORD会引发崩溃?

    ;然而等我写好了程序再把 BYTE 改成 WORD ，发现并不会崩溃，但

    ;一开始最精简的程序又会崩溃，显示不出来东西，这又是为什么呢？

    ;问题待查

    INC DI

    INC DI

    LOOP CLS_S

   

    ;恢复颜色

    MOV DI,1

    MOV CX,2000

    RESET_COLOR:

    MOV BYTE PTR ES:[DI],7

    INC DI

    INC DI

    LOOP RESET_COLOR

   

    POP ES

    POP DI

    POP CX

    POP AX

    RET

;--------------------------------------------------------------------------------------------

 

;--------------------------------------------------------------------------------------------

;功能:把一个byte、两位数的BCD码转变成2个byte的ASCII码

;参数:(AL)=十进制两位数的BCD码(十位=高4位的BCD码,个位=低4位的BCD码)

;返回:(AH)=十位的ASCII码,(AL)=个位的ASCII码 

    BCD2ASCII:

    PUSH CX     ;保存用到的寄存器

    MOV AH,AL       ;AL中的BCD码复制一份到AH中

    MOV CL,4        ;右移4位,取得月份十位的值

    SHR AH,CL       ;(AH)=月份十位的值

    AND AL,00001111B;(AL)=月份个位的值

    ADD AH,30H      ;(AH)=月份十位的ASCII码

    ADD AL,30H      ;(AL)=月份个位的ASCII码

    POP CX          ;恢复用到的寄存器

    RET         ;返回

;--------------------------------------------------------------------------------------------

 

;--------------------------------------------------------------------------------------------

;功能:把2个byte的ASCII码转变成一个byte、两位数的BCD码

;参数:(AH)=十位的ASCII码,(AL)=个位的ASCII码

;返回:(AL)=十进制两位数的BCD码(十位=高4位的BCD码,个位=低4位的BCD码) 

    ASCII2BCD:

    PUSH CX     ;保存用到的寄存器

    SUB AH,30H      ;(AH的低4位)=月份十位的BCD码

    SUB AL,30H      ;(AL的低4位)=月份个位的BCD码

    MOV CL,4        ;左移4位

    SHL AH,CL       ;(AH的高4位)=月份十位的BCD码

    OR AH,00001111B ;(AH低4位)置1

    OR AL,11110000B ;(AL高4位)置1

    AND AL,AH       ;(AL)=十进制两位数的BCD码

    POP CX          ;恢复用到的寄存器

    RET         ;返回

;--------------------------------------------------------------------------------------------

 

;--------------------------------------------------------------------------------------------

;功能:产生延时

;参数:无

;返回:无

    DELAY:

    PUSH AX

    PUSH DX

    MOV DX,1000

    MOV AX,0   

    DELAY_S: 

    SUB AX,1

    SBB DX,0 

    CMP AX,0

    JNE DELAY_S

    CMP DX,0

    JNE DELAY_S

 

    POP DX

    POP AX

    RET         ;返回

;--------------------------------------------------------------------------------------------

 

;字符栈

;--------------------------------------------------------------------------------------------

;功能:0号:字符入栈 1号:字符出栈 2号:显示栈中的字符

;参数:   (AH)=功能选择,(AL)=入栈的字符,DS:SI指向字符栈空间

;       (DH)=显示的行位置,(DL)=显示的列位置

;返回:(AL)=出栈的字符

    CHARSTACK:

    JMP CHARSTART

   

    CHAR_TABLE  DW CHARPUSH,CHARPOP,CHARSHOW

    TOP         DW  0

       

    CHARSTART:

    PUSH BX

    CMP AH,2

    JA SRET     ;没有对应的功能号,结束子程序

    ;调用相应的子功能 

    MOV BL,AH

    MOV BH,0

    SHL BX,1

    CALL WORD PTR CHAR_TABLE[BX]

   

    ;限制输入的长度,如果超过了日期字符串的长度,将TOP置为0

    CMP TOP,18

    JNE SRET

    MOV TOP,0

   

    SRET:

    POP BX

    RET

   

    ;字符入栈,(AL)=入栈的字符 

    CHARPUSH:

    CMP AL,1BH      ;如果是ESC

    JE ESC_INPUT    ;跳转到ESC_INPUT

    PUSH BX

    MOV BX,TOP

    MOV [BX][SI],AL ;字符入栈

    MOV BYTE PTR 1[BX][SI],0

    INC TOP     ;TOP指向新的栈顶

    POP BX

    JMP CHARPUSH_RET

   

    ESC_INPUT: 

    MOV TOP,0       ;TOP置为0

   

    CHARPUSH_RET:

    RET

   

    ;字符出栈,(AL)=出栈的字符

    CHARPOP:

    PUSH BX

    CMP TOP,0       ;是否已到栈底

    JE CHARPOPRET   ;是则不出栈,结束子功能 

    DEC TOP     ;TOP指向要出栈的字符

    MOV BX,TOP

    MOV AL,[BX][SI] ;字符出栈

    MOV BYTE PTR [BX][SI],' '

    CHARPOPRET:

    POP BX

    RET

   

    ;DS:SI指向字符栈空间,(DH)=显示的行位置,(DL)=显示的列位置

    CHARSHOW:

    PUSH AX

    PUSH BX

    PUSH DX

    PUSH DI

    PUSH ES

    ;使ES:SI指向显示的位置,DS:SI指向字符栈空间

    MOV BX,0B800H

    MOV ES,BX

    MOV AL,160

    MUL DH

    MOV DI,AX

    MOV AL,DL

    SHL AL,1

    MOV AH,0

    ADD DI,AX  

   

    MOV BX,0

   

    CHARSHOWS:

    CMP TOP,0

    JE SET_CURSOR       ;处理删除最后一个字符的事件

    CMP BX,TOP

    JE ENDSHOW

    MOV AL,[BX][SI]

    MOV ES:[DI],AL

    MOV ES:[DI+2],BYTE PTR ' '

    INC BX

    INC DI

    INC DI

    JMP CHARSHOWS

   

    SET_CURSOR:

    MOV BYTE PTR ES:[DI],' '

       

    ENDSHOW:   

    POP ES

    POP DI

    POP DX

    POP BX

    POP AX

    RET

;--------------------------------------------------------------------------------------------

 

SYS ENDS

;============================================================================================

 

   

;安装过程的第一行指令

END START
```



## 截屏

### 登录界面

![登录界面](/home/yinzhongen/.config/Typora/typora-user-images/image-20200425163206741.png)

### clock

<img src="/home/yinzhongen/.config/Typora/typora-user-images/image-20200425163535587.png" alt="image-20200425163535587" style="zoom:80%;" />

### set clock

​	<img src="/home/yinzhongen/.config/Typora/typora-user-images/image-20200425163652182.png" alt="image-20200425163652182" style="zoom:80%;" />

<img src="/home/yinzhongen/.config/Typora/typora-user-images/image-20200425163819167.png" alt="image-20200425163819167" style="zoom:80%;" />

### start system

​	<img src="/home/yinzhongen/.config/Typora/typora-user-images/image-20200425163913934.png" alt="image-20200425163913934" style="zoom:80%;" />