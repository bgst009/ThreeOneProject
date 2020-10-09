	ifndef	??version
?debug	macro
	endm
	endif
	?debug	S "\src\five\b.c"
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
	?debug	C E91D513D510D5C7372635C666976655C622E63
_BSS	ends
_TEXT	segment	byte public 'CODE'
;	?debug	L 13
_main	proc	near
;	?debug	L 14
	mov	word ptr DGROUP:_pstu,offset DGROUP:_a
;	?debug	L 16
	mov	bx,word ptr DGROUP:_pstu
	mov	word ptr [bx],1
;	?debug	L 17
	mov	bx,word ptr DGROUP:_pstu
	mov	byte ptr [bx+2],80
;	?debug	L 18
	mov	bx,word ptr DGROUP:_pstu
	mov	byte ptr [bx+3],84
;	?debug	L 19
	mov	bx,word ptr DGROUP:_pstu
	mov	byte ptr [bx+4],111
;	?debug	L 20
	mov	bx,word ptr DGROUP:_pstu
	mov	byte ptr [bx+5],109
;	?debug	L 21
	mov	bx,word ptr DGROUP:_pstu
	mov	byte ptr [bx+6],48
;	?debug	L 23
	mov	word ptr DGROUP:_pchar,0
;	?debug	L 24
	mov	word ptr DGROUP:_pint,0
;	?debug	L 25
	mov	word ptr DGROUP:_pstu,0
;	?debug	L 27
	mov	ax,word ptr DGROUP:_pchar
	inc	ax
	mov	word ptr DGROUP:_pchar,ax
;	?debug	L 28
	mov	ax,word ptr DGROUP:_pint
	inc	ax
	inc	ax
	mov	word ptr DGROUP:_pint,ax
;	?debug	L 29
	mov	ax,word ptr DGROUP:_pstu
	add	ax,11
	mov	word ptr DGROUP:_pstu,ax
@1:
;	?debug	L 30
	ret	
_main	endp
_TEXT	ends
_BSS	segment word public 'BSS'
_a	label	word
	db	11 dup (?)
_pint	label	word
	db	2 dup (?)
_pstu	label	word
	db	2 dup (?)
_pchar	label	word
	db	2 dup (?)
_BSS	ends
	?debug	C E9
_DATA	segment word public 'DATA'
s@	label	byte
_DATA	ends
_TEXT	segment	byte public 'CODE'
_TEXT	ends
	public	_pchar
	public	_pstu
	public	_pint
	public	_main
	public	_a
	end
