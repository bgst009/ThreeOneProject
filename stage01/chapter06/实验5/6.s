assume cs:code

data segment
    dw 1,2,3,4,5,6,7,8,0,0ah,0bh,,0ch,,0dh,,0eh,,0fh,0ffh
data ends

stack segment
    dw 0,0,0,0,0,0,0,0 
stack ends

code segment

start:  mov ax,data
        mov ds,ax

        mov ax,stack
        mov ss,ax
        mov sp,16

        mov bx,0h
        mov cx,8
s0:
        mov ax,ds:[bx]
        push ax
        add bx,2
        loop s0;

        mov ax,4c00h
        int 21h

code ends
end start