assume cs:code

code segment

start:  ;do0安装
        
            ;源地址
        mov ax,cs
        mov ds,ax
        mov si,offset do0;0034
            ;目的地址
        mov ax,0
        mov es,ax
        mov di,7e00h
            ;设置传送长度
        mov cx,offset do0end-offset do0;0032
            ;甚至传送方向为正方向
        cld
        rep  movsb

        ;设置中断向量表

        mov ax,0
        mov es,ax
        mov word ptr es:[0*4],7e00h
        mov word ptr es:[0*4+2],0

    ;    int 0

        mov ax,1000
        mov bh,1
        div bh

        mov ax,4c00h
        int 21h

do0:    jmp short do0start
string: db 'divide error';12

do0start:   mov ax,cs
            mov ds,ax
        ;    mov si,202h     ;设置ds:si指向字符串
            mov si,offset string - offset do0 + 7e00h

            mov ax,0b800h
            mov es,ax
            mov di,12*160+36*2      ;设置es:di指向显存空间位置

            mov cx,12           ;设置cx的长度
    s:      mov al,ds:[si]
            mov ah,10001100b
            mov es:[di],ax
            inc si
            add di,2
            loop s

        mov ax,4c00h
        int 21h

do0end: nop

code ends

end start