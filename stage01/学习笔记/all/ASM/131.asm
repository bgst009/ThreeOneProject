assume cs:code,ss:stack,ds:data

data segment
    db 'Welcom to masm',0
data ends

stack segment
    db 128 dup(0)
stack ends

code segment

start:  mov ax,stack
        mov ss,ax
        mov sp,128

        call load_7ch
        call set_7ch

        call init_reg
        call showstring

        mov ax,4c00h
        int 21h


;==========================================================
showstring: mov si,0
            mov dh,15
            mov dl,40
            mov cl,2

            int 7ch

            ret
;==========================================================
init_reg:   mov ax,data
            mov ds,ax

            mov ax,0b800h
            mov es,ax

            ret
;==========================================================
set_7ch:    mov ax,0
            mov es,ax
            mov word ptr es:[7ch*4],7e00h
            mov word ptr es:[7ch*4+2],0

            ret

;==========================================================
load_7ch:   mov ax,cs
            mov ds,ax
            mov si,offset fun_7ch

            mov ax,0
            mov es,ax
            mov di,7e00h

            mov cx,offset fun_7ch_end - offset fun_7ch

            cld

            rep movsb

            ret

fun_7ch:    
            call get_row_and_col
            ;call get_col
            call show
            iret

show:           push dx
                push ds
                push es
                push si
                push di

Show_String:    mov dl,ds:[si]
                cmp dl,0
                je show_ret
                mov es:[di],dl
                mov es:[di+1],cl
                add di,2
                inc si
                jmp Show_String

show_ret:       pop di
                pop si
                pop es
                pop ds
                pop dx

        ret

get_row_and_col:    mov ax,0
                    mov al,160
                    mul dh

                    mov di,ax

                    mov ax,0
                    mov al,2
                    mul dl

                    add di,ax

                    ret
fun_7ch_end: nop


code ends

end start