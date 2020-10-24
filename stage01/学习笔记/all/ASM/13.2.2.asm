assume cs:code,ss:stack

stack segment
        db 128 dup(0)
stack ends

data segment
           ; 0123456789ab
        db 'conversation',0
data ends

code segment

start:  mov ax,stack
        mov ss,ax
        mov sp,128

    ;    call show_string
        call set_inter_table
        call mov_cap_to_table

        mov ax,data
        mov ds,ax

        int 7ch

        call show_string



        mov ax,4c00h
        int 21h


show_string:    mov ax,0b800h
                mov es,ax
                mov ax,data
                mov ds,ax
                mov si,0
                mov di,160*10+10*2
                mov cx,0

    ShowString: mov al,ds:[si]
                mov cl,al
                jcxz ssret
                mov ah,10001010b
                mov es:[di],ax
                inc si
                add di,2
                jmp ShowString


    ssret:      ret

set_inter_table:    mov ax,0
                    mov es,ax
                    mov word ptr es:[7ch*4],7e00h
                    mov word ptr es:[7ch*4+2],0

                    ret

mov_cap_to_table:   mov ax,cs
                    mov ds,ax
                    mov si,offset capitalize

                    mov ax,0
                    mov es,ax
                    mov di,7e00h

                    mov cx,offset capitalize_end - offset capitalize

                    cld
                    rep movsb

                ret
capitalize:     push cx
                push si
                mov si,0
    change:     mov cl,ds:[si]
                mov ch,0
                jcxz ok
                and byte ptr ds:[si],11011111b
                inc si
                jmp short change
                
    ok:         pop si
                pop cx
                iret
capitalize_end: nop
code ends

end start