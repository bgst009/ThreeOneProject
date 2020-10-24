assume cs:code,ss:stack

stack segment
db 128 dup(0)
stack ends

code segment
start:
    mov ax,stack
    mov ss,ax
    mov sp,128

    call copy_boot
    call save_old_int9

    mov ax,0
    push ax
    mov ax,200h
    push ax
    retf

    mov ax,4c00h
    int 21h
    ;================ save int9 =====================================================
    save_old_int9:
            push ax
            push bx
            push cx
            push dx
            push ds
            push es
            push si
            push di
        save_old_int9_bg:
                mov ax,0
                mov es,ax
                push es:[9*4]
                pop es:[7e00h]
                push es:[9*4+2]
                pop es:[7e02h]
        save_old_int9_end:
                pop di
                pop si
                pop es
                pop ds
                pop dx
                pop cx
                pop bx
                pop ax
                ret
    ;================================================================================
    copy_boot:
        push ax
        push bx
        push cx
        push dx
        push ds
        push es
        push si
        push di
        copy_boot_bg:
            mov ax,cs
            mov ds,ax
            mov si,offset boot

            mov ax,0
            mov es,ax
            mov di,200h

            mov cx,offset boot_end - offset boot

            cld
            rep movsb

        copy_boot_end:
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
    boot:
        jmp boot_bg

        OPTION_1 db '(1) restart pc',0
        OPTION_2 db '(2) start system',0
        OPTION_3 db '(3) clock',0
        OPTION_4 db '(4) set clock',0

        ADDRESS_OPTION  dw offset OPTION_1 - offset boot + 200h
                        dw offset OPTION_2 - offset boot + 200h
                        dw offset OPTION_3 - offset boot + 200h
                        dw offset OPTION_4 - offset boot + 200h

        TIME_CMOS  db   9,8,7,4,2,0
        TIME_STYLE db   'YY/MM/DD hh:mm:ss',0

        boot_bg:
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
        boot_ret:
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

                    mov bx,offset ADDRESS_OPTION - offset boot + 200h
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
                    ; mov dh,2
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
                show_clock_bg:
                    call show_style
                    call set_new_int9
                    mov bx,offset TIME_CMOS - offset boot + 200h

                    show_time:
                        mov si,bx
                        mov di,160*20+2*30
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

                        jmp show_time
                    show_clock_ret:
                        call set_old_int9

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
                    mov di,160*20+2*30
                    mov si,offset TIME_STYLE - offset boot + 200h
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
            ;============== new_int9 =========================
            new_int9:
                push ax
                push bx
                push cx
                push dx
                push ds
                push es
                push si
                push di
                new_int9_bg:
                    in al,60h
                    pushf
                    call dword ptr cs:[7e00h]

                    cmp al,01h  ;ESC
                    ; je isESC


                    cmp al,3bh  ;F1
                    jne new_int9_ret
                    call change_time_color

                    
                new_int9_ret:
                        pop di
                        pop si
                        pop es
                        pop ds
                        pop dx
                        pop cx
                        pop bx
                        pop ax
                        iret
                new_int9_end:nop
            ;====================== set new int9 ===========================
            set_new_int9:
                push ax
                push bx
                push cx
                push dx
                push ds
                push es
                push si
                push di
                set_new_int9_bg:
                    mov bx,0
                    mov es,bx

                    cli
                    mov word ptr es:[9*4],offset new_int9 - offset boot + 200h
                    mov word ptr es:[9*4+2],0
                    sti
                set_new_int9_end:
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
                    mov bx,1 + 160*20+2*30
                    
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
                        ret
            ;===================================================
            isESC:
                push ax
                push bx
                push cx
                push dx
                push ds
                push es
                push si
                push di
                isESC_bg:
                    pop ax
                    add sp,4+8*2
                    popf
                    jmp show_clock_ret
                isESC_end:
                        pop di
                        pop si
                        pop es
                        pop ds
                        pop dx
                        pop cx
                        pop bx
                        pop ax
                        ret
            ;============== set old int 9 ==========================
            set_old_int9:
                push ax
                push bx
                push cx
                push dx
                push ds
                push es
                push si
                push di
                set_old_int9_bg:
                    mov ax,0
                    mov es,ax
                    cli
                    push es:[7e00h]
                    pop es:[9*4]
                    push es:[7e02h]
                    pop es:[9*4+2]
                    sti
                set_old_int9_end:
                        pop di
                        pop si
                        pop es
                        pop ds
                        pop dx
                        pop cx
                        pop bx
                        pop ax
                        ret
        ;================ boot end =========================
        boot_end:
            nop
code ends
end start