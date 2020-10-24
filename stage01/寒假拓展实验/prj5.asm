assume cs:code,ss:stack,ds:data

stack segment
    db 128 dup(0)
stack ends

data segment
 	db 'h12E332l@L#O*&^!88nI@cE$% %$T1O m33E44E55t y77O88u!()'
	db '?'
data ends

code segment

start:  

    mov ax,data
    mov ds,ax
    mov ax,0b800h
    mov es,ax
    mov di,160*13+2*10
    mov ax,stack
    mov ss,ax
    mov sp,128

    call show_data
    add di,160
    call filter_data
    add di,160
    call show_data


    mov ax,4c00h
    int 21h

    filter_data:
        push ax
        push bx
        push cx
        push dx
        push di
        push ds
        push es

        mov bx,0
        mov al,0
        filter_data_bg:
    
        mov cx,0
        mov al,ds:[bx]
        
        ;call show_char
        ;mov byte ptr ds:[bx-1],20h
        inc bx
        mov cl,al

        cmp cl,'?'
        je filter_data_end

        cmp cl,'!'
        je filter_data_bg

        ;check ' '
        cmp cl,' '
        je filter_data_bg

        ;A-Z
        ;check above A
        cmp cl,'A'
        ja check_not_above_Z
        
        A:

        ;a-z
        cmp cl,'a'
        ja check_not_above_Z_S
        
        A_S:

        ; ;0-9
        ; cmp cl,'0'
        ; ja check_not_above_9

        Zero:

        mov byte ptr ds:[bx-1],' '
        jmp filter_data_bg

        ;check not above Z
        check_not_above_Z:
        cmp cl,'Z'
        jb filter_data_bg
        jmp A

        ;check not above Z
        check_not_above_Z_S:
        cmp cl,'z'
        jb turn_a_to_A
        jmp A_S


        turn_a_to_A:
        and al,11011111b
        mov ds:[bx-1],al
        jmp filter_data_bg

        ; ;check not above 9
        ; check_not_above_9:
        ; cmp cl,'9'
        ; jb filter_data_bg
        ; jmp Zero

        ; show_char:
        ;     mov al,ds:[bx]
        ;     mov ah,71h
        ;     mov es:[di],ax
        ;     add di,2
        ;     ret

        filter_data_end:
            pop es
            pop ds
            pop di
            pop dx
            pop cx
            pop bx
            pop ax
            ret


    show_data:
        push ax
        push bx
        push cx
        push dx
        push di
        push ds
        push es


            mov bx,0
        show_data_bg:
            mov cx,0
            mov al,ds:[bx]
            mov cl,al
            sub cl,'?'
            jcxz show_data_ret
            mov ah,71h
            mov es:[di],ax
            inc bx
            add di,2
            jmp show_data_bg

        show_data_ret:
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