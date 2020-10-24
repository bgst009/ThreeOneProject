;
assume cs:code
code segment
start:

    call clear_screen

    ;int 1
    mov bx,0
    mov ax,30
    sub cx,1

    mov ax,4c00h
    int 21h

;==============================
clear_screen:
    push ax
    push bx
    push cx
    push dx
    push ds
    push es
    push si
    push di
    clear_screen_bg:
			mov bx,0b800h
			mov es,bx
			
			mov bx,0
			mov dl,0
            mov dh,00000010b
			mov cx,2000

	clearScreen:	
					mov es:[bx],dx
					add bx,2
					
					loop clearScreen
	
    clear_screen_end:
        pop di
        pop si
        pop es
        pop ds
        pop dx
        pop cx
        pop bx
        pop ax
		ret
code ends
end start