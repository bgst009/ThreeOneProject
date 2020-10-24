assume cs:code,ds:data,ss:stack

data segment
	db 'welcome to masm!',0
data ends

stack segment
	db 128 dup(0)
stack ends

code segment


	start:

    mov ax,stack
    mov ss,ax
    mov sp,128

    mov ax,data
    mov ds,ax
    mov si,0

    mov dh,8;row
    mov dl,3;cul
    mov cl,2;color
    call show_str

    mov ax,4c00h
    int 21h

    show_str:
        push ax
        push dx
        push cx
        push es
        push si
        push di

        mov ax,0b800h
        mov es,ax
        mov di,0

        call get_row
        add di,ax
        call get_cul
        add di,ax

        call show

        pop di
        pop si
        pop es
        pop cx
        pop dx
        pop ax
        ret

    get_row:
        mov al,160
        mul dh
        ret
    get_cul:
        mov al,2
        mul dl
        ret

    show:
        push ax
        push bx
        push cx
        push di
        push si

        sub ax,ax
        sub bx,bx
        

        mov bl,cl
        show_1:
            mov cl,ds:[si]
            mov al,ds:[si]
            mov ch,0
            jcxz ok
            mov ah,bl
            mov es:[di],ax
            add di,2
            inc si
            jmp show_1


        ok:
        pop si
        pop di
        pop cx
        pop bx
        pop ax
        ret

        ret
code ends
end start