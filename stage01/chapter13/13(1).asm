assume cs:code,ss:stack,ds:data

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

    call transfer
    call test_application

    mov ax,4c00h
    int 21h

;=======================================
test_application:
    push ax
    push bx
    push cx
    push dx
    push ds
    push es
    push si
    push di
    test_application_bg:
        mov dh,10;row
        mov dl,10;cul
        mov cl,2 ;color
        mov ax,data;ds:si
        mov ds,ax
        mov si,0
        int 7ch
    test_application_end:
        pop di
        pop si
        pop es
        pop ds
        pop dx
        pop cx
        pop bx
        pop ax
        ret
;======================================= 
transfer:
    push ax
    push bx
    push cx
    push dx
    push ds
    push es
    push si
    push di
    transfer_bg:
        ;mov 7ch
        mov ax,cs
        mov ds,ax
        mov si,offset int_7ch

        mov ax,0
        mov es,ax
        mov di,200h

        mov cx,offset int_7ch_end - offset int_7ch

        cld
        rep movsb

        ;set int table
        mov ax,0
        mov es,ax
        mov word ptr es:[7ch*4],200h
        mov word ptr es:[7ch*4+2],0
    transfer_end:
        pop di
        pop si
        pop es
        pop ds
        pop dx
        pop cx
        pop bx
        pop ax
        ret

;===================================
int_7ch:
    push ax
    push bx
    push cx
    push dx
    push ds
    push es
    push si
    push di
    int_7ch_bg:
        mov ax,0b800h
        mov es,ax
        mov di,0
        call get_row
        add di,ax
        call get_cul
        add di,ax



        s0:
            mov al,ds:[si]
            cmp al,0
            je end_0
            mov ah,cl
            mov es:[di],ax
            inc si
            inc di
            inc di
            jmp s0

        end_0:
        pop di
        pop si
        pop es
        pop ds
        pop dx
        pop cx
        pop bx
        pop ax
        iret

    get_row:
        mov al,160
        mul dh
        ret
    get_cul:
        mov al,2
        mul dl
        ret
    int_7ch_end:
        nop

code ends
end start