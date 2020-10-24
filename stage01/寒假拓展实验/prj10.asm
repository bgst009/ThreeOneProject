assume cs:code,ds:data

data segment
db 'happy spring festival!';22
data ends

code segment
start:

    mov ax,data
    mov ds,ax
    mov ax,0b800h
    mov es,ax

    call show

    mov ax,4c00h
    int 21h

    show:

        push ax
        push bx
        push cx
        push dx
        push di
        push ds
        push es
        show_bg:
            mov cx,3
            s1:;show three happy spring festival！
                call show_one_string
            loop s1
        show_end:
            pop es
            pop ds
            pop di
            pop dx
            pop cx
            pop bx
            pop ax
            ret

    show_one_string:
        push ax
        push bx
        push cx
        push dx
        push di
        push ds
        push es
        show_one_string_bg:
            mov cx,22
            mov bx,0
            mov ah,1
            s2:
                mov al,ds:[bx]
                mov es:[di],al
                mov es:[di+1],ah

                inc bx
                add di,161
                loop s2
        show_one_string_end:
            pop es
            pop ds
            pop di
            pop dx
            pop cx
            pop bx
            pop ax
            ret

code ends
end start