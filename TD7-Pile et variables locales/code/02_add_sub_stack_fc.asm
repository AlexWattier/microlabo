; 02_add_sub_stack_fc.asm
;
; nasm -f elf64 -F dwarf 02_add_sub_stack_fc.asm
; ld -o 02_add_sub_stack_fc 02_add_sub_stack_fc.o

global _start

section .bss
    variable    RESB    1

section .text
_start:

    ; pile vide
    ;                     petites adresses
    ;           |      |
    ; rsp --->  +------+  grandes adresses 0x7fffffffdab0
    ; rem. : le contenu initial de rsp peut varier

    ; push

    mov     rax, 0x123456789ABCDEF0

    ; push    al          ; ko car al fait 8 bits
    ; error: invalid combination of opcode and operands

    sub     rsp, 1
    mov     byte [rsp], al
    ; la valeur 0xF0 est placée sur la pile sur 1 byte
    ;   rsp <-- rsp - 1
    ;
    ;           |      | petites adresses
    ; rsp --->  | 0xF0 | 0x7fffffffdaaf
    ;           +------+ grandes adresses 0x7fffffffdab0
    ; rem. : le contenu initial de rsp peut varier

    push    ax
    ; la valeur 0xDEF0 est placée sur la pile sur 2 bytes
    ;   rsp <-- rsp - 2
    ;
    ;           |      | petites adresses
    ; rsp --->  | 0xF0 | 0x7fffffffdaad
    ;           | 0xDE |
    ;           | 0xF0 | 0x7fffffffdaaf
    ;           +------+ grandes adresses 0x7fffffffdab0
    ; rem. : le contenu initial de rsp peut varier

    ; push    eax         ; ko car eax fait 32 bits
    ; error: instruction not supported in 64-bit mode

    sub     rsp, 4
    mov     dword [rsp], eax
    ; la valeur 0x9ABCDEF0 est placée sur la pile sur 4 bytes
    ;   rsp <-- rsp - 4
    ;
    ;           |      | petites adresses
    ; rsp --->  | 0xF0 | 0x7fffffffdaa9
    ;           | 0xDE |
    ;           | 0xBC |
    ;           | 0x9A |
    ;           | 0xF0 | 0x7fffffffdaad
    ;           | 0xDE |
    ;           | 0xF0 | 0x7fffffffdaaf
    ;           +------+ grandes adresses 0x7fffffffdab0
    ; rem. : le contenu initial de rsp peut varier

    push    rax
    ; la valeur 0x123456789ABCDEF0 est placée sur la pile sur 8 bytes
    ;   rsp <-- rsp - 8
    ;
    ;           |      | petites adresses
    ; rsp --->  | 0xF0 | 0x7fffffffdaa1
    ;           | 0xDE |
    ;           | 0xBC |
    ;           | 0x9A |
    ;           | 0x78 |
    ;           | 0x56 |
    ;           | 0x34 |
    ;           | 0x12 |
    ;           | 0xF0 | 0x7fffffffdaa9
    ;           | 0xDE |
    ;           | 0xBC |
    ;           | 0x9A |
    ;           | 0xF0 | 0x7fffffffdaad
    ;           | 0xDE |
    ;           | 0xF0 | 0x7fffffffdaaf
    ;           +------+ grandes adresses 0x7fffffffdab0
    ; rem. : le contenu initial de rsp peut varier

    ; push    byte [variable]     ; ko car 1 byte
    ; error: invalid combination of opcode and operands

    ; sub     rsp, 1
    ; mov     byte [rsp], byte [variable] ; ko car 2 mémoires
    ; error: invalid combination of opcode and operands

    ; pop

    ; pop     r10b            ; ko car r10b fait 8 bits
    ; error: invalid combination of opcode and operands

    mov     r10b, byte [rsp]
    add     rsp, 1
    ; la valeur 0xF0 est placée dans r10b et rsp incrémenté de 1
    ;   r10b <-- 0xF0
    ;   rsp <-- rsp + 1
    ;
    ;           |      | petites adresses
    ;           | 0xF0 | 0x7fffffffdaa1
    ; rsp --->  | 0xDE | 0x7fffffffdaa2
    ;           | 0xBC |
    ;           | 0x9A |
    ;           | 0x78 |
    ;           | 0x56 |
    ;           | 0x34 |
    ;           | 0x12 |
    ;           | 0xF0 | 0x7fffffffdaa9
    ;           | 0xDE |
    ;           | 0xBC |
    ;           | 0x9A |
    ;           | 0xF0 | 0x7fffffffdaad
    ;           | 0xDE |
    ;           | 0xF0 | 0x7fffffffdaaf
    ;           +------+ grandes adresses 0x7fffffffdab0
    ; rem. : le contenu initial de rsp peut varier

    pop     r11w
    ; la valeur 0xBCDE est placée dans r11w et rsp incrémenté de 2
    ;   r11w <-- 0xBCDE
    ;   rsp <-- rsp + 2
    ;
    ;           |      | petites adresses
    ;           | 0xF0 | 0x7fffffffdaa1
    ;           | 0xDE | 0x7fffffffdaa2
    ;           | 0xBC |
    ; rsp --->  | 0x9A | 0x7fffffffdaa4
    ;           | 0x78 |
    ;           | 0x56 |
    ;           | 0x34 |
    ;           | 0x12 |
    ;           | 0xF0 | 0x7fffffffdaa9
    ;           | 0xDE |
    ;           | 0xBC |
    ;           | 0x9A |
    ;           | 0xF0 | 0x7fffffffdaad
    ;           | 0xDE |
    ;           | 0xF0 | 0x7fffffffdaaf
    ;           +------+ grandes adresses 0x7fffffffdab0
    ; rem. : le contenu initial de rsp peut varier

    ; pop     r12d            ; ko car r12d fait 32 bits
    ; error: instruction not supported in 64-bit mode

    mov     r12d, dword [rsp]
    add     rsp, 4
    ; la valeur 0x3456789A est placée dans r12d et rsp incrémenté de 4
    ;   r12d <-- 0x3456789A
    ;   rsp <-- rsp + 4
    ;
    ;           |      | petites adresses
    ;           | 0xF0 | 0x7fffffffdaa1
    ;           | 0xDE | 0x7fffffffdaa2
    ;           | 0xBC |
    ;           | 0x9A | 0x7fffffffdaa4
    ;           | 0x78 |
    ;           | 0x56 |
    ;           | 0x34 |
    ; rsp --->  | 0x12 | 0x7fffffffdaa8
    ;           | 0xF0 | 0x7fffffffdaa9
    ;           | 0xDE |
    ;           | 0xBC |
    ;           | 0x9A |
    ;           | 0xF0 | 0x7fffffffdaad
    ;           | 0xDE |
    ;           | 0xF0 | 0x7fffffffdaaf
    ;           +------+ grandes adresses 0x7fffffffdab0
    ; rem. : le contenu initial de rsp peut varier

    pop     r13
    ; la valeur 0xF0DEF09ABCDEF012 est placée dans r13 et rsp
    ; incrémenté de 8
    ;   r13 <-- 0xF0DEF09ABCDEF012
    ;   rsp <-- rsp + 8
    ;
    ;           |      | petites adresses
    ;           | 0xF0 | 0x7fffffffdaa1
    ;           | 0xDE | 0x7fffffffdaa2
    ;           | 0xBC |
    ;           | 0x9A | 0x7fffffffdaa4
    ;           | 0x78 |
    ;           | 0x56 |
    ;           | 0x34 |
    ;           | 0x12 | 0x7fffffffdaa8
    ;           | 0xF0 | 0x7fffffffdaa9
    ;           | 0xDE |
    ;           | 0xBC |
    ;           | 0x9A |
    ;           | 0xF0 | 0x7fffffffdaad
    ;           | 0xDE |
    ;           | 0xF0 | 0x7fffffffdaaf
    ; rsp --->  +------+ grandes adresses 0x7fffffffdab0
    ; rem. : le contenu initial de rsp peut varier

    mov     rax, 60
    mov     rdi, 0
    syscall
