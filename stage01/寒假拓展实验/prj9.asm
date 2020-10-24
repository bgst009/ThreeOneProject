assume cs:code

code segment
start:

    mov ax,0b800h
    mov es,ax
    mov di,3*160+50*2

    call show_ascci

    mov ax,4c00h
    int 21h

    show_ascci:
        push ax
        push bx
        push cx
        push dx
        push di
        push ds
        push es
        show_ascci_bg:
        
		mov ax,0000h
		mov bx,0

        mov cx,7
        s1:;show cul
        	push cx
        	mov cx,20
        s2:;show row
			mov es:[di],al
			mov byte ptr es:[di+1],2
			call delay
			add di,160
			inc al

			cmp bx,128
			je show_ascci_end
			inc bx

        loop s2

        pop cx
		sub di,160*20
		sub di,2*5
        loop s1

        show_ascci_end:
            pop es
            pop ds
            pop di
            pop dx
            pop cx
            pop bx
            pop ax
            ret

delay:
    push ax
    push bx
    push cx
    push dx
    push di
    push ds
    push es

	mov cx,06H
	mov bx,1
delay_bg:
	push cx
	mov cx,0FFFFH
	s:	
		mov ax,bx
		inc bx
		loop s
	pop cx
	mov ax,0
	mov bx,1
	loop delay_bg

delay_end:
    pop es
    pop ds
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
	ret

code ends
end start