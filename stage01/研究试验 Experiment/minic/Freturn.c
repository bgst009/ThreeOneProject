float f(float, float);

/*
_main	proc	near
	push	bp
	mov	bp,sp
	sub	sp,12
*/
main()
{
        /*ax=cccd dx= 400c    */
    float c = 2.2, a = 1.1, b = 1.1; /*
                                        mov	dx,16396
                                        mov	ax,-13107
                                        mov	word ptr [bp-10],dx
                                        mov	word ptr [bp-12],ax
                                    ;	?debug	L 11
                                        mov	dx,16268
                                        mov	ax,-13107
                                        mov	word ptr [bp-6],dx
                                        mov	word ptr [bp-8],ax
                                    ;	?debug	L 11
                                        mov	dx,16268
                                        mov	ax,-13107
                                        mov	word ptr [bp-2],dx
                                        mov	word ptr [bp-4],ax
                                    */

    c = f(a, b);                    /*
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
                                    */
    /*printf("%f",c);*/
}

/*
_f	proc	near
	push	bp
	mov	bp,sp
	sub	sp,4
*/
float f(float a, float b)
{
    float ab = a + b;   /*
                            FLD	dword ptr [bp+4]
                            FLD	dword ptr [bp+8]
                            FADD	
                            FSTP	dword ptr [bp-4]
                            FWAIT
                        */
    
    return ab;          /*
                        	FLD	dword ptr [bp-4]
                            jmp	short @2
                        @2:
                        ;	?debug	L 50
                            mov	sp,bp
                            pop	bp
                            ret	
                        */
}