assume cs:code

code segment
start:
    call get_str
    mov ax,4c00h
    int 21h
;==========================================================
    get_str:
        push ax
        get_str_bg:
            mov ah,0
            int 16h

            cmp al,20h
            jb nochar
            mov ah,0
            call char_stack
            mov ah,2
            call char_stack
            jmp get_str_bg
        nochar:
            cmp ah,0eh
            je backspace
            cmp ah,1ch
            je enter
            jmp get_str_bg

        backspace:
            mov ah,1
            call char_stack
            mov ah,2
            call char_stack
            jmp get_str
        
        enter:
            mov al,0
            mov ah,0
            call char_stack
            mov ah,2
            call char_stack
            pop ax
        get_str_end:
            ret
;==========================================================
    char_stack:
        jmp short char_stack_bg
        table dw char_push,char_pop,char_show
        top   dw 0
        char_stack_bg:
            push bx
            push dx
            push di
            push es

            cmp ah,2
            ja char_stack_end

            mov bl,ah
            mov bh,0
            add bx,bx
            jmp word ptr table[bx]

            char_push:
                mov bx,top
                mov [si][bx],al
                inc top
                jmp char_stack_end
            
            char_pop:
                cmp top,0
                je char_stack_end
                dec top
                mov bx,top
                mov al,[si][bx]
                jmp char_stack_end

            char_show:
                mov bx,0b800h
                mov es,bx
                mov al,160
                mov ah,0
                mul dh
                mov di,ax
                add dl,dl
                mov dh,0
                add di,dx

                mov bx,0

                char_show_lp1:
                    cmp bx,top
                    jne noempty
                    mov byte ptr es:[di],' '
                    jmp char_stack_end
                noempty:
                    mov al,[si][bx]
                    mov es:[di],al
                    mov byte ptr es:[di+2],' '
                    inc bx
                    add di,2
                    jmp char_show_lp1

        char_stack_end:
            pop es
            pop di
            pop dx
            pop bx
            ret
code ends
end start