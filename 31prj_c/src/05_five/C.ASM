	ifndef	??version
?debug	macro
	endm
	endif
	?debug	S "\src\five\c.c"
_TEXT	segment	byte public 'CODE'
DGROUP	group	_DATA,_BSS
	assume	cs:_TEXT,ds:DGROUP,ss:DGROUP
_TEXT	ends
_DATA	segment word public 'DATA'
d@	label	byte
d@w	label	word
_DATA	ends
_BSS	segment word public 'BSS'
b@	label	byte
b@w	label	word
	?debug	C E92E523D510D5C7372635C666976655C632E63
_BSS	ends
_DATA	segment word public 'DATA'
_str	label	byte
	db	104
	db	101
	db	108
	db	108
	db	111
	db	32
	db	119
	db	111
	db	114
	db	108
	db	100
	db	33
	db	8 dup (0)
_a	label	word
	dw	11
	dw	22
	dw	33
	dw	44
	dw	55
	dw	66
	dw	77
	dw	88
_DATA	ends
_TEXT	segment	byte public 'CODE'
;	?debug	L 7
_main	proc	near
;	?debug	L 8
	mov	word ptr DGROUP:_pf+2,0
	mov	word ptr DGROUP:_pf,512
;	?debug	L 9
	mov	word ptr DGROUP:_n,0
	jmp	short @5
@4:
;	?debug	L 10
	mov	bx,word ptr DGROUP:_n
	mov	al,byte ptr DGROUP:_str[bx]
	les	bx,dword ptr DGROUP:_pf
	add	bx,word ptr DGROUP:_n
	mov	byte ptr es:[bx],al
@3:
	inc	word ptr DGROUP:_n
@5:
	mov	bx,word ptr DGROUP:_n
	cmp	byte ptr DGROUP:_str[bx],0
	jne	@4
@2:
;	?debug	L 12
	mov	word ptr DGROUP:_p,offset DGROUP:_str
;	?debug	L 13
	mov	word ptr DGROUP:_pf+2,0
	mov	word ptr DGROUP:_pf,528
;	?debug	L 14
	mov	word ptr DGROUP:_n,0
	jmp	short @9
@8:
;	?debug	L 15
	mov	bx,word ptr DGROUP:_n
	mov	al,byte ptr DGROUP:_str[bx]
	les	bx,dword ptr DGROUP:_pf
	add	bx,word ptr DGROUP:_n
	mov	byte ptr es:[bx],al
@7:
	inc	word ptr DGROUP:_n
@9:
	mov	bx,word ptr DGROUP:_p
	add	bx,word ptr DGROUP:_n
	cmp	byte ptr [bx],0
	jne	@8
@6:
;	?debug	L 17
	mov	word ptr DGROUP:_n,0
	jmp	short @13
@12:
;	?debug	L 18
	mov	bx,word ptr DGROUP:_n
	shl	bx,1
	mov	ax,word ptr DGROUP:_a[bx]
	mov	dx,word ptr DGROUP:_n
	shl	dx,1
	xor	bx,bx
	mov	es,bx
	mov	bx,544
	add	bx,dx
	mov	word ptr es:[bx],ax
@11:
	inc	word ptr DGROUP:_n
@13:
	cmp	word ptr DGROUP:_n,8
	jl	@12
@10:
;	?debug	L 19
	mov	word ptr DGROUP:_n,0
	jmp	short @17
@16:
;	?debug	L 20
	mov	bx,word ptr DGROUP:_n
	shl	bx,1
	mov	ax,word ptr DGROUP:_a[bx]
	push	ax
	mov	ax,word ptr DGROUP:_n
	shl	ax,1
	add	ax,560
	cwd	
	mov	bx,ax
	mov	es,dx
	pop	ax
	mov	word ptr es:[bx],ax
@15:
	inc	word ptr DGROUP:_n
@17:
	cmp	word ptr DGROUP:_n,8
	jl	@16
@14:
@1:
;	?debug	L 21
	ret	
_main	endp
_TEXT	ends
_BSS	segment word public 'BSS'
_n	label	word
	db	2 dup (?)
_pf	label	dword
	db	4 dup (?)
_p	label	word
	db	2 dup (?)
_BSS	ends
	?debug	C E9
_DATA	segment word public 'DATA'
s@	label	byte
_DATA	ends
_TEXT	segment	byte public 'CODE'
_TEXT	ends
	public	_main
	public	_str
	public	_p
	public	_pf
	public	_n
	public	_a
	end
