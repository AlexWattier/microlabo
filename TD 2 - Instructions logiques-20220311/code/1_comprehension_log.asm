; 1_comprehension_log.asm

global main

section .text
main:
    mov al, 10011101b                
    not al              ; al = 01100010b, zf = 0, sf = 1

    mov al, 11100101b
    mov ah, 00101010b
    and al, ah          ; al = 11101111b, zf = 0, sf = 1

    mov al, 11100101b
    mov ah, 00001010b
    and al, ah          ; al = 11101111b, zf = 0, sf = 1

    mov al, 01100101b
    mov ah, 01010101b
    or  al, ah          ; al = 01110101b, zf = 0, sf = 0

    mov al, 11100101b
    mov ah, 01010101b
    or  al, ah          ; al = 11110101b, zf = 0, sf = 1

    mov dx, 1100010011100101b
    mov si, 0011000001100010b
    xor dx, si          ; dx = 1111010010000111b
                        ; zf = 0, sf = 1	

    mov al, 11100101b
    mov ah, 11100101b
    xor al, ah          ; al = 00000000b, zf = 0, sf = 0

    ; fin
    mov rax, 60
    mov rdi, 0
    syscall

