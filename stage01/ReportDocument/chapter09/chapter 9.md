# chapter 9



## 实验8

**可以正常返回，因为 ==jmp short s1== 翻译为机器码后只有偏移的距离**

## 实验9

### 代码

```assembly
assume cs:code,ds:data,ss:stack

stack segment
	db 128 dup(0)
stack ends

data segment

    db 'welcome to masm!'
	db  00001010B
	db  00101100B
	db  01111001B

data ends

code segment
start:

    mov ax,data
    mov ds,ax
    mov ax,0b800h
    mov es,ax

    mov si,0
    mov bx,16
    mov di,160*10+2*30


    mov cx,3
showRow:
    push bx
	push cx
	push si
	push di

    mov cx,16
    mov ah,ds:[bx] 
show:
    mov al,ds:[si]
    
    mov es:[di],ax

    inc si
    
    add di,2

    loop show


    pop di
	pop si
	pop cx
	pop bx
    
    inc bx
    add di,160
    loop showRow

    mov ax,4c00h
    int 21h
code ends

end start
```

### 截屏

![Screenshot_20200310_101310](chapter%209.assets/Screenshot_20200310_101310.png)