assume cs:code,ss:stack

stack segment
db 128 dup(0)
stack ends

code segment
start:
    mov ax,stack
    mov ss,ax
    mov sp,128

    call copy_BOOT

    mov ax,0
    push ax
    mov ax,7e00h
    push ax
    retf

    mov ax,4c00h
    int 21h
    ;================================================================================
    copy_BOOT:
        push ax
        push bx
        push cx
        push dx
        push ds
        push es
        push si
        push di
        copy_BOOT_bg:
            mov ax,cs
            mov ds,ax
            mov si,offset BOOT

            mov ax,0
            mov es,ax
            mov di,7e00h

            mov cx,offset BOOT_end - offset BOOT

            cld
            rep movsb

        copy_BOOT_end:
            pop di
            pop si
            pop es
            pop ds
            pop dx
            pop cx
            pop bx
            pop ax
            ret
    ;=================================================================================
    BOOT:
        jmp BOOT_bg

        OPTION_1 db '(1) restart pc',0
        OPTION_2 db '(2) start system',0
        OPTION_3 db '(3) clock',0
        OPTION_4 db '(4) set clock',0

        ADDRESS_OPTION  dw offset OPTION_1 - offset BOOT + 7e00h
                        dw offset OPTION_2 - offset BOOT + 7e00h
                        dw offset OPTION_3 - offset BOOT + 7e00h
                        dw offset OPTION_4 - offset BOOT + 7e00h

        TIME_CMOS  db   9,8,7,4,2,0
        TIME_STYLE db   'YY/MM/DD hh:mm:ss',0

        BOOT_bg:
            call init_reg
            call clear_screen
            call show_option

            jmp choose_option

            mov ax,4c00h
            int 21h

        ;========= choose_option ==============
        choose_option:
            call clear_buff
            mov ah,0
            int 16h

            cmp al,'1'
            je isChooseOne
            cmp al,'2'
            je isChooseTwo
            cmp al,'3'
            je isChooseThree
            cmp al,'4'
            je isChooseFour

            ;===================== 1.2.3.4 ==========
            isChooseOne:
                mov di,160*3
                mov byte ptr es:[di],'1'
                jmp choose_option
            isChooseTwo:
                mov di,160*3
                mov byte ptr es:[di],'2'
                jmp choose_option
            isChooseThree:
                mov di,160*3
                mov byte ptr es:[di],'3'
                call show_clock
                jmp choose_option
            isChooseFour:
                mov di,160*3
                mov byte ptr es:[di],'4'
                jmp choose_option

            jmp choose_option
            clear_buff:
                mov ah,1
                int 16h
                jz clear_buff_ret
                mov ah,0
                int 16h
                jmp clear_buff
            clear_buff_ret:
                ret
        BOOT_ret:
            ;==========   init_reg   ===========
            init_reg:
                init_reg_bg:
                    mov ax,0b800h
                    mov es,ax

                    mov ax,0
                    mov ds,ax
                init_reg_end:
                    ret

            ;========== clear_screen ============
            clear_screen:
                push ax
                push bx
                push cx
                push dx
                push ds
                push es
                push si
                push di
                clear_screen_bg:
                        mov bx,0b800h
                        mov es,bx
                        
                        mov bx,0
                        mov dl,0
                        mov dh,00001010b
                        mov cx,2000

                clearScreen:	
                                mov es:[bx],dx
                                add bx,2
                                
                                loop clearScreen
                
                clear_screen_end:
                    pop di
                    pop si
                    pop es
                    pop ds
                    pop dx
                    pop cx
                    pop bx
                    pop ax
                    ret
            ;========== show option ========
            show_option:
                push ax
                push bx
                push cx
                push dx
                push ds
                push es
                push si
                push di
                show_option_bg:

                    mov bx,offset ADDRESS_OPTION - offset BOOT + 7e00h
                    mov di,160*10+2*30
                    mov cx,4
                    mov dh,2
                    show_row:
                        mov si,ds:[bx]
                        call show_string
                        add bx,2
                        add di,160
                        loop show_row
                        
                show_option_end:
                        pop di
                        pop si
                        pop es
                        pop ds
                        pop dx
                        pop cx
                        pop bx
                        pop ax
                        ret
            ;========== show string =====================
            show_string:
                push ax
                push bx
                push cx
                push dx
                push ds
                push es
                push si
                push di
                show_string_bg:
                    mov dl,ds:[si]
                    cmp dl,0
                    je show_string_end
                    mov es:[di],dx
                    inc si
                    inc di
                    inc di
                    jmp show_string_bg
                show_string_end:
                        pop di
                        pop si
                        pop es
                        pop ds
                        pop dx
                        pop cx
                        pop bx
                        pop ax
                        ret
            ;============= show clock =========================
            show_clock:
                push ax
                push bx
                push cx
                push dx
                push ds
                push es
                push si
                push di
                    call clear_screen
                    call show_style
                show_clock_bg:
                    mov bx,offset TIME_CMOS - offset BOOT + 7e00h
                    show_time:
                        mov si,bx
                        mov di,160*12+2*30
                        mov cx,6


                        show_date:
                            mov al,ds:[si]
                            out 70h,al
                            in al,71h

                            mov ah,al
                            shr ah,1
                            shr ah,1
                            shr ah,1
                            shr ah,1
                            and al,00001111b

                            add ah,30h
                            add al,30h
                            mov es:[di],ah
                            mov es:[di+2],al

                            add di,6
                            inc si

                            loop show_date

                            mov ah,1 ;调用16h中断的1号功能（非阻塞）
                            int 16h
                            cmp al,1bh ;判断是否为ESC
                            ; je clockreturn ;若是ESC，回到菜单
                            jne ne_ESC
                            jmp clockreturn
                            ne_ESC:
                            cmp ah,3bh ;判断是否为F1
                            ; je changecolor
                            jne ne_ESC_OR_F1
                            jmp changecolor

                        ne_ESC_OR_F1:
                        call clear_buff
                        jmp show_clock_bg

                            clockreturn:
                                call clear_screen
                                call clear_buff
                                jmp BOOT_bg
                            changecolor:
                                call clear_buff
                                call change_time_color
                                jmp show_clock_bg

                show_clock_end:
                        pop di
                        pop si
                        pop es
                        pop ds
                        pop dx
                        pop cx
                        pop bx
                        pop ax
                        ret
                ;=============== show_style ======================
                show_style:
                    push ax
                    push bx
                    push cx
                    push dx
                    push ds
                    push es
                    push si
                    push di
                    show_style_bg:
                        mov di,160*12+2*30
                        mov si,offset TIME_STYLE - offset BOOT + 7e00h
                        mov dh,01011010b
                        call show_string
                    show_style_end:
                            pop di
                            pop si
                            pop es
                            pop ds
                            pop dx
                            pop cx
                            pop bx
                            pop ax
                            ret
                ;================= change_time_color ========================
                change_time_color:
                    push ax
                    push bx
                    push cx
                    push dx
                    push ds
                    push es
                    push si
                    push di
                    change_time_color_bg:
                        mov bx,0b800h
                        mov es,bx
                        mov bx,1 + 160*12+2*30
                        
                        mov cx,17
                        ct_lp:
                        inc byte ptr es:[bx]
                        add bx,2
                        loop ct_lp
                    change_time_color_end:
                            pop di
                            pop si
                            pop es
                            pop ds
                            pop dx
                            pop cx
                            pop bx
                            pop ax
                            ; ret
                            jmp show_time
        BOOT_end:
            nop
code ends
end start