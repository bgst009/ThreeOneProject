assume cs:code,ss:stack,ds:data

data segment
    db 128 dup(0)
data ends

stack segment
    db 128 dup(0)
stack ends

code segment

TIME_STYLE: db  'YY/MM/DD HH:MM:SS',0
TIME_CMOS:  db  9,8,7,4,2,0

start:  mov ax,stack
        mov ss,ax
        mov sp,128

        call init_reg
        call show_clock

        mov ax,4c00h
        int 21h
;===========================================
show_clock:
            call show_TIME_STYLE
showtime:
            mov si,offset TIME_CMOS
            mov di,160*10+30*2

            mov cx,6
showdate:  
            mov al,ds:[si]
            out 70h,al
            in al,71h

            mov ah,al
            shr ah,1
            shr ah,1
            shr ah,1
            shr ah,1
            and al,00001111b

            add ah,30h
            add al,30h

            mov es:[di],ah
            mov es:[di+2],al

            inc si
            add di,6

            loop showdate

            jmp showtime

;===========================================
show_TIME_STYLE:    mov si,offset TIME_STYLE
                    mov di,160*10+30*2
                    call show_string
                    ret
;===========================================
show_string:    push dx
                push ds
                push es
                push si
                push di

ShowString:     mov dl,ds:[si]
                cmp dl,0
                je show_string_end
                mov es:[di],dl
                mov byte ptr es:[di+1],2
                inc si
                add di,2
                jmp ShowString




show_string_end:    pop di
                    pop si
                    pop es
                    pop ds
                    pop dx
                    ret
;===========================================
init_reg:   mov ax,0b800h
            mov es,ax

            mov ax,cs
            mov ds,ax

            ret

code ends

end start