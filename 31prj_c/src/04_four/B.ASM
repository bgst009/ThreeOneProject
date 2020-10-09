	ifndef	??version
?debug	macro
	endm
	endif
	?debug	S "\src\four\b.c"
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
	?debug	C E975613A510D5C7372635C666F75725C622E63
_BSS	ends
_TEXT	segment	byte public 'CODE'
;	?debug	L 5
_main	proc	near
;	?debug	L 6
	mov	ax,2
	push	ax
	mov	ax,1
	push	ax
	call	near ptr _f1
	pop	cx
	pop	cx
	mov	word ptr DGROUP:_a,ax
;	?debug	L 7
	mov	ax,10
	push	ax
	mov	ax,20
	push	ax
	call	near ptr _f2
	pop	cx
	pop	cx
	mov	word ptr DGROUP:_b,ax
;	?debug	L 8
	push	word ptr DGROUP:_b
	push	word ptr DGROUP:_a
	call	near ptr _func
	pop	cx
	pop	cx
	mov	word ptr DGROUP:_a,ax
;	?debug	L 9
	push	word ptr DGROUP:_a
	mov	ax,offset DGROUP:s@
	push	ax
	call	near ptr _printf
	pop	cx
	pop	cx
@1:
;	?debug	L 10
	ret	
_main	endp
;	?debug	L 12
_func	proc	near
	push	bp
	mov	bp,sp
;	?debug	L 12
	mov	ax,word ptr [bp+4]
	mul	word ptr [bp+6]
	jmp	short @2
@2:
;	?debug	L 12
	pop	bp
	ret	
_func	endp
_TEXT	ends
_BSS	segment word public 'BSS'
_a	label	word
	db	2 dup (?)
_b	label	word
	db	2 dup (?)
_BSS	ends
	?debug	C E9
_DATA	segment word public 'DATA'
s@	label	byte
	db	37
	db	100
	db	10
	db	0
_DATA	ends
_TEXT	segment	byte public 'CODE'
	extrn	_printf:near
	extrn	_f2:near
	extrn	_f1:near
_TEXT	ends
	public	_main
	public	_func
	public	_b
	public	_a
	end
