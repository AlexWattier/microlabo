; 2_ascii_minVersMaj_partiel.asm

global main

section .text
main:
    nop         ; ne fait rien

    mov bl , 8          ; 0000 1000b
    
    mov al , 00110000b  ; 0011 0000b
    or  bl , al         ; 0011 1000b

    ; fin
    mov rax, 60
    mov rdi, 0
    syscall

