; 00_section.asm

global _start

section .data
    bd0     DB      1
    bd1     DB      42
    bd2     DB      -1
    bd3     DB      23

section .rodata
    drd0    DD      314
    drd1    DD      4
    drd2    DD      12

section .bss
    wb0     RESW    1
    wb1     RESW    1
    wb2     RESW    1

section .text
_start:

    mov     rsi, _start     ; 0x4000b0

    mov     rax, drd0       ; 0x40013c
    mov     rbx, drd1       ; 0x400140
    mov     rcx, drd2       ; 0x400144

    mov     r8, bd0         ; 0x600148
    mov     r9, bd1         ; 0x600149
    mov     r10, bd2        ; 0x60014a
    mov     r11, bd3        ; 0x60014b

    ; rem. : si bd3 pas déclaré,
    ;        wb0 quand même en adresse multiple de 4 : alignement (?)
    ;        https://en.wikipedia.org/wiki/Data_structure_alignment

    mov     r12, wb0        ; 0x60014c
    mov     r13, wb1        ; 0x60014e
    mov     r14, wb2        ; 0x600150

    ; rsp : 0x7fffffffe730 : cette valeur peut varier

 .infinity:
    jmp     .infinity

    mov     rax, 60
    mov     rdi, 0
    syscall
