assume cs:code

code segment
s1: db  'Good,better,best,','$'
s2: db  'Never let it rest','$'
s3: db  'Till good is better,','$'
s4: db  'And better,best.','$'
s:  dw  offset s1,offset s2,offset s3,offset s4
row:    db 2,4,6,8

start:
        call load_7ch
        call set_7ch

        call show

        mov ax,4c00h
        int 21h

show:   mov ax,cs
        mov ds,ax
        mov bx,offset s
        mov si,offset row
        mov cx,4
    ok: mov bh,0
        mov dh,ds:[si]
        mov dl,0
        mov ah,2
        int 10h

        mov dx,ds:[bx]
        mov ah,9
        int 21h

        inc si
        add bx,2

        loop ok

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
fun_7ch_iret:  
            iret


fun_7ch_end: nop


code ends

end start