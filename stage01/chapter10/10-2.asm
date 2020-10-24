assume cs:code,ds:data,ss:stack

data segment
data ends

stack segment
    db 128 dup(0)
stack ends

code segment
    start:
        mov ax,data
        mov ds,ax
        mov ax,stack
        mov ss,ax
        mov sp,128

        mov ax,4240h;L
        mov dx,000fh;H
        mov cx,0ah;N

        push ax
        mov bp,sp
        call divdw

        mov ax,4c00h
        int 21h

        divdw:

            mov ax,dx
            mov dx,0
            div cx
            push ax

            mov ax,ss:[bp+0];
            div cx
            mov cx,dx

            pop dx

            ret
code ends
end start