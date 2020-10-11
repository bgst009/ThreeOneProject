	ifndef	??version
?debug	macro
	endm
	endif
	?debug	S "\src\011_el~1\a.c"
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
	?debug	C E97D5A4B51115C7372635C3031315F656C7E315C612E63
_BSS	ends
_DATA	segment word public 'DATA'
_a	label	byte
	db	48
	db	199 dup (0)
_DATA	ends
_TEXT	segment	byte public 'CODE'
;	?debug	L 5
_main	proc	near
;	?debug	L 6
	mov	word ptr DGROUP:_b+2,cs
	mov	word ptr DGROUP:_b,offset _f
;	?debug	L 7
	call	dword ptr DGROUP:_b
@1:
;	?debug	L 8
	ret	
_main	endp
;	?debug	L 9
_f	proc	near
;	?debug	L 9
	mov	bx,-18432
	mov	es,bx
	mov	bx,1680
	mov	byte ptr es:[bx],99
@2:
;	?debug	L 9
	ret	
_f	endp
_TEXT	ends
_BSS	segment word public 'BSS'
_b	label	dword
	db	4 dup (?)
_BSS	ends
	?debug	C E9
_DATA	segment word public 'DATA'
s@	label	byte
_DATA	ends
_TEXT	segment	byte public 'CODE'
_TEXT	ends
	public	_main
	public	_f
	public	_b
	public	_a
	end
