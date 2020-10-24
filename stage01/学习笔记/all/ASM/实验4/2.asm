assume cs:code,ss:stack


stack segment
        db 128 dup(0)
stack ends

code segment

start:

        mov ax,0020h
        mov ds,ax
        mov bx,0000h
        mov cx,64

lp:     mov ds:[bx],bx
        inc bx
        loop lp

        mov ax,4c00h
        int 21h


code ends

end start