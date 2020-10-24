assume cs:code,ss:stack


stack segment
        db 128 dup(0)
stack ends

code segment

start:

        mov ax,2000h
        mov ds,ax
        mov ax,1000h
        mov ss,ax
        mov sp,0008h

        mov word ptr ds:[0],0001h
        mov word ptr ds:[2],0002h
        mov word ptr ds:[4],0003h
        mov word ptr ds:[6],0004h

        push ds:[0]
        push ds:[2]
        push ds:[4]
        push ds:[6]

        mov ax,2000h
        mov ss,ax
        mov sp,0
        add sp,10

        pop ax
        pop bx
        push ax
        push bx
        pop ax
        pop bx

        mov ax,0b800h
        mov es,ax
        mov di,160*10+2*10
        mov byte ptr es:[di],89
        mov byte ptr es:[di+1],2

        add di,2
        mov byte ptr es:[di],90
        mov byte ptr es:[di+1],2

        add di,2
        mov byte ptr es:[di],69
        mov byte ptr es:[di+1],2

        

        mov ax,4c00h
        int 21h


code ends

end start