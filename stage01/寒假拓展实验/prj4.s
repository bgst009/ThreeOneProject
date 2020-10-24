assume cs:code,ss:stack,ds:data

data segment
	dw 5,4,0,10
data ends

stack segment
	 dw 128 dup(0)
stack ends

code segment
start:
	
	;初始化寄存器值
	call initReg
	;使用add计算乘方
	;call CalculatePowerOfNum
	;使用mul计算乘方
	call mulCalculatePowerOfNum
	;打印结果
	call print
		mov ax,4c00h
		int 21h

;===========================
mulCalculatePowerOfNum:

	mov cx,ds:[2]
	mov dx,ds:[0]
	mov ax,1
lpmul:
		mul dx
		mov dx,ds:[0]
		loop lpmul
		mov ds:[4],ax

		ret


;==========================
print:
		mov ax,0b800h
		mov es,ax
		mov di,160*10+2*25
		mov cx,0

		call print_radix
		call print_symble01
		call print_power
		call print_symble02
		call print_answer

ret

print_radix:
		push cx
		push di
		push es
		add di,2*5
		mov ax,ds:[0];被除数

	ra:
		mov cl,ds:[6];除数
		div cl

		add ah,30h;余数


		mov es:[di],ah
		mov byte ptr es:[di+1],71h

		mov cl,al;商
		jcxz print_radix_end

		sub di,2
		mov ah,0
		jmp ra

	print_radix_end:	
		pop es
		pop di
		pop cx
		add di,160
		ret
;=======================

print_power:
		push cx
		push di
		push es

		add di,2*5
		mov ax,ds:[2];被除数

	pa:
		mov cl,ds:[6];除数
		div cl

		add ah,30h;余数

		mov es:[di],ah
		mov byte ptr es:[di+1],71h

		mov cl,al;商
		jcxz print_power_end

		sub di,2
		mov ah,0
		jmp pa

	print_power_end:	
		pop es
		pop di
		pop cx
		add di,160
		ret
;====================

print_answer:
		push cx
		push di
		push es

		add di,2*5
		mov ax,ds:[4];被除数

	aa:
		mov cl,ds:[6];除数
		div cl

		add ah,30h;余数

		mov es:[di],ah
		mov byte ptr es:[di+1],71h

		mov cl,al;商
		jcxz print_answer_end

		sub di,2
		mov ah,0
		jmp pa

	print_answer_end:	
		pop es
		pop di
		pop cx
		ret
;====================
print_symble01:

	push di

	add di,2*5

	mov byte ptr es:[di],'^'
	mov byte ptr es:[di+1],71h

	print_symble01_end:
		pop di
		add di,160
		ret

print_symble02:

	push di
	push cx
	mov cx,6

	add di,2*5
 lps: 
	mov byte ptr es:[di],'_'
	mov byte ptr es:[di+1],71h
	sub di,2
	loop lps

	

	print_symble02_end:
		pop cx
		pop di
		add di,160
		ret


;==========================
CalculatePowerOfNum:


	mov bx,0
	mov ax,ds:[bx+0];底
	mov cx,ds:[bx+2];幂
    mov bx,ax;底

    mov ax,1;幂==0
lp: 
    push cx
    mov cx,bx
    mov dx,ax;存结果
    mov ax,0

lp1:
    add ax,dx
    loop lp1

    pop cx
    loop lp

    mov dx,ax

    mov bx,0
    mov ds:[bx+4],dx
	ret

;==========================
initReg:

	mov ax,data
	mov ds,ax
	mov ax,stack
	mov ss,ax
	mov sp,128

	ret

code ends
end start