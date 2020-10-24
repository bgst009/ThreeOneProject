	ifndef	??version
?debug	macro
	endm
	endif
	?debug	S "a.c"
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
	?debug	C E90F87D55003612E63
_BSS	ends
_TEXT	segment	byte public 'CODE'
;	?debug	L 3
_main	proc	near
;	?debug	L 5
	mov	ax,2
	push	ax
	mov	al,97
	push	ax
	call	near ptr _showchar
	pop	cx
	pop	cx
@1:
;	?debug	L 6
	ret	
_main	endp
;	?debug	L 8
_showchar	proc	near
	push	bp
	mov	bp,sp
;	?debug	L 10
	mov	al,byte ptr [bp+4]
	mov	bx,-18432
	mov	es,bx
	mov	bx,1680
	mov	byte ptr es:[bx],al
;	?debug	L 11
	mov	al,byte ptr [bp+4]
	mov	bx,-18432
	mov	es,bx
	mov	bx,1681
	mov	byte ptr es:[bx],al
@2:
;	?debug	L 12
	pop	bp
	ret	
_showchar	endp
_TEXT	ends
	?debug	C E9
_DATA	segment word public 'DATA'
s@	label	byte
_DATA	ends
_TEXT	segment	byte public 'CODE'
_TEXT	ends
	public	_showchar
	public	_main
	end
