assume cs:code,ds:data,ss:stack


data segment
	dd  1000000
data ends


stack segment
	db 128 dup(0)
stack ends

code segment

	start:  mov ax,stack;stack
			mov ss,ax
			mov sp,128
			
			mov ax,data
			mov ds,ax
			
			mov ax,0
			mov bx,0
			
			mov ax,ds:[bx+0]
			mov dx,ds:[bx+2]
			
			mov cx,10
			push ax
			mov bp,sp
			
			call divdw
			
			
	
	
	mov ax,4C00H
	int 21H
	
divdw:	mov ax,dx
		mov dx,0
		
		div cx
		
		push ax
		
		mov ax,ss:[bp+0]
		
		div cx
		mov cx,dx
		pop dx
		
		

	
		ret
	
	
	
code ends
end start
