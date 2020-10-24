assume cs:code
data segment
 db 256 dup (0)
data ends
code segment
 start:mov ax,offset start
       mov ax,4c00h
       int 21h
code ends
end start