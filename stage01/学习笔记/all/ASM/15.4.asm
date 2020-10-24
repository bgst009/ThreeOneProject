assume cs:code,ss:stack

stack segment
    db 128 dup(0)
stack ends

data segment
    db 128 dup(0)
data ends

code segment

start:  mov ax,stack
        mov ss,ax
        mov sp,128

        call saveOldInt9

        call showABC

        call renewint9

        mov ax,4c00h
        int 21h

renewint9:  push ax
            push es


            mov ax,0
            mov es,ax

            push ds:[0]
            push ds:[2]
            pop es:[9*4+2]
            pop es:[9*4]

            pop es
            pop ax
            ret

saveOldInt9:push ax
            push ds
            push es

            mov ax,data
            mov ds,ax

            mov ax,0
            mov es,ax

            push es:[9*4]
            pop ds:[0]
            push es:[9*4+2]
            pop ds:[2]

            mov word ptr es:[9*4],offset int9
            mov es:[9*4+2],cs

            pop es
            pop ds
            pop ax
            ret

int9:   push ax
        push bx
        push es

        in al,60h

        pushf

        pushf
        pop bx
        and bh,11111100b
        push bx
        popf

        call dword ptr ds:[0]

        cmp al,1
        jne int9iret

        mov ax,0b800h
        mov es,ax

        inc byte ptr es:[160*12+40*2+1]


    
int9iret:   pop es
            pop bx
            pop ax
    iret

showABC:
        mov ax,0b800h
        mov es,ax

        mov di,160*12+40*2

        mov al,'a'
s:
        mov es:[di],al
        mov byte ptr es:[di+1],01011010b

        call delay


        inc al
        cmp al,'z'
        jna s

        ret

delay:  push ax
        push dx

        mov dx,10h
        mov ax,0
    s1: sub ax,1
        sbb dx,0
        cmp ax,0
        jne s1
        cmp dx,0
        jne s1

        pop dx
        pop ax

        ret

code ends

end start