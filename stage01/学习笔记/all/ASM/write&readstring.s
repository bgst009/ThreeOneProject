assume cs:code,ss:stack

stack segment
    db 128 dup(0)
stack ends

data segment
    db '(1) clear screen',0
data ends

code segment

start:  mov ax,stack
        mov ss,ax
        mov sp,128

        call show_input_string

        mov ax,4c00h
        int 21h

show_input_string:

                    call init_reg
                    call get_str

                    ret
;==========================
init_reg:

            ret
;==========================
get_str:    push ax
get_strs:   mov ah,0
            int 16h

            cmp al,20h
            jb nochar

            mov ah,0
            call char_stack
            mov ah,2
            call char_stack
            jmp get_strs

    nochar:     cmp ah,0eh
            je back_space
            cmp ah,1ch
            je enter
            jmp get_strs
    back_space:
            mov ah,1
            call char_stack
            mov ah,2
            call char_stack
            jmp get_strs
    enter:      
            mov al,0
            mov ah,0
            call char_stack
            mov ah,2
            call char_stack
            pop ax

            ret

;=============================
char_stack: jmp short char_start

table   dw  charpush,charpop,charshow
top     dw  0

char_start: push bx
            push dx
            push di
            push es

            cmp ah,2
            ja sret

            mov bl,ah
            mov bh,0
            add bx,bx
            jmp word ptr table[bx]

charpush:   mov bx,top
            mov [si][bx],al
            inc top
            jmp sret

charpop:    cmp top,0
            je sret
            dec top
            mov bx,top
            mov al,[si][bx]
            jmp sret

charshow:   mov ax,0b800h
            mov es,ax

            mov al,160
            mov ah,0

            mul dh
            mov di,ax
            add dl,dl
            mov dh,0
            add di,dx

            mov bx,0

charshows:  cmp bx,top
            jne noempty
            mov byte ptr es:[di],' '
            jmp sret

noempty:    mov al,[si][bx]
            mov es:[di],al
            mov byte ptr es:[di+1],2
            mov byte ptr es:[di+2],' '
            inc bx
            add di,2
            jmp charshows

sret:       pop es
            pop di
            pop dx
            pop bx
            ret


code ends

end start