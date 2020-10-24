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

        call init_reg
        call load_7ch
        call renew_table

        call show_option

        mov ax,0
        int 16h


        mov ah,al
        mov al,2
        int 7ch

        mov ax,4c00h
        int 21h

show_option:    push ax
                push es

                mov ax,0b800h
                mov es,ax
                mov ax,data
                mov ds,ax

                mov si,0
                mov di,160*10+40

        so:     mov al,ds:[si]
                cmp al,0
                je show_option_ret
                mov ah,2
                mov es:[di],ax
                inc si
                add di,2
                jmp so


                inc si
                add di,2

show_option_ret:pop es
                pop ax
                ret

int7ch: 
        jmp setscreen
  table dw offset sub1 - offset int7ch + 7e00h
        dw offset sub2 - offset int7ch + 7e00h
        dw offset sub3 - offset int7ch + 7e00h
        dw offset sub4 - offset int7ch + 7e00h

    setscreen:
        push bx

        ;call sub1
        ;call sub2
        ;call sub3
        ;call sub4

        cmp ah,3
        ja sret

        mov bx,0
        mov es,bx

        mov bl,ah
        add bx,bx
        add bx,offset table - offset int7ch + 7e00h

        call word ptr es:[bx]

    sret:   pop bx
            ret


int7chIret:iret

    sub1:   push ax
            push cx
            push es

            mov bx,0b800h
            mov es,bx
            mov bx,0
            mov cx,2000
        sb1:mov byte ptr es:[bx],' '
            add bx,2
            loop sb1

            pop es
            pop cx
            pop bx
            ret
    sub2:   push bx
            push cx
            push es

            mov bx,0b800h
            mov es,bx
            mov bx,1
            mov cx,2000
        sb2:and byte ptr es:[bx],11111000b
            or es:[bx],al
            add bx,2
            loop sb2

            pop es
            pop cx
            pop bx
            ret

    sub3:   push bx
            push cx
            push es

            mov cl,4
            shl al,cl

            mov bx,0b800h
            mov es,bx
            mov bx,1
            mov cx,2000

        sb3:and byte ptr es:[bx],10001111b
            or es:[bx],al
            add bx,2
            loop sb3

            pop es
            pop cx
            pop bx
            ret

    sub4:   push cx
            push si
            push di
            push es
            push ds

            mov si,0b800h
            mov es,si
            mov ds,si

            mov si,160
            mov di,0

            cld
            mov cx,24

        sb4:push cx
            mov cx,160
            rep movsb
            pop cx
            loop sb4

            mov cx,80
            mov si,0
        sb4s1:  mov byte ptr [160*24+si],' '
                add si,2
                loop sb4s1

            pop ds
            pop es
            pop di
            pop si
            pop cx
            ret

int7chend: nop


renew_table:    push ax
                push es

                mov ax,0
                mov es,ax
                mov word ptr es:[7ch*4],7e00h
                mov word ptr es:[7ch*4+2],0

                pop es
                pop ax
                ret

load_7ch:   push ax
            push ds
            push es
            push si
            push di

            mov ax,cs
            mov ds,ax
            mov si,offset int7ch
            mov ax,0
            mov es,ax
            mov di,7e00h

            mov cx,offset int7chend - offset int7ch

            cld

            rep movsb

            pop di
            pop si
            pop es
            pop ds
            pop ax
            ret

init_reg:   mov ax,data
            mov ds,ax

            ret

code ends

end start