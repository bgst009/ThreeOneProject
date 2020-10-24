
; 绿  黄  紫  红  蓝  青
;010  110 101 100 001 011
; 2    6   5   4   1   3
;123456蓝绿青红紫黄


assume cs:code,ds:data

data segment
	db '--------------------'	;20列
data ends

code segment
start:
    mov ax,data
    mov ds,ax
    mov ax,0b800h
    mov es,ax
    mov di,23*160+0*2

    call show

    mov ax,4c00h
    int 21h

    show:
        push ax
        push bx
        push cx
        push dx
        push di
        push ds
        push es


        show_bg:

        call show_row

		mov cx,60
		ssp:
        call show_face
		loop ssp

        show_end:
            pop es
            pop ds
            pop di
            pop dx
            pop cx
            pop bx
            pop ax
            ret

    show_row:
        push ax
        push bx
        push cx
        push dx
        push di
        push ds
        push es

		mov  cx,3
    show_row_bg:
		s0:;show three row
		push cx
		mov cx,20
		mov bx,0
		s1:;show one row
			mov al,ds:[bx]
			mov es:[di],al
			mov byte ptr es:[di+1],2
			inc bx
			add di,2
			loop s1
		pop cx
		sub di,160*4
		loop s0
    show_row_end:
            pop es
            pop ds
            pop di
            pop dx
            pop cx
            pop bx
            pop ax
            ret

    show_face:
        push ax
        push bx
        push cx
        push dx
        push di
        push ds
        push es

		sub di,160
		mov cx,3
    show_face_bg:
		s4:;show face each line
		push cx

		mov cx,20
		s3:;show face
		mov byte ptr es:[di],1
		mov byte ptr es:[di+1],2
		call delay
		mov byte ptr es:[di],0
		mov byte ptr es:[di+1],2
		
		add di,2
		loop s3
		pop cx
		sub di,160*4
		loop s4
    show_face_end:
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