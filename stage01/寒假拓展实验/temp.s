assume cs:code,ds:data
data segment
;--  文字:  中  --
;--  Modern18;  此字体下对应的点阵为：宽x高=24x24   --
DB  00H,00H,00H,00H,38H,00H,00H,3CH,00H,00H,38H,00H,00H,38H,00H,10H
DB  38H,18H,3FH,0FFH,0FCH,38H,38H,38H,18H,38H,38H,18H,38H,38H,18H,38H
DB  38H,18H,38H,38H,18H,38H,38H,1FH,0FFH,0F8H,38H,38H,38H,38H,38H,38H
DB  00H,38H,00H,00H,38H,00H,00H,38H,00H,00H,38H,00H,00H,38H,00H,00H
DB  38H,00H,00H,38H,00H,00H,00H,00H
;--  文字:  华  --
;--  Modern18;  此字体下对应的点阵为：宽x高=24x24   --
DB  00H,00H,00H,03H,8EH,00H,03H,8EH,00H,07H,0CH,38H,07H,0CH,7CH,0EH
DB  0CH,0F0H,0FH,0FH,0C0H,1FH,0FH,80H,3FH,1EH,0CH,77H,7CH,0CH,07H,0CCH
DB  0EH,07H,0EH,0EH,07H,0FH,0FEH,07H,3CH,00H,06H,38H,00H,00H,38H,0CH
DB  7FH,0FFH,0FEH,20H,38H,00H,00H,38H,00H,00H,38H,00H,00H,38H,00H,00H
DB  38H,00H,00H,38H,00H,00H,00H,00H

data ends
 
;下面一部分是将16进制数据转换为二进制显示.用来比较清楚的明白点阵情况
;因为点阵的宽高比,相当于3*8个为一行,可以隐约看到	中字的尖
;00000000 00000000 00000000
;00000000 00110000 00000000
;00000000 00111100 00000000
 
code segment
start:
	mov ax,0b800h
	mov es,ax
	mov ax,data
	mov ds,ax
	mov si,0
	mov bh,100b	;黑底红字
	mov bl,03h	;心形
	mov ah,0	;用ax存点阵
	mov dh,0	;用于计数判定3字每行循环
	mov di,180	;"中"起始位置
	jmp read
 
;子程序
over:	mov ax,4c00h
	int 21h
 
;hua:
;	mov di,92
;	ret
check:	cmp si,72
	jne next2		
	mov di,136	;"华"起始位置;为什么是这个位置,而不是我算的中间偏右的位置开始才对?
  next2:cmp si,144
	je over
	cmp dh,3
	jne read
	mov dh,0
	add di,112	;换行
	jmp read
 
read:	
	mov al,ds:[si]
	inc si
	inc dh
	jmp div2
 
;show:	mov es:[di],bx
;	ret
doom:
	mov cx,8
  s1:
	pop ax
	cmp ah,1
	jne next
	mov es:[di],bx
  next:	add di,2
	loop s1
	jmp check
	
 
;16进制转化为2进制,并入栈存储
div2:	
	mov cx,8
   s0:	mov dl,2
	div dl
	mov dl,al	;商暂存于dl中
	mov al,0
	push ax		;余数入栈
	mov al,dl	;上次除法的商恢复到ax中
  loop	s0
	jmp doom
 
code ends
end start