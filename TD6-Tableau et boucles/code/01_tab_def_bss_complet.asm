; 01\_tab\_def\_bss\_complet.asm

global _start

section .bss
    ; t1 : tableau d'1 élément de taille 1 byte
    t1          RESB    1

    ; t2 : tableau de 6 éléments de taille 2 bytes chacun
    t2          RESW    6

    ; t3 : tableau de 100 éléments de taille 4 bytes chacun
    t3          RESD    100

    ; t4 : tableau de 10 éléments de taille 8 bytes chacun
    t4          RESQ    10

; extrait du contenu de la section .bss (byte par byte, hexadécimal) :
; ---> petites adresses --->
;       t1   t2
;  ... | 00 | 00 | 00 | 00 | 00 | 00 | 00 | 00 | 00 | 00 | 00 | .
;
;                t3
;     . 00 | 00 | 00 | 00 | 00 | 00 | 00 | 00 | 00 | 00 | 00 | ...
;
;                                       ---> grande adresses --->

section .text
_start:

    mov     byte [t1], 1

    mov     word [t2], 2
    mov     word [t2 + 5 * 2], 3

    mov     dword [t3], 4
    mov     dword [t3 + 99 * 4], 5

    mov     qword [t4], 6
    mov     qword [t4 + 9 * 8], 7

    mov     rax, 60
    mov     rdi, 0
    syscall
