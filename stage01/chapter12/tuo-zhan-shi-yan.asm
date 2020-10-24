assume cs:code

code segment
start:

    call a_green

    mov ax,4c00h
    int 21h

    a_green:
    push ax
    push bx
    push cx
    push dx
    push ds
    push es
    push si
    push di
    a_green_bg:
        mov ax,0b800h
        mov ds,ax
        mov si,0

        mov cx,2000
        lp:
            mov al,ds:[si]
            cmp al,'a'
            jne lp_end
            mov byte ptr ds:[si+1],2

        lp_end:
            inc si
            inc si
            loop lp
    a_green_end:
        pop di
        pop si
        pop es
        pop ds
        pop dx
        pop cx
        pop bx
        pop ax
		ret
code ends
end start