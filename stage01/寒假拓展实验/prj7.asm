; 绿  黄  紫  红  蓝  青
;010  110 101 100 001 011
; 2    6   5   4   1   3
;123456蓝绿青红紫黄
 
assume cs:code,ds:data
 
data segment
	db '.....*........*.......'	;22列
	db '....*..*.....*.*......'
	db '.....*..*....*..*.....'
	db '......*..*..*.*.*.....'
	db '.....*.........*......'
	db '...*.............*....'
	db '..*...............*...'	;中间8,上6,下20
	db '.*.................*..'
	db '*...................*.'
	db '*...................*.'
	db '*.....*.......*.....*.'
	db '*...................*.'
	db '*...@.....U.....@...*.'
	db '.*.................*..'
	db '..**.............**...'	;15行
data ends
 
code segment
start:	

	mov ax,data
	mov ds,ax
	mov ax,0b800h
	mov es,ax
	mov di,3*160+20*2
	mov bx,0
	mov ah,1

	call show

	mov ax,4c00h
	int 21h
 

show:
	


	show_bg:
	call delay

	push di
	push bx

	mov cx,15

	show_row:
		push cx
		mov cx,22
		show_cul:
			mov al,ds:[bx]
			
			mov es:[di],al
			mov es:[di+1],ah

			inc bx
			add di,2
		loop show_cul
	pop cx
	sub di,2*22
	add di,160
	loop show_row

	inc ah
	pop bx
	pop di
	jmp show_bg	





	show_end:
		ret

delay:
    push ax
    push bx
    push cx
    push dx
    push di
    push ds
    push es

	mov cx,0FH
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