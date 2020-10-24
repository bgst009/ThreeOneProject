assume cs:code

code segment
s1: db  'Good,better,best,','$'
s2: db  'Never let it rest','$'
s3: db  'Till good is better,','$'
s4: db  'And better,best.','$'
s:  dw  offset s1,offset s2,offset s3,offset s4
row:    db 2,4,6,8

start:

        call clear_screen
        call show

        mov ax,4c00h
        int 21h

show:   
    push ax
    push bx
    push cx
    push dx
    push ds
    push es
    push si
    push di
    show_bg:
        mov ax,cs
        mov ds,ax
        mov bx,offset s
        mov si,offset row
        mov cx,4
    ok: mov bh,0
        mov dh,ds:[si]
        mov dl,0
        mov ah,2
        int 10h

        mov dx,ds:[bx]  
        mov ah,9
        int 21h

        inc si
        add bx,2

        loop ok
    show_end:
        pop di
        pop si
        pop es
        pop ds
        pop dx
        pop cx
        pop bx
        pop ax
		ret

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