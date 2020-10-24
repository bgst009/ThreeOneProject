assume cs:code,ds:data,ss:stack

data segment

		db	'1975','1976','1977','1978','1979','1980','1981','1982','1983'
		db	'1984','1985','1986','1987','1988','1989','1990','1991','1992'
		db	'1993','1994','1995'
		;以上是表示21年的21个字符串 year

		;54h
		dd	16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
		dd	345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
		;以上是表示21年公司总收入的21个dword数据	sum

		;a8
		dw	3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
		dw	11542,14430,15257,17800

data ends

table segment
				;0123456789ABCDEF
	db	21 dup ('year summ ne ?? ')
table ends

stack segment stack
	db	128 dup (0)
stack ends


code segment

start:
		;data
		mov ax,data
		mov ds,ax
		;table
		mov ax,table
		mov es,ax

        mov ax,stack
        mov ss,ax
        mov sp,128
        
        mov si,0
        mov di,0
        
        mov bp,0
        mov bx,0

        mov cx,21

lp:

        mov ax,ds:[0+bp+0]
        mov es:[di+0],ax
        mov ax,ds:[0+bp+2]
        mov es:[di+2],ax

        mov ax,ds:[84+bp+0]
        mov es:[di+5],ax
        mov dx,ds:[84+bp+2]
        mov es:[di+7],dx

        div word ptr ds:[0a8h+si]
        mov es:[di+0Dh],ax

        mov ax,ds:[0a8h+si]
        mov es:[di+0ah],ax

        add di,10h
        add si,2
        add bp,4

        loop lp




        ;dh dl
        mov dh,2
        mov dl,30
        mov cx,21

        mov ax,table
        mov ds,ax


lpr:    push cx
        mov ax,0b800h
        mov es,ax

        mov cx,0
        mov bp,0
        mov cl,dh
lpdh:   add bp,160
        loop lpdh

        push bp

        mov bp,0
        mov cl,dl
lpdl:   add bp,2
        loop lpdl

        pop ax
        add bp,ax

        mov cx,4
        mov si,0
lp1:
        mov al,ds:[bx+si]
        mov ah,2

        push si
        add si,si
        mov es:[bp+si],ax
        pop si
        inc si

        loop lp1

        add bx,16
        inc dh
        pop cx
        loop lpr

		mov ax,4c00h
		int 21h


code ends
end start