	ifndef	??version
?debug	macro
	endm
	endif
	?debug	S "return~2.c"
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
	?debug	C E9A96AD6500A72657475726E7E322E63
_BSS	ends
_TEXT	segment	byte public 'CODE'
;	?debug	L 10
_main	proc	near
	push	bp
	mov	bp,sp
	sub	sp,28
;	?debug	L 15
	mov	word ptr [bp-28],1
;	?debug	L 16
	mov	dx,16268
	mov	ax,-13107
	mov	word ptr [bp-24],dx
	mov	word ptr [bp-26],ax
;	?debug	L 17
	mov	word ptr [bp-16],16369
	mov	word ptr [bp-18],-15729
	mov	word ptr [bp-20],23592
	mov	word ptr [bp-22],-2621
;	?debug	L 19
	lea	bx,word ptr [bp-14] ;bx=ffd0 偏移地址
	push	ss
	push	bx
	lea	bx,word ptr [bp-28]
	mov	dx,ss
	mov	ax,bx
	mov	cx,14
	call	far ptr SPUSH@
	call	near ptr _f
	add	sp,14
	push	ds
	push	ax
	mov	cx,14
	call	far ptr SCOPY@
@1:
;	?debug	L 22
	mov	sp,bp
	pop	bp
	ret	
_main	endp
_TEXT	ends
_BSS	segment word public 'BSS'
	db	14 dup (?)
_BSS	ends
_TEXT	segment	byte public 'CODE'
;	?debug	L 24
_f	proc	near
	push	bp
	mov	bp,sp
;	?debug	L 25
	inc	word ptr [bp+4]
;	?debug	L 26
	FLD	dword ptr [bp+6]
	FADD	qword ptr DGROUP:s@
	FSTP	dword ptr [bp+6]
	FWAIT	
;	?debug	L 27
	FLD	qword ptr [bp+10]
	FADD	qword ptr DGROUP:s@
	FSTP	qword ptr [bp+10]
	FWAIT	
;	?debug	L 29
	mov	bx,offset DGROUP:b@
	push	ds
	push	bx
	lea	bx,word ptr [bp+4]
	push	ss
	push	bx
	mov	cx,14
	call	far ptr SCOPY@
;	?debug	L 29
	mov	ax,offset DGROUP:b@
	jmp	short @2
@2:
;	?debug	L 30
	pop	bp
	ret	
_f	endp
_TEXT	ends
	?debug	C E9
_DATA	segment word public 'DATA'
s@	label	byte
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	240
	db	63
_DATA	ends
	extrn	FIDRQQ:far
	extrn	SCOPY@:far
	extrn	SPUSH@:far
_TEXT	segment	byte public 'CODE'
_TEXT	ends
	public	_main
	public	_f
	end
