assume cs:code,ss:stack


stack segment
        db 128 dup(0)
stack ends

code segment

start:

        mov ax,cs
        mov ds,ax
        mov ax,0020h
        mov es,ax
        mov bx,0
       ; mov cx,17h
        sub cx,5

s:      mov al,[bx]
        mov es:[bx],al
        inc bx
        loop s


        mov ax,4c00h
        int 21h


code ends

end start