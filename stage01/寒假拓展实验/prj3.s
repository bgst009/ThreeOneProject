assume cs:code,ds:Calculate

Calculate segment
       ;0123456789abcdef
    db '1. 3/1=         '
    db '2. 5+3=         '
    db '3. 9-3=         '
    db '4. 4+5=         '
Calculate ends

code segment
start:
        call initReg
        call CalculateTheAnswer
        call showCalculateSegment
        
        mov ax,4c00h
        int 21h
;=======================================
initReg:
        mov ax,Calculate
        mov ds,ax
        ret
;=======================================
CalculateTheAnswer:

		push ax
		push bx
		push cx
		push dx
		push si
		push di
		push dx
		push ds


        mov cx,4
        mov bx,0
lp:     push cx
        mov al,ds:[bx+4]

        ;根据运算符来选择
        mov cl,al
        sub cl,'+'
        jcxz plus
		mov cl,al
		sub cl,'-'
		jcxz subtract
		mov cl,al
		sub cl,'/'
		jcxz divdide
		jmp ended

plus:		mov ax,0
			mov al,ds:[bx+3]
			sub al,30h
			mov ah,ds:[bx+5]
			sub ah,30h
			add al,ah

			add al,30h
			mov ds:[bx+9],al
			jmp ended

subtract:	mov ax,0

			mov al,ds:[bx+3]
			sub al,30h
			mov ah,ds:[bx+5]
			sub ah,30h

			sub al,ah
			add al,30h

			mov ds:[bx+9],al
			jmp ended

divdide:	mov ax,0

			mov al,ds:[bx+3]
			sub al,30h
			mov dl,ds:[bx+5]
			sub dl,30h

			div dl

			add al,30h

			mov ds:[bx+9],al
			jmp ended


ended:	
        pop cx
        add bx,16
        loop lp

		pop ds
		pop dx
		pop di
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		ret
;=======================================
showCalculateSegment:

        push ax
        push es
        push ds
        push si
        push di
        push cx

        ;out
        mov ax,0b800h
        mov es,ax
        
        ;in
        mov ax,Calculate
        mov ds,ax

        ;show row
        mov cx,4
        mov bx,0
        mov si,0
        mov di,160*8+2*30

        ;show cul
 lpr:    
        push cx
        mov cx,16
        mov bx,0
 lpc:    mov al,ds:[si+bx]
        mov ah,01110001b
        push bx
        add bx,bx
        mov es:[di+bx],ax
        pop bx

        inc bx
        loop lpc

        add si,16
        add di,160
        pop cx
        loop lpr


        pop cx
        pop di
        pop si
        pop ds
        pop es
        pop ax

        ret



code ends
end start