assume cs:code,ss:stack

stack segment
    db 128 dup (0)
stack ends

code segment
start:
    mov ax,stack
    mov ss,ax
    mov sp,128

    call install_int

    call ShowABC

    ;call RenewInt9
    mov ax,4c00h
    int 21h

;======== ShowABC ===========
ShowABC:
    push ax
    push bx
    push cx
    push dx
    push ds
    push es
    push si
    push di

    mov ax,0b800h
    mov es,ax
    mov di,160*12+40*2
    mov al,'b'
    LoopS:  
        mov es:[di],al
        mov byte ptr es:[di+1],11011000b
        call delay

        cmp dl,'z'
        jna LoopS


    pop di
    pop si
    pop es
    pop ds
    pop dx
    pop cx
    pop bx
    pop ax
    ret

delay:  
    push ax
    push dx

    mov dx,1000h
    mov ax,0

    s1: 
        sub ax,1
        sbb dx,0
        cmp ax,0
        jne s1
        cmp dx,0
        jne s1

    pop dx
    pop ax

    ret
;====== install_int =========
install_int:
    install_int_bg:
        ;save

        mov ax,0
        mov es,ax
        push es:[9*4]
        pop es:[200h]
        push es:[9*4+2]
        pop es:[202h]

        ;set new
        cli
        mov word ptr es:[9*4],204h
        mov word ptr es:[9*4+2],0
        sti


        ;load
        push cs
        pop ds

        mov ax,0
        mov es,ax

        mov si,offset int9
        mov di,204h
        mov cx,offset int9_end - offset int9
        cld
        rep movsb

    install_int_end:
        ret


;====== int9 =================
int9:
    push ax
    push bx
    push cx
    push dx
    push es 
    push ds
    push di
    push si
        
    int9_bg:

        in al,60h

        pushf
        call dword ptr cs:[200h]

        cmp al,9eh
        jne F1

        mov ax,0b800h
        mov es,ax
        mov bx,1
        mov al,'A'
        mov cx,2000h
        s9: ;inc byte ptr es:[bx]
            mov es:[bx-1],al
            add bx,2
            loop s9

    F1:         cmp al,3bh
                jne A

                mov ax,0b800h
                mov es,ax
                mov bx,1
                mov cx,2000
        sF1:    inc byte ptr es:[bx]
                add bx,2
                loop sF1

    A:          cmp al,1eh
                jne int9_iret
                mov ax,0b800h
                mov es,ax
                mov bx,0
                mov cx,2000
            A_L:mov al,' '
                mov es:[bx],al
                add bx,2
                loop A_L

        int9_iret:
            pop si
            pop di
            pop ds
            pop es
            pop dx
            pop cx
            pop bx
            pop ax
            iret
    int9_end:   
        nop

;======================================
RenewInt9:
    mov ax,0
    mov es,ax
    push es:[200h]
    pop es:[9*4]
    push es:[202h]
    pop es:[9*4+2]

    ret
code ends
end start