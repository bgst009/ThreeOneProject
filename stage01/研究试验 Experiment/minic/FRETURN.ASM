	ifndef	??version
?debug	macro
	endm
	endif
	?debug	S "freturn.c"
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
	?debug	C E98E7BD650096672657475726E2E63
_BSS	ends
_TEXT	segment	byte public 'CODE'
;	?debug	L 9
_main	proc	near
	push	bp
	mov	bp,sp
	sub	sp,12
;	?debug	L 12
	mov	dx,16396
	mov	ax,-13107
	mov	word ptr [bp-10],dx
	mov	word ptr [bp-12],ax
;	?debug	L 12
	mov	dx,16268
	mov	ax,-13107
	mov	word ptr [bp-6],dx
	mov	word ptr [bp-8],ax
;	?debug	L 12
	mov	dx,16268
	mov	ax,-13107
	mov	word ptr [bp-2],dx
	mov	word ptr [bp-4],ax
;	?debug	L 29
	mov	dx,word ptr [bp-2]
	mov	ax,word ptr [bp-4]
	push	dx
	push	ax
	mov	dx,word ptr [bp-6]
	mov	ax,word ptr [bp-8]
	push	dx
	push	ax
	call	near ptr _f
	add	sp,8
	FSTP	dword ptr [bp-12]
	FWAIT	
@1:
;	?debug	L 44
	mov	sp,bp
	pop	bp
	ret	
_main	endp
;	?debug	L 52
_f	proc	near
	push	bp
	mov	bp,sp
	sub	sp,4
;	?debug	L 54
	FLD	dword ptr [bp+4]
	FLD	dword ptr [bp+8]
	FADD	
	FSTP	dword ptr [bp-4]
	FWAIT	
;	?debug	L 62
	FLD	dword ptr [bp-4]
	jmp	short @2
@2:
;	?debug	L 71
	mov	sp,bp
	pop	bp
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