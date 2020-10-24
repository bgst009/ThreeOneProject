assume cs:code

a segment
    db 1,2,3,4,5,6,7,8 ;0-f
a ends

b segment
    db 1,2,3,4,5,6,7,8 ;10-1f
b ends

c segment
    db 0,0,0,0,0,0,0,0 ;20-2f
c ends

code segment

start:  mov ax,a
        mov ds,ax
        mov bx,0
        mov cx,8
    s0: mov al,ds:[bx]
        add al,ds:[bx+10h]
        mov ds:[bx+20h],al
        inc bx
        loop s0

        mov ax,4c00h
        int 21h

code ends
end start