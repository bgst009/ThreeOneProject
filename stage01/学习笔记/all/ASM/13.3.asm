assume cs:code,ss:stack

stack segment
    db 128 dup(0)
stack ends

code segment

start:  mov ax,0b800h
        mov es,ax
        mov di,160*10+10*2

        call load_7ch
        call add_int_table

        mov bx,offset se- offset s
        mov cx,80
s:      mov byte ptr es:[di],'!'
        mov byte ptr es:[di+1],10001100b
        add di,2
        int 7ch
se:     nop

        mov ax,4c00h
        int 21h
        

add_int_table:      push ax
                    push es

                    mov ax,0
                    mov es,ax
                    mov word ptr es:[7ch*4],200h
                    mov word ptr es:[7ch*4+2],0

                    pop es
                    pop es

                    ret

load_7ch:   push ax

            push ds
            push si
            push es
            push di
            push cx

            mov ax,cs
            mov ds,ax
            mov si,offset lp

            mov ax,0
            mov es,ax
            mov di,200h

            mov cx,offset lp_end - offset lp

            cld
            rep movsb

            pop cx
            pop di
            pop es
            pop si
            pop ds
            pop ax

            ret

lp:     mov bp,0
        push,bp
        mov bp,sp
        dec cx
        jcxz ipret
        add ss:[bp+2],bx
        
ipret:  pop bp
        iret
lp_end: nop



code ends

end start