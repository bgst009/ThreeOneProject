	ifndef	??version
?debug	macro
	endm
	endif
	?debug	S "ur2.c"
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
	?debug	C E9E0A2C650057572322E63
_BSS	ends
_TEXT	segment	byte public 'CODE'
;	?debug	L 4
_main	proc	near
;	?debug	L 6
	mov	ax,1
;	?debug	L 7
	mov	bx,1
;	?debug	L 8
	mov	cx,2
;	?debug	L 9
	call	near ptr _f
@1:
;	?debug	L 10
	ret	
_main	endp
;	?debug	L 12
_f	proc	near
;	?debug	L 14
	mov	ax,bx
	add	ax,cx
@2:
;	?debug	L 15
	ret	
_f	endp
_TEXT	ends
	?debug	C E9
_DATA	segment word public 'DATA'
s@	label	byte
_DATA	ends
_TEXT	segment	byte public 'CODE'
_TEXT	ends
	public	_main
	public	_f
	end
