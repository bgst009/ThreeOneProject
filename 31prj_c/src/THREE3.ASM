	ifndef	??version
?debug	macro
	endm
	endif
	?debug	S "\src\three3.c"
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
	?debug	C E9836D39510D5C7372635C7468726565332E63
_BSS	ends
_DATA	segment word public 'DATA'
_a	label	word
	dw	1
_b	label	word
	dw	2
_c	label	byte
	db	3
_a1	label	word
	dw	4
_a2	label	word
	dw	5
	dw	0
_DATA	ends
_TEXT	segment	byte public 'CODE'
;	?debug	L 7
_main	proc	near
;	?debug	L 8
	inc	word ptr DGROUP:_a
;	?debug	L 9
	inc	word ptr DGROUP:_b
;	?debug	L 10
	inc	byte ptr DGROUP:_c
;	?debug	L 11
	inc	word ptr DGROUP:_a1
;	?debug	L 12
	add	word ptr DGROUP:_a2,1
	adc	word ptr DGROUP:_a2+2,0
@1:
;	?debug	L 13
	ret	
_main	endp
_TEXT	ends
	?debug	C E9
_DATA	segment word public 'DATA'
s@	label	byte
_DATA	ends
_TEXT	segment	byte public 'CODE'
_TEXT	ends
	public	_main
	public	_c
	public	_b
	public	_a
	public	_a2
	public	_a1
	end
