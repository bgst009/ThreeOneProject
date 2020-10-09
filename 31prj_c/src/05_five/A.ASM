	ifndef	??version
?debug	macro
	endm
	endif
	?debug	S "\src\five\a.c"
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
	?debug	C E981433D510D5C7372635C666976655C612E63
_BSS	ends
_TEXT	segment	byte public 'CODE'
;	?debug	L 7
_main	proc	near
;	?debug	L 8
	mov	word ptr DGROUP:_p,4096
;	?debug	L 9
	mov	al,byte ptr [4096]
	mov	bx,word ptr DGROUP:_p
	add	al,byte ptr [bx]
	xor	bx,bx
	mov	es,bx
	mov	bx,512
	add	al,byte ptr es:[bx]
	mov	byte ptr DGROUP:_ch,al
;	?debug	L 11
	mov	word ptr DGROUP:_p,offset DGROUP:_ch
;	?debug	L 13
	mov	bx,word ptr DGROUP:_p
	mov	al,byte ptr [bx]
	inc	al
	mov	bx,word ptr DGROUP:_p
	mov	byte ptr [bx],al
;	?debug	L 15
	mov	word ptr DGROUP:_pa,offset DGROUP:_p
;	?debug	L 16
	mov	bx,word ptr DGROUP:_pa
	mov	bx,word ptr [bx]
	mov	al,byte ptr [bx]
	inc	al
	mov	bx,word ptr DGROUP:_pa
	mov	bx,word ptr [bx]
	mov	byte ptr [bx],al
;	?debug	L 18
	mov	word ptr DGROUP:_pf+2,ds
	mov	word ptr DGROUP:_pf,offset DGROUP:_ch
;	?debug	L 19
	les	bx,dword ptr DGROUP:_pf
	mov	al,byte ptr es:[bx]
	inc	al
	les	bx,dword ptr DGROUP:_pf
	mov	byte ptr es:[bx],al
;	?debug	L 21
	mov	ax,offset DGROUP:_ch
	mov	word ptr DGROUP:_n,ax
;	?debug	L 22
	mov	bx,word ptr DGROUP:_n
	mov	al,byte ptr [bx]
	inc	al
	mov	bx,word ptr DGROUP:_n
	mov	byte ptr [bx],al
@1:
;	?debug	L 23
	ret	
_main	endp
_TEXT	ends
_BSS	segment word public 'BSS'
_pa	label	word
	db	2 dup (?)
_ch	label	byte
	db	1 dup (?)
_n	label	word
	db	2 dup (?)
_pf	label	dword
	db	4 dup (?)
_p	label	word
	db	2 dup (?)
_BSS	ends
	?debug	C E9
_DATA	segment word public 'DATA'
s@	label	byte
_DATA	ends
_TEXT	segment	byte public 'CODE'
_TEXT	ends
	public	_main
	public	_p
	public	_pf
	public	_n
	public	_ch
	public	_pa
	end
