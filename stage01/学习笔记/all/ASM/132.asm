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
        call show_char




        mov ax,4c00h
        int 21h

show_char:  mov di,160*12
            mov bx,offset sc - offset sce
            mov cx,80

sc:         mov byte ptr es:[di],'!'
            mov byte ptr es:[di+1],2
            add di,2
            int 7ch
sce:        ret


init_reg:   mov ax,0b800h
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

fun_7ch:    push bp
            mov bp,sp
            dec cx
            jcxz fun_7ch_iret
            add ss:[bp+2],bx

fun_7ch_iret:   pop bp
            iret


fun_7ch_end: nop


code ends

end start