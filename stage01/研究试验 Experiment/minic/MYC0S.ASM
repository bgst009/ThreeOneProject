	ifndef	??version
?debug	macro
	endm
	endif
	?debug	S "myc0s.c"
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
	?debug	C E96382D650076D796330732E63
_BSS	ends
_TEXT	segment	byte public 'CODE'
;	?debug	L 2
_f	proc	near
;	?debug	L 4
	mov	bx,-18432
	mov	es,bx
	mov	bx,1680
	mov	byte ptr es:[bx],97
;	?debug	L 5
	mov	bx,-18432
	mov	es,bx
	mov	bx,1681
	mov	byte ptr es:[bx],2
@1:
;	?debug	L 6
	ret	
_f	endp
;	?debug	L 8
_main	proc	near
	push	bp
	mov	bp,sp
	sub	sp,4
;	?debug	L 9
	mov	word ptr [bp-4],0
;	?debug	L 10
	mov	word ptr [bp-2],0
;	?debug	L 11
	call	near ptr _f
@2:
;	?debug	L 12
	mov	sp,bp
	pop	bp
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
	public	_f
	end
