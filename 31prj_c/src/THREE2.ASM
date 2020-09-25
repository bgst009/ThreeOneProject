	ifndef	??version
?debug	macro
	endm
	endif
	?debug	S "\src\three2.c"
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
	?debug	C E9A96A39510D5C7372635C7468726565322E63
_BSS	ends
_TEXT	segment	byte public 'CODE'
;	?debug	L 2
_main	proc	near
;	?debug	L 3
	call	near ptr _f
;	?debug	L 4
	call	near ptr _f
@1:
;	?debug	L 5
	ret	
_main	endp
_TEXT	ends
_DATA	segment word public 'DATA'
	dw	0
_DATA	ends
_TEXT	segment	byte public 'CODE'
;	?debug	L 6
_f	proc	near
	push	si
;	?debug	L 7
	xor	si,si
;	?debug	L 9
	inc	si
;	?debug	L 10
	inc	word ptr DGROUP:d@
;	?debug	L 11
	push	word ptr DGROUP:d@
	push	si
	mov	ax,offset DGROUP:s@
	push	ax
	call	near ptr _printf
	add	sp,6
@2:
;	?debug	L 12
	pop	si
	ret	
_f	endp
_TEXT	ends
	?debug	C E9
_DATA	segment word public 'DATA'
s@	label	byte
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
	public	_f
	end
