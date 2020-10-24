assume cs:code,ss:stack,ds:data

data segment
    db 'coversation!',0
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
    mov ax,data
    mov ds,ax
    mov si,0
    mov ax,0b800h
    mov es,ax
    mov di,160*15+2*20

    s:
        cmp byte ptr ds:[si],0
        je test_application_end
        mov al,ds:[si]
        mov ah,2
        mov es:[di],ax
        inc si
        inc di
        inc di
        mov bx,offset s - offset test_application_end
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

    int_7ch:
    int_7ch_bg:
        push bp
        mov bp,sp
        add [bp+2],bx

        pop bp
        iret
    int_7ch_end:
        nop

code ends
end start