	ifndef	??version
?debug	macro
	endm
	endif
	?debug	S "\src\three4.c"
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
	?debug	C E9127239510D5C7372635C7468726565342E63
_BSS	ends
_TEXT	segment	byte public 'CODE'
;	?debug	L 18
_main	proc	near
	push	bp
	mov	bp,sp
	sub	sp,6
;	?debug	L 22
	mov	word ptr DGROUP:_a,1
;	?debug	L 23
	mov	byte ptr DGROUP:_a+2,80
;	?debug	L 24
	mov	byte ptr DGROUP:_a+3,82
;	?debug	L 25
	mov	byte ptr DGROUP:_a+4,88
;	?debug	L 27
	mov	word ptr [bp-6],2
;	?debug	L 28
	mov	byte ptr [bp-4],90
;	?debug	L 29
	mov	byte ptr [bp-3],92
;	?debug	L 30
	mov	byte ptr [bp-2],98
;	?debug	L 32
	mov	ax,offset DGROUP:s@
	push	ax
	call	near ptr _printf
	pop	cx
;	?debug	L 33
	mov	ax,offset DGROUP:s@+19
	push	ax
	call	near ptr _printf
	pop	cx
;	?debug	L 35
	mov	al,byte ptr DGROUP:_a+4
	cbw	
	push	ax
	mov	al,byte ptr DGROUP:_a+3
	cbw	
	push	ax
	mov	al,byte ptr DGROUP:_a+2
	cbw	
	push	ax
	push	word ptr DGROUP:_a
	mov	ax,offset DGROUP:s@+38
	push	ax
	call	near ptr _printf
	add	sp,10
;	?debug	L 36
	mov	al,byte ptr [bp-2]
	cbw	
	push	ax
	mov	al,byte ptr [bp-3]
	cbw	
	push	ax
	mov	al,byte ptr [bp-4]
	cbw	
	push	ax
	push	word ptr [bp-6]
	mov	ax,offset DGROUP:s@+57
	push	ax
	call	near ptr _printf
	add	sp,10
@1:
;	?debug	L 37
	mov	sp,bp
	pop	bp
	ret	
_main	endp
_TEXT	ends
_BSS	segment word public 'BSS'
_a	label	word
	db	5 dup (?)
_BSS	ends
	?debug	C E9
_DATA	segment word public 'DATA'
s@	label	byte
	db	110
	db	117
	db	109
	db	98
	db	101
	db	114
	db	32
	db	99
	db	32
	db	32
	db	111
	db	115
	db	32
	db	109
	db	97
	db	115
	db	109
	db	10
	db	0
	db	45
	db	45
	db	45
	db	45
	db	45
	db	45
	db	45
	db	45
	db	45
	db	45
	db	45
	db	45
	db	45
	db	45
	db	45
	db	45
	db	45
	db	10
	db	0
	db	37
	db	100
	db	32
	db	32
	db	32
	db	32
	db	32
	db	37
	db	100
	db	32
	db	32
	db	37
	db	100
	db	32
	db	32
	db	37
	db	100
	db	10
	db	0
	db	37
	db	100
	db	32
	db	32
	db	32
	db	32
	db	32
	db	37
	db	100
	db	32
	db	32
	db	37
	db	100
	db	32
	db	32
	db	37
	db	100
	db	10
	db	0
_DATA	ends
_TEXT	segment	byte public 'CODE'
	extrn	_printf:near
_TEXT	ends
	public	_main
	public	_a
	end
