; 00\_tab\_def\_data\_rodata\_complet.asm

global _start

section .data
    ; tableaux

    ; t1 : tableau de 4 éléments de taille 1 byte chacun
    t1          DB      0, 1, 2, 3

    ; t2 : tableau de 3 (2 + 1) éléments de taille 4 bytes chacun
    ; 1er élément : 'A' (0x41) codé sur 4 bytes
    ;             : en mémoire petit-boutisme hex : 41 00 00 00
    ; 2e élément : 'B' (0x42) codé sur 4 bytes
    ;            : en mémoire petit-boutisme hex : 42 00 00 00
    ; 3e élément : 'C' (0x43) codé sur 4 bytes
    ;            : en mémoire petit-boutisme hex : 43 00 00 00
    t2          DD      'A', 'B'
                DD      'C'      ; variable anonyme « attachée » à t2

    ; tailles / nombre d'éléments de tableaux
    ; obtenus pas calculs de différences d'adresses

    ; tailleT1 : taille 8 bytes, contenu égal à 4 (4 $\times$ 1)
    tailleT1    DQ      t2 - t1

    ; tailleT2 : variable 2 bytes, contenu égal à 12 (3 $\times$ 4)
    tailleT2    DW      tailleT1 - t2

    ; nbElemT2 : variable 4 bytes, contenu égal à 3 (12 / 4)
    nbElemT2    DD      (tailleT1 - t2) / 4

; contenu de la section .data (byte par byte, hexadécimal) :
; ---> petites adresses --->
;       t1                  t2
;  ... | 00 | 01 | 02 | 03 | 41 | 00 | 00 | 00 | 42 | 00 | .
;
;                                    tailleT1
;     . 00 | 00 | 43 | 00 | 00 | 00 | 04 | 00 | 00 | 00 | ..
;
;                          tailleT2  nbElemT2
;    .. 00 | 00 | 00 | 00 | 0C | 00 | 03 | 00 |00 | 00 | ...
;
;                                       ---> grande adresses --->

section .rodata

    ; t3 : tableau de 4 éléments de taille 2 bytes chacun
    ; 1er élément : 0xAB codé sur 2 bytes
    ;             : en mémoire petit-boutisme hex : AB 00
    ; 2e élément : 0xAB codé sur 2 bytes
    ;             : en mémoire petit-boutisme hex : AB 00
    ; 3e élément : 0xAB codé sur 2 bytes
    ;             : en mémoire petit-boutisme hex : AB 00
    ; 4e élément : 0xAB codé sur 2 bytes
    ;             : en mémoire petit-boutisme hex : AB 00
    t3  times 4     DW  0xAB

    ; tailleT3 : taille 8 bytes, contenu égal à 8 (4 $\times$ 2)
    ; \( \$ \) : remplacé par l'adresse en début de ligne où il apparait
    ;   : donc ici \( \$ \) est égal à tailleT3
    tailleT3        DQ  $ - t3

; contenu de la section .rodata (byte par byte, hexadécimal) :
; ---> petites adresses --->
;       t3                                      tailleT3
;  ... | AB | 00 | AB | 00 | AB | 00 | AB | 00 | 08 | 00 | .
;
;     . 00 | 00 | 00 | 00 | 00 | 00 | ...
;                                       ---> grande adresses --->

section .text
_start:

    mov     rax, 60
    mov     rdi, 0
    syscall
