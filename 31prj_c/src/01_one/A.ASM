	ifndef	??version
?debug	macro
	endm
	endif
	?debug	S "\src\a.c"
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
	?debug	C E96B593851085C7372635C612E63
_BSS	ends
_TEXT	segment	byte public 'CODE'
;	?debug	L 2
_f1	proc	near
;	?debug	L 2
	mov	word ptr DGROUP:_a,1
@1:
;	?debug	L 2
	ret	
_f1	endp
;	?debug	L 3
_f2	proc	near
;	?debug	L 3
	mov	word ptr DGROUP:_a,2
@2:
;	?debug	L 3
	ret	
_f2	endp
;	?debug	L 4
_f3	proc	near
;	?debug	L 4
	mov	word ptr DGROUP:_a,3
@3:
;	?debug	L 4
	ret	
_f3	endp
;	?debug	L 5
_main	proc	near
	push	si
;	?debug	L 6
	mov	si,offset DGROUP:s@
;	?debug	L 7
	mov	ax,offset _main
	push	ax
	mov	ax,offset DGROUP:s@+21
	push	ax
	call	near ptr _printf
	pop	cx
	pop	cx
;	?debug	L 8
	mov	ax,ds
	push	ax
	mov	ax,offset DGROUP:s@+32
	push	ax
	call	near ptr _printf
	pop	cx
	pop	cx
;	?debug	L 9
	mov	ax,cs
	push	ax
	mov	ax,offset DGROUP:s@+41
	push	ax
	call	near ptr _printf
	pop	cx
	pop	cx
;	?debug	L 10
	push	si
	mov	ax,offset DGROUP:s@+50
	push	ax
	call	near ptr _printf
	pop	cx
	pop	cx
;	?debug	L 11
	mov	ax,offset _f1
	push	ax
	mov	ax,offset DGROUP:s@+53
	push	ax
	call	near ptr _printf
	pop	cx
	pop	cx
;	?debug	L 12
	mov	ax,ds
	push	ax
	mov	ax,offset DGROUP:s@+62
	push	ax
	call	near ptr _printf
	pop	cx
	pop	cx
;	?debug	L 13
	mov	ax,cs
	push	ax
	mov	ax,offset DGROUP:s@+71
	push	ax
	call	near ptr _printf
	pop	cx
	pop	cx
;	?debug	L 14
	push	si
	mov	ax,offset DGROUP:s@+80
	push	ax
	call	near ptr _printf
	pop	cx
	pop	cx
;	?debug	L 16
	mov	ax,offset _f2
	push	ax
	mov	ax,offset DGROUP:s@+83
	push	ax
	call	near ptr _printf
	pop	cx
	pop	cx
;	?debug	L 17
	mov	ax,ds
	push	ax
	mov	ax,offset DGROUP:s@+92
	push	ax
	call	near ptr _printf
	pop	cx
	pop	cx
;	?debug	L 18
	mov	ax,cs
	push	ax
	mov	ax,offset DGROUP:s@+101
	push	ax
	call	near ptr _printf
	pop	cx
	pop	cx
;	?debug	L 19
	push	si
	mov	ax,offset DGROUP:s@+110
	push	ax
	call	near ptr _printf
	pop	cx
	pop	cx
;	?debug	L 21
	mov	ax,offset _f3
	push	ax
	mov	ax,offset DGROUP:s@+113
	push	ax
	call	near ptr _printf
	pop	cx
	pop	cx
;	?debug	L 22
	mov	ax,ds
	push	ax
	mov	ax,offset DGROUP:s@+122
	push	ax
	call	near ptr _printf
	pop	cx
	pop	cx
;	?debug	L 23
	mov	ax,cs
	push	ax
	mov	ax,offset DGROUP:s@+131
	push	ax
	call	near ptr _printf
	pop	cx
	pop	cx
@4:
;	?debug	L 24
	pop	si
	ret	
_main	endp
_TEXT	ends
_BSS	segment word public 'BSS'
_a	label	word
	db	2 dup (?)
_BSS	ends
	?debug	C E9
_DATA	segment word public 'DATA'
s@	label	byte
	db	45
	db	45
	db	45
	db	45
	db	45
	db	45
	db	45
	db	45
	db	45
	db	45
	db	45
	db	45
	db	45
	db	45
	db	45
	db	45
	db	45
	db	45
	db	45
	db	45
	db	0
	db	10
	db	109
	db	97
	db	105
	db	110
	db	58
	db	32
	db	37
	db	120
	db	10
	db	0
	db	10
	db	68
	db	83
	db	58
	db	32
	db	37
	db	120
	db	10
	db	0
	db	10
	db	67
	db	83
	db	58
	db	32
	db	37
	db	120
	db	10
	db	0
	db	37
	db	115
	db	0
	db	10
	db	102
	db	49
	db	58
	db	32
	db	37
	db	120
	db	10
	db	0
	db	10
	db	68
	db	83
	db	58
	db	32
	db	37
	db	120
	db	10
	db	0
	db	10
	db	67
	db	83
	db	58
	db	32
	db	37
	db	120
	db	10
	db	0
	db	37
	db	115
	db	0
	db	10
	db	102
	db	50
	db	58
	db	32
	db	37
	db	120
	db	10
	db	0
	db	10
	db	68
	db	83
	db	58
	db	32
	db	37
	db	120
	db	10
	db	0
	db	10
	db	67
	db	83
	db	58
	db	32
	db	37
	db	120
	db	10
	db	0
	db	37
	db	115
	db	0
	db	10
	db	102
	db	51
	db	58
	db	32
	db	37
	db	120
	db	10
	db	0
	db	10
	db	68
	db	83
	db	58
	db	32
	db	37
	db	120
	db	10
	db	0
	db	10
	db	67
	db	83
	db	58
	db	32
	db	37
	db	120
	db	10
	db	0
_DATA	ends
_TEXT	segment	byte public 'CODE'
	extrn	_printf:near
_TEXT	ends
	public	_main
	public	_a
	public	_f3
	public	_f2
	public	_f1
	end
