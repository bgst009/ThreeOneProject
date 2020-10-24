assume cs:code,ss:stack

stack segment
        db 128 dup(0)
stack ends

code segment

start:  mov ax,stack
        mov ss,ax
        mov sp,128

        call mov_sqr_to_inter
        call set_inter_table

        mov ax,3456
        int 7ch
        add ax,ax
        adc dx,dx

        

        mov ax,4c00h
        int 21h


set_inter_table:    mov ax,0
                    mov es,ax
                    mov word ptr es:[7ch*4],7e00h
                    mov word ptr es:[7ch*4+2],0

                    ret

mov_sqr_to_inter:   mov ax,cs
                    mov ds,ax
                    mov si,offset sqr

                    mov ax,0
                    mov es,ax
                    mov di,7e00h

                    mov cx,offset sqrend- offset sqr

                    cld
                    rep movsb

                    ret

sqr:    mul ax
        iret
sqrend:  nop

code ends

end start