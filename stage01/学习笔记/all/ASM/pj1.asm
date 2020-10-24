assume cs:code,ds:data,ss:stack

data segment
		;0,0
		db	'1975','1976','1977','1978','1979','1980','1981','1982','1983'
		db	'1984','1985','1986','1987','1988','1989','1990','1991','1992'
		db	'1993','1994','1995'
		;以上是表示21年的21个字符串 year

		;84,54h
		dd	16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
		dd	345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
		;以上是表示21年公司总收入的21个dword数据	sum

		;168,a8
		dw	3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
		dw	11542,14430,15257,17800
data ends



stack segment
	db 128 dup(0)
stack ends


table segment	;0123456789ABCDEF
	db	21 dup ('year summ ne ?? ')
table ends

string segment
	db	10 dup (' ')
string ends


code segment


	start:  mov ax,stack;stack
			mov ss,ax
			mov sp,128
			
			call clear_screen;清空屏幕
			
			call init_reg;初始化寄存器组，把数据导入
			
			call show;把内容打印到屏幕上
			
			
			mov ax,4C00H
			int 21H


;================================把内容打印到屏幕上
	show:		call init_show_reg_A;初始化寄存器组
				call print_year;打印年
				
				call init_show_reg_I
				call print_income;打印收入,打印一行，循环21次
				
				
				
					mov cx,20
					mov si,0
		setnull:	mov ax,string
					mov es,ax
					mov ax,0000
					mov es:[si],ax
					inc si
					loop setnull
					
				call init_show_reg_I
				call print_client
				
				
						mov cx,20
					mov si,0
		setnull_1:	mov ax,string
					mov es,ax
					mov ax,0000
					mov es:[si],ax
					inc si
					loop setnull_1
					
				call init_show_reg_I
				call print_avg
				
				
				
				ret
				
;=================================
print_avg:		mov ax,data
				mov ds,ax
				
				mov ax,table
				mov es,ax
				
				
				sub si,si
				
				sub di,di
				
				mov bx,54h
				mov di,0a8h
				
				
				
				mov cx,21
				
	movToTable: 	
				;被除数
				mov ax,ds:[bx+0];低位
				mov dx,ds:[bx+2];高位
		
				push ax
				mov bp,sp
				
				call divdw
				add bx,4
				add di,2
				add si,4
				loop movToTable	
			
				
				mov si,0
				mov di,160 *3 + 30 * 3;屏幕输出位置
			
				
				mov cx,21
	showAvg:	call PrintNum_Avg
				add si,4
				add di,160
				loop showAvg
				ret
;=================================
	PrintNum_Avg:	push ax
					push bx
					push cx
					push dx
					push ds
					push es
				;	push si
					push di
					push bp
					
					
					
					mov bp,10;打印列数
					
					mov ax,table
					mov ds,ax
					mov ax,string
					mov es,ax
					
					call shortdiv
					call showstring
					
	PrintNumAvgRet:
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
					
;=================================
divdw:				push ax
					push bx
					push cx
					push dx
					push ds
					push es
					push si
					push di
					push bp
				
				mov cx,ds:[di];除数
				
				mov ax,dx
				mov dx,0
				
				div cx
				
				push ax
				
				mov ax,ss:[bp+0]
				
				div cx
				mov cx,dx
				pop dx
				
			

	call movToTable_1
	
	
					pop bp
					pop di
					pop si
					pop es
					pop ds
					pop dx
					pop cx
					pop bx
					pop ax
					
			ret
;================================
movToTable_1:		push ax
					push bx
					push cx
					push dx
					push ds
					push es
					push si
					push di
					push bp
					
				;;	mov cx,table
				;;	mov es,cx
					
					
					mov es:[si+0],ax
					mov es:[si+2],dx
					
					pop bp
					pop di
					pop si
					pop es
					pop ds
					pop dx
					pop cx
					pop bx
					pop ax
				
				ret
;=================================
print_client: 		mov si,0a8h
					
					mov di,160 *3 + 30 * 2;屏幕输出位置
					mov cx,21
					
		printC:		call PrintNum
					add si,2
					add di,160
					loop printC
	
	PrintClient:	ret  		
;=================================
	
;=================================
	print_income:	
					
					mov si,54h
					
					mov di,160 *3 + 30 * 1;屏幕输出位置
					mov cx,21
					
		printI:		call PrintNum
					add si,4
				;	add si,2
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
					
					
					
					mov bp,10;打印列数
					
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
					
					mov cx,11
					

		S_s:		mov ax,ds:[si]
					mov ah,00000100b
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
;================================
	print_year:	push ax
				push bx
				push cx
				push dx
				push ds
				push es
				push si
				push di
				
				
				mov di,160*3+10*1;屏幕输出位置
				mov cx,21;打印行数
	printY:		push cx

				mov cx,4;打印列数
	PrintYear:	push cx
	
				mov cx,0
				mov cl,ds:[si]
				jcxz PrintYearRet
				mov dl,cl
				mov dh,00000100b;设置字体颜色
				mov es:[di],dx
					
				add di,2
				inc si
				
				pop cx
				loop PrintYear
				add di,160-8
				
				pop cx
				loop printY
				
	PrintYearRet:	pop di
					pop si
					pop es
					pop ds
					pop dx
					pop cx
					pop bx
					pop ax
				
					ret

;================================初始化寄存器组
init_show_reg_A:	mov ax,0b800h
					mov es,ax
					
					ret
;==============================初始化寄存器组，把数据导入
init_reg:	mov bx,data;data in
				mov ds,bx
				mov bx,table;data out
				mov es,bx
			ret

;===================================清空屏幕
	clear_screen:	mov bx,0b800h
					mov es,bx
					
					mov bx,0
					mov dx,0700h
					mov cx,2000
					
	clearScreen:	mov es:[bx],dx
					add bx,2
					
					loop clearScreen
					
					ret
code ends

end start