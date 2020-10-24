	ifndef	??version
?debug	macro
	endm
	endif
	?debug	S "return.c"
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
	?debug	C E99A51D5500872657475726E2E63
_BSS	ends
_TEXT	segment	byte public 'CODE'
;	?debug	L 5
_main	proc	near
	push	bp
	mov	bp,sp
	sub	sp,4
;	?debug	L 8
	call	near ptr _f
	FSTP	dword ptr [bp-4]
	FWAIT	
@1:
;	?debug	L 9
	mov	sp,bp
	pop	bp
	ret	
_main	endp
;	?debug	L 11
_f	proc	near
;	?debug	L 14


;FLD类似于   PUSH指令
;FSTP类似于  POP指令
;FADD类似于  ADD指令

	FLD	dword ptr DGROUP:_a
	FLD	dword ptr DGROUP:_b
	FADD	
	FSTP	dword ptr DGROUP:_ab
	FWAIT	
;	?debug	L 15
	FLD	dword ptr DGROUP:_ab
	jmp	short @2
@2:
;	?debug	L 16
	ret	x
_f	endp
_TEXT	ends
_BSS	segment word public 'BSS'
_a	label	dword
	db	4 dup (?)
_b	label	dword
	db	4 dup (?)
_ab	label	dword
	db	4 dup (?)
_BSS	ends
	?debug	C E9
_DATA	segment word public 'DATA'
s@	label	byte
_DATA	ends
_TEXT	segment	byte public 'CODE'
_TEXT	ends
	public	_main
	public	_ab
	public	_f
	public	_b
	public	_a
	end
