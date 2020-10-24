assume cs:codeseg

codeseg segment
    dw 0123h,0456h,0789h,0abch,0defh,0cbah,0987h ;0h-fh
    dw 0,0,0,0,0,0,0,0,0,0,0 ;10h-23h
start:

        mov ax,cs
        mov ss,ax
        mov sp,24h

        mov ax,0
        mov ds,ax
        mov bx,0
        mov cx,8
    s:  push ds:[bx]
        pop cs:[bx]
        add bx,2
        loop s

        mov ax,4c00h
        int 21h

codeseg ends
end start