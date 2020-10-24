assume cs:code,ss:stack,ds:data

data segment
data ends

stack segment
stack ends

code segent
start:
    mov ax,0b800h
    mov es,ax
    mov bx,0h

    mov ah,3
    mov al,8
    mov ch,0
    mov cl,1
    mov dh,0
    mov dl,0
    int 13h

    mov ax,4c00h
    int 21h
code ends
end start