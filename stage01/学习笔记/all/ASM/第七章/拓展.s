assume cs:code,ds:data,ss:stack

data segment
    db '1. display      '
    db '2. brows        '
    db '3. replace      '
    db '4. modify       '
data ends

stack segment
 dw 0,0,0,0,0,0,0,0
stack ends

code segment
start:
        mov ax,data
        mov ds,ax
        mov ax,stack
        mov ss,ax
        mov sp,16


        mov bx,3
        mov cx,4

loopR:  push cx
        mov cx,4

loopC:  mov al,ds:[bx]
        and al,11011111b
        mov ds:[bx],al

        inc bx
        loop loopC

        sub bx,4
        add bx,16
        pop cx
        loop loopR


        mov ax,0b800h
        mov es,ax
        mov di,160*10+2*32

        mov si,0
        mov cx,4
showR:  push cx

        mov bx,0
        mov cx,16

showC:  mov al,[si+bx]
        mov ah,2

        push bx
        add bx,bx
        mov es:[di+bx],ax

        pop bx
        inc bx

        loop showC

        add si,16
        add di,160

        pop cx

        loop showR

        mov ax,4c00h
        int 21h

code ends
end start