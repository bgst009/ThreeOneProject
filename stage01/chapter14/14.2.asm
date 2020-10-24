assume cs:code

code segment
start:

    mov bx,0
    mov ax,1


    mov cx,10
    s:
        add bx,ax
        loop s
    
    mov ax,1
    shl ax,1
    mov dx,0
    mov cx,5
    s1:
        add dx,ax
        loop s1


    mov ax,4c00h
    int 21h
code ends
end start