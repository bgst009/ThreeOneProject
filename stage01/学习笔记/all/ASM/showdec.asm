;=================================
	print_client:	
					
					mov si,0a8h
					
					mov di,160 *3 + 30 * 1;屏幕输出位置
					mov cx,21
					
		printI:		call PrintNum
		
					add si,4
					add di,160
					loop printI
	
	PrintIncome:	ret 
					
;[==============================]
	PrintNum:		push ax
					push bx
					push cx
					push dx
					push ds
					push es
				;	push si
					push di
					push bp
					
					
					
					mov bp,0Fh
					mov ax,data
					mov ds,ax
					mov ax,string
					mov es,ax
					
					call shortdiv
					call showstring
					
	PrintNumRet:
					pop bp
					pop di
				;	pop si
					pop es
					pop ds
					pop dx
					pop cx
					pop bx
					pop ax
					
					ret
					
	;===============================
	shortdiv:		push ax
					push bx
					push cx
					push dx
					push ds
					push es
				;	push si
					push di
					push bp
					
					mov ax,ds:[si];取数
		SD:			mov cx,10
					mov dx,0
					
					div cx
					add dl,30H
					
					mov es:[bp],dl
					
					mov cx,ax
					jcxz shortdivRet
					
					dec bp
					mov dx,0
					
					jmp SD
					

					
					
	shortdivRet:	pop bp
					pop di
				;	pop si
					pop es
					pop ds
					pop dx
					pop cx
					pop bx
					pop ax
					ret
	;============================
	showstring:		push ax
					push bx
					push cx
					push dx
					push ds
					push es
					push si
				;	push di
					
					mov si,0
					call init_show_reg_I
					
					mov cx,16
					

		S_s:		mov ax,ds:[si]
					mov ah,01101010B
					mov es:[di],ax
					inc si
					add di,2
					
					loop S_s
					
	showstringRet:	;pop di
					pop si
					pop es
					pop ds
					pop dx
					pop cx
					pop bx
					pop ax
					ret
		;========================
		init_show_reg_I:	mov bx,string;show_data in
							mov ds,bx
							
							mov bx,0b800h;show_data out
							mov es,bx
							
							ret