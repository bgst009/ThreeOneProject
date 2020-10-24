assume cs:code

datasg segment
    db "Beginner's All-purpouse Symbolic Instructionn Code.",0
datasg ends

code segment

    begin:  mov ax,datasg
            mov ds,ax
            mov si,0
            call letterc

            mov ax,4c00h
            int 21h
    
    letterc:    mov al,ds:[si]
                mov cx,ds:[si]
                
                cmp al,97h
                jna ignore
                cmp al,122
                jnb ignore

                and al,1101111b
                mov ds:[si],al

     ignore:    inc si
                jcxz letterc

                ret   

code ends

end begin