assume cs:code,ds:Cryptography

Cryptography segment
      ; 0123456789abcdef0
    db 'tqsfbe!zpvs!xjoht' 
    db '!!cf!zpvs!nbtufs!' 
Cryptography ends

PlainText segment 
    db 2*17 dup (' ') 
PlainText ends 

code segment
        start:
        mov ax,Cryptography
        mov ds,ax
        mov ax,PlainText
        mov es,ax

        mov cx,2*17
        mov bx,0

    lp: mov al,ds:[bx]
        sub al,1
        mov es:[bx],al
        inc bx
        loop lp

        mov ax,0b800h
        mov es,ax
        mov di,160*12+2*20
        mov ax,PlainText
        mov ds,ax

        mov cx,2*17
        mov bx,0

lp1:    mov al,ds:[bx]
        mov es:[di],al
        mov byte ptr es:[di+1],01110001b
        inc bx
        inc di
        inc di

        loop lp1

    mov ax,4c00h
    int 21h

code ends
end start