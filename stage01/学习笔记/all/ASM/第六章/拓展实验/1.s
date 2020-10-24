assume cs:code,ss:stack,ds:data

data segment
    db 'ying zhong en'
data ends

stack segment
    dw 0,0,0,0,0,0,0,0
stack ends

code segment
start:
        mov ax,stack
        mov ss,ax
        mov sp,16

        mov ax,0b800h
        mov es,ax
        mov di,160*12+2*30
        mov bx,0

        mov ax,data
        mov ds,ax

        mov cx,3
lp1:    push cx

        mov cx,16
        push di
        mov bx,0

lp2:    mov al,ds:[bx]
        mov es:[di],al
        mov byte ptr es:[di+1],2
        add di,2
        inc bx
        loop lp2


        pop di
        add di,160
        pop cx
        loop lp1

code ends
end start