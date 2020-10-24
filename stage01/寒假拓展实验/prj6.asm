assume cs:code,ds:data,ss:stack
data segment
;--  文字:  中  --
;--  Modern18;  此字体下对应的点阵为：宽x高=24x24   --
DB  00H,00H,00H
DB  00H,38H,00H
DB  00H,3CH,00H
DB  00H,38H,00H
DB  00H,38H,00H
DB  10H,38H,18H
DB  3FH,0FFH,0FCH
DB  38H,38H,38H
DB  18H,38H,38H
DB  18H,38H,38H
DB  18H,38H,38H
DB  18H,38H,38H
DB  18H,38H,38H
DB  1FH,0FFH,0F8H
DB  38H,38H,38H
DB  38H,38H,38H
DB  00H,38H,00H
DB  00H,38H,00H
DB  00H,38H,00H
DB  00H,38H,00H
DB  00H,38H,00H
DB  00H,38H,00H
DB  00H,38H,00H
DB  00H,00H,00H
;--  文字:  华  --
;--  Modern18;  此字体下对应的点阵为：宽x高=24x24   --
DB  00H,00H,00H
DB  03H,8EH,00H
DB  03H,8EH,00H
DB  07H,0CH,38H
DB  07H,0CH,7CH
DB  0EH,0CH,0F0H
DB  0FH,0FH,0C0H
DB  1FH,0FH,80H
DB  3FH,1EH,0CH
DB  77H,7CH,0CH
DB  07H,0CCH,0EH
DB  07H,0EH,0EH
DB  07H,0FH,0FEH
DB  07H,3CH,00H
DB  06H,38H,00H
DB  00H,38H,0CH
DB  7FH,0FFH,0FEH
DB  20H,38H,00H
DB  00H,38H,00H
DB  00H,38H,00H
DB  00H,38H,00H
DB  00H,38H,00H
DB  00H,38H,00H
DB  00H,00H,00H

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
	mov ax,0b800h
	mov es,ax
	mov di,160*0+2*10

	mov bx,0
	mov si,0

	call show
	mov di,160*0+8*10
	call show

	mov ax,4c00h
	int 21h
 
 ;========================
	show:
		show_bg:
			mov cx,24
			show_line_lp:
				call show_line
				sub di,2*24
				add di,160
			loop show_line_lp

		show_end:
			ret

	;====================
	show_line:
		push cx
		show_line_bg:
			mov cx,3
			mov ax,0
			show_8_bit_lp:
			;	call get_bit
				call show_8_bit
			loop show_8_bit_lp
		show_line_end:
			pop cx
			ret
	
	;====================
	; get_bit:
	; 	push ax
	; 	push cx
	; 	push dx

	; 	mov cx,8
	; 	mov ax,0
	; 	get_bit_bg:
	; 		mov al,ds:[si]
	; 		inc si
	; 		lp1:
	; 		mov dx,0
	; 		mov dl,2
	; 		div dl
	; 		mov al,dl
	; 		mov al,0
	; 		push ax
	; 		mov al,dl
	; 		loop lp1

	; 	get_bit_end:
	; 		pop dx
	; 		pop cx
	; 		pop ax
	; 		ret

	;====================
	show_8_bit:
		push cx
		mov ax,0
		mov cx,8
		mov dx,0
		show_8_bit_bg:

			mov al,ds:[si]
			inc si
			lp1:
			mov dl,2
			div dl
			mov dl,al
			mov al,0
			push ax
			mov al,dl
			loop lp1

			mov cx,8
			lp0:
			pop ax
			cmp ah,1
			jne next
			mov ah,03h
			mov es:[di],ah
			mov byte ptr es:[di+1],100b
			next:
			add di,2
			loop lp0

		show_8_bit_end:
			pop cx
			ret
	; show_8_bit:
	; 	push cx
	; 	mov ax,0
	; show_8_bit_bg:
	; 	mov cx,8
	; 	lp0:
	; 	mov al,33h
	; 	mov es:[di],al
	; 	mov byte ptr es:[di+1],71h
	; 	add di,2
	; 	loop lp0
	; show_8_bit_end:
	; 	pop cx
	; 	ret
 
code ends
end start