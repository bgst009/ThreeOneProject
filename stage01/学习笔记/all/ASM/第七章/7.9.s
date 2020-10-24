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
        mov di,160*9+2*31


        mov bx,0
        mov cx,4
showR:  push cx

        mov si,0
        mov cx,16
showC:

        mov al,[bx+si]
        mov es:[di],al
        mov ah,2
        mov es:[di+1],ah

        inc si
        add di,2

        loop showC

        add bx,16

        sub di,32
        add di,160
        pop cx
        loop showR

        mov ax,4c00h
        int 21h

code ends
end start