assume cs:code,ss:stack,ds:data

stack segment
    db 128 dup(0)
stack ends

data segment
    db 'A'
    db 2
data ends

code segment

start:  
        mov ax,0b800h
        mov es,ax
        mov di,160*12+2*30
        
        mov ax,data
        mov ds,ax

        mov al,ds:[0]
        mov ah,ds:[1]

        mov es:[di],ax

        mov ax,4c00h
        int 21h

code ends
end start