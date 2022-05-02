; 09_repeter_exemple_complet.asm

global _start

section .rodata
    tab     DD      -8, -2, 7, 12, -6    ; DD : double word : 4 bytes

; contenu de la section .rodata (byte par byte, hexadécimal) :
; ---> petites adresses --->
;        tab
;  .... | F8 | FF | FF | FF | FE | FF | FF | FF | 07 | 00 | .
;
;      . 00 | 00 | 0C | 00 | 00 | 00 | FA | FF | FF | FF | ...
;
;                                       ---> grande adresses --->

section .text
_start:

    mov     rax, 0  ; compteur
    mov     rcx, 0  ; indice

 repeter:
    bt      dword [tab + rcx * 4], 31   ; test du bit de signe
    jnc     positif
    inc     rax     ; ici CF == 1 : strictement < 0
  positif:
    inc     rcx
    cmp     rcx, 5  ; car indices : 0 → 4 car 5 éléments
    jnz     repeter

    ; ici : rax == # éléments de tab < 0

    mov     rax, 60
    mov     rdi, 0
    syscall
