	ifndef	??version
?debug	macro
	endm
	endif
	?debug	S "\src\three5.c"
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
	?debug	C E9737539510D5C7372635C7468726565352E63
_BSS	ends
_TEXT	segment	byte public 'CODE'
;	?debug	L 11
_main	proc	near
	push	bp
	mov	bp,sp
	sub	sp,6
	push	si
;	?debug	L 15
	lea	bx,word ptr [bp-6]
	push	ss
	push	bx
	call	near ptr _func
	push	ds
	push	ax
	mov	cx,6
	call	far ptr SCOPY@
;	?debug	L 16
	lea	bx,word ptr [bp-6]
	mov	dx,ss
	mov	ax,bx
	mov	cx,6
	call	far ptr SPUSH@
	call	near ptr _f
	add	sp,6
	mov	si,ax
;	?debug	L 18
	push	si
	mov	ax,offset DGROUP:s@
	push	ax
	call	near ptr _printf
	pop	cx
	pop	cx
;	?debug	L 19
	call	near ptr _func
	mov	dx,ds
	mov	cx,6
	call	far ptr SPUSH@
	call	near ptr _f
	add	sp,6
	push	ax
	mov	ax,offset DGROUP:s@+4
	push	ax
	call	near ptr _printf
	pop	cx
	pop	cx
@1:
;	?debug	L 20
	pop	si
	mov	sp,bp
	pop	bp
	ret	
_main	endp
;	?debug	L 22
_f	proc	near
	push	bp
	mov	bp,sp
;	?debug	L 22
	mov	ax,word ptr [bp+4]
	add	ax,word ptr [bp+6]
	mul	word ptr [bp+8]
	jmp	short @2
@2:
;	?debug	L 22
	pop	bp
	ret	
_f	endp
_TEXT	ends
_BSS	segment word public 'BSS'
	db	6 dup (?)
_BSS	ends
_TEXT	segment	byte public 'CODE'
;	?debug	L 24
_func	proc	near
	push	bp
	mov	bp,sp
	sub	sp,6
;	?debug	L 26
	mov	word ptr [bp-6],1
;	?debug	L 27
	mov	word ptr [bp-4],2
;	?debug	L 28
	mov	word ptr [bp-2],3
;	?debug	L 29
	mov	bx,offset DGROUP:b@
	push	ds
	push	bx
	lea	bx,word ptr [bp-6]
	push	ss
	push	bx
	mov	cx,6
	call	far ptr SCOPY@
;	?debug	L 29
	mov	ax,offset DGROUP:b@
	jmp	short @3
@3:
;	?debug	L 30
	mov	sp,bp
	pop	bp
	ret	
_func	endp
_TEXT	ends
	?debug	C E9
_DATA	segment word public 'DATA'
s@	label	byte
	db	32
	db	37
	db	100
	db	0
	db	32
	db	37
	db	100
	db	0
_DATA	ends
	extrn	SPUSH@:far
	extrn	SCOPY@:far
_TEXT	segment	byte public 'CODE'
	extrn	_printf:near
_TEXT	ends
	public	_main
	public	_func
	public	_f
	end
