assume cs:code,ds:data,ss:stack

data segment
	dw 123,12666,1,8,3,38,0
data ends

string segment
	db 10  dup (0),0	
string ends

stack segment
	db 128 dup(0)
stack ends

code segment


	start:
;
    mov ax,stack
	  mov ss,ax
	  mov sp,128

    call init_reg

    mov dh,8;row
    mov dl,3;cul
    mov cl,2;color

    a:
    mov ax,ds:[si]
    mov cx,ax
    jcxz Pro_end
    call dtoc

    inc dh
    mov dl,3;cul
    mov cl,2;color
    call show_str

    call zero

    add si,2
    jmp a

    Pro_end:
    mov ax,4c00h
    int 21h


    zero:
				push ax
				push bx
				push cx
				push dx
				push ds
				push es
				push si
				push di

        mov cx,10
        mov ax,string
        mov es,ax
        mov di,0

        lp:
        mov al,0
        mov es:[di],al
        inc di
        loop lp

    zero_ret:
				pop di
				pop si
				pop es
				pop ds
				pop dx
				pop cx
				pop bx
				pop ax
        ret

    dtoc:
				push ax
				push bx
				push cx
				push dx
				push ds
				push es
				push si
				push di

        mov si,0
        mov dx,0
    dtoc_bg:
        mov cx,10
        div cx
        add dl,30h
        mov es:[si],dl
        mov cx,ax
        jcxz dtoc_end
        inc si
        mov dx,0
        jmp dtoc_bg


    dtoc_end:
				pop di
				pop si
				pop es
				pop ds
				pop dx
				pop cx
				pop bx
				pop ax
        ret

    init_reg:
        mov ax,data
        mov ds,ax
        mov ax,string
        mov es,ax

        mov si,0

        ret


    show_str:
				push ax
				push bx
				push cx
				push dx
				push ds
				push es
				push si
				push di

        mov ax,string
        mov ds,ax
        mov si,0

        mov ax,0b800h
        mov es,ax
        mov di,0

        call get_row
        add di,ax
        add dl,10
        call get_cul
        add di,ax

        call show

				pop di
				pop si
				pop es
				pop ds
				pop dx
				pop cx
				pop bx
				pop ax
        ret

    get_row:
        mov al,160
        mul dh
        ret
    get_cul:
        mov al,2
        mul dl
        ret

    show:
				push ax
				push bx
				push cx
				push dx
				push ds
				push es
				push si
				push di

        sub ax,ax
        sub bx,bx
        

        mov bl,cl
        show_1:
            mov cl,ds:[si]
            mov al,ds:[si]
            mov ch,0
            jcxz ok
            mov ah,bl
            mov es:[di],ax
            sub di,2
            inc si
            jmp show_1


        ok:
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