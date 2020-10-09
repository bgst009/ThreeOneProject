	ifndef	??version
?debug	macro
	endm
	endif
	?debug	S "\src\three.c"
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
	?debug	C E9A56939510C5C7372635C74687265652E63
_BSS	ends
_TEXT	segment	byte public 'CODE'
;	?debug	L 10
_main	proc	near
;	?debug	L 11
	mov	word ptr DGROUP:_n,0
;	?debug	L 12
	call	near ptr _f1
;	?debug	L 13
	mov	ax,2
	push	ax
	mov	ax,1
	push	ax
	call	near ptr _f2
	pop	cx
	pop	cx
	mov	word ptr DGROUP:_n,ax
;	?debug	L 14
	call	far ptr _f3
	mov	word ptr DGROUP:_n,ax
@1:
;	?debug	L 15
	ret	
_main	endp
;	?debug	L 17
_f1	proc	near
;	?debug	L 17
	mov	word ptr DGROUP:_n,1
@2:
;	?debug	L 17
	ret	
_f1	endp
;	?debug	L 18
_f2	proc	near
	push	bp
	mov	bp,sp
	push	si
;	?debug	L 20
	mov	si,word ptr [bp+4]
	add	si,word ptr [bp+6]
;	?debug	L 21
	mov	ax,si
	jmp	short @3
@3:
;	?debug	L 22
	pop	si
	pop	bp
	ret	
_f2	endp
;	?debug	L 24
_f3	proc	far
;	?debug	L 24
	mov	ax,10
	jmp	short @4
@4:
;	?debug	L 24
	ret	
_f3	endp
_TEXT	ends
_BSS	segment word public 'BSS'
_n	label	word
	db	2 dup (?)
_BSS	ends
	?debug	C E9
_DATA	segment word public 'DATA'
s@	label	byte
_DATA	ends
_TEXT	segment	byte public 'CODE'
_TEXT	ends
	public	_main
	public	_n
	public	_f3
	public	_f2
	public	_f1
	end
