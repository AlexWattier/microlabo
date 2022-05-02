; 01_push_pop_64_fc.asm
;
; nasm -f elf64 -F dwarf 01_push_pop_64_fc.asm
;   il y a des warnings, voir plus bas
; ld -o 01_push_pop_64_fc 01_push_pop_64_fc.o

global _start

section .rodata
    source          DB      1, 2, 3, 4, 5, 6, 7, 8

section .bss
    destination     RESQ    1

section .text
_start:

    ; pile vide
    ;                     petites adresses
    ;           |      |
    ; rsp --->  +------+  grandes adresses 0x7fffffffdab0
    ; rem. : le contenu initial de rsp peut varier

    ; push registre

    mov     rax, 0x123456789ABCDEF0

    ; push    al          ; ko car al fait 8 bits
    ; error: invalid combination of opcode and operands

    push    ax
    ; la valeur 0xDEF0 est placée sur la pile sur 2 bytes
    ;   rsp <-- rsp - 2
    ;
    ;           |      | petites adresses
    ; rsp --->  | 0xF0 | 0x7fffffffdaae
    ;           | 0xDE |
    ;           +------+ grandes adresses 0x7fffffffdab0
    ; rem. : le contenu initial de rsp peut varier

    ; push    eax         ; ko car eax fait 32 bits
    ; error: instruction not supported in 64-bit mode

    push    rax
    ; la valeur 0x123456789ABCDEF0 est placée sur la pile sur 8 bytes
    ;   rsp <-- rsp - 8
    ;
    ;           |      | petites adresses
    ; rsp --->  | 0xF0 | 0x7fffffffdaa6
    ;           | 0xDE |
    ;           | 0xBC |
    ;           | 0x9A |
    ;           | 0x78 |
    ;           | 0x56 |
    ;           | 0x34 |
    ;           | 0x12 |
    ;           | 0xF0 | 0x7fffffffdaae
    ;           | 0xDE |
    ;           +------+ grandes adresses 0x7fffffffdab0
    ; rem. : le contenu initial de rsp peut varier

    ; push mémoire

    ; push    byte [source]     ; ko car source fait 8 bits
    ; error: invalid combination of opcode and operands

    push    word [source]
    ; la valeur 0x0201 est placée sur la pile sur 2 bytes
    ;   rsp <-- rsp - 2
    ;
    ;           |      | petites adresses
    ; rsp --->  | 0x01 | 0x7fffffffdaa4
    ;           | 0x02 |
    ;           | 0xF0 | 0x7fffffffdaa6
    ;           | 0xDE |
    ;           | 0xBC |
    ;           | 0x9A |
    ;           | 0x78 |
    ;           | 0x56 |
    ;           | 0x34 |
    ;           | 0x12 |
    ;           | 0xF0 | 0x7fffffffdaae
    ;           | 0xDE |
    ;           +------+ grandes adresses 0x7fffffffdab0
    ; rem. : le contenu initial de rsp peut varier

    ; push    dword [source]      ; ko car source fait 32 bits
    ; error: instruction not supported in 64-bit mode

    push    qword [source]
    ; la valeur 0x0807060504030201 est placée sur la pile sur 8 bytes
    ;   rsp <-- rsp - 8
    ;
    ;           |      | petites adresses
    ; rsp --->  | 0x01 | 0x7fffffffda9c
    ;           | 0x02 |
    ;           | 0x03 |
    ;           | 0x04 |
    ;           | 0x05 |
    ;           | 0x06 |
    ;           | 0x07 |
    ;           | 0x08 |
    ;           | 0x01 | 0x7fffffffdaa4
    ;           | 0x02 |
    ;           | 0xF0 | 0x7fffffffdaa6
    ;           | 0xDE |
    ;           | 0xBC |
    ;           | 0x9A |
    ;           | 0x78 |
    ;           | 0x56 |
    ;           | 0x34 |
    ;           | 0x12 |
    ;           | 0xF0 | 0x7fffffffdaae
    ;           | 0xDE |
    ;           +------+ grandes adresses 0x7fffffffdab0
    ; rem. : le contenu initial de rsp peut varier

    ; pop registre

    ; pop     r8b             ; ko car r8b fait 8 bits
    ; error: invalid combination of opcode and operands

    pop     r9w
    ; la valeur 0x0201 est placée dans r9w et rsp incrémenté de 2
    ;   r9w <-- 0x0201
    ;   rsp <-- rsp + 2
    ;
    ;           |      | petites adresses
    ;           | 0x01 | 0x7fffffffda9c
    ;           | 0x02 |
    ; rsp --->  | 0x03 | 0x7fffffffda9e
    ;           | 0x04 |
    ;           | 0x05 |
    ;           | 0x06 |
    ;           | 0x07 |
    ;           | 0x08 |
    ;           | 0x01 | 0x7fffffffdaa4
    ;           | 0x02 |
    ;           | 0xF0 | 0x7fffffffdaa6
    ;           | 0xDE |
    ;           | 0xBC |
    ;           | 0x9A |
    ;           | 0x78 |
    ;           | 0x56 |
    ;           | 0x34 |
    ;           | 0x12 |
    ;           | 0xF0 | 0x7fffffffdaae
    ;           | 0xDE |
    ;           +------+ grandes adresses 0x7fffffffdab0
    ; rem. : le contenu initial de rsp peut varier

    ; pop     r10d            ; ko car r10d fait 32 bits
    ; error: instruction not supported in 64-bit mode

    pop     r11
    ; la valeur 0x0201080706050403 est placée dans r11 et rsp
    ; incrémenté de 8
    ;   r11 <-- 0x0201080706050403
    ;   rsp <-- rsp + 8
    ;
    ;           |      | petites adresses
    ;           | 0x01 | 0x7fffffffda9c
    ;           | 0x02 |
    ;           | 0x03 | 0x7fffffffda9e
    ;           | 0x04 |
    ;           | 0x05 |
    ;           | 0x06 |
    ;           | 0x07 |
    ;           | 0x08 |
    ;           | 0x01 | 0x7fffffffdaa4
    ;           | 0x02 |
    ; rsp --->  | 0xF0 | 0x7fffffffdaa6
    ;           | 0xDE |
    ;           | 0xBC |
    ;           | 0x9A |
    ;           | 0x78 |
    ;           | 0x56 |
    ;           | 0x34 |
    ;           | 0x12 |
    ;           | 0xF0 | 0x7fffffffdaae
    ;           | 0xDE |
    ;           +------+ grandes adresses 0x7fffffffdab0
    ; rem. : le contenu initial de rsp peut varier

    ; pop mémoire

    ; pop     byte [destination]      ; ko car destination fait 8 bits
    ; error: invalid combination of opcode and operands

    pop     word [destination]
    ; la valeur 0xDEF0 est placée à l'adresse destination sur 2 bytes
    ; et rsp incrémenté de 2
    ;   word [destination] <-- 0xDEF0
    ;   rsp <-- rsp + 2
    ;
    ;           |      | petites adresses
    ;           | 0x01 | 0x7fffffffda9c
    ;           | 0x02 |
    ;           | 0x03 | 0x7fffffffda9e
    ;           | 0x04 |
    ;           | 0x05 |
    ;           | 0x06 |
    ;           | 0x07 |
    ;           | 0x08 |
    ;           | 0x01 | 0x7fffffffdaa4
    ;           | 0x02 |
    ;           | 0xF0 | 0x7fffffffdaa6
    ;           | 0xDE |
    ; rsp --->  | 0xBC | 0x7fffffffdaa8
    ;           | 0x9A |
    ;           | 0x78 |
    ;           | 0x56 |
    ;           | 0x34 |
    ;           | 0x12 |
    ;           | 0xF0 | 0x7fffffffdaae
    ;           | 0xDE |
    ;           +------+ grandes adresses 0x7fffffffdab0
    ; rem. : le contenu initial de rsp peut varier

    ; pop     dword [destination]   ; ko car destination fait 32 bits
    ; error: instruction not supported in 64-bit mode

    pop     qword [destination]
    ; la valeur 0xDEF0123456789ABC est placée à l'adresse destination
    ; sur 8 bytes et rsp incrémenté de 8
    ;   qword [destination] <-- 0xDEF0123456789ABC
    ;   rsp <-- rsp + 8
    ;
    ;           |      | petites adresses
    ;           | 0x01 | 0x7fffffffda9c
    ;           | 0x02 |
    ;           | 0x03 | 0x7fffffffda9e
    ;           | 0x04 |
    ;           | 0x05 |
    ;           | 0x06 |
    ;           | 0x07 |
    ;           | 0x08 |
    ;           | 0x01 | 0x7fffffffdaa4
    ;           | 0x02 |
    ;           | 0xF0 | 0x7fffffffdaa6
    ;           | 0xDE |
    ;           | 0xBC | 0x7fffffffdaa8
    ;           | 0x9A |
    ;           | 0x78 |
    ;           | 0x56 |
    ;           | 0x34 |
    ;           | 0x12 |
    ;           | 0xF0 | 0x7fffffffdaae
    ;           | 0xDE |
    ; rsp --->  +------+ grandes adresses 0x7fffffffdab0
    ; rem. : le contenu initial de rsp peut varier

    ; push immédiat

    push    byte 0xF0
    ; warning: signed byte value exceeds bounds [-w+number-overflow]
    ; la valeur 0xF0 est étendue par extension de signe sur 64 bits
    ; et placée sur la pile, c'est-à-dire que :
    ; la valeur 0xFFFFFFFFFFFFFFF0 est placée sur la pile sur 8 bytes
    ;   rsp <-- rsp - 8
    ;
    ;           |      | petites adresses
    ;           | 0x01 | 0x7fffffffda9c
    ;           | 0x02 |
    ;           | 0x03 | 0x7fffffffda9e
    ;           | 0x04 |
    ;           | 0x05 |
    ;           | 0x06 |
    ;           | 0x07 |
    ;           | 0x08 |
    ;           | 0x01 | 0x7fffffffdaa4
    ;           | 0x02 |
    ;           | 0xF0 | 0x7fffffffdaa6
    ;           | 0xDE |
    ; rsp --->  | 0xF0 | 0x7fffffffdaa8
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF | 0x7fffffffdaae
    ;           | 0xFF |
    ;           +------+ grandes adresses 0x7fffffffdab0
    ; rem. : le contenu initial de rsp peut varier

    push    word 0xDEF0
    ; la valeur 0xDEF0 est placée sur la pile sur 2 bytes
    ;   rsp <-- rsp - 2
    ;
    ;           |      | petites adresses
    ;           | 0x01 | 0x7fffffffda9c
    ;           | 0x02 |
    ;           | 0x03 | 0x7fffffffda9e
    ;           | 0x04 |
    ;           | 0x05 |
    ;           | 0x06 |
    ;           | 0x07 |
    ;           | 0x08 |
    ;           | 0x01 | 0x7fffffffdaa4
    ;           | 0x02 |
    ; rsp --->  | 0xF0 | 0x7fffffffdaa6
    ;           | 0xDE |
    ;           | 0xF0 | 0x7fffffffdaa8
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF | 0x7fffffffdaae
    ;           | 0xFF |
    ;           +------+ grandes adresses 0x7fffffffdab0
    ; rem. : le contenu initial de rsp peut varier

    push    dword 0x9ABCDEF0
    ; warning: signed dword immediate exceeds bounds [-w+number-overflow]
    ; warning: dword data exceeds bounds [-w+number-overflow]
    ; la valeur 0x9ABCDEF0 est étendue par extension de signe sur
    ; 64 bits et placée sur la pile, c'est-à-dire que :
    ; la valeur 0xFFFFFFFF9ABCDEF0 est placée sur la pile sur 8 bytes
    ;   rsp <-- rsp - 8
    ;
    ;           |      | petites adresses
    ;           | 0x01 | 0x7fffffffda9c
    ;           | 0x02 |
    ; rsp --->  | 0xF0 | 0x7fffffffda9e
    ;           | 0xDE |
    ;           | 0xBC |
    ;           | 0x9A |
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF | 0x7fffffffdaa4
    ;           | 0xFF |
    ;           | 0xF0 | 0x7fffffffdaa6
    ;           | 0xDE |
    ;           | 0xF0 | 0x7fffffffdaa8
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF | 0x7fffffffdaae
    ;           | 0xFF |
    ;           +------+ grandes adresses 0x7fffffffdab0
    ; rem. : le contenu initial de rsp peut varier

    push    qword 0x123456789ABCDEF0
    ; warning: signed dword immediate exceeds bounds [-w+number-overflow]
    ; warning: dword data exceeds bounds [-w+number-overflow]
    ; les 32 bits de poids faible de la valeur 0x123456789ABCDEF0,
    ; c'est-à-dire la valeur 0x9ABCDEF0 est étendue par extension
    ; de signe sur 64 bits et placée sur la pile, c'est-à-dire que :
    ; la valeur 0xFFFFFFFF9ABCDEF0 est placée sur la pile sur 8 bytes
    ;   rsp <-- rsp - 8
    ;
    ;           |      | petites adresses
    ; rsp --->  | 0xF0 | 0x7fffffffda96
    ;           | 0xDE |
    ;           | 0xBC |
    ;           | 0x9A |
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF | 0x7fffffffda9c
    ;           | 0xFF |
    ;           | 0xF0 | 0x7fffffffda9e
    ;           | 0xDE |
    ;           | 0xBC |
    ;           | 0x9A |
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF | 0x7fffffffdaa4
    ;           | 0xFF |
    ;           | 0xF0 | 0x7fffffffdaa6
    ;           | 0xDE |
    ;           | 0xF0 | 0x7fffffffdaa8
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF | 0x7fffffffdaae
    ;           | 0xFF |
    ;           +------+ grandes adresses 0x7fffffffdab0
    ; rem. : le contenu initial de rsp peut varier

    push   0
    ; les 32 bits de poids faible de la valeur 0x00, c'est-à-dire
    ; la valeur 0x00 est étendue par extension de signe sur 64 bits
    ; et placée sur la pile, c'est-à-dire que :
    ; la valeur 0x00 est placée sur la pile sur 8 bytes
    ;   rsp <-- rsp - 8
    ;
    ;           |      | petites adresses
    ; rsp --->  | 0x00 | 0x7fffffffda8e
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0xF0 | 0x7fffffffda96
    ;           | 0xDE |
    ;           | 0xBC |
    ;           | 0x9A |
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF | 0x7fffffffda9c
    ;           | 0xFF |
    ;           | 0xF0 | 0x7fffffffda9e
    ;           | 0xDE |
    ;           | 0xBC |
    ;           | 0x9A |
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF | 0x7fffffffdaa4
    ;           | 0xFF |
    ;           | 0xF0 | 0x7fffffffdaa6
    ;           | 0xDE |
    ;           | 0xF0 | 0x7fffffffdaa8
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF | 0x7fffffffdaae
    ;           | 0xFF |
    ;           +------+ grandes adresses 0x7fffffffdab0
    ; rem. : le contenu initial de rsp peut varier

    push    0x123456789ABCDEF0
    ; warning: signed dword immediate exceeds bounds [-w+number-overflow]
    ; warning: dword data exceeds bounds [-w+number-overflow]
    ; les 32 bits de poids faible de la valeur 0x123456789ABCDEF0,
    ; c'est-à-dire la valeur 0x9ABCDEF0 est étendue par extension
    ; de signe sur 64 bits et placée sur la pile, c'est-à-dire que :
    ; la valeur 0xFFFFFFFF9ABCDEF0 est placée sur la pile sur 8 bytes
    ;   rsp <-- rsp - 8
    ;
    ;           |      | petites adresses
    ; rsp --->  | 0xF0 | 0x7fffffffda86
    ;           | 0xDE |
    ;           | 0xBC |
    ;           | 0x9A |
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0x00 | 0x7fffffffda8e
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0x00 |
    ;           | 0xF0 | 0x7fffffffda96
    ;           | 0xDE |
    ;           | 0xBC |
    ;           | 0x9A |
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF | 0x7fffffffda9c
    ;           | 0xFF |
    ;           | 0xF0 | 0x7fffffffda9e
    ;           | 0xDE |
    ;           | 0xBC |
    ;           | 0x9A |
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF | 0x7fffffffdaa4
    ;           | 0xFF |
    ;           | 0xF0 | 0x7fffffffdaa6
    ;           | 0xDE |
    ;           | 0xF0 | 0x7fffffffdaa8
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF |
    ;           | 0xFF | 0x7fffffffdaae
    ;           | 0xFF |
    ;           +------+ grandes adresses 0x7fffffffdab0
    ; rem. : le contenu initial de rsp peut varier


    mov     rax, 60
    mov     rdi, 0
    syscall
