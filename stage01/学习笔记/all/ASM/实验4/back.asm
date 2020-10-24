assume cs:code,ss:stack,ds:data

data segment
        db 'yingzhongen'
data ends

stack segment
        db 128 dup(0)
stack ends

code segment

start:

        mov ax,0b800h
        mov es,ax
        mov di,160*12+50

        mov bx,0041h
        mov cx,26
s:      mov es:[di],bl
        mov byte ptr es:[di+1],2
        add di,2
        inc bl
        loop s

        mov ax,4c00h
        int 21h


code ends

end start